//
//  ProfileScreenViewController.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 08/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var viewModel: ProfileViewModel = ProfileViewModel()
    
    // MARK: - IBActions
    
    @IBAction func saveButtonClicked(sender: UIButton) {
        if(!areAllFieldsEmpty()) {
            setTextFieldsText()
            showUserDataTextField()
            textFieldDoneEditing()
            saveButtonAlert()
            viewModel.saveBool(sender.isSelected, viewModel.constants.doesUserExists)
        } else {
            saveBtn.isEnabled = false
        }
    }
    
    @IBAction func cancelButtonClicked(sender: UIButton) {
        if(!areAllFieldsEmpty()) {
            showCancelButtonAlert()
        } else {
            cancelBtn.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showUserDataTextField()
        setupObservers()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        
        //all labels style
        setupTextField(nameTextField)
        setupTextField(departmentTextField)
        setupTextField(mailTextField)
        setupTextField(telTextField)
        setupUiTextView(aboutMeTextView)
        aboutMeTextView.delegate = self
        
        //button style
        saveBtn.layer.cornerRadius = 10.0
        cancelBtn.layer.cornerRadius = 10.0
        cancelBtn.backgroundColor = UIColor(named: CommonConstants.lightGreyColor)
        
        //image style
        profileImg.layer.masksToBounds = false
        profileImg.backgroundColor = UIColor(named: CommonConstants.darkWhiteColor)
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.layer.borderWidth = 4.0
        profileImg.layer.borderColor = UIColor(named: CommonConstants.accentColor)?.cgColor
        
        //navBar style
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        //to create a new back button
        let newBackButton = UIBarButtonItem(title: viewModel.constants.settingsTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileScreenViewController.back(sender:)))
        newBackButton.tintColor = UIColor(named: CommonConstants.purpleColor)
        self.navigationItem.leftBarButtonItem = newBackButton
        
        //to check if the data was previously saved
        if (viewModel.doesUserExists(viewModel.constants.doesUserExists)) {
            self.cancelBtn.setTitle(self.viewModel.constants.deleteDataOption, for: .normal)
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTextField (_ textField: UITextField) {
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor(named: CommonConstants.blackToWhite)?.cgColor
        textField.clipsToBounds = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(ProfileScreenViewController.textFieldDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = UIReturnKeyType.done
    }
    
    private func setupUiTextView (_ textView: UITextView) {
        textView.layer.cornerRadius = 15.0
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor(named: CommonConstants.blackToWhite)?.cgColor
        textView.clipsToBounds = true
    }

    private func setTextFieldsText() {
        viewModel.saveString(nameTextField.text!, viewModel.constants.nameKey)
        viewModel.saveString(departmentTextField.text!, viewModel.constants.departmentKey)
        viewModel.saveString(mailTextField.text!, viewModel.constants.mailKey)
        viewModel.saveString(telTextField.text!, viewModel.constants.telephoneKey)
        viewModel.saveString(aboutMeTextView.text!, viewModel.constants.aboutMeKey)
    }

    private func showUserDataTextField() {
        nameTextField.text = viewModel.getString(viewModel.constants.nameKey)
        departmentTextField.text = viewModel.getString(viewModel.constants.departmentKey)
        mailTextField.text = viewModel.getString(viewModel.constants.mailKey)
        telTextField.text =  viewModel.getString(viewModel.constants.telephoneKey)
        aboutMeTextView.text =  viewModel.getString(viewModel.constants.aboutMeKey)
    }
    
    private func resetAllScreenFields() {
        self.viewModel.resetUserDefaults(self.viewModel.constants.nameKey)
        self.viewModel.resetUserDefaults(self.viewModel.constants.departmentKey)
        self.viewModel.resetUserDefaults(self.viewModel.constants.mailKey)
        self.viewModel.resetUserDefaults(self.viewModel.constants.telephoneKey)
        self.viewModel.resetUserDefaults(self.viewModel.constants.aboutMeKey)
        self.viewModel.resetUserDefaults(self.viewModel.constants.doesUserExists)
    }
    
    private func areAllFieldsEmpty() -> Bool {
        guard let nameText = nameTextField.text,
              let departmentText = departmentTextField.text,
              let mailText = mailTextField.text,
              let telephoneText = telTextField.text,
              let aboutMeText = aboutMeTextView.text else { return true }
        return nameText.isEmpty && departmentText.isEmpty && mailText.isEmpty && telephoneText.isEmpty && aboutMeText.isEmpty
    }
    
    // MARK: - Go Back
    
    @objc func back(sender: UIBarButtonItem) {
        if (self.cancelBtn.currentTitle == self.viewModel.constants.buttonCancelText) {
            if(!areAllFieldsEmpty()) {
                goingBackAlert()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Keyboard Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - Alerts
    
    private func saveButtonAlert () {
        let refreshAlert = UIAlertController(title: viewModel.constants.alertProfileTitleSaveButton,
            message: viewModel.constants.alertProfileMessageSaveButton,
            preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: viewModel.constants.alertProfileActionOK, style: .default, handler: { (action: UIAlertAction!) in
            self.cancelBtn.setTitle(self.viewModel.constants.deleteDataOption, for: .normal)
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    private func goingBackAlert () {
        let refreshAlert = UIAlertController(title: viewModel.constants.alertGoBackButtonTitle, message: viewModel.constants.alertGoBackButtonMessage, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: viewModel.constants.alertProfileActionOK, style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: viewModel.constants.alertProfileActionCancel, style: .cancel, handler: { _ in
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    private func showCancelButtonAlert () {
        let refreshAlert = UIAlertController(title: viewModel.constants.alertProfileTitleCancelButton, message: viewModel.constants.alertProfileMessage, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: viewModel.constants.alertProfileActionOK, style: .default, handler: { (action: UIAlertAction!) in
            if (self.cancelBtn.currentTitle == self.viewModel.constants.deleteDataOption) {
                self.resetAllScreenFields()
            }
            self.showUserDataTextField()
        }))

        refreshAlert.addAction(UIAlertAction(title: viewModel.constants.alertProfileActionCancel, style: .cancel, handler: { _ in
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegate

extension ProfileScreenViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cancelBtn.isEnabled = true
        saveBtn.isEnabled = true
    }
    
    private func textFieldDoneEditing() {
        nameTextField.resignFirstResponder()
        departmentTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
        telTextField.resignFirstResponder()
        aboutMeTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.cancelBtn.setTitle(self.viewModel.constants.buttonCancelText, for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.cancelBtn.setTitle(self.viewModel.constants.buttonCancelText, for: .normal)
    }
    
}
