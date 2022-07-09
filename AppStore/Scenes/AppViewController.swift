//
//  AppViewController.swift
//  AppStore
//
//  Created by 구희정 on 2022/07/08.
//

import SnapKit
import UIKit

final class AppViewController : UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        //StackView 의 방향 = 세로
        stackView.axis = .vertical
        //StackView 의 서브뷰끼리의 간격만 맞춰준다.
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        
        let featureSectionView = UIView()
        let rankingFeatureSectionView = UIView()
        let exchangeCondeButtonView = UIView()
        
        featureSectionView.backgroundColor = .red
        rankingFeatureSectionView.backgroundColor = .blue
        exchangeCondeButtonView.backgroundColor = .yellow
        
        [
            featureSectionView,
            rankingFeatureSectionView,
            exchangeCondeButtonView
        ].forEach{
            $0.snp.makeConstraints { $0.height.equalTo(500) }
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
}

private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        //항상 보여짐
        navigationItem.largeTitleDisplayMode = .always
        //무슨일이 있어도 항상 LargeTitle을 보여줌
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //세로 스크롤을 하기위해 가로를 고정으로 둔다.
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}