//
//  HomeViewController.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var vm: HomeViewModel = HomeViewModel(id: -1)
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        bind()
        
        vm.loadPosts()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_BackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func bind(){
        vm.$postsDataArr.sink(receiveValue: {_ in
            Task {@MainActor in
                self.tableView.reloadData()
            }
        }).store(in: &subscriptions)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.postsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeTableViewCell
        
        let post = vm.postsDataArr[indexPath.row]
        cell.lbl_likes.text = "\(post.id)"
        cell.lbl_title.text = "\(post.title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.postsDataArr.remove(at: indexPath.row)
    }
}

extension HomeViewController: HandlePostsAPICallFlow {
    func handleSuccessFlow() {
        Task {@MainActor in
            tableView.reloadData()
        }
    }
    
    func handleFailureFlow(errString: String) {
        Task {@MainActor in
            let alert = UIAlertController(title: "Oooopss!!", message: errString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
