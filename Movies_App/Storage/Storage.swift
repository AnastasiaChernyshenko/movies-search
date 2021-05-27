//
//  Storage.swift
//  Movies_App
//
//  Created by Anastasia on 14.02.2021.
//

import SwiftyUserDefaults

class Storage {
    
    private var suggestions: [String]
    
    init() {
        self.suggestions = Defaults[\.suggestions] ?? []
    }
    
    func add(suggestion: String) {
        guard !suggestion.isEmpty, suggestions.first(where: { $0 == suggestion }) == nil else { return }
        
        if suggestions.count == 10 {
            suggestions.removeLast()
        }
        
        suggestions.insert(suggestion, at: 0)
        Defaults[\.suggestions] = suggestions
    }
    
    func getSuggestions() -> [String] {
        return suggestions
    }
    
    func getLastSuggestion() -> String? {
        return suggestions.last
    }
}

extension DefaultsKeys {
    var suggestions: DefaultsKey<[String]?> {.init("suggestions")}
}
