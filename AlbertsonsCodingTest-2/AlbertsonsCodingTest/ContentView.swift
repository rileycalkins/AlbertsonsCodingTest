//
//  ContentView.swift
//  AlbertsonsCodingTest
//
//  Created by Riley Calkins on 11/22/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var longFormObjects:[LongForm] = []
    @State var showAlert = false
    var body: some View {
        VStack {
            let binding = Binding<String> {
                viewModel.searchString
            } set: { string in
                viewModel.searchString = string
            }
            HStack {
                TextField("Search Term", text: binding, prompt: Text("Enter an acronym eg. HMM, or OMG"))
                    .textFieldStyle(.roundedBorder)
                    
                    .onSubmit {
                        getAcronyms()
                    }
                Button {
                    if viewModel.searchString != "" {
                        getAcronyms()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                }
            }.padding(.horizontal, 20)
            
            List(viewModel.longFormObjects, id: \.lf) { obj in
                VStack(alignment: .leading) {
                    Text(obj.lf).font(.title3)
                    Text("Frequency: \(obj.freq)")
                    Text("Since: \(obj.since)")
                    
                }
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("No Results Found"),
                  dismissButton: .default(Text("Okay"), action: {
                showAlert = false
            }))
        }
    }
    
    private func getAcronyms() {
        viewModel.getAcronyms(for: viewModel.searchString) { items in
            viewModel.getAcronyms(for: viewModel.searchString) { items in
                if items.count == 0 {
                    showAlert = true
                } else {
                    viewModel.longFormObjects = items.flatMap { $0.lfs }
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
