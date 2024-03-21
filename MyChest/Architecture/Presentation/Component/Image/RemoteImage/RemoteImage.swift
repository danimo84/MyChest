//
//  RemoteImage.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import SwiftUI

struct RemoteImage: View {
    
    @ObservedObject var viewModel: RemoteImageViewModel
    
    var body: some View {
        if let imageUrl = URL(string: viewModel.url) {
            Image.cachedURL(imageUrl)
                .resizable()
                .frame(
                    width: viewModel.widht,
                    height: viewModel.height
                )
                .aspectRatio(contentMode: viewModel.contentMode ?? .fit)
                .clipShapeIfNeeded(
                    clippedShape: viewModel.clipedShape ?? false,
                    cornerRadius: viewModel.cornerRadius
                )
        }
    }
}

#Preview {
    RemoteImage(
        viewModel: .init(
            widht: Theme.Accounts.accountImageSize,
            height: Theme.Accounts.accountImageSize,
            url: ""
        )
    )
}
