//
//  Petition.swift
//  P007_WhitehousePetitions
//
//  Created by Alexey Ozerov on 10/08/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
