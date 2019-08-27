//
//  ViewController.swift
//  ImageBench
//
//  Created by Loren Olson on 4/2/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Image"
        makeView(width: 1000.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = true
    }


}


class Scene: TScene {
    
    var photo: TImage!
    
    override func setup() {
        photo = TImage(contentsOfFileInBundle: "henge.jpg")
    }
    
    override func update() {
        background(gray: 0.5)
        
        let x = remap(value: tin.mouseX, start1: 0, stop1: tin.width, start2: -500, stop2: 0)
        photo.draw(x: x, y: 0)
    }
}

