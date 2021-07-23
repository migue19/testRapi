//
//  AuthVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 21/07/21.
//

import UIKit
import WebKit
import NutUtils
protocol AuthApproveTokenDelegate {
    func ApproveSuccess(token: String)
}
class AuthVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var url: URL!
    var token: String!
    var delegate: AuthApproveTokenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    init(url: URL, token: String) {
        self.url = url
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Error al cargar XIB")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
}
extension AuthVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if url?.absoluteString == "https://www.themoviedb.org/auth/access/approve" {
            self.dismiss(animated: true) { [weak self] in
                let token = self?.token
                self?.delegate?.ApproveSuccess(token: token.valueOrEmpty)
            }
        }
        decisionHandler(.allow)
    }
}
