//
//  BiometricTest.swift
//  Biometrics
//
//  Created by Andrew Seeley on 28/8/18.
//  Copyright © 2018 Seemu. All rights reserved.
//

import Foundation
import LocalAuthentication

var biometricType: LABiometryType {
    let authContext = LAContext()
    return authContext.biometryType
}
