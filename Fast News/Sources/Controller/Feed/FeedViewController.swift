//
//  FeedViewController.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Constants
    
    let kToDetails: String = "toDetails"
    
    //MARK: - Properties
    
    var viewModels: [HotNewsViewModel] = [HotNewsViewModel]()
    
    var hotNews: [HotNews] = [HotNews]() {
        didSet {
            _ = hotNews.map { (news) in
                viewModels.append(HotNewsViewModel(hotNews: news))
            }
            
            self.mainView.setup(with: viewModels, and: self)
        }
    }
    
    var mainView: FeedView {
        guard let view = self.view as? FeedView else {
            fatalError("View is not of type FeedView!")
        }
        return view
    }
    
    var fetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fast News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadNews()
    }
    
    func loadNews(){
        
        if !NetworkStatus.shared.isConnected {
            self.hotNews = InMemoryDb.shared.getHotNews()
            return
        }
        
        if !fetching {
            fetching = true
            
            DispatchQueue.main.async {
                HotNewsProvider.shared.hotNews { (completion) in
                    do {
                        let hotNews = try completion()
                        
                        if hotNews.count > 0 { InMemoryDb.shared.removeAll() }
                        for news in hotNews {
                            InMemoryDb.shared.save(model: news)
                        }
                        
                        self.hotNews = InMemoryDb.shared.getHotNews()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    self.fetching = false
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hotNewsViewModel = sender as? HotNewsViewModel else { return }
        guard let detailViewController = segue.destination as? FeedDetailsViewController else { return }
        
        detailViewController.hotNewsViewModel = hotNewsViewModel
    }
}

extension FeedViewController: FeedViewDelegate {
    func didTapShare(url: String?) {
        if url == nil { return }
        let activityVC = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func loadMoreNews() {
        self.loadNews()
    }
    
    func didTouch(cell: FeedCell, indexPath: IndexPath) {
        self.performSegue(withIdentifier: kToDetails, sender: self.mainView.viewModels[indexPath.row])
    }
}
