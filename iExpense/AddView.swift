//
//  AddView.swift
//  iExpense
//
//  Created by Peter Salz on 03.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        
        NavigationView {
            
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(
                        name: self.name,
                        type: self.type,
                        amount: actualAmount
                    )
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Input Error"),
                    message: Text("\(self.amount) is not a valid integer."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
