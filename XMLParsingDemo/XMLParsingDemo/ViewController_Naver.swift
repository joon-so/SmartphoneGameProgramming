//
//  ViewController.swift
//  XMLParsingDemo
//
//  Created by KPUGAME on 2021/04/11.
//

import UIKit

class ViewController_Naver: UIViewController, XMLParserDelegate, UITableViewDataSource {

    @IBOutlet weak var tbData: UITableView!
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view.
    }

    func beginParsing()
    {
        posts = []
        let client_id = "J0xlzLY_mwqXVGY7OBho"
        let client_secret = "8NphEmVq6H"
        let naverURL = URL(string: "https://openapi.naver.com/v1/search/book.xml?query=love&dispaly=10&start=1")!
        
        var naverURLRequest = URLRequest(url: naverURL)
        naverURLRequest.addValue(client_id, forHTTPHeaderField: "X-Naver-Client-Id")
        naverURLRequest.addValue(client_secret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: naverURLRequest) {data, response, error in
            if let data = data {
                self.parser = XMLParser(data: data)
                self.parser.delegate = self
                self.parser.parse()
                DispatchQueue.main.async {
                    self.tbData!.reloadData()
                }
            }
        }.resume()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "title") {
            title1.append(string)
        } else if element.isEqual(to: "author"){
            date.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "date") as! NSString as String
        return cell
    }
}

