//
//  ViewController.swift
//  slideOutMenu
//
//  Created by apple on 06.10.2022.
//

import UIKit

class  HomeController : UITableViewController {
    //MARK: - Properties
    
    private let menuWidth: CGFloat = 300
    //MARK: - Lifecycle
    let menuController = MenuController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItes()
        setupMenuController()

        let penGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePen))
        view.addGestureRecognizer(penGesture)
    }
    //MARK: - helper funcs
    fileprivate func setupNavigationItes() {
        navigationItem.title = "Home"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain , target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(hanleHide))
    }
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.currentUIWindow()
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)
    }
    private func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.menuController.view.transform = transform
            self.navigationController?.view.transform = transform
        }

    }
    //MARK: - selector funcs
    @objc private func handlePen(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        print("DEBAG: pan gesture...", translation)
        menuController.view.transform = CGAffineTransform(translationX: translation.x, y: 0 )
        navigationController?.view.transform = CGAffineTransform(translationX: translation.x, y: 0 )

    }
    @objc private func hanleHide() {
        print("DEBAG: test hide..")
        performAnimation(transform: .identity)
    }

    @objc private func handleOpen() {
        print("DEBAG: test open..")
        performAnimation(transform: .init(translationX: self.menuWidth, y: 0))
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .red
        cell.textLabel?.text = "Main \(indexPath.item)"
        return cell
    }
    
}

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}
