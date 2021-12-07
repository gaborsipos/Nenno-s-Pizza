//
//  ScreenViewModelProtocol.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

protocol ScreenViewModelProtocol {
    var disposeBag: DisposeBag { get }
    var showSnackbarPublisher: PublishSubject<String> { get }

    func loadData()
}
