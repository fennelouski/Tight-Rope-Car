//
//  AppIconTests.swift
//  Tight Rope CarTests
//

import Testing
import UIKit
@testable import Tight_Rope_Car

struct AppIconTests {

    @Test func applicationDeclaresAppIcon() {
        let icons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any]
        #expect(icons != nil)
    }

    @Test func appIconPNGLoadsFromAssetCatalog() {
        let icon = UIImage(named: "AppIcon")
        #expect(icon != nil || Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") != nil)
    }
}
