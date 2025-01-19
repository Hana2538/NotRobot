import SwiftUI

struct NotRobotGameView: View {
    let KURO = [
        "Gorila", "HandMac", "CorrectKURO1",
        "CorrectKURO2", "CorrectKURO3", "Gassi",
        "ISU", "Mac", "wall"
    ]
    
    let KUMA = [
        "Guitar", "CorrectKUMA2", "Tail",
        "Tissue", "CorrectKURO3", "Yenn",
        "CorrectKUMA3", "Mike", "CorrectKUMA1"
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var Mentor: String = "メンター"
    @State private var currentImages: [String] = []
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(width: 371, height: 120)
                    .foregroundColor(Color(red: 0.0, green: 0.643, blue: 1.0))
                
                Text("\(Mentor)")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.trailing, 180)
                    .padding(.bottom, 30)
                
                Text("の画像をすべて選択してください")
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .padding(.trailing, 25)
                    .padding(.top, 50)
            }
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(currentImages, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipped()
                }
            }
            

            ZStack {
                Rectangle()
                    .frame(width: 371, height: 80)
                    .foregroundColor(Color(red: 0.961, green: 0.961, blue: 0.961))
                
                HStack {
                    Button(action: {

                        if Bool.random() {
                            Mentor = "KURO"
                            currentImages = KURO.shuffled() // 配列をシャッフル
                        } else {
                            Mentor = "さわっくま"
                            currentImages = KUMA.shuffled() // 配列をシャッフル
                        }
                    }) {
                        Image(systemName: "arrow.trianglehead.clockwise")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 180)
                    
                    Button(action: {
                        print("確認ボタンが押されました")
                    }) {
                        Text("確認")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.0, green: 0.643, blue: 1.0))
                            .frame(width: 90)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            currentImages = KURO.shuffled()
        }
    }
}
