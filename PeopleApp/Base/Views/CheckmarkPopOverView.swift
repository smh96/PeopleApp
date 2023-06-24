//
//  CheckmarkPopOverView.swift
//  PeopleApp
//
//  Created by Sander Haug on 24/06/2023.
//

import SwiftUI

struct CheckmarkPopOverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle,
                          design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopOverView()
            .previewLayout(.sizeThatFits)
            .background(.blue)
    }
}
