//
//  TestViewController.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mapTable = NSMapTable<AnyObject, AnyObject>.init(keyOptions: [.weakMemory], valueOptions: [.weakMemory], capacity: 5)
        let man:Person = Man()
        mapTable.setObject(man, forKey: man)
        for obj in mapTable.keyEnumerator().allObjects {
            if obj is Person {
                
                let test = obj as! Person
                test.sex()
                test.age()
            }
        }
        print("\(String(describing: mapTable.object(forKey: man)))")
        print("Keys: \(mapTable.keyEnumerator().allObjects)")
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

}
