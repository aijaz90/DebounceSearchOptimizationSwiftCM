//
//  ViewController.swift
//  DebounceSearchOptimizationSwiftCM
//
//  Created by Aijaz Ali on 08/02/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.searchController = searchController
        self.setupSearchBarListeners()
    }
    
    fileprivate func setupSearchBarListeners() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
        
        publisher.map ({
            ($0.object as! UITextField).text
        })
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .removeDuplicates() // if there is same text don't call the sink method
        .sink { str in
            // here you call the api or search action to be performed.
            
            print((str ?? ""))
        }.store(in: &cancellables)
        
        //       _ = publisher.sink { (notification) in
        //           print(123)
        //           guard let textField = notification.object as? UISearchTextField else { return }
        //           print(textField.text!)
        //        }
    }
    
    fileprivate func searchText(query: String) {
        
    }
}

