//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController{
    
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    
    @IBOutlet weak var imageViewRapptrAnimation: UIImageView!
    @IBOutlet weak var buttonFadeIn: UIButton!
    
    private var didImageFade = false
    private var rapptrImageName = "ic_logo"
    private var isDragging = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
    
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        
        if(didImageFade){
            fadeImage(toImageNamed: rapptrImageName)
        }else{
            fadeImage(toImageNamed: "")
        }
        
        didImageFade = !didImageFade
        print(didImageFade)
    }
    
    func setupUI(){
        // fade in button
        buttonFadeIn.backgroundColor = UIColor(hexString: "#0E5C89")
        buttonFadeIn.tintColor = UIColor(hexString: "#FFFFFF")
        buttonFadeIn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                
        // rapptr image
        imageViewRapptrAnimation.image = UIImage(named: rapptrImageName)
        
        // screen background
        view.backgroundColor = UIColor(hexString: "#F9F9F9")
    }
    
    func fadeImage(toImageNamed: String){
        let toImage = UIImage(named:toImageNamed)
        UIView.transition(with: self.imageViewRapptrAnimation,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { self.imageViewRapptrAnimation.image = toImage },
                          completion: nil)
    }
    
}

extension AnimationViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        let location = touch.location(in: imageViewRapptrAnimation)
        if imageViewRapptrAnimation.bounds.contains(location){
            print("did touch image")
            isDragging = true
        }else{
            isDragging = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else{
            return
        }
        
        let location = touch.location(in: view)
        
        imageViewRapptrAnimation.frame.origin.x = location.x - (imageViewRapptrAnimation.frame.width / 2)
        imageViewRapptrAnimation.frame.origin.y = location.y - (imageViewRapptrAnimation.frame.height / 2)
        
    }
}
