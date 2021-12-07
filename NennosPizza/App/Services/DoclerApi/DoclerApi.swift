//
//  DoclerApi.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Moya

enum DoclerApi {
    case pizzas
    case ingredients
    case drinks
    case checkout(params: CheckoutRequestParams)
}

extension DoclerApi: TargetType {
    var baseURL: URL {
        switch self {
        case .checkout:
            return URL(string: AppSettings.doclerApiEnvironment.checkoutBaseUrl)!
        default:
            return URL(string: AppSettings.doclerApiEnvironment.baseUrl)!
        }
    }

    var path: String {
        switch self {
        case .pizzas:
            return "pizzas.json"
        case .ingredients:
            return "ingredients.json"
        case .drinks:
            return "drinks.json"
        case .checkout:
            return ""
        }
    }

    var method: Method {
        switch self {
        case .pizzas, .ingredients, .drinks:
            return .get
        case .checkout:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .pizzas, .ingredients, .drinks:
            return .requestPlain
        case .checkout(let params):
            return .requestJSONEncodable(params)
        }
    }

    var headers: [String: String]? {
        nil
    }
}
