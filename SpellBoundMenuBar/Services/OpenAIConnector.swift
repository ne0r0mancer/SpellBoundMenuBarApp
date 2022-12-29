//
//  OpenAIConnector.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import Foundation

enum CannotReadPropertyFile: Error {
    case propertyFileReadingError
}

public class OpenAIConnector {

    let openAIURL = URL(string: "https://api.openai.com/v1/completions")
    var openAIKey: String = ""

    init() {
        print("OpenAIConnector initialized")
        guard let fileUrl = Bundle.main.url(forResource: "Secrets", withExtension: "plist") else {
            print("ERROR: Cannot find Secrets.plist")
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let secrets = try PropertyListDecoder().decode([String: String].self, from: data)
            openAIKey = secrets["openAIKey"] ?? ""
            print("OpenAI key is", openAIKey)
            
        } catch {
            print("ERROR: Cannot read Secrets.plist")
        }
    }

    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        let session: URLSession
        if (sessionConfig != nil) {
            session = URLSession(configuration: sessionConfig!)
        } else {
            session = URLSession.shared
        }
        var requestData: Data?
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error != nil {
                print("error: \(error!.localizedDescription): \(error!.localizedDescription)")
            } else if data != nil {
                requestData = data
            }

            print("Semaphore signalled")
            semaphore.signal()
        })
        task.resume()

        // Handle async with semaphores. Max wait of 10 seconds
        let timeout = DispatchTime.now() + .seconds(20)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }

    public func processPrompt(
            prompt: String,
            temperature: Float = 0.5
    ) -> Optional<String> {
        print("Calling URL: \(openAIURL!)")
        print("Calling OpenAI with prompt: \(prompt)")
        var request = URLRequest(url: self.openAIURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        let httpBody: [String: Any] = [
            "prompt": prompt,
            "frequency_penalty": 0,
            "model": "text-davinci-003",
            "stop": ["Input:"],
            "temperature": temperature,
            "presence_penalty": 0,
            "max_tokens": 450,
            "n": 1,
            "best_of": 1,
            "user": ""
        ]

        var httpBodyJson: Data

        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            return nil
        }
        request.httpBody = httpBodyJson
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print("Response: \(jsonStr)")
            let responseHandler = OpenAIResponseHandler()

            return responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].text

        }

        return nil
    }

    struct OpenAIResponseHandler {
        func decodeJson(jsonString: String) -> OpenAIResponse? {
            let json = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            do {
                let product = try decoder.decode(OpenAIResponse.self, from: json)
                return product

            } catch {
                print("Error decoding OpenAI API Response")
            }

            return nil
        }
    }

    struct OpenAIResponse: Codable {
        var id: String
        var object: String
        var created: Int
        var model: String
        var choices: [Choice]
    }

    struct Choice: Codable {
        var text: String
        var index: Int
        var logprobs: String?
        var finish_reason: String
    }
}

