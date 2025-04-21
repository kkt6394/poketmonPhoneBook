//
//  PhoneBookViewController.swift
//  poketmonPhoneBook
//
//  Created by 김기태 on 4/21/25.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    // 프로필 이미지
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    //랜덤 이미지 생성 버튼
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)

        return button
    }()
    
    // 이름 텍스트필드
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // 전화번호 텍스트필드
    let numTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private func configureUI() {
        [
            profileImageView,
            randomButton,
            nameTextField,
            numTextField
        ]
            .forEach { view.addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(randomButton.snp.bottom).offset(20)
            $0.width.equalTo(350)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        numTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.width.equalTo(350)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()


        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "연락처 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(adjustButtonTapped))
        configureUI()
    }
    
    @objc
    func adjustButtonTapped() {
        
    }


}
