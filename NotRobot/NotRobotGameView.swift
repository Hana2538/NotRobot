import SwiftUI

struct NotRobotGameView: View {
    // Mentor（人）ごとに画像リストを紐づける辞書
    let mentors: [String: [String]] = [
        "KURO": [
            "Gorila", "HandMac", "CorrectKURO1",
            "CorrectKURO2", "CorrectKURO3", "Gassi",
            "ISU", "Mac", "wall"
        ],
        "さわっくま": [
            "Guitar", "CorrectKUMA2", "Tail",
            "Tissue", "CorrectKURO3", "Yenn",
            "CorrectKUMA3", "Mike", "CorrectKUMA1"
        ],
        "しばちゃん": [
            "CorrectShiba1", "CorrectShiba2", "CorrectShiba3",
            "ItIsMe", "MacPen", "Pen",
            "Piri", "Umbrella", "CorrectKUMA1"
        ]
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var Mentor: String = "メンター"
    @State private var currentImages: [String] = []
    @State private var selectedImages: Set<String> = []
    
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
                    ZStack {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: selectedImages.contains(imageName) ? 90 : 120, 
                                   height: selectedImages.contains(imageName) ? 90 : 120)
                            .clipped()
                            .onTapGesture {
                                // 画像をタップしたら見た目が切り替わるよ
                                if selectedImages.contains(imageName) {
                                    selectedImages.remove(imageName)
                                } else {
                                    selectedImages.insert(imageName)
                                }
                            }
                        
                        if selectedImages.contains(imageName) {
                            
                            Circle()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(red: 0.0, green: 0.643, blue: 1.0))
                                    .offset(x: 35, y: -35)
                            
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                                .offset(x: 35, y: -35) // チェックマークの位置を調整
                        }
                    }
                }
            }
            
            
            ZStack {
                Rectangle()
                    .frame(width: 371, height: 80)
                    .foregroundColor(Color(red: 0.961, green: 0.961, blue: 0.961))
                
                HStack {
                    Button(action: {
                        
                        if let randomMentor = mentors.keys.randomElement() {
                            Mentor = randomMentor
                            currentImages = mentors[randomMentor]?.shuffled() ?? []
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
            // 初期値として Mentor と対応する画像を設定
            if let randomMentor = mentors.keys.randomElement() {
                Mentor = randomMentor
                currentImages = mentors[randomMentor]?.shuffled() ?? []
            }
        }
    }
}
