//
//  ViewController.swift
//  poketmonPhoneBook
//
//  Created by 김기태 on 4/21/25.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    // 친구목록 레이블 생성
    let listLabel: UILabel = {
        let listLabel = UILabel()
        listLabel.text = "친구 목록"
        listLabel.font = .boldSystemFont(ofSize: 24)
        return listLabel
    }()
    
    // 연락처 추가 버튼 생성
    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 18)
        return addButton
    }()
    
    // 테이블 뷰 생성
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        //셀 등록
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        
        return tableView
    }()
    
    // UI구성 메서드 설정
    private func configureUI() {
        
        view.backgroundColor = .white
        
        [listLabel, addButton, tableView].forEach { view.addSubview($0) }
        
        // 친구목록 레이블 위치설정
        listLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        //
        addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 버튼 위치설정
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(listLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        //테이블 뷰 위치설정
        tableView.snp.makeConstraints {
            $0.top.equalTo(listLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    @objc
    func buttonTapped() {
        navigationController?.pushViewController(PhoneBookViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        
    }
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}




