//
//  ViewController+JSONmethods.swift
//  CommitsApp
//
//  Created by Nadia on 16.01.2021.
//

import Foundation
import UIKit

extension ViewController {
    func saveContext(){
        if container.viewContext.hasChanges {
        do {
            try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func loadSavedData() {
        let request = Commit.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        request.predicate = commitPredicate
        do {
            commits = try container.viewContext.fetch(request)
            print("Got \(commits.count) commits")
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    @objc func fetchCommits() {
        if let data = try? Data(contentsOf: URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100")!) {
            do {
                let jsonCommits = try JSON(data: data)
                let jsonCommitArray = jsonCommits.arrayValue
                print("Received \(jsonCommitArray.count) new commits.")
                DispatchQueue.main.async { [unowned self] in
                    for jsonCommit in jsonCommitArray {
            
                        let commit = Commit(context: self.container.viewContext)
                        self.configure(commit: commit, usingJSON: jsonCommit)
                    }
                    self.saveContext()
                    self.loadSavedData()
                }
            } catch {
                print("error")
            }
        }
    }

    
    func configure(commit: Commit, usingJSON json: JSON) {
        commit.sha = json["sha"].stringValue
        commit.message = json["commit"]["message"].stringValue
        commit.url = json["html_url"].stringValue
        let formatter = ISO8601DateFormatter()
        commit.date = formatter.date(from: json["commit"]["committer"] ["date"].stringValue) ?? Date()
        
        var commitAuthor: Author!
        // see if this author exists already
        let authorRequest = Author.createFetchRequest()
        authorRequest.predicate = NSPredicate(format: "name == %@", json["commit"] ["committer"]["name"].stringValue)
        if let authors = try? container.viewContext.fetch(authorRequest) {
            if authors.count > 0 {
                // we have this author already
                commitAuthor = authors[0]
            }
        }
        
        if commitAuthor == nil {
            // we didn't find a saved author - create a new one!
            let author = Author(context: container.viewContext)
            author.name = json["commit"]["committer"]["name"].stringValue
            author.email = json["commit"]["committer"]["email"].stringValue
            commitAuthor = author
        }
            // use the author, either saved or new
        commit.author = commitAuthor
    }
    
    @objc func changeFilter() {
        let ac = UIAlertController(title: "Filter commits...", message: nil, preferredStyle: .actionSheet)
        // 1
        ac.addAction(UIAlertAction(title: "Show only fixes", style: .default)
        { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "message CONTAINS[c] 'fix'")
            self.loadSavedData()
        })
        
        // 2
        ac.addAction(UIAlertAction(title: "Ignore Pull Requests", style: .default)
        { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "NOT message BEGINSWITH 'Merge pull request'")
            self.loadSavedData()
        })
        
        // 3
        ac.addAction(UIAlertAction(title: "Show only recent", style: .default)
        { [unowned self] _ in
            let twelveHoursAgo = Date().addingTimeInterval(-43200)
            self.commitPredicate = NSPredicate(format: "date > %@", twelveHoursAgo as NSDate)
            self.loadSavedData()
        })
        
        // 4
        ac.addAction(UIAlertAction(title: "Show only Durian commits", style: .default)
        { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "author.name == 'Joe Groff'")
            self.loadSavedData()
        })
        
        // 5
        ac.addAction(UIAlertAction(title: "Show All Commits", style: .default)
        { [unowned self] _ in
            self.commitPredicate = nil
            self.loadSavedData()
        })
        

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}
