//
//  ViewController.swift
//  PontoCerto
//
//  Created by Leonardo Santos on 02/07/17.
//  Copyright © 2017 Leonardo Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var FavoritosTableView: UITableView!
    
    @IBOutlet weak var DisciplinasTableView: UITableView!
    
    
    @IBAction func addFavoritoButton()
    {
        let selectedIndexPath = DisciplinasTableView.indexPathForSelectedRow
        let index:Int  = (selectedIndexPath!.last!)
        favoritosList.append(list[index])
        list.remove(at: index)
        
        favoritosList = ordenaArrayString(array: favoritosList)
        list = ordenaArrayString(array: list)
        
        DisciplinasTableView.reloadData()
        FavoritosTableView.reloadData()
    }
    
    @IBAction func removeFavoritoButton()
    {
        let selectedIndexPath = FavoritosTableView.indexPathForSelectedRow
        let index:Int  = (selectedIndexPath!.last!)
        list.append(favoritosList[index])
        favoritosList.remove(at: index)
        
        favoritosList = ordenaArrayString(array: favoritosList)
        list = ordenaArrayString(array: list)
        
        DisciplinasTableView.reloadData()
        FavoritosTableView.reloadData()
    }
    
    
        var list = ["Administração Financeira","Álgebra Linear","Análise de Algoritmo","Análise de Sistemas","Análise Empresarial e Admin.","Banco de Dados I","Banco de Dados II","Cálculo Diferenc. e Integral I",   "Cálculo Diferenc. e Integral II","Desenvolv. de Páginas Web","Empreendedorismo","Estatística","Estruturas de Dados I","Estruturas de Dados II","Estruturas Discretas","Fund. de Sist. de Informação","Gerência de Proj. de Informat.",   "Interação Humano Computador",   "Introdução à Lógica Computac.","Linguag. Formais e Autômatos","Matemática Básica","Organização de Computadores","Probabilidade","Processos de Software","Programação Modular","Projeto de Graduação I","Projeto de Graduação II",   "Proj. e Const. de Sistemas",   "Proj. Const. Sistemas-SGBD","Redes de Computadores I","Redes de Computadores II","Sistemas Operacionais","Técnicas de Programação I","Técnicas de Programação II","Teorias e Práticas Discursivas","Administ. de Banco de Dados","Algoritmos p/ Prob. Combinat.",   "Ambiente Operacional Unix",   "Compiladores","Computação Gráfica","Comunic. e Segurança de Dados","Desenvolv. de Servidor Web","Fluxos em Redes","Fund. Repr. Conh. e Raciocínio","Gerência de Dados em Amb. Distribuídos e Paralelos","Gest. de Processos de Negócios","Informática na Educação",   "Inteligéncia Artificial",   "Programação Linear","Sistemas Colaborativos","Sistemas Multimídia","Tóp. Avançados em Algoritmos","Tóp. Avançados em BD I","Tóp. Avançados em BD II","Tóp. Avançados em BD III","Tóp. Avançados em Eng. Sw. I","Tóp. Avançados em Eng. Sw. II","Tóp. Avan. em Redes de Comp. I","Tóp. Avan. em Redes de Comp. II","Tóp. Avan. em Redes de Comp. III"]
    
    var favoritosList:[String] = []
    
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            if(tableView == DisciplinasTableView)
            {
                return (list.count)
            }
            else
            {
                return(favoritosList.count)
            }
        }
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            if(tableView == DisciplinasTableView)
            {
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
                cell.textLabel?.text = list[indexPath.row]
                
                return(cell)
            }
            else
            {
            
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
                cell.textLabel?.text = favoritosList[indexPath.row]
            
                return(cell)
            }
        }
    
    func ordenaArrayString(array:[String]) -> [String]
    {
        return array.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Controle de disciplinas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

