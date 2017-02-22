//
//  ClockInViewController.swift
//  BestBrain
//
//  Created by Suhani on 10/01/17.
//  Copyright © 2017 bestbrainLLC. All rights reserved.
//

import UIKit

class ClockInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.evo_drawerController?.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnMenuClicked(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
}
