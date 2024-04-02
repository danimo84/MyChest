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
                    width: viewModel.width,
                    height: viewModel.height
                )
                .aspectRatio(contentMode: viewModel.contentMode)
                .clipShapeIfNeeded(
                    clippedShape: viewModel.clipedShape,
                    cornerRadius: viewModel.cornerRadius
                )
                .overlayIfNeeded(
                    overlaied: viewModel.overlied,
                    strokeWidth: viewModel.strokeWidth ?? .zero,
                    strokeColor: viewModel.strokeColor,
                    cornerRadius: viewModel.cornerRadius
                )
                .shadowIfNeeded(
                    shadowed: viewModel.shadowed,
                    shadowRadius: viewModel.shadowRadius,
                    shadowColor: viewModel.shadowColor
                )
        }
    }
}

#Preview {
    RemoteImage(
        viewModel: .init(
            width: Theme.Accounts.accountImageSize,
            height: Theme.Accounts.accountImageSize,
            url: ""
        )
    )
}
