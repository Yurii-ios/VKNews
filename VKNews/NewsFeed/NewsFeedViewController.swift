//
//  NewsFeedViewController.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 21/10/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic,NewsFeedCodeCellDelegate {

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
  
    private var feedViewModel = FeedViewModel(cells: [])
    @IBOutlet var table: UITableView!
    
    private var titleView = TitleView()
    
    // sozdaem indikator zagryzki
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupTopBar()
    setupTable()
    
    view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    
    interactor?.makeRequest(request: .getNewsFeed)
    interactor?.makeRequest(request: .getUser)
  }
    
    private func setupTable() {
        // registriryem ja4ejky
        table.register(UINib(nibName: "NewsFeedCell", bundle: nil),forCellReuseIdentifier: NewsFeedCell.reuseId)
        // registriruem ja4ejky clasa NewsFeedCodeCell
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
       
        table.addSubview(refreshControl)
    }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayNewsFeed(feedViewModel: let feedViewModel):
        self.feedViewModel = feedViewModel
        table.reloadData()
        // yberaem
        refreshControl.endRefreshing()
    case .displayUser(userViewModel: let userViewModel):
        titleView.set(userViewModel: userViewModel)
    }
  }
    
    private func setupTopBar() {
        // skruwaem kogda listaem wniz, i pojawl kogda listaem w werch
        self.navigationController?.hidesBarsOnSwipe = true
        
        // dobawl titleView na nawbar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    // obnowliaem dannue pri swaipe w niz
    @objc private func refresh() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    //MARK: - NewsFeedCodeCellDelegate
    
    func revealPost(for cell: NewsFeedCodeCell) {
        print("5555")
        // poly4aem dostyp k postId, 4tobu poly4it dostyp k id posta 4tobu w dalnejshem raskrut wes tekst w poste
        guard let indexPath = table.indexPath(for: cell) else { return }
        // poly4aem dostyp k informacii ja4ejki
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.revealPostIds(postId: cellViewModel.postId))
    }
    

  
}

//MARK: - TableView Delegate, UITableViewDataSource

// wuwodim ja4ejki na ekran table view
extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}
