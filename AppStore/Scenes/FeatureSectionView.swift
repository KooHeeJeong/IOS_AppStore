//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by 구희정 on 2022/07/10.
//

import UIKit
import SnapKit

final class FeatureSectionView : UIView {
    private var featureList: [Feature] = []
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        //페이징 처리할 때, 페이지가 화면에 딱 맞게 떨어지도록 옵션
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        //스크롤이 생기지 않도록 옵션
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            FeatureSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell")
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        fechData()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatureSectionView : UICollectionViewDelegateFlowLayout {
    //sizeForItemAt = Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0 , height: frame.width)
    }
    //insetForSeciontAt = Cell의 Inset (Cell의 중앙정렬을 위해서 left,right에 16을 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    //mininumLineSpacingForSectionAt = Section의 최소 마진 값
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
}

extension FeatureSectionView : UICollectionViewDataSource {
    //numberOfItemsInSection = Section 의 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureList.count
    }
    
    //cellForItemAt = Sceiont Item의 연결
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        
        let feature = featureList[indexPath.item]
        cell?.setup(feature: feature)
        
        return cell ?? UICollectionViewCell()
    }
}

private extension FeatureSectionView {
    func setupViews() {
        [
            collectionView,
            separatorView
        ].forEach{
            addSubview($0)
        }
        
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(snp.width)
        }
        
        separatorView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    func fechData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        }catch {}
    }
    
}
