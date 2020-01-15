//
//  RootView.swift
//  Components
//
//  Created by JT Bergman on 1/14/20.
//  Copyright © 2020 Joseph Bergman. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        let url = URL(string: "https://images.unsplash.com/photo-1530319067432-f2a729c03db5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=980&q=80")!
        return RemoteImage(url: url, loadingView: {
            Image(systemName: "wifi")
        }, imageView: { image in
            image
        }, errorView: { error in
            Image(systemName: "wifi.slash")
        })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RootView().navigationBarTitle(Text("Components"))
        }
    }
}
