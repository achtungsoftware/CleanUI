//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import Combine

/// A class for handling http requests and json encoding
public class CUHttp {
    
    /// This function uploads mutiple media to the server (Audio, Video, Image)
    /// - Parameters:
    ///   - urlString: The Api url
    ///   - parameters: Post parameters
    ///   - videos: An Array of video asset urls
    ///   - images: An Array of images
    ///   - audios: An Array of audio asset urls
    ///   - thread: The ``CUThreadHelper`` async thread for processing
    ///   - callback: Callback with the result String and success Bool
    public static func upload(_ urlString: String, parameters: [String: String]? = nil, videos: [String: URL]? = nil, images: [String: UIImage]? = nil, audios: [String: URL]? = nil, thread: CUThreadHelper.async = .background, callback: @escaping (String, Bool) -> ()) {
        thread.run {
            
            guard let url = URL(string: urlString) else {
                CUThreadHelper.async.main.run {
                    callback("", false)
                }
                return
            }
            
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            
            
            let boundary = "Boundary-\(NSUUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            
            let body = NSMutableData()
            
            if let parameters = parameters {
                for (key, value) in parameters {
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")
                }
            }
            
            if let images = images {
                for (name, image) in images {
                    let imageData = image.jpegData(compressionQuality: 0.8)
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(name)\"; filename=\"image.jpg\"\r\n")
                    body.appendString(string: "Content-Type: image/jpg\r\n\r\n")
                    body.append(imageData! as Data)
                    body.appendString(string: "\r\n")
                }
            }
            
            if let videos = videos {
                for (name, video) in videos {
                    var videoData: Data?
                    do {
                        videoData = try Data(contentsOf: video, options: Data.ReadingOptions.alwaysMapped)
                    } catch _ {
                        videoData = nil
                    }
                    if(videoData != nil){
                        body.appendString(string: "--\(boundary)\r\n")
                        body.appendString(string: "Content-Disposition: form-data; name=\"\(name)\"; filename=\"video.mp4\"\r\n")
                        body.appendString(string: "Content-Type: video/mp4\r\n\r\n")
                        body.append(videoData! as Data)
                        body.appendString(string: "\r\n")
                    }
                }
            }
            
            
            if let audios = audios {
                for (name, audio) in audios {
                    var audioData: Data?
                    do {
                        audioData = try Data(contentsOf: audio, options: Data.ReadingOptions.alwaysMapped)
                    } catch _ {
                        audioData = nil
                    }
                    
                    if(audioData != nil){
                        body.appendString(string: "--\(boundary)\r\n")
                        body.appendString(string: "Content-Disposition: form-data; name=\"\(name)\"; filename=\"audio.m4a\"\r\n")
                        body.appendString(string: "Content-Type: audio/m4a\r\n\r\n")
                        body.append(audioData! as Data)
                        body.appendString(string: "\r\n")
                    }
                }
            }
            
            body.appendString(string: "--\(boundary)--\r\n")
            
            
            request.httpBody = body as Data
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                // Check if Error took place
                if error != nil {
                    CUThreadHelper.async.main.run {
                        callback("", false)
                    }
                    return
                }
                
                // Read HTTP Response Status code
                let response = response as? HTTPURLResponse
                
                // Convert HTTP Response Data to a simple String
                let dataString = String(data: data!, encoding: .utf8)
                
                if(response?.statusCode == 200){
                    if(dataString != ""){
                        CUThreadHelper.async.main.run {
                            callback(dataString ?? "", true)
                        }
                    }else {
                        CUThreadHelper.async.main.run {
                            callback("", false)
                        }
                    }
                }else {
                    CUThreadHelper.async.main.run {
                        callback("", false)
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    /// This function makes an http post request and trys to encode the result to an object
    /// - Parameters:
    ///   - urlString: The Api url
    ///   - parameters: Post parameters
    ///   - thread: The ``CUThreadHelper`` async thread for processing
    ///   - callback: Callback with the object, the result String and success Bool
    public static func postObject<T: Decodable>(_ urlString: String, parameters: [String: String]? = nil, type: T.Type, thread: CUThreadHelper.async = .utility, callback: @escaping (T?, String, Bool) -> ()){
        thread.run {
            
            guard let url = URL(string: urlString) else {
                CUThreadHelper.async.main.run {
                    callback(nil, "", false)
                }
                return
            }
            
            // Prepare URL Request Object
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set HTTP Request Body
            request.httpBody = buildPostDataString(parameters).data(using: String.Encoding.utf8)
            
            // Perform HTTP Request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check if Error took place
                if error != nil {
                    CUThreadHelper.async.main.run {
                        callback(nil, "", false)
                    }
                    return
                }
                
                // Read HTTP Response Status code
                let response = response as? HTTPURLResponse
                
                // Convert HTTP Response Data to a simple String
                let dataString = String(data: data!, encoding: .utf8)
                
                if(response?.statusCode == 200){
                    if(dataString != ""){
                        let jsonData = dataString!.data(using: .utf8)!
                        do {
                            let data: T = try JSONDecoder().decode(T.self, from: jsonData)
                            CUThreadHelper.async.main.run {
                                callback(data, dataString ?? "", true)
                            }
                        } catch {
                            CUThreadHelper.async.main.run {
                                callback(nil, "", false)
                            }
                        }
                    }else {
                        CUThreadHelper.async.main.run {
                            callback(nil, "", false)
                        }
                    }
                }else {
                    CUThreadHelper.async.main.run {
                        callback(nil, "", false)
                    }
                }
            }
            task.resume()
        }
    }
    
    /// This function makes an http post request and trys to encode the result to an object array
    /// - Parameters:
    ///   - urlString: The Api url
    ///   - parameters: Post parameters
    ///   - thread: The ``CUThreadHelper`` async thread for processing
    ///   - callback: Callback with the object array, the result String and success Bool
    public static func postObjectArray<T: Decodable>(_ urlString: String, parameters: [String: String]? = nil, type: T.Type, thread: CUThreadHelper.async = .utility, callback: @escaping ([T]?, String, Bool) -> ()){
        
        thread.run {
            guard let url = URL(string: urlString) else {
                CUThreadHelper.async.main.run {
                    callback(nil, "", false)
                }
                return
            }
            
            // Prepare URL Request Object
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set HTTP Request Body
            request.httpBody = buildPostDataString(parameters).data(using: String.Encoding.utf8)
            
            // Perform HTTP Request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check if Error took place
                if error != nil {
                    CUThreadHelper.async.main.run {
                        callback(nil, "", false)
                    }
                    return
                }
                
                // Read HTTP Response Status code
                let response = response as? HTTPURLResponse
                
                // Convert HTTP Response Data to a simple String
                let dataString = String(data: data!, encoding: .utf8)
                
                if(response?.statusCode == 200){
                    if(dataString != ""){
                        let jsonData = dataString!.data(using: .utf8)
                        do {
                            let data: [T] = try JSONDecoder().decode([T].self, from: jsonData!)
                            CUThreadHelper.async.main.run {
                                callback(data, dataString ?? "", true)
                            }
                        } catch {
                            CUThreadHelper.async.main.run {
                                callback(nil, "", false)
                            }
                        }
                    }else {
                        CUThreadHelper.async.main.run {
                            callback(nil, "", false)
                        }
                    }
                }else {
                    CUThreadHelper.async.main.run {
                        callback(nil, "", false)
                    }
                }
            }
            task.resume()
        }
    }
    
    /// This function makes an http post request
    /// - Parameters:
    ///   - urlString: The Api url
    ///   - parameters: Post parameters
    ///   - thread: The ``CUThreadHelper`` async thread for processing
    ///   - callback: Callback with the result String and success Bool
    public static func post(_ urlString: String, parameters: [String: String]? = nil, thread: CUThreadHelper.async = .utility, callback: @escaping (String, Bool) -> ()){
        thread.run {
            
            guard let url = URL(string: urlString) else {
                CUThreadHelper.async.main.run {
                    callback("", false)
                }
                return
            }
            
            // Prepare URL Request Object
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set HTTP Request Body
            request.httpBody = buildPostDataString(parameters).data(using: String.Encoding.utf8)
            
            // Perform HTTP Request
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check if Error took place
                if error != nil {
                    CUThreadHelper.async.main.run {
                        callback("", false)
                    }
                    return
                }
                
                // Read HTTP Response Status code
                let response = response as? HTTPURLResponse
                
                // Convert HTTP Response Data to a simple String
                let dataString = String(data: data!, encoding: .utf8)
                
                if(response?.statusCode == 200){
                    if(dataString != ""){
                        CUThreadHelper.async.main.run {
                            callback(dataString ?? "", true)
                        }
                    }else {
                        CUThreadHelper.async.main.run {
                            callback("", false)
                        }
                    }
                }else {
                    CUThreadHelper.async.main.run {
                        callback("", false)
                    }
                }
            }
            task.resume()
        }
    }
    
    /// Creates an parameter string from a dictionary and applies url encoding to the value
    /// - Parameter parameters: The parameter dictionary
    /// - Returns: An encoded String for url paramater
    public static func buildPostDataString(_ parameters: [String: String]?) -> String {
        var postData = ""
        if let parameters = parameters {
            for (key, value) in parameters {
                postData.append("\(key)=\(value.urlEncode())&")
            }
        }
        
        return String(postData.dropLast())
    }
}

extension NSMutableData {
    func appendString(string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) {
            append(data)
        }
    }
}
