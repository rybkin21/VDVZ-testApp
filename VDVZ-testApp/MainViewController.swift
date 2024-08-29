
import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Outlets

    private var viewModel = ProductsViewModel()
    private var products: [ProductData] = []

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var sectionButtons: UISegmentedControl = {
        let sectionButtons = UISegmentedControl()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        sectionButtons.setTitleTextAttributes(titleTextAttributes, for: .selected)
        sectionButtons.addTarget(self, action: #selector(sectionChanget), for: .valueChanged)
        return sectionButtons
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        loadData()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.backgroundColor = .systemBackground
        view.addSubviews(sectionButtons, collectionView)
    }

    private func setupLayout() {

        sectionButtons.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionButtons.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(220)
        }
    }

    // MARK: - Actions

    @objc private func sectionChanget() {
        let selectedIndex = sectionButtons.selectedSegmentIndex
        if selectedIndex < viewModel.sections.count {
            viewModel.products = viewModel.sections[selectedIndex].productData
            collectionView.setContentOffset(.zero, animated: true)
            collectionView.reloadData()
        }

    }

    private func loadData() {
        viewModel.fetchProducts { [weak self] in
            DispatchQueue.main.async {
                self?.setupSections()
                self?.collectionView.reloadData()
            }
        }
    }

    private func setupSections() {
        for section in viewModel.sections {
            sectionButtons.insertSegment(withTitle: section.name,
                                         at: section.id,
                                         animated: false)
        }
        sectionButtons.selectedSegmentIndex = 0
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.configuration(model: viewModel.products[indexPath.item])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: collectionView.bounds.width / 2.4, height: collectionView.bounds.height)
            return size
        }
}
