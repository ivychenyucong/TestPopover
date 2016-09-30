//
//  ViewController.swift
//  TestPopover
//
//  Created by ivy on 16/9/28.
//  Copyright © 2016年 ivy. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
    
    //MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle{
         return .none
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController?{
        let replaceVC = ReplaceViewController()
        return replaceVC;
    }
    
//    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        
//    }
    
    @IBAction func clickBtn(_ sender: AnyObject) {
        let pop = PopViewController()

        //这个属性必须实现,否则popoverPresentationController为nil
        pop.modalPresentationStyle = .popover
        //设置代理,用 adaptivePresentationStyle(for controller) 指定不要全屏显示
        pop.popoverPresentationController?.delegate = self
        
        //popover 的大小
        pop.preferredContentSize = CGSize(width:100, height:100)
        
        //popover基于哪个view出来
        pop.popoverPresentationController?.sourceView = btn
        pop.popoverPresentationController?.sourceRect  = CGRect.zero
//        pop.popoverPresentationController?.sourceRect  = CGRect(origin:CGPoint(x:100,y:100) ,size:CGSize(width:0,height:0))
        
        //popover的箭头方向
        pop.popoverPresentationController?.permittedArrowDirections = .down

        self.present(pop, animated: true, completion: nil)
    }
    
    //MARK: UITraitEnvironment
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)  {
        
        //iphone 横屏
        if previousTraitCollection?.horizontalSizeClass == .compact &&  previousTraitCollection?.verticalSizeClass == .compact{
            print("iphone从横屏->竖屏")
        }
        else if (previousTraitCollection?.horizontalSizeClass == .compact &&  previousTraitCollection?.verticalSizeClass == .regular){
            print("iphone从竖屏->横屏")

        }
    }
    
    
    //MARK: UIContentContainer
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator){
        
        super.willTransition(to: newCollection, with: coordinator)
        

        coordinator.animateAlongsideTransition(in: self.view, animation: { (context) in
            //动画,随便写点啥把.
            self.btn.titleLabel?.text = "gugu"
            
            }) { (context) in
                
                //iphone 横屏
                if newCollection.horizontalSizeClass == .compact &&  newCollection.verticalSizeClass == .compact{
                    print("iphone目前是横屏")
                }
                else if (newCollection.horizontalSizeClass == .compact &&  newCollection.verticalSizeClass == .regular){
                    print("iphone目前是竖屏")
                    
                }

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ivyPopover" {
            let popOverVC = segue.destination
            popOverVC.modalPresentationStyle = .popover
            popOverVC.preferredContentSize = CGSize(width:100, height:100)
            popOverVC.popoverPresentationController?.delegate = self
        }
        
    }
    
    
    
    
    
}

