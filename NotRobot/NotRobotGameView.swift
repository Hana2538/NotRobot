import SwiftUI
import AVFoundation

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
    
    // メンターの順番リスト
    let mentorOrder: [String] = ["しばちゃん", "さわっくま", "KURO"]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var Mentor: String = "メンター"
    @State private var currentImages: [String] = []
    @State private var selectedImages: Set<String> = []
    @State private var currentMentorIndex: Int = 0 // 現在のメンターのインデックス
    @State private var statusText: String = "このテストはKUROとさわっくまとしばちゃんの3人のみなので、自分でキリのいいところで終わってください"
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(width: 371, height: 120)
                    .foregroundColor(Color.blue)
                
                Text("\(Mentor)")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 180)
                    .padding(.bottom, 30)
                
                Text("の画像をすべて選択してください")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
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
                                .offset(x: 35, y: -35)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .offset(x: 35, y: -35)
                        }
                    }
                }
            }
            
            ZStack {
                Rectangle()
                    .frame(width: 371, height: 80)
                    .foregroundColor(.gray.opacity(0.2))
                
                HStack {
                    Button(action: nextQuestion) {
                        Image(systemName: "arrow.trianglehead.clockwise")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 180)
                    
                    Button(action: checkAnswer) {
                        Text("確認")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .frame(width: 90)
                    }
                }
            }
            
            // ステータス表示
            Text(statusText)
                .font(statusText == "ああ、あなたはロボットじゃないですね！" || statusText == "不正解！もしやあなたはロボットですね？" ? .system(size: 24).bold() : .system(size: 16))
                .foregroundColor(statusText == "ああ、あなたはロボットじゃないですね！" || statusText == "不正解！もしやあなたはロボットですね？" ? .red : .gray)
                .padding(.top, 20)
            
            
            Spacer()
        }
        .padding()
        .onAppear(perform: nextQuestion)
    }
    
    /// **正解・不正解を判定**
    private func checkAnswer() {
        var correctImages: Set<String> = []
        
        // メンターごとの正解画像をセット
        if Mentor == "KURO" {
            correctImages = Set(["CorrectKURO1", "CorrectKURO2", "CorrectKURO3"])
        } else if Mentor == "さわっくま" {
            correctImages = Set(["CorrectKUMA1", "CorrectKUMA2", "CorrectKUMA3"])
        } else if Mentor == "しばちゃん" {
            correctImages = Set(["CorrectShiba1", "CorrectShiba2", "CorrectShiba3"])
        }
        
        let isCorrect = selectedImages == correctImages
        
        if isCorrect {
            statusText = "ああ、あなたはロボットじゃないですね！"
            
            // 2秒後に次の問題へ
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                nextQuestion()
            }
        } else {
            statusText = "不正解！もしやあなたはロボットですね？"
        }
    }
    
    /// **次の問題に進む**
    private func nextQuestion() {
        currentMentorIndex = (currentMentorIndex + 1) % mentorOrder.count
        Mentor = mentorOrder[currentMentorIndex]
        currentImages = mentors[Mentor]?.shuffled() ?? []
        selectedImages.removeAll()
        statusText = "このテストはKUROとさわっくまとしばちゃんの3人のみなので、自分でキリのいいところで終わってください"
    }
}
