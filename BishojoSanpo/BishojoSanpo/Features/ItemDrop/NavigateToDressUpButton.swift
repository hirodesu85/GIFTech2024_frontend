//
//  NavigateToDressUpButton.swift
//  BishojoSanpo
//
//  Created by 伊藤まどか on 2024/04/21.
//

import SwiftUI

struct NavigateToDressUpButton: View {
    @EnvironmentObject var router: NavigationRouter
    var body: some View {
        Button(action: {
            router.items.removeLast(router.items.count)
            router.items.append(.dressUp)
        }, label: {
            Text("着せ替えする")
        })
    }
}

#Preview {
    NavigateToDressUpButton()
}
