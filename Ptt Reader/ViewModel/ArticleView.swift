import SwiftUI

struct ArticleView: View {
    @StateObject var Article:Article
    @Binding var blackStyle:Bool
    var width=UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment:.leading){
            VStack(alignment: .leading){
                HStack{
                    Text("標題").foregroundColor(Color.blue)
                    Text(Article.title)
                        .foregroundColor(blackStyle ? Color.white : Color.black)
                    Text("")
                    Text("看板").foregroundColor(Color.blue)
                    Text(Article.board)
                        .foregroundColor(blackStyle ? Color.white : Color.black)
                }
                HStack{
                    Text("作者").foregroundColor(Color.blue)
                    Text(Article.author)
                        .foregroundColor(blackStyle ? Color.white : Color.black)
                }
                HStack{
                    Text("時間").foregroundColor(Color.blue)
                    Text(Article.time)
                        .foregroundColor(blackStyle ? Color.white : Color.black)
                }
            }
            ForEach(Article.content.indices,id:\.self){
                i in
                if HTMLParser.checkURL(str:Article.content[i]){
                    AsyncImage(url: URL(string: Article.content[i]), scale: 2)
                }
                else {
                    Text(Article.content[i])
                        .foregroundColor(blackStyle ? Color.white : Color.black)
                }
            }
            ForEach(Article.comment.indices,id:\.self){
                i in
                CommentView(blackStyle: $blackStyle)
                    .environmentObject(Article.comment[i])
            }
        }
    }
}
struct CommentView:View{
    @EnvironmentObject var comment:Comment
    @Binding var blackStyle:Bool
    func genColor(r:Double,g:Double,b:Double)->Color{
        return Color(.sRGB,red: r/255.0,green: g/255.0,blue: b/255.0)
    }
    func genState(state:String)->Text{
        if state == "推"{
            return Text(state)
                .foregroundColor(blackStyle ? Color.white : Color.black)
        }
        else if state == "噓"{
            return Text(state)
                .foregroundColor(Color.red)
        }
        else{
            return Text(state)
                .foregroundColor(Color.gray)
        }
    }
    var body:some View{
        HStack{
            genState(state: comment.state)
            HStack(spacing:0){
                Text(comment.author)
                    .foregroundColor(blackStyle ? genColor(r: 255, g: 255, b: 0) : genColor(r: 55, g: 55, b: 0))
                Text(":")
                    .foregroundColor(blackStyle ? genColor(r: 204, g: 204, b: 77) : genColor(r: 144, g: 144, b: 17))
            }
            Text(comment.content)
                .foregroundColor(blackStyle ? genColor(r: 204, g: 204, b: 77) : genColor(r: 144, g: 144, b: 17))
            Spacer()
            Text(comment.IP)
                .foregroundColor(blackStyle ? Color.white : Color.black)
            Text(comment.date)
                .foregroundColor(blackStyle ? Color.white : Color.black)
        }
    }
}
