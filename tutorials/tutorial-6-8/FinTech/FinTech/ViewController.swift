//
//  ViewController.swift
//  FinTech
//
//  Created by Nadia on 01.12.2020.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Лейблы со значениями
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companySymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    // Индикатор активности
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // Пикер
    @IBOutlet weak var companyPicker: UIPickerView!
    
    
    // Методы, чтобы пикер обновлялся и нормально работыл
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.companies.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(self.companies.keys)[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.requestQuoteUpdate()
    }

    // Словарь с компаниями для пикера
    private var companies : [String: String] = ["Apple": "AAPL",
                                                "Microsoft": "MSFT",
                                                "Google": "GOOG",
                                                "Amazon": "AMZN",
                                                "Facebook": "FB"]
    
    // То что происходит на запуске
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestQuoteCompanies()
        
        self.companyPicker.dataSource = self
        self.companyPicker.delegate = self
        
        self.activityIndicator.hidesWhenStopped = true;
        
        self.requestQuoteUpdate()
    }
    
    // Обновление полей
    private func requestQuoteUpdate() {
        self.activityIndicator.startAnimating()
        self.companyNameLabel.text = "-"
        self.companySymbolLabel.text = "-"
        self.priceLabel.text = "-"
        self.priceChangeLabel.text = "-"
        self.priceChangeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha:1.0)
        
        let selectedRow = self.companyPicker.selectedRow(inComponent: 0)
        let selectedSymbol = Array(self.companies.values)[selectedRow]
        requestQuote(for: selectedSymbol)
    }
    
    // Заполнение полей на экране
    private func displayStockInfo(companyName: String, symbol : String, price: Double, priceChange: Double) {
        activityIndicator.stopAnimating()
        self.companyNameLabel.text = companyName
        self.companySymbolLabel.text = symbol
        self.priceLabel.text = "\(price)"
        
        self.priceChangeLabel.text = "\(priceChange)"
        if priceChange>0 {
            self.priceChangeLabel.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }
        if priceChange<0 {
            self.priceChangeLabel.textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }


    // Запрос к API для получения данных о компании
    private func requestQuote(for symbol: String) {
        let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote/?token=pk_d588c24949f1445a9750a04d43d9a360")!
        let dataTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
                else {
                    print("Network error")
                    return
            }
            self.parseQuote(data: data)
        }
        dataTask.resume()
    }
    
    // Парсинг запроса про компанию
    private func parseQuote(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double
                else {
                    print("Invalid JSON format")
                    return
            }
            DispatchQueue.main.async {
                self.displayStockInfo(companyName: companyName, symbol: companySymbol, price: price, priceChange: priceChange)
            }
        }
        catch {
            print("JSON parsing error: " + error.localizedDescription)
        }
    }
    
    
    // Запрос к API для получения списка компаний
    private func requestQuoteCompanies() {
        let url = URL(string: "https://cloud.iexapis.com/stable/stock/market/list/mostactive/?token=pk_d588c24949f1445a9750a04d43d9a360")!
        let dataTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
                else {
                    print("Network error")
                    return
            }
            self.parseQuoteCompanies(data: data)
        }
        dataTask.resume()
    }
    
    private func parseQuoteCompanies(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            guard
                let json = jsonObject as? [[String: Any]]
                else {
                    print("Invalid JSON format")
                    return
            }
            DispatchQueue.main.async {
                for item in json {
                    let name = item["companyName"] as! String
                    let symbol = item["symbol"] as! String
                    self.companies[name] = symbol
                }
            }
        }
        catch {
            print("JSON parsing error: " + error.localizedDescription)
        }
    }

}

