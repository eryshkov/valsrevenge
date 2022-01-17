//
//  GameScene+ViewUpdates.swift
//  valsrevenge
//
//  Created by Evgenii Ryshkov on 17.01.2022.
//

import Foundation

extension GameScene: GameViewControllerDelegate {
    func didChangeLayout() {
        let w = view?.bounds.size.width ?? 1024
        let h = view?.bounds.size.height ?? 1336

        if h >= w {//portrait
            camera?.setScale(1)
        } else {
            camera?.setScale(1.25)
        }
    }
}