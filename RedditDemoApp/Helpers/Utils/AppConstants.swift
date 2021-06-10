//
//  AppConstants.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

struct AppConstants {

    static let clientId = "e9lmTPDTWyGwdA"
    static let authRedirectUri = "reddit-app://auth-completion"

    static let authPermissionURLFormat = "https://www.reddit.com/api/v1/authorize.compact?client_id=%@&response_type=code&state=state&redirect_uri=%@&duration=temporary&scope=read"

}
