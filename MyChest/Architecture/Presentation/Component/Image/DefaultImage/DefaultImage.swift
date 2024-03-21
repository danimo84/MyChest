//
//  DefaultImage.swift
//  MyChest
//
//  Created by Daniel Moraleda on 20/3/24.
//

import SwiftUI

struct DefaultImage: View {
    
    var viewModel: DefaultImageViewModel

    var body: some View {
        Image(systemName: viewModel.image ?? Assets.SystemImage.photo)
            .resizable()
            .frame(
                width: viewModel.width,
                height: viewModel.height
            )
    }
}

#Preview {
    DefaultImage(
        viewModel: .init(
            width: Theme.Accounts.accountImageSize,
            height: Theme.Accounts.accountImageSize
        )
    )
}
