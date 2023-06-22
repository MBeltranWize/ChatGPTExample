//
//  ContentView.swift
//  ChatGPTExample
//
//  Created by Miguel Beltran Sandoval on 03/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var messages = [String]()
    @State var text = ""
    @ObservedObject var chatGpt = ChatGPT()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                LazyVStack {
                    ForEach(messages, id: \.self) { message in
                        /// formato de vista
                        messageView(text: message)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                TextField("Type here..", text: $text)
                Button("Send") {
                    sendText()
                }
                .bold()
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.primary)
                .cornerRadius(12)
            }
            
        }
        .onAppear {
            chatGpt.setUp()
        }
        .background(.clear)
        .padding()
    }
    
    func messageView(text: String) -> some View {
        HStack {
            let isGPT = text.contains("ChatGPT")
            
            if !isGPT { Spacer ()}
                Text(text)
                .bold()
                .padding()
                .background(isGPT ? Color.gray.opacity(0.2) : .blue)
                .foregroundColor(isGPT ? .primary : .white)
                .cornerRadius(15)
            if isGPT { Spacer ()}
        }
    }
    
    
    func sendText() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        messages.append("Me: \(text)")
        chatGpt.send(text: text) { result in
            self.text = ""
            DispatchQueue.main.async {
                messages.append("ChatGPT: \(result)")
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
