//
//  NotasViewController.swift
//  PontoCerto
//
//  Created by Leonardo Santos on 02/07/17.
//  Copyright © 2017 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class NotasViewController  : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var avaliacoesTableView: UITableView!
 
    
    @IBOutlet weak var mediaTextLabel: UILabel!
    
    func calculaMedia()
    {
        var media : Double = 0.0
        
        var peso : Double = 0
        
        for item in avaliacoes
        {
            media += (item.nota * item.peso)
            peso += item.peso
        }
        if peso > 0
        {
            media = media / peso
        }
        
        
        mediaTextLabel.text = "Média: \(String(format:"%.2f", media))"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData()
        avaliacoesTableView.reloadData()
    }
    
    func getData() {
        do {
            avaliacoes = try context.fetch(Avaliacao.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        
        var aval:[Avaliacao] = []
        
        for av in avaliacoes
        {
            if av.nomeFavorito == nomeDisciplina
            {
                aval.append(av)
            }
        }
        
        avaliacoes = aval
        
        calculaMedia()
    }

    
    var avaliacoes: [Avaliacao] = []
    
//    var tipoAv = ["Prova I","Prova II","Prova Final"]
//    var nota = [1,2,3]
//    var peso = [2,2,6]
    
    @IBOutlet weak var NomeDisciplinaLabel: UILabel!
    
    @IBOutlet weak var tipoAvaliacaoTextField: UITextField!
    
    @IBOutlet weak var pesoTextField: UITextField!
    
    @IBOutlet weak var notaTextField: UITextField!
    
    func alertEmptyFields()
    {
        let alert = UIAlertController(title: "Erro", message: "Por favor preencha corretamente os campos.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addAvaliacao(_ sender: Any)
    {
        var tipoAv:String = ""
        var peso:Double = 0.0
        var nota:Double = 0.0
        
        if let t = tipoAvaliacaoTextField.text
        {
            tipoAv = t
        }
        else
        {
            alertEmptyFields()
            return
        }
        if let n = Double(notaTextField.text!)
        {
            nota = n
        }
        else
        {
            alertEmptyFields()
            return
        }
        if let p = Double(pesoTextField.text!)
        {
            peso = p
        }
        else
        {
            alertEmptyFields()
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let av = Avaliacao(context: context) // Link Task & Context
        av.nomeFavorito = nomeDisciplina
        av.nota = nota
        av.peso = peso
        av.tipoAvaliacao = tipoAv
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        tipoAvaliacaoTextField.text = ""
        notaTextField.text = ""
        pesoTextField.text = ""
        
        getData()
        avaliacoesTableView.reloadData()
    }
    
    
    var nomeDisciplina : String! = nil
    
    
    public func alteraNome(nome : String)
    {
        nomeDisciplina = nome;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return avaliacoes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if avaliacoes.count > 0
        {
            let avs = avaliacoes[indexPath.row]
            
            if nomeDisciplina == avs.nomeFavorito
            {               //print(avaliacoes[indexPath.row].tipoAvaliacao)
                if let cell = tableView.dequeueReusableCell(withIdentifier: "dadosAvaliacao") {
                    (cell.contentView.viewWithTag(10) as! UILabel).text = avs.tipoAvaliacao
                    (cell.contentView.viewWithTag(20) as! UILabel).text = String(avs.nota)
                    (cell.contentView.viewWithTag(30) as! UILabel).text = String(avs.peso)
                    
                    return cell
                }
            }
        }
        let cell = UITableViewCell()
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let av = avaliacoes[indexPath.row]
            print(av.tipoAvaliacao!)
            context.delete(av)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                avaliacoes = try context.fetch(Avaliacao.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        avaliacoesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NomeDisciplinaLabel.text = nomeDisciplina;
        
        self.title = "Notas"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
