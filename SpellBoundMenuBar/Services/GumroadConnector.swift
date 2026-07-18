//
//  OpenAIConnector.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import Foundation

enum MissingLicenseKey: Error {
    case licenseKeyMissing
}

public class GumroadConnector {

    let gumroadURL = URL(string: "https://api.gumroad.com/v2/licenses/verify")

    // Product IDs are build configuration, not secrets — set them in Info.plist
    // so forks can point at their own Gumroad products without touching source.
    var gumroadMembershipProduct = Bundle.main.object(forInfoDictionaryKey: "GumroadMembershipProductID") as? String ?? ""
    var gumroadLifetimeProduct = Bundle.main.object(forInfoDictionaryKey: "GumroadLifetimeProductID") as? String ?? ""

    // shared
    public static let shared = GumroadConnector()

    init() {
        print("Initializing GumroadConnector")
        if gumroadMembershipProduct.isEmpty && gumroadLifetimeProduct.isEmpty {
            print("WARNING: no Gumroad product IDs configured in Info.plist — license checks will fail")
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
        let timeout = DispatchTime.now() + .seconds(30)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }

    public func verifyMembershipWithFallback(gumroadKey: String) -> Bool {
        let membershipOk = verify(gumroadKey: gumroadKey, productKey: gumroadMembershipProduct)
        if (membershipOk) {
            return true
        } else {
            // fallback to lifetime
            return verify(gumroadKey: gumroadKey, productKey: gumroadLifetimeProduct)
        }
    }

    public func verify(gumroadKey: String, productKey: String) -> Bool {
        print("Calling URL: \(gumroadURL!)")
        var request = URLRequest(url: self.gumroadURL!)
        request.httpMethod = "POST"
        // post data containing gumroadProduct and gumroadLicence
        let postString = "product_id=\(productKey)&license_key=\(gumroadKey)"
        request.httpBody = postString.data(using: .utf8)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            let jsonStr = String(data: requestData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print("Response: \(jsonStr)")
            let responseHandler = GumroadResponseHandler()

            return responseHandler.decodeJson(jsonString: jsonStr)?.success ?? false

        }

        return false
    }

    struct GumroadResponseHandler {
        func decodeJson(jsonString: String) -> GumroadResponse? {
            let json = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            do {
                let licenceCheck = try decoder.decode(GumroadResponse.self, from: json)
                return licenceCheck

            } catch {
                print("Error decoding Gumroad API Response")
            }

            return nil
        }
    }

    struct GumroadResponse: Codable {
        var success: Bool
    }
}

