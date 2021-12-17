//
//  RankViewController.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/17.
//

import UIKit
import RealmSwift

class RankViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var realm : Realm!

    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RankTableViewCell", bundle: nil), forCellReuseIdentifier: "RankTableViewCell")
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
}

extension RankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = realm.objects(Score.self)
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RankTableViewCell", for: indexPath) as? RankTableViewCell else { return UITableViewCell()}
        let datas = sortData()
        print(datas)
        cell.updateUI(cellData: datas[indexPath.row])
        return cell
    }
    
    func sortData() -> Results<Score> {
        var info : Results<Score>
        info = realm.objects(Score.self).sorted(byKeyPath: "score", ascending: false)
        return info
    }
}
