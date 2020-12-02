//
//  SearchBar.swift
//  TweetSearchApp
//
//  Created by Mitsuaki Ihara on 2020/12/03.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard searchBar.text != nil else {
                return
            }
            text = searchBar.text!
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> some UISearchBar {
        let view = UISearchBar(frame: .zero)
        view.delegate = context.coordinator
        view.placeholder = "Input search word here."
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}
