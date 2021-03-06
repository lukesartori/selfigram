//
//  FeedTableViewController.swift
//  selfigram
//
//  Created by Luke Sartori on 2018-03-12.
//  Copyright © 2018 Luke. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var posts = [Post]()
    var words = ["Hello", "My", "Name", "Is", "Selfiegram"]

    func getPosts() {
        if let query = Post.query() {
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            
            query.findObjectsInBackground(block: { (posts, error) -> Void in
                self.refreshControl?.endRefreshing()
                if let posts = posts as? [Post]{
                    self.posts = posts
                    self.tableView.reloadData()
                }
                
            })
        }
    }
    
    @IBAction func doubleTappedSelfie(_ sender: UITapGestureRecognizer) {
        // get the location (x,y) position on our tableView where we have clicked
        let tapLocation = sender.location(in: tableView)
        
        // based on the x, y position we can get the indexPath for where we are at
        if let indexPathAtTapLocation = tableView.indexPathForRow(at: tapLocation){
            
            // based on the indexPath we can get the specific cell that is being tapped
            let cell = tableView.cellForRow(at: indexPathAtTapLocation) as! selfieCell
            
            //run a method on that cell.
            cell.tapAnimation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
    }
    
    @IBAction func refreshPulled(_ sender: UIRefreshControl) {
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! selfieCell
        
        let post = self.posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }


    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        // 1: Create an ImagePickerController
        let pickerController = UIImagePickerController()
        
        // 2: Self in this line refers to this View Controller
        //    Setting the Delegate Property means you want to receive a message
        //    from pickerController when a specific event is triggered.
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            // 3. We check if we are running on a Simulator
            //    If so, we pick a photo from the simulator’s Photo Library
            // We need to do this because the simulator does not have a camera
            pickerController.sourceType = .photoLibrary
        } else {
            // 4. We check if we are running on an iPhone or iPad (ie: not a simulator)
            //    If so, we open up the pickerController's Camera (Front Camera, for selfies!)
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        // Preset the pickerController on screen
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // setting the compression quality to 90%
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.current(){
                
                //2. We create a Post object from the image
                let post = Post(image: imageFile, user: user, comment: "A Selfie")
                
                post.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        print("Post successfully saved in Parse")
                        
                        //3. Add post to our posts array, chose index 0 so that it will be added
                        //   to the top of your table instead of at the bottom (default behaviour)
                        self.posts.insert(post, at: 0)
                        
                        //4. Now that we have added a post, updating our table
                        //   We are just inserting our new Post instead of reloading our whole tableView
                        //   Both method would work, however, this gives us a cool animation for free
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                })
            }
        }

        //4. We remember to dismiss the Image Picker from our screen.
        dismiss(animated: true, completion: nil)

        //5. Now that we have added a post, reload our table
        tableView.reloadData()
    }
}
