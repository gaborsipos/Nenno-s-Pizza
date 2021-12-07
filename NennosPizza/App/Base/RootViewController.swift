//
//  RootViewController.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift
import UIKit

class RootViewController: UIViewController {
    // MARK: - RootViewControllerProtocol properties

    var viewController: UIViewController {
        return self
    }

    let rootViewModel: ScreenViewModelProtocol
    var isNavigationBarEnabled = true

    // MARK: - Properties

    var shouldUpdateViewConstraints = true {
        didSet {
            if shouldUpdateViewConstraints {
                view.setNeedsUpdateConstraints()
            }
        }
    }

    let disposeBag = DisposeBag()

    private var showSnackbarAnimator: UIViewPropertyAnimator?
    private var hideSnackbarAnimator: UIViewPropertyAnimator?
    private var snackbarTimer: Timer?

    private lazy var snackbarView: NPSnackbarView = {
        let snackbarView = NPSnackbarView()
        snackbarView.translatesAutoresizingMaskIntoConstraints = false

        return snackbarView
    }()

    // MARK: - Initialization

    init(viewModel: ScreenViewModelProtocol) {
        self.rootViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController functions

    override func loadView() {
        view = createView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if navigationController?.isNavigationBarHidden == isNavigationBarEnabled {
            navigationController?.setNavigationBarHidden(!isNavigationBarEnabled, animated: animated)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
        view.setNeedsUpdateConstraints()
        rootViewModel.loadData()
    }

    override func updateViewConstraints() {
        if shouldUpdateViewConstraints {
            shouldUpdateViewConstraints = false
            setupViewConstraints()
        }

        super.updateViewConstraints()
    }

    // MARK: - Functions

    /// Add your subviews. Call the super for the root view, add your subviews to it and return the root view.
    func createView() -> NPView {
        return NPView()
    }

    /// Initialize your views. This will be called in the `viewDidLoad` lifecycle function.
    func initializeView() {
        view.accessibilityIdentifier = String(describing: type(of: self))

        view.backgroundColor = .white

        navigationController?.navigationBar.tintColor = UIColor(hex: "#E14D45")

        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .heavy),
            NSAttributedString.Key.foregroundColor: UIColor(hex: "#E14D45")
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        rootViewModel.showSnackbarPublisher
            .subscribe(onNext: { [weak self] message in
                guard let self = self else { return }

                self.showSnackbar(message: message)
            })
            .disposed(by: disposeBag)
    }

    /// Setup your constraints here. Set `shouldUpdateViewConstraints` to `true` to trigger this.
    func setupViewConstraints() {
    }

    private func showSnackbar(message: String) {
        let timerInterval = 3.0
        snackbarTimer?.invalidate()

        snackbarView.message = message

        if snackbarView.superview == nil {
            view.addSubview(snackbarView)

            snackbarView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        } else if hideSnackbarAnimator?.isRunning ?? false {
            hideSnackbarAnimator?.stopAnimation(true)
        } else {
            snackbarTimer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false, block: { [weak self] _ in
                self?.hideSnackbar()
            })
            return
        }

        snackbarView.alpha = 0
        snackbarView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        showSnackbarAnimator = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut)
        showSnackbarAnimator?.addAnimations {[weak self] in
            guard let self = self else { return }

            self.snackbarView.alpha = 1
            self.snackbarView.transform = .identity
        }
        showSnackbarAnimator?.addCompletion { [weak self] _ in
            self?.snackbarTimer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false, block: { _ in
                self?.hideSnackbar()
            })
        }
        showSnackbarAnimator?.startAnimation()
    }

    private func hideSnackbar() {
        hideSnackbarAnimator?.stopAnimation(true)
        hideSnackbarAnimator = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut)
        hideSnackbarAnimator?.addAnimations { [weak self] in
            self?.snackbarView.alpha = 0
        }
        hideSnackbarAnimator?.addCompletion({ [weak self] _ in
            self?.snackbarView.removeFromSuperview()
        })
        hideSnackbarAnimator?.startAnimation()
    }
}

// MARK: - RootViewControllerProtocol

extension RootViewController: RootViewControllerProtocol {
}
