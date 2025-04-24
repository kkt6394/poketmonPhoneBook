//
//  PhoneBookViewController.swift
//  poketmonPhoneBook
//
//  Created by 김기태 on 4/21/25.
//

import UIKit
import SnapKit
import Alamofire
import CoreData

class PhoneBookViewController: UIViewController {
    
    static var container: NSPersistentContainer! 
    
    var basicNum: Int = 0
    // 프로필 이미지
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    //랜덤 이미지 생성 버튼
    lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // 이름 텍스트필드
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "이름을 입력하세요"
        return textField
    }()
    
    // 전화번호 텍스트필드
    let numTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "전화번호를 입력하세요"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    // UI 구성 메서드
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
        
        // 내비게이션 아이템
        navigationItem.title = "연락처 추가"
        // 오른쪽 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(adjustButtonTapped))
        
        configureUI()
        
    }
    // 데이터 통신 메서드
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
        
    }
    private func fetchPoketmon() {
        var urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(basicNum)" )
        
        guard let url = urlComponents?.url else { return }
        fetchData(url: url) { [weak self] (result: Result<Pokemon, AFError>) in
            switch result {
            case .success(let result):
                //                // 기본
                //                guard let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(result.id).png") else { return }
                //                // 7세대
                //                guard let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/\(result.id).png") else { return }
                //                // 썬문
                //                guard let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/\(result.id).png") else { return }
                // 6세대 x-y ( 범위 넘어감 )
                guard let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/x-y/shiny/\(result.id).png") else { return }
                
                
                
                AF.request(imageUrl).responseData { response in
                    if let data = response.data, let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
                            self?.profileImageView.image = image
//                        }
                    }
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func createData(name: String, phoneNum: String, image: Data) {
        guard let entity = NSEntityDescription.entity(forEntityName: Phonebook.className, in: PhoneBookViewController.container.viewContext) else { return }
        let newPhonebook = NSManagedObject(entity: entity, insertInto: PhoneBookViewController.container.viewContext)
        newPhonebook.setValue(name, forKey: Phonebook.Key.name)
        newPhonebook.setValue(phoneNum, forKey: Phonebook.Key.phoneNum)
        newPhonebook.setValue(image, forKey: Phonebook.Key.image)
        
        do {
            try PhoneBookViewController.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    
    func readAllData() {
        do {
            let phonebooks = try PhoneBookViewController.container.viewContext.fetch(Phonebook.fetchRequest())
            for phonebook in phonebooks as [NSManagedObject] {
                if let name = phonebook.value(forKey: Phonebook.Key.name) as? String,
                   let phoneNum = phonebook.value(forKey: Phonebook.Key.phoneNum) as? String,
                   let image = phonebook.value(forKey: Phonebook.Key.image) as? String {
                    print("name: \(name), phoneNumber: \(phoneNum), image: \(image)")
                    
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    @objc
    func adjustButtonTapped() {
        createData(name: nameTextField.text ?? "", phoneNum: numTextField.text ?? "", image: (profileImageView.image?.pngData())!)
        navigationController?.popViewController(animated: true)
//        readAllData()

    }
    
    @objc
    func randomButtonTapped() {
        let randomInt = Int.random(in: 1...1000)
        basicNum = randomInt
        print("\(basicNum)")
        fetchPoketmon()
        
    }
    
    
}
