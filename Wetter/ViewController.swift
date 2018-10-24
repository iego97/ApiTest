//
//  ViewController.swift
//  Wetter
//
//  Created by Alumno on 18/10/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var lblGrados: UILabel!
    
    @IBOutlet weak var aiCargar: UIActivityIndicatorView!
    
      let urlWetter = "https://api.openweathermap.org/data/2.5/weather?q=Berlin&APPID=3326d4de85a204e001116973cc1e557a&units=metric"
    
    let urlConverter = "https://free.currencyconverterapi.com/api/v6/convert?q=USD_MXN&compact=y"
    
    @IBOutlet weak var txtUsd: UITextField!
    @IBOutlet weak var lblMxn: UILabel!
    
    
    @IBAction func doTapConvertirMxnAUsd(_ sender: Any) {
       
        Alamofire.request(urlConverter).responseJSON{
            response in
            
            if let dictConvertidor = response.result.value as? NSDictionary{
                if let dictUsd = dictConvertidor.value(forKey: "USD_MXN") as? NSDictionary{
                    if let val = dictUsd.value(forKey: "val") as? Double{
                        
                        let conversion = (Double(self.txtUsd.text!)!) * val
                        
                        self.lblMxn.text = "\(conversion)"
                        
                        
                    }
                    
                }
            }else{
                
            }
        }
        
    }
    
    
    @IBAction func doTapActualizarClima(_ sender: Any) {
        lblGrados.text = "-"
        aiCargar.startAnimating()
        
        
        
        
        //INICIO CLIMA
        Alamofire.request(urlWetter).responseJSON {
            response in
            if let dictRespuesta = response.result.value as? NSDictionary{
                
                if let dictMain = dictRespuesta.value(forKey: "main") as? NSDictionary{
                    
                    if let temp = dictMain.value(forKey: "temp") as? Double{
                        
                        self.lblGrados.text = "\(temp) ºC"
                        self.aiCargar.stopAnimating()
                        
                    }
                }
                
            }else{
                
            }
        }
        //FIN CLIMA
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aiCargar.startAnimating()
        
     
        
        Alamofire.request(urlWetter).responseJSON {
            response in
            if let dictRespuesta = response.result.value as? NSDictionary{
                
                if let dictMain = dictRespuesta.value(forKey: "main") as? NSDictionary{
                    
                    if let temp = dictMain.value(forKey: "temp") as? Double{
                    
                        self.lblGrados.text = "\(temp) ºC"
                        self.aiCargar.stopAnimating()
                    
                    }
                }
                
            }else{
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

