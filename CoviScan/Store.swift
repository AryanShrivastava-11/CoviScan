//
//  Store.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 29/10/21.
//

import SwiftUI
import Combine

class Store: ObservableObject{
    @Published var result: Result = Result(covid_percentage: 0.00, pneumonia_percentage: 0.00, normal_percentage: 0.00, prediction: "Normal")
    
}
