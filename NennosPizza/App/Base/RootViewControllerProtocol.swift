//
//  RootViewControllerProtocol.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift
import UIKit

protocol RootViewControllerProtocol {
    var viewController: UIViewController { get }
    var rootViewModel: ScreenViewModelProtocol { get }
    var isNavigationBarEnabled: Bool { get set }
}
