//
//  AddXView.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/25/23.
//

import SwiftUI

struct AddXView: View {
    @StateObject var viewModel: AddXViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddXView_Previews: PreviewProvider {
    static var previews: some View {
        AddXView(viewModel: AddXViewModel())
    }
}
