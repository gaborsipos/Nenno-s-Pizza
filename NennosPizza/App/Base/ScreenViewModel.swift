//
//  ScreenViewModel.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

class ScreenViewModel: ScreenViewModelProtocol {
    // MARK: - ScreenViewModelProtocol properties

    let disposeBag = DisposeBag()

    private(set) var showSnackbarPublisher = PublishSubject<String>()

    // MARK: - ScreenViewModelProtocol functions

    func loadData() {
    }

    // MARK: - Functions

    func showSnackbar(_ message: String) {
        showSnackbarPublisher.onNext(message)
    }
}
