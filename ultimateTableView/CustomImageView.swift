//
//  CustomImageView.swift
//  ultimateTableView
//
//  Created by Mikaela Caron on 3/12/19.
//  Copyright © 2019 Mikaela Caron. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .gray)
    
    func loadImage(from url: URL) {
        
        image = nil
        addSpinner()
        
        //checking if task is nil. if it is it will skip this, otherwise it will cancel the previous task
        if let task = task {
            task.cancel()
        }
        
        //we can safely cast it as a UIImage because we know we saved it as a UIImage
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
         
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print ("Couldn't load image from URL: \(url)")
                return
            }
            
            //After we have the image
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            //makes sure that the task runs on the main thread
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
            
        }//end task
        
        task.resume()
        
    }//end loadImage()
    
    func addSpinner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.startAnimating()
        
    }//end addSpinner()
    
    func removeSpinner() {
        spinner.removeFromSuperview()
    }//end removeSpinner()
    
}//end CustomImageView class
