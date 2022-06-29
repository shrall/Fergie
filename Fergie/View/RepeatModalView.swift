//
//  RepeatModalView.swift
//  Fergie
//
//  Created by Candra Winardi on 28/06/22.
//

import SwiftUI

struct RepeatModalView: View {
    @Binding var isPresentRepeatModal: Bool
    @Binding var isCheckedRepeatModal: String
    
    var body: some View {
        NavigationView{
            List{
                Button{
                    isCheckedRepeatModal = "Tomorrow"
                    isPresentRepeatModal.toggle()
                }label: {
                    HStack{
                        Text("Tomorrow")
                        Spacer()
                        if(isCheckedRepeatModal == "Tomorrow"){
                            Image(systemName: "checkmark")
                        }
                    }
                }
                Button{
                    isCheckedRepeatModal = "in 7 Days"
                    isPresentRepeatModal.toggle()
                }label: {
                    HStack{
                        Text("in 7 Days")
                        Spacer()
                        if(isCheckedRepeatModal == "in 7 Days"){
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }.navigationTitle("Repeat").navigationBarTitleDisplayMode(.inline)
        }
    }
}
