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
    
    var segundos = 10
    var guardSegundos = 10
    var timer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTimer.delegate = self
        pickerTimer.dataSource = self
    }
    
    
    @IBAction func IniciarContagem(_ sender: Any) {
        
        if(btnIniciarParar.titleLabel?.text == "Iniciar") {
            self.btnIniciarParar.setTitle("Parar", for: .normal)
            self.pickerTimer.isHidden = true
            self.lbContador.isHidden = false
            segundos = guardSegundos
            lbContador.text = String(segundos)
                        
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(contador),
                                         userInfo: nil,
                                         repeats: true)
        }
        else {
            timer.invalidate()
            limparCampos()
        }
    }
    
    @objc func contador() {
            if (segundos > 1) {
                segundos -= 1
                lbContador.text = String(segundos)
            } else {
                lbContador.text = String(0)
                encerrarContagem()
        }
    }
    
    func encerrarContagem() {
        timer.invalidate()
        
        let alert = UIAlertController(title: "Atencao!",
                                      message: "Seu Tempo acabou!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
            self.limparCampos()
        }))
        self.present(alert, animated: true)
    }
    
    func limparCampos() {
        self.btnIniciarParar.setTitle("Iniciar", for: .normal)
        self.pickerTimer.isHidden = false
        self.lbContador.isHidden = true
        self.lbContador.text = String(0)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayDados.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.arrayDados[row] as! NSString as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.segundos = Int(String(self.arrayDados[row]as! NSString).prefix(2))!
        self.guardSegundos = segundos
    }
    
}

