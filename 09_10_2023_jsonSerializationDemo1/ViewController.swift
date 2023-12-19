//
//  ViewController.swift
//  09_10_2023_jsonSerializationDemo1
//
//  Created by Vishal Jagtap on 18/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    var posts : [Post] = []
    private let postTableViewCellIdentifier = "PostTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initializeTableView()
        registerXIBWithTableView()
    }
    
    func initializeTableView(){
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    func registerXIBWithTableView(){
        let uiNib = UINib(nibName: postTableViewCellIdentifier, bundle: nil)
        self.postTableView.register(uiNib, forCellReuseIdentifier: postTableViewCellIdentifier)
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
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: postTableViewCellIdentifier, for: indexPath) as! PostTableViewCell
        postTableViewCell.postUserIdLabel.text = String(posts[indexPath.row].userId)
        postTableViewCell.postTitleLabel.text = posts[indexPath.row].title
        postTableViewCell.postBodyLabel.text = posts[indexPath.row].body
        
        return postTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
