//
//  ViewController.swift
//  PontoCerto
//
//  Created by Leonardo Santos on 02/07/17.
//  Copyright © 2017 Leonardo Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var disciplinas: [Disciplina] = []
    var favoritos: [Favorito] = []
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData()
        DisciplinasTableView.reloadData()
        FavoritosTableView.reloadData()
    }
    
    func getData() {
        do {
            disciplinas = try context.fetch(Disciplina.fetchRequest())
            favoritos = try context.fetch(Favorito.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    func addToDisciplinaCoreData(nome: String)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let disc = Disciplina(context: context) // Link Task & Context
        disc.nome = nome
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addToFavoritoCoreData(nome: String)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favs = Favorito(context: context) // Link Task & Context
        favs.nome = nome
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func removeFromDisciplinaCoreData(nome:String)
    {
        let selectedIndexPath = DisciplinasTableView.indexPathForSelectedRow!
        
        
        let disc = disciplinas[selectedIndexPath.row]
        context.delete(disc)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            disciplinas = try context.fetch(Disciplina.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        
    }

    func removeFromFavoritoCoreData(nome:String)
    {
        let selectedIndexPath = FavoritosTableView.indexPathForSelectedRow!
        
        let favs = favoritos[selectedIndexPath.row]
        context.delete(favs)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            favoritos = try context.fetch(Favorito.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    func populateWhenEmpty()
    {
        var testDisc: [Disciplina] = []
        var testFav: [Favorito] = []
        do {
            testDisc = try context.fetch(Disciplina.fetchRequest())
            testFav = try context.fetch(Favorito.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        
        if(testDisc.count==0 && testFav.count == 0)
        {
            for dis in list
            {
                addToDisciplinaCoreData(nome: dis)
                getData()
                DisciplinasTableView.reloadData()
            }
        }
        
    }

    
    @IBOutlet weak var FavoritosTableView: UITableView!
    
    @IBOutlet weak var DisciplinasTableView: UITableView!
    
    var disciplinaToFav : String! = nil
    
    func alertSelect()
    {
        let alert = UIAlertController(title: "Erro", message: "Por favor selecione um campo primeiro.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func addFavoritoButton()
    {
        var nomeDisciplina:String = ""
        
        if let selectedIndexPath = DisciplinasTableView.indexPathForSelectedRow
        {
            let cell = DisciplinasTableView.cellForRow(at: (selectedIndexPath)) as! Cell
            nomeDisciplina = cell.disciplinaLabel.text!;
            
            removeFromDisciplinaCoreData(nome: nomeDisciplina)
            addToFavoritoCoreData(nome: nomeDisciplina)
            
            getData()
            DisciplinasTableView.reloadData()
            FavoritosTableView.reloadData()
        }
        
        else
        {
            alertSelect();
        }
        

    }
    
    func deleteAllData()
    {
        for item in disciplinas
        {
        context.delete(item)
        }
        for item in favoritos
        {
            context.delete(item)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        getData()
        DisciplinasTableView.reloadData()
        FavoritosTableView.reloadData()
    
    }    
    
    @IBAction func removeFavoritoButton()
    {
        var nomeFavorito:String = ""
        
        if let selectedIndexPath = FavoritosTableView.indexPathForSelectedRow
        {
        
        let cell = FavoritosTableView.cellForRow(at: (selectedIndexPath)) as! Cell
        nomeFavorito = cell.disciplinaLabel.text!;

        
        removeFromFavoritoCoreData(nome: nomeFavorito)
        addToDisciplinaCoreData(nome: nomeFavorito)
        
        getData()
        DisciplinasTableView.reloadData()
        FavoritosTableView.reloadData()
        }
        else
        {
            alertSelect()
        }
        
    }
    
    
    @IBAction func editaFavoritoButton()
    {
        
        if let selectedIndexPath = FavoritosTableView.indexPathForSelectedRow
        {
        let cell = FavoritosTableView.cellForRow(at: (selectedIndexPath)) as! Cell

        let t : String! = cell.disciplinaLabel.text!;
        disciplinaToFav = t
        
        self.performSegue(withIdentifier: "toFav", sender: self)
        }
        else
        {
            alertSelect()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    	{
        if segue.identifier == "toFav"
        {
            let notasViewController = segue.destination as! NotasViewController
            notasViewController.alteraNome(nome: disciplinaToFav)
        }
    }
    
    
    
        var list = ["Administração Financeira","Álgebra Linear","Análise de Algoritmo","Análise de Sistemas","Análise Empresarial e Admin.","Banco de Dados I","Banco de Dados II","Cálculo Diferenc. e Integral I",   "Cálculo Diferenc. e Integral II","Desenvolv. de Páginas Web","Empreendedorismo","Estatística","Estruturas de Dados I","Estruturas de Dados II","Estruturas Discretas","Fund. de Sist. de Informação","Gerência de Proj. de Informat.",   "Interação Humano Computador",   "Introdução à Lógica Computac.","Linguag. Formais e Autômatos","Matemática Básica","Organização de Computadores","Probabilidade","Processos de Software","Programação Modular","Projeto de Graduação I","Projeto de Graduação II",   "Proj. e Const. de Sistemas",   "Proj. Const. Sistemas-SGBD","Redes de Computadores I","Redes de Computadores II","Sistemas Operacionais","Técnicas de Programação I","Técnicas de Programação II","Teorias e Práticas Discursivas","Administ. de Banco de Dados","Algoritmos p/ Prob. Combinat.",   "Ambiente Operacional Unix",   "Compiladores","Computação Gráfica","Comunic. e Segurança de Dados","Desenvolv. de Servidor Web","Fluxos em Redes","Fund. Repr. Conh. e Raciocínio","Gerência de Dados em Amb. Distribuídos e Paralelos","Gest. de Processos de Negócios","Informática na Educação",   "Inteligéncia Artificial",   "Programação Linear","Sistemas Colaborativos","Sistemas Multimídia","Tóp. Avançados em Algoritmos","Tóp. Avançados em BD I","Tóp. Avançados em BD II","Tóp. Avançados em BD III","Tóp. Avançados em Eng. Sw. I","Tóp. Avançados em Eng. Sw. II","Tóp. Avan. em Redes de Comp. I","Tóp. Avan. em Redes de Comp. II","Tóp. Avan. em Redes de Comp. III"]
    
    var favoritosList:[String] = []
    
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            if(tableView == DisciplinasTableView)
            {
                return (disciplinas.count)
            }
            else
            {
                return(favoritos.count)
            }
        }
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            if(tableView == DisciplinasTableView)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
                let disc = disciplinas[indexPath.row]
                
                if let myName = disc.nome {
                    cell.disciplinaLabel.text = myName
                }
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
                let favs = favoritos[indexPath.row]
                
                if let myName = favs.nome {
                    cell.disciplinaLabel.text = myName
                }
                return cell
            }
        }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let disc = disciplinas[indexPath.row]
//            context.delete(disc)
//            (UIApplication.shared.delegate as! AppDelegate).saveContext()
//            
//            do {
//                disciplinas = try context.fetch(Disciplina.fetchRequest())
//            } catch {
//                print("Fetching Failed")
//            }
//        }
//        DisciplinasTableView.reloadData()
//    }
    
    func ordenaArrayString(array:[String]) -> [String]
    {
        return array.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Disciplinas"
        
        DisciplinasTableView.delegate = self
        DisciplinasTableView.dataSource = self
        
        FavoritosTableView.delegate = self
        FavoritosTableView.dataSource = self
        
        populateWhenEmpty()
        
        self.DisciplinasTableView.estimatedRowHeight = 80
        self.DisciplinasTableView.rowHeight = UITableViewAutomaticDimension
        
        self.FavoritosTableView.estimatedRowHeight = 80
        self.FavoritosTableView.rowHeight = UITableViewAutomaticDimension
        
        self.DisciplinasTableView.setNeedsLayout()
        self.DisciplinasTableView.layoutIfNeeded()
        
        self.FavoritosTableView.setNeedsLayout()
        self.FavoritosTableView.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

