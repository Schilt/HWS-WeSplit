//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrew A. Schilt on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmountOfCheck / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountOfCheck: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue    }
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<100) {
                            Text("\($0) percent")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmountOfCheck, format: currencyFormat)
                } header: {
                    Text("Total amount for check")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
