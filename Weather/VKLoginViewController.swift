//
//  LoginViewController.swift
//  Weather
//
//  Created by Daniil Kniss on 02.12.2020.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!{
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7730247"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "336918"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.68")
                ]
                
                let request = URLRequest(url: urlComponents.url!)
                
                webView.load(request)
        
        
    }
    
}

extension VKLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        print(params)
        
       guard let token = params["access_token"],
             let userIdString = params["user_id"],
             let userId = Int(userIdString) else {
            decisionHandler(.allow)
            return
        
       }
        
        Session.shared.token = token
        
        Session.shared.userId = userId
        
        print("Token: \(token) ")
        
        print("UserID: \(userId)")
        
        performSegue(withIdentifier: "Login", sender: nil)
        
        decisionHandler(.cancel)
    }
    
    
}




//class LoginViewController: UIViewController {
//
//
//    @IBOutlet weak var mainLabel: UIImageView!
//
//    @IBOutlet weak var mainView: UIView!
//
//    @IBOutlet weak var loginLabel: UILabel!
//
//    @IBOutlet weak var loginTextField: UITextField!
//
//    @IBOutlet weak var passwordTextField: UITextField!
//
//    @IBOutlet weak var passwordLabel: UILabel!
//
//    @IBOutlet weak var loginButton: UIButton!
//
//    @IBOutlet weak var dotsView: UIView!
//
//    @IBOutlet weak var dot1: UIImageView! {
//        didSet {
//            dot1.layer.cornerRadius = dot1.frame.width / 2
//            dot1.layer.borderColor = UIColor.gray.cgColor
//            dot1.clipsToBounds = true
//            dot1.alpha = 0
//        }
//    }
//
//    @IBOutlet weak var dot2: UIImageView! {
//        didSet {
//            dot2.layer.cornerRadius = self.dot2.frame.width / 2
//            dot2.layer.borderColor = UIColor.gray.cgColor
//            dot2.clipsToBounds = true
//            dot2.alpha = 0
//        }
//    }
//
//    @IBOutlet weak var dot3: UIImageView! {
//        didSet {
//            dot3.layer.cornerRadius = self.dot3.frame.width / 2
//            dot3.layer.borderColor = UIColor.gray.cgColor
//            dot3.clipsToBounds = true
//            dot3.alpha = 0
//        }
//    }
//
//    @IBAction func loginButtonPressed(_ sender: UIButton) {
//
//        animateDots()
//
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
//            if self.checkUserData() {
//                self.performSegue(withIdentifier: "Login", sender: nil)
//            } else {
//                self.showLoginError()
//            }
//        }
//    }
//
//    @IBOutlet weak var scrollView: UIScrollView!
//
//
//
//    @objc func keyboardWasShown(notification: Notification) {
//
//            // Получаем размер клавиатуры
//            let info = notification.userInfo! as NSDictionary
//            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
//            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
//
//            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
//            self.scrollView?.contentInset = contentInsets
//            scrollView?.scrollIndicatorInsets = contentInsets
//        }
//
//        //Когда клавиатура исчезает
//        @objc func keyboardWillBeHidden(notification: Notification) {
//            // Устанавливаем отступ внизу UIScrollView, равный 0
//            let contentInsets = UIEdgeInsets.zero
//            scrollView?.contentInset = contentInsets
//        }
//
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//
//            // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
//            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
//            // Второе — когда она пропадает
//            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//
//            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        }
//
//    @objc func hideKeyboard() {
//            self.scrollView?.endEditing(true)
//        }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    // Жест нажатия
//    let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//    // Присваиваем его UIScrollVIew
//    scrollView?.addGestureRecognizer(hideKeyboardGesture)
//
//    }
//
//
//        func checkUserData() -> Bool {
//            guard let login = loginTextField.text else { return false }
//            let password = passwordTextField.text
//
//            if login == "1" && password == "1" {
//                return true
//            } else {
//                return false
//            }
//        }
//
//        func showLoginError() {
//            // Создаем контроллер
//            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
//            // Создаем кнопку для UIAlertController
//            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            // Добавляем кнопку на UIAlertController
//            alert.addAction(action)
//            // Показываем UIAlertController
//            present(alert, animated: true, completion: nil)
//        }
//
//
//    func animateDots() {
//
//        if checkUserData() {
//
//            UIView.animate(withDuration: 1) {
//                self.mainLabel.alpha -= 1
//                self.loginLabel.alpha -= 1
//                self.loginTextField.alpha -= 1
//                self.passwordLabel.alpha -= 1
//                self.passwordTextField.alpha -= 1
//                self.loginButton.alpha -= 1
//            }
//
//            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
//                self.dot1.alpha += 1
//            } completion: { _ in
//                self.dot1.alpha = 0
//            }
//
//            UIView.animate(withDuration: 1, delay: 0.3, options: [.autoreverse, .repeat]) {
//                self.dot2.alpha += 1
//            } completion: { _ in
//                self.dot2.alpha = 0
//            }
//
//            UIView.animate(withDuration: 1, delay: 0.7, options: [.autoreverse, .repeat]) {
//                self.dot3.alpha += 1
//            } completion: { _ in
//                self.dot3.alpha = 0
//            }
//        }
//
//    }
//
//}
    
    
    
    
    
    
    





