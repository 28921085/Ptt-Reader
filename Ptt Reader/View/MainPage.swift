import SwiftUI

struct MainPage: View {
    @Binding var blackStyle:Bool
    var body: some View {
        ZStack{
            Rectangle()
                .fill(blackStyle ? Color.black : Color.white)
                .scaledToFit()
            VStack{
                Text("選擇風格")
                    .foregroundColor(blackStyle ? Color.white : Color.black)
                Toggle(isOn: $blackStyle){
                    Text(blackStyle ? "黑色" : "白色")
                        .foregroundColor(blackStyle ? Color.white : Color.black)
                }
            }
        }
        
        
        
        
    }
}
