//
//  ViewController.swift
//  09_10_2023_jsonSerializationDemo1
//
//  Created by Vishal Jagtap on 18/12/23.
//

import UIKit

class ViewController: UIViewController {

    var posts : [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        let postUrlString = "https://jsonplaceholder.typicode.com/posts"
        let postUrl = URL(string: postUrlString)
        
        var postUrlRequest = URLRequest(url: postUrl!)
        postUrlRequest.httpMethod = "GET"
        
        let postUrlSession = URLSession(configuration:.default)
        
        var dataTask = postUrlSession.dataTask(with: postUrlRequest) { postData, postUrlResponse, postError in
            
            print(postUrlResponse)
            print(postData)
            print(postError)
            print("===========================")
            let postResponse = try! JSONSerialization.jsonObject(with: postData!) as! [[String:Any]]
            print(postResponse)
            
            for eachPostResponse in postResponse{
                let postDictionary = eachPostResponse as! [String:Any]
                let postId = postDictionary["id"] as! Int
                let postUserId = postDictionary["userId"] as! Int
                let postTitle = postDictionary["title"] as! String
                let postBody = postDictionary["body"] as! String
                
                let postObject = Post(id: postId,
                                      userId: postUserId,
                                      title: postTitle,
                                      body: postBody)
                self.posts.append(postObject)
            }
        }
        dataTask.resume()
    }
}
