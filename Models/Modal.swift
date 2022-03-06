//
//  Modal.swift
//  GIFKeyboard
//
//  Created by Antoine Thiel on 05/03/2022.
//
import UIKit
import Foundation

class GIFModal: UIViewController, UITextFieldDelegate {
    
    var searchBar:UITextField! = nil
    var scrollView:UIScrollView = UIScrollView()
    let apiUtils:ApiUtils = ApiUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar = UITextField(frame: CGRect(x: 20, y: 20, width: 300, height: 40))
        self.searchBar.placeholder = "Search GIF"
        self.searchBar.borderStyle = .roundedRect
        self.searchBar.autocorrectionType = .no
        self.searchBar.keyboardType = .default
        self.searchBar.returnKeyType = .done
        self.searchBar.clearButtonMode = .whileEditing
        self.searchBar.contentVerticalAlignment = .center
        self.searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        self.scrollView = UIScrollView(frame: CGRect(x: 20, y: 70, width: 300, height: 500))
        self.scrollView.backgroundColor = UIColor.gray
        self.view.addSubview(scrollView)
        //self.becomeFirstResponder()
    }
    
    func populateModal(imgs:[String]) {
        var i = 0
        for img in imgs {
            let imageURL = UIImage.gifImageWithURL(img)
            let imageView = UIImageView(image: imageURL)
            let xPosition = view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width - 40, height: self.scrollView.frame.height)
            scrollView.contentSize.width = scrollView.frame.width * CGFloat( i + 1)
            scrollView.addSubview(imageView)
            i = i + 1
        }
        view.addSubview(scrollView)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchBar.resignFirstResponder()
        print("coucou")
        guard let text = self.searchBar.text else {
            return false
        }
        print("coucou")
        apiUtils.getGifBySearchTerm(searchTerm: text){ err, items in
            guard err == nil else {
                return
            }
            guard let gifs = items else {
                return
            }
            var urls = [String]()
            for gif in gifs {
                urls.append(gif.media[0].tinygif.url)
            }
            self.populateModal(imgs: urls)
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           // return NO to disallow editing.
           print("TextField should begin editing method called")
           return true
       }

       func textFieldDidBeginEditing(_ textField: UITextField) {
           // became first responder
           print("TextField did begin editing method called")
       }

       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
           print("TextField should snd editing method called")
           return true
       }

       func textFieldDidEndEditing(_ textField: UITextField) {
           // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
           print("TextField did end editing method called")
       }

    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
           // if implemented, called in place of textFieldDidEndEditing:
           print("TextField did end editing with reason method called")
       }

       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // return NO to not change text
           print("While entering the characters this method gets called")
           return true
       }

       func textFieldShouldClear(_ textField: UITextField) -> Bool {
           // called when clear button pressed. return NO to ignore (no notifications)
           print("TextField should clear method called")
           return true
       }
    
}
