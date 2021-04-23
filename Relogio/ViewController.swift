//
//  ViewController.swift
//  Relogio
//
//  Created by aluno on 14/04/21.
//  Copyright © 2021 Cesar School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerTimer: UIPickerView!
    @IBOutlet weak var lbContador: UILabel!
    @IBOutlet weak var btnIniciarParar: UIButton!
    
    var arrayDados: NSArray = ["10 segundos",
                               "20 segundos",
                               "30 segundos",
                               "40 segundos",
                               "50 segundos",
                               "60 segundos"]
    
    var segundos: Int = 0
    
    var cronometro: Cronometro?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTimer.delegate = self
        pickerTimer.dataSource = self
        
        self.cronometro = Cronometro(refreshInterval: TimeInterval(0.01)) {
            (elapsedTime: TimeInterval, remainingTime: TimeInterval?) in
            if remainingTime != nil {
                self.lbContador.text = String(Int(((remainingTime ?? 10) / 1) * 1000))

            } else {
                self.lbContador.text = String(Int(((elapsedTime ) / 1) * 1000))
            }
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayDados.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        self.segundos = Int(String(String(self.arrayDados[row] as! String).prefix(2)))!
        
        // Título com a posição do array com a linha do picker
        return self.arrayDados[row] as! NSString as String
    }
    
    @IBAction func IniciarContagem(_ sender: Any) {
        
        if(btnIniciarParar.titleLabel?.text == "Iniciar") {
            self.btnIniciarParar.setTitle("Parar", for: .normal)
            self.pickerTimer.isHidden = true
            self.lbContador.isHidden = false
            print(segundos)
            
            if ( segundos > 0 ) {
                cronometro?.setLimit(timeLimit: TimeInterval(segundos)) {
                    print("iniciou...")
                    print(TimeInterval(self.segundos))
                    
                    let alert = UIAlertController(title: "cronometro", message: "Segundos", preferredStyle: .alert)
                    self.present(alert, animated: true)
                }
            } else {
                cronometro?.timeLimit = nil
            }
            //cronometro?.start()
        }
        else {
            self.btnIniciarParar.setTitle("Iniciar", for: .normal)
            self.pickerTimer.isHidden = false
            self.lbContador.isHidden = true
        }
    }
}

