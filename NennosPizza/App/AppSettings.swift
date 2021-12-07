//
//  AppSettings.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

struct AppSettings {
    // MARK: - Properties

    static var doclerApiEnvironment: DoclerApiEnvironment {
        DoclerApiEnvironment(baseUrl: "https://doclerlabs.github.io/mobile-native-challenge",
                             checkoutBaseUrl: "https://httpbin.org/post")
    }
}

struct DoclerApiEnvironment {
    // MARK: - Properties

    var baseUrl: String
    var checkoutBaseUrl: String
}
