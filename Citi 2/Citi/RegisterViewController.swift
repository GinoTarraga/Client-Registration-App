//
//  RegisterViewController.swift
//  Citi
//
//  Created by gino tarraga on 2/26/19.
//  Copyright © 2019 gino tarraga. All rights reserved.
//

import UIKit
import JavaScriptCore
import CoreLocation
import WebKit
import MessageUI

class RegisterViewController: UIViewController,  WKUIDelegate, WKNavigationDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    //client 1
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    
    @IBOutlet weak var cellPhoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var employerTextField: UITextField!
    @IBOutlet weak var employerAddressTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var currentLandlordTextField: UITextField!
    @IBOutlet weak var moveInDateTextField: UITextField!
    @IBOutlet weak var budgetTextField: UITextField!
    
    //client2
    @IBOutlet weak var client2Name: UITextField!
    @IBOutlet weak var client2Address: UITextField!
    @IBOutlet weak var client2ZipCode: UITextField!
    @IBOutlet weak var client2City: UITextField!
    @IBOutlet weak var client2State: UITextField!
    @IBOutlet weak var client2CellPhone: UITextField!
    @IBOutlet weak var client2Email: UITextField!
    @IBOutlet weak var client2Employer: UITextField!
    @IBOutlet weak var client2EmployerAddress: UITextField!
    @IBOutlet weak var client2Position: UITextField!
    @IBOutlet weak var client2Income: UITextField!
    
    //agent selection, pickerView
    @IBOutlet weak var agentPickerView: UITextField!
    
    //webview to run html 
    @IBOutlet weak var webView2: WKWebView!
    
    //create array of agent's emails
    private let agentList = ["--Select Agent--", "Gino Tarraga", "Andrew Tarraga", "Danilo"]
    
    let agentEmailDictionary : [String:String] = ["Gino Tarraga":"gtarraga@citihabitats.com", "Andrew Tarraga":"ginotarraga@gmail.com", "Danilo":"gino@rusammy.com"]
    
    //array of state abrivation
    private let stateList = ["--State--","AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN",
        "IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY",
        "NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY",]
    
    //create multiple pickerView objects
    let agentPicker = UIPickerView()
    let statePicker = UIPickerView()
    let statePicker2 = UIPickerView()
    
    //load viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        //createToolBar()
        // Do any additional setup after loading the view.
        
        let url = Bundle.main.url(forResource: "1", withExtension: "html", subdirectory: "registration")!
        webView2.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView2.load(request)
        
        submit.layer.cornerRadius = 8
        cancel.layer.cornerRadius = 8
    }
    
   //function to create pickerView
    func createPickerView() {
        //customize picker object
        agentPicker.delegate = self
        statePicker.delegate = self
        statePicker2.delegate = self
        
        agentPickerView.inputView = agentPicker
        stateTextField.inputView = statePicker
        client2State.inputView = statePicker2
        
        //customize background color
        agentPicker.backgroundColor = .white
        statePicker.backgroundColor = .white
        statePicker2.backgroundColor = .white
    }
    
    //dismisses keyboard from screen, supports lower versions of IOS
    @IBAction func dissmissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    //Submits user's input
    @IBAction func submitRegistration(_ sender: AnyObject) {
        //getting user inputs
        
        //check whether there are two clients or one. Parse different dictionary for 2 clients
        var key = 1;
        if (client2Name.text?.isEmpty)! == true { //if client2Name is empty
        //check for empty fields
        //check if fields are empty by using "if (fullName.text?.isEmpty)!
            if (fullNameTextField.text?.isEmpty)! || (cellPhoneTextField.text?.isEmpty)! || (budgetTextField.text?.isEmpty)!
                || (incomeTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (agentPickerView.text?.isEmpty)!{
                //display alert message
                //to display alert message, call "displayMessage(userMessage: "") inside if statement
                displayMessage(userMessage: "Full Name, Cell Phone, Budget, Income, Agent & Email must be filled out", temp: 1)
                return
            }
            
            if agentPickerView.text! == "--Select Agent--" {
                displayMessage(userMessage: "Select a Corresponding Agent", temp: 1)
                return
            }
            
            let clientInformation = ["budget":budgetTextField.text!, "client1Name":fullNameTextField.text!, "client1Address":addressTextField.text!, "client1City":cityTextField.text!, "client1State":stateTextField.text!, "client1CellPhone":cellPhoneTextField.text!, "client1Email":emailTextField.text!, "client1Employer":employerTextField.text!, "client1EmployerAddress":employerAddressTextField.text!, "client1Position":positionTextField.text!, "client1Income":incomeTextField.text!, "client1MoveInDate":moveInDateTextField.text!, "agentName":agentPickerView.text!, "key":key] as [String : Any]
        
            //converts user input into json object
            let jsonObject = try! JSONSerialization.data(withJSONObject: clientInformation, options: [])
        
            //convert to json String
            let jsonString = String(data: jsonObject, encoding: String.Encoding.utf8)
        
            //displays into webview
            webView2.evaluateJavaScript(("setValues('\(jsonString!)')"), completionHandler: nil)
            
            //create pdf from webview2
            self.createPDF(formatter: webView2.viewPrintFormatter(), filename: "pdf")
        }else{
            key = 2;
            if (fullNameTextField.text?.isEmpty)! || (cellPhoneTextField.text?.isEmpty)! || (budgetTextField.text?.isEmpty)!
                || (incomeTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (incomeTextField.text?.isEmpty)! || (client2Name.text?.isEmpty)! || (client2CellPhone.text?.isEmpty)! || (client2Email.text?.isEmpty)! || (client2Income.text?.isEmpty)!{
                //display alert message
                //to display alert message, call "displayMessage(userMessage: "") inside if statement
                displayMessage(userMessage: "Full Name, Cell Phone, Budget, Income & Email must be filled out for both clients", temp: 1)
                return
            }
            
            if agentPickerView.text! == "--Select Agent--" {
                displayMessage(userMessage: "Select a Corresponding Agent", temp: 1)
                return
            }
            
            let clientInformation = ["budget":budgetTextField.text!, "client1Name":fullNameTextField.text!, "client1Address":addressTextField.text!, "client1City":cityTextField.text!, "client1State":stateTextField.text!, "client1CellPhone":cellPhoneTextField.text!, "client1Email":emailTextField.text!, "client1Employer":employerTextField.text!, "client1EmployerAddress":employerAddressTextField.text!, "client1Position":positionTextField.text!, "client1Income":incomeTextField.text!, "client1MoveInDate":moveInDateTextField.text!, /*Client2 input*/ "client2Name":client2Name.text!, "client2Address":client2Address.text!, "client2City":client2City.text!, "client2State":client2State.text!, "client2CellPhone":client2CellPhone.text!, "client2Email":client2Email.text!, "client2Employer":client2Employer.text!, "client2EmployerAddress":client2EmployerAddress.text!, "client2Position":client2Position.text!, "client2Income":client2Income.text!, "agentName":agentPickerView.text!, "key":key] as [String: Any]
            
            //converts user input into json object
            let jsonObject = try! JSONSerialization.data(withJSONObject: clientInformation, options: [])
            
            //convert to json String
            let jsonString = String(data: jsonObject, encoding: String.Encoding.utf8)
            
            //displays into webview
            webView2.evaluateJavaScript(("setValues('\(jsonString!)')"), completionHandler: nil)
            
            //create pdf from webview2
            self.createPDF(formatter: webView2.viewPrintFormatter(), filename: "pdf")
        }
    }
    //composes email & presents new webview
    func email(file: Data){
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        //checks which agent has been selected and matches corresponding email
        for (names, email) in agentEmailDictionary {
            if agentPickerView.text! == names {
                mailComposer.setToRecipients([email])
                break;
            }
        }

        mailComposer.setSubject(fullNameTextField.text! + " " + "Registraion Form")
        
        mailComposer.addAttachmentData(file, mimeType: "application/pdf", fileName: fullNameTextField.text! + " " + "Registration Form")
        
        //displays email composer 3
       self.present(mailComposer, animated: true)
    }
    
    //creates pdf from webview2
    func createPDF(formatter: UIViewPrintFormatter, filename: String){
        
        //Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formatter, startingAtPageAt: 0)
        
        //assign pageRect and printRec
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue((NSValue(cgRect: page)), forKey: "paperRect")
        render.setValue((NSValue(cgRect: printable)), forKey: "printableRect")
        
        //create PDF
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        
        for i in 1...render.numberOfPages {
            UIGraphicsBeginPDFPage()
            let bound = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bound)
        }
        
        UIGraphicsEndPDFContext()
        //composes email from pdf generated
        email(file: pdfData as Data)
    }

    //function takes in a message in order to alert user if there is an error in their input
    func displayMessage(userMessage:String, temp:Int) -> Void {
        DispatchQueue.main.async {
            //creates alert object
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            //creates action button that user needs to touch
            let okAction = UIAlertAction(title: "OK", style: .default)
            {   (action: UIAlertAction!) in
                //Code in this block will trigger when OK button is clicked
                print("OK")
                //Only runs when temp = 2 to exit email composer and return to the first view controller
                if temp == 2 {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            //how to add OkAction button to alert controller
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

//picker view delegate
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == agentPicker {
            return agentList.count
        }else
            if pickerView == statePicker {
            return stateList.count
        }else
            if pickerView == statePicker2 {
            return stateList.count
        }
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == agentPicker {
            self.agentPickerView.text = self.agentList[row]
        }else
            if pickerView == statePicker {
               stateTextField.text = stateList[row]
        }else
            if pickerView == statePicker2 {
                client2State.text = stateList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agentPicker {
            return agentList[row]
        }else
            if pickerView == statePicker {
                return stateList[row]
        }else
            if pickerView == statePicker2 {
                return stateList[row]
        }
        return ""
    }
}

extension RegisterViewController: MFMailComposeViewControllerDelegate {
    //dismisses mail controller once user hits cancel or send
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to Send")
        case .sent:
            displayMessage(userMessage: "Registration Complete", temp: 2)
            print("Email Sent")
        case .saved:
            print("Email Saved")
        }
        controller.dismiss(animated: true)
    }
}
