//
//  CustomButton.swift
//  Reminder
//
//  Created by pineone on 2022/10/05.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

enum buttonColor {
    case blue
    case red
    case black
}

class CustomButton: UIButton {
    
    private var image : String
    private var text : String
    private var number : String
    private var imageColor : String
    
    private lazy var buttonImage = UIImageView().then {
        $0.image = UIImage(systemName: image)
        $0.tintColor = UIColor.red
    }
    
    private lazy var buttonLabel = UILabel().then {
        $0.text = text
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private lazy var buttonNumber = UILabel().then {
        $0.text = number
        $0.font = .systemFont(ofSize: 26, weight: .bold)
    }
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        setupView()
    //        setupLayout()
    //        backgroundColor = .white
    //    }
    
    // MARK: - init()
    init(image: String, text: String, number: String, imageColor: String) {
        
        self.image = image
        self.text = text
        self.number = number
        self.imageColor = imageColor
        
        super.init(frame: .zero)
        setupView()
        setupLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override var isHighlighted: Bool {
    //        didSet {
    //            backgroundColor = isHighlighted ? .red : .blue
    //        }
    //    }
}
// MARK: - extension
extension CustomButton {
    func setupView() {
        layer.cornerRadius = 10
    }
    
    func setupLayout() {
        self.addSubviews([buttonImage, buttonLabel, buttonNumber])
        buttonImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.height.width.equalTo(30)
        }
        buttonLabel.snp.makeConstraints {
            $0.top.equalTo(buttonImage.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(30)
        }
        buttonNumber.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}
