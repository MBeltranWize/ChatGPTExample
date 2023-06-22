//
//  ChatGPT.swift
//  ChatGPTExample
//
//  Created by Miguel Beltran Sandoval on 03/03/23.
//

import Foundation
import OpenAISwift

class ChatGPT : ObservableObject {
    
    private var client : OpenAISwift?
    
    func setUp() {
        client = OpenAISwift(authToken: Constants.secretKey)
    }
    
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text,
                               maxTokens: 200,
                               completionHandler: { result in
            switch result {
            case .success(let response):
                let message = response.choices.first?.text ?? "please rephrase your question"
                completion(message)
            case .failure(_):
                break
            }
        })
    }
}
