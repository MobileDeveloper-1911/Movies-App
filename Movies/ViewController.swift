//
//  ViewController.swift
//  Movies
//
//  Created by Vaibhav Gawde on 07/02/24.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newsTableView : UITableView!
    private var newsViewModel = NewsViewModel()
    
    var newsArticle : NewsResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: NewsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        
        observeEvents()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticle?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as! NewsTableViewCell
        
        cell.newsDescription.text = newsArticle?.articles[indexPath.row].description
        cell.newsImage.setImage(with: newsArticle?.articles[indexPath.row].urlToImage ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: newsArticle?.articles[indexPath.row].url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    func observeEvents(){
        self.newsViewModel.getNews()
        self.newsViewModel.events = {
            [weak self] events in guard let self else {
                return
            }
            
            switch events {
                
            case .loading:
                print("Loading")
            case .stopLoading:
                print("Stop Loading")
            case .success:
                print("Success")
                self.newsArticle = self.newsViewModel.news
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }

            case .error(error: let error):
                print(error)

            }
        }
    }


}





