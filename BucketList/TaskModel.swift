//
//  TaskModel.swift
//  BucketList
//
//  Created by Isidro Arzate on 7/12/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import Foundation

class TaskModel {
//    static function that will be used to fetch tasks from API
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
//        set the URL from where we are grabbing the tasks
        let url = URL(string: "http://localhost:8000/tasks")
//        instatiate a web session
        let session = URLSession.shared
//        make the request
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://localhost:8000/tasks") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Create some bodyData and attach it to the HTTPBody
            let bodyData =  ["objective" : objective] as NSDictionary //"objective=\(objective)"
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: .prettyPrinted)  //bodyData.data(using: .utf8)
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
}
