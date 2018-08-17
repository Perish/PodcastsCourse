//
//  String.swift
//  PodcastsCourse
//
//  Created by 徐冲 on 2018/8/17.
//  Copyright © 2018年 徐冲. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
