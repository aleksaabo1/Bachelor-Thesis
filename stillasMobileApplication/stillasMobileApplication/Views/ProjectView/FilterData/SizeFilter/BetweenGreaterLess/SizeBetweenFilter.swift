//
//  SizeBetweenFilter.swift
//  stillasMobileApplication
//
//  Created by Tormod Mork Muller on 28/04/2022.
//

import SwiftUI

/// **SizeBetweenFilter**
/// The View for selecting a project with size between two values
struct SizeBetweenFilter: View {
    
    /// Enum for input
    enum Field: Int, CaseIterable {
        case input
    }

    /// Size filter active
    @Binding var sizeFilterActive: Bool
    
    /// Has textfield been activated and should be in focus?
    @FocusState var focusedField: Field?
    
    /// First slider values
    @State var scoreFrom: Int = 100
    @Binding var scoreFromBind: Int
    
    /// The input of minimum size
    @ObservedObject var input = NumbersOnly()
    
    /// Second slider values
    @State var scoreTo: Int = 1000
    @Binding var scoreToBind: Int

    /// The input of maximum size
    @ObservedObject var input2 = NumbersOnly()
    
    /// Slider data
    var sliderSizeMin = 100.0
    var sliderSizeMax = 1000.0
    var stepLength = 50.0

    /// First slider value
    var intProxyS1: Binding<Double>{
        Binding<Double>(
            get: {
            //returns the score as a Double
                return Double(scoreFrom)
        }, set: {
            //rounds the double to an Int
            print($0.description)
            scoreFrom = Int($0)
            input.value = "\(Int($0))"
        })
    }
    
    /// Second slider value
    var intProxyS2: Binding<Double>{
        Binding<Double>(
            get: {
            //returns the score as a Double
                return Double(scoreTo)
        }, set: {
            //rounds the double to an Int
            print($0.description)
            scoreTo = Int($0)
            input2.value = "\(Int($0))"
        })
    }
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    if (Int(input.value) == Int(sliderSizeMin)) {
                        Text("Under")
                    } else {
                        Text("Minimum")
                    }
                    HStack {
                        /// Adds textfield with bind to slider
                        TextField("\(Int(sliderSizeMin))", text: $input.value)
                            .font(Font.system(size: 30, design: .default))
                            .onChange(of: input.value) { value in
                                scoreFrom = Int(value) ?? Int(sliderSizeMax + sliderSizeMin) / 2
                            }
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .input)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            Text("m")
                                .font(Font.system(size: 30, design: .default))
                            Text("2")
                                .baselineOffset(6.0)
                        }
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                        .background(Color.gray)
                }
                
                Text(" - ")
                    .font(Font.system(size: 35, design: .default))
                    .offset(y: 10)
                
                VStack {
                    if (Int(input2.value) == Int(sliderSizeMax)) {
                        Text("Over")
                    } else {
                        Text("Maksimum")
                    }
                    HStack {
                        /// Adds textfield with bind to slider
                        TextField("\(Int(sliderSizeMax))", text: $input2.value)
                            .font(Font.system(size: 30, design: .default))
                            .onChange(of: input2.value) { value in
                                if (Int(value) ?? Int(sliderSizeMax)) >= Int(sliderSizeMax) {
                                    scoreTo = Int(sliderSizeMax)
                                    
                                    // TODO: Update textfield value to slider value or max value
                                } else if (Int(value) ?? Int(sliderSizeMin)) <= Int(sliderSizeMin) {
                                    scoreTo = Int(sliderSizeMin)
                                    // TODO: Update textfield value to slider value or min value
                                } else {
                                    scoreTo = Int(value) ?? Int(sliderSizeMax + sliderSizeMin) / 2
                                }
                            }
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .input)
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            Text("m")
                                .font(Font.system(size: 30, design: .default))
                            Text("2")
                                .baselineOffset(6.0)
                        }
                    }
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                        .background(Color.gray)
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
            .frame(width: 350, alignment: .center)
            .font(.headline)
            .font(Font.system(size: 60, design: .default))
            
            VStack {
                VStack (alignment: .leading){
                    HStack {
                        Text("Fra")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .font(Font.system(size: 20, design: .default))
                    .padding(.top, 20)
                    
                    /// Adds slider for minimum size
                    Slider(value: intProxyS1 , in: sliderSizeMin...sliderSizeMax, step: stepLength, onEditingChanged: {_ in
                        print(scoreFrom.description)
                    })
                    .frame(width: 350, alignment: .center)
                    .padding(.vertical, 20)
                }
                VStack (alignment: .leading) {
                    HStack {
                        Text("Til")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .font(Font.system(size: 20, design: .default))
                    .padding(.top, 20)
                    
                    /// Adds slider for maximum size
                    Slider(value: intProxyS2 , in: sliderSizeMin...sliderSizeMax, step: stepLength, onEditingChanged: {_ in
                        print(scoreTo.description)
                    })
                    .frame(width: 350, alignment: .center)
                    .padding(.vertical, 20)
                }
            }
        }
        Spacer()
        
        /// Returnerer den brukte størrelsedataen til parent Viewen
        Button(action: {
            print("Bruk")
            scoreFrom = Int(input.value) ?? 100
            scoreFromBind = scoreFrom
            scoreTo = Int(input2.value) ?? 1000
            scoreToBind = scoreTo
            sizeFilterActive = true
        }) {
            Text("Bruk")
                .frame(width: 300, height: 50, alignment: .center)
        }
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
        
        Spacer()
            .frame(height:50)  // limit spacer size by applying a frame
    }
}

/*
struct SizeBetweenFilter_Previews: PreviewProvider {
    static var previews: some View {
        SizeBetweenFilter()
    }
}*/
