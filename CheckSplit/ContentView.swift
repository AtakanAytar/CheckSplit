//
//  ContentView.swift
//  CheckSplit
//
//  Created by Atakan Aytar on 27.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    
    let tipPercentages = [0,10,15,20,25]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var tipPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * tipSelection / 100
        
        let tipPerPerson = tipValue / peopleCount
        return tipPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount",value: $checkAmount,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad).focused($amountIsFocused)
                    
                    Picker("Number of people",selection: $numberOfPeople ){
                        
                        
                        ForEach(1..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage",selection: $tipPercentage)
                    {
                        ForEach(tipPercentages,id: \.self){
                            Text($0,format:.percent)
                        }
                        
                    }.pickerStyle(.segmented)
                }header: {
                    Text("HOW MUCH TIP WOUL YOU LIKE TO LEAVE ?")
                }
                
                
                Section{
                    Text(tipPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    
                }header: {
                    Text("TIP PER PERSON")
                }

                Section{
                    Text(totalPerPerson - tipPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    
                }header: {
                    Text("CHECK WITHOUT TIP PER PERSON")
                }
                
                
                Section{
                    Text(totalPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    
                }header: {
                    Text("TOTAL CHECK PER PERSON")
                }


                
                
                
                
                
                
                
            }
            .navigationTitle("Check Split")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
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
