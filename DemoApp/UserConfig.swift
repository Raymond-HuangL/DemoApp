//
//  UserConfig.swift
//  DemoApp
//
//  Created by 黄磊 on 2026/4/6.
//


import AutoConfig
import PushManager

final class UserConfig: ConfigProtocol {
    static let configs: [ConfigPair] = [
        .make(.pushDefaultSceneId, s_appSceneId),
    ]
}
