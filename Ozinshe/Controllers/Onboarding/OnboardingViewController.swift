//
//  OnboardingViewController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit
import SnapKit
import AdvancedPageControl

final class OnboardingViewController: UIViewController {
	
    var viewModel: OnboardingViewModel
    weak var coordinator: AuthenticationDelegate?
    
	private let items: [OnboardingItem] = [
		OnboardingItem(
			title: "ÖZINŞE-ге қош келдің!",
			subtitle: "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары",
			image: .Onboarding.slide1
		),
		OnboardingItem(
			title: "ÖZINŞE-ге қош келдің!", 
			subtitle: "Кез келген құрылғыдан қара\nСүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара",
			image: .Onboarding.slide2
		),
		OnboardingItem(
			title: "ÖZINŞE-ге қош келдің!",
			subtitle: "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз",
			image: .Onboarding.slide3
		),
	]
	
	// MARK: - UI Elements
	
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.itemSize = view.bounds.size
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		collectionView.contentInsetAdjustmentBehavior = .never
		collectionView.isPagingEnabled = true
		collectionView.bounces = false
		collectionView.showsHorizontalScrollIndicator = false
		
		collectionView.register(cellType: OnboardingCell.self)
		
		return collectionView
	}()
	
	private lazy var pageControl: AdvancedPageControlView = {
		let pageControl = AdvancedPageControlView()
		
		pageControl.drawer = ExtendedDotDrawer(
			numberOfPages: items.count,
			height: 6,
			width: 6,
			space: 4,
			raduis: 3,
			indicatorColor: .Onboarding.activeIndicator,
			dotsColor: .Onboarding.indicator,
			borderWidth: 0
		)
		
		return pageControl
	}()
	
	private lazy var skipButton: UIButton = {
		var configuration = UIButton.Configuration.plain()
		
		configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
		
		let button = BaseButton(configuration: configuration)
	
		button.setAttributedTitle(
			NSAttributedString(
				string: "Өткізу",
				attributes: [.font: UIFont.appFont(ofSize: 12, weight: .medium)]
			),
			for: .normal)
		button.tintColor = .Onboarding.skipTitle
		button.backgroundColor = .Onboarding.skipBackground
		button.layer.cornerRadius = 8
		
		button.addTarget(self, action: #selector(navigateToLogin), for: .primaryActionTriggered)
		
		return button
	}()
	
	private lazy var startButton: UIButton = {
		let button = BaseButton()
		
		button.setTitle("Әрі қарай", for: .normal)
		button.titleLabel?.font = .appFont(ofSize: 16, weight: .semiBold)
		button.layer.cornerRadius = 12
		button.backgroundColor = .Button.Primary.background
		button.tintColor = .Button.Primary.text
		button.layer.opacity = 0
		
		button.addTarget(self, action: #selector(navigateToLogin), for: .primaryActionTriggered)
		
		return button
	}()
	
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
}

extension OnboardingViewController {
	private func setupViews() {
		view.addSubviews(collectionView, pageControl, skipButton, startButton)
	}
	
	private func setupConstraints() {
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		pageControl.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(118)
			make.horizontalEdges.equalToSuperview()
		}
		
		skipButton.snp.makeConstraints { make in
			make.top.right.equalTo(view.safeAreaLayoutGuide).inset(16)
		}
		
		startButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(38)
			make.horizontalEdges.equalToSuperview().inset(24)
			make.height.equalTo(56)
		}
	}
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(cellType: OnboardingCell.self, for: indexPath) else {
			fatalError("Cell type cast error!")
		}
		
		cell.setData(withItem: items[indexPath.row])
		
		return cell
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offSet = scrollView.contentOffset.x
		let width = scrollView.frame.width
		let currentIndex = Int(round(offSet/width))
		
		pageControl.setPage(currentIndex)
		
		if currentIndex == items.count - 1 {
			UIView.animate(withDuration: 0.15) {
				self.skipButton.layer.opacity = 0
				self.startButton.layer.opacity = 1
			}
		} else {
			UIView.animate(withDuration: 0.15) {
				self.skipButton.layer.opacity = 1
				self.startButton.layer.opacity = 0
			}
		}
	}
}

extension OnboardingViewController {
	@objc
	private func navigateToLogin() {
        coordinator?.showLogin()
    }
}
