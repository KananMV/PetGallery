//
//  LoginViewController.swift
//  PetGallery
//
//  Created by Kenan Memmedov on 16.09.25.
//

import UIKit
import SnapKit

class EntryViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero,style: .grouped)
        view.register(HeaderImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: "HeaderImageTableViewCell")
        view.register(EntryVCTableViewCell.self, forCellReuseIdentifier: "EntryVCTableViewCell")
        view.register(FooterImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: "FooterImageTableViewCell")
        view.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.contentInset = .zero
        view.scrollIndicatorInsets = .zero
        view.contentInsetAdjustmentBehavior = .never
        view.isScrollEnabled = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationController?.navigationBar.isHidden = true
        tableView.bounces = false
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        setCons()
    }
    
    func setCons() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
     
}

extension EntryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderImageTableViewCell") as? HeaderImageTableViewCell else { return nil}
        header.configure(image: "dogIcon")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.frame.width
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryVCTableViewCell") as? EntryVCTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.buttonAction = { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .login:
                    let vc = LoginViewController()
                    self.navigationController?.show(vc, sender: nil)
                case .register:
                    let vc = RegisterViewController()
                    self.navigationController?.show(vc, sender: nil)
                
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
                cell.selectionStyle = .none
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterImageTableViewCell") as?
                FooterImageTableViewCell else { return nil}
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerHeight: CGFloat = view.frame.width
        let footerHeight: CGFloat = 100

        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else {
            let estimatedNormalCellHeight: CGFloat = 250
            let totalContent = headerHeight + estimatedNormalCellHeight + footerHeight
            let emptyHeight = max(view.frame.height - totalContent, 40)
            return emptyHeight
        }
    }
    
    
}

