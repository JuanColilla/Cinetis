//
//  MoviesViewController.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 16/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

/// Movie Collection Storyboard ViewController
class MoviesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    enum CellDisposition {
        case list
        case grid
        var image: String {
            switch self {
            case .list:
                return "square.grid.2x2.fill"
            case .grid:
                return "rectangle.portrait.fill"
            }
        }
        var cellsPerRow: Float {
            switch self {
            case .list:
                return 1
            case .grid:
                return 2
            }
        }
    }
    
    // MARK: Properties
    let collectionViewModel = MoviesViewModel()
    let movieSearchController = UISearchController(searchResultsController: nil)
    var isBarSearchEmpty: Bool {
        return movieSearchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return movieSearchController.isActive && !isBarSearchEmpty
    }
    var orderSegmentedControl = OrderSegmentedControlView()
    var cellDisposition = CellDisposition.grid
    var switchCellDispositionButton = UIBarButtonItem()
    
    // MARK: APP LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetFlowLayout()
        setUpSearchControllerParameters()
        setupUI()
        collectionViewModel.sortMoviesAlphabetically()
        collectionView.register(OrderSegmentedControlView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OrderSegmentedControlView")
    }
   
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        resetFlowLayout()
        orderSegmentedControl.updateSegmentedControlWidth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !collectionViewModel.didOnBoardingLaunch() {
            showOnBoarding()
        }
    }
    
    // MARK: Functions
    func resetFlowLayout() {
        collectionView.collectionViewLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            return flowLayout
        }()
    }
    private func setupUI() {
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(
            image: UIImage(systemName: collectionViewModel.constants.filterButtonImage),
            style: .plain,
            target: self,
            action: #selector(filterButtonAction)))
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height > 1336 {
            switchCellDispositionButton = UIBarButtonItem(image: UIImage(systemName: cellDisposition.image), style: .plain, target: self, action: #selector(switchCellDisposition))
            navigationItem.rightBarButtonItems?.append(switchCellDispositionButton)
        }
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destVc = segue.destination as? MovieDetailsViewController {
            if let cell = sender as? MovieViewCell {
                
                let indexPath = self.collectionView.indexPath(for: cell)?.row ?? 0
                destVc.movieDetailViewModel.movie = collectionViewModel.getMovie(indexPath, isFiltering: isFiltering)
            }
        }        
    }
    
    // MARK: OnBoarding
    func showOnBoarding() {
        performSegue(withIdentifier: collectionViewModel.constants.showboarding, sender: nil)
        collectionViewModel.setLaunchedBefore()
    }
    
    

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewModel.getMoviesCount(isFiltering: isFiltering)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewModel.constants.moviecell, for: indexPath) as? MovieViewCell else {
            return UICollectionViewCell()
        }
        movieCell.cellViewModel.setMovie(movie: collectionViewModel.getMovie(indexPath.row, isFiltering: isFiltering))
        movieCell.setUpUI()

        movieCell.layer.masksToBounds = true
        movieCell.layer.cornerRadius = 15
        
        return movieCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let movieSupplView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OrderSegmentedControlView", for: indexPath) as? OrderSegmentedControlView else {
            return UICollectionReusableView()
        }
        orderSegmentedControl = movieSupplView
        movieSupplView.collectionViewModel = collectionViewModel
        movieSupplView.collectionView = collectionView
        if !movieSupplView.subviews.contains(orderSegmentedControl.orderSegmentedControl) {
            movieSupplView.setUpSegmentedControl()
        }
        return movieSupplView
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Float(UIScreen.main.bounds.width)
        let cellWidth : Float
        let cellHeight : Float
        if UIDevice.current.userInterfaceIdiom == .phone {
            cellWidth = (screenWidth - 40)/cellDisposition.cellsPerRow
            cellHeight = (250/175)*cellWidth
        } else {
            if UIDevice.current.orientation.isLandscape {
                cellWidth = (screenWidth - 60) / 4
                cellHeight = (250/175)*cellWidth
            } else {
                cellWidth = (screenWidth - 50) / 3
                cellHeight = (250/175)*cellWidth
            }
        }
        return CGSize(width: Int(cellWidth), height: Int(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 35)
    }

    
    // MARK: - SearchController
    func setUpSearchControllerParameters() {
        movieSearchController.searchResultsUpdater = self
        movieSearchController.obscuresBackgroundDuringPresentation = false
        movieSearchController.searchBar.placeholder = collectionViewModel.constants.searchBarHint.localized()
        navigationItem.searchController = movieSearchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        collectionViewModel.setFilteredMovies(searchText)
        collectionView.reloadData()
    }
    
    // MARK: - FilterModal
    @IBAction func filterButtonAction() {
        guard let filterVC = UIStoryboard(name: "FilterModal", bundle: Bundle.main).instantiateInitialViewController() else {
            return
        }
        tabBarController?.present(filterVC, animated: true, completion: nil)
    }
    
    @IBAction func unwindFilterModal(unwindSegue: UIStoryboardSegue) {
    }

    // MARK: - CellsDisposition
    @IBAction func switchCellDisposition() {
        switch cellDisposition {
        case .grid:
            cellDisposition = CellDisposition.list
        case .list:
            cellDisposition = CellDisposition.grid
        }
        switchCellDispositionButton.image = UIImage(systemName: cellDisposition.image)
        collectionView.reloadData()
    }
   
}

extension MoviesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = movieSearchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
    
}
