//
//  TagView.swift
//  iFriends
//
//  Created by jescobar on 2/3/22.
//

import SwiftUI

struct Tag: ViewModifier {
    let backgroudColor: Color
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.callout.bold())
            .padding()
            .background(backgroudColor)
            .clipShape(Capsule())
    }
}

extension View {
    func tagView(_ color: Color) -> some View {
        modifier(Tag(backgroudColor: color))
    }
}

struct TagView: View {
    let tag: String
    var body: some View {
        Text(tag)
            .tagView(.red)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "Demo tag")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
