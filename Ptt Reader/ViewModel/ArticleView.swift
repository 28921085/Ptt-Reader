import SwiftUI

struct ArticleView: View {
    @StateObject var Article:Article
    var width=UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment:.leading){
            VStack(alignment: .leading){
                HStack{
                    Text("標題").foregroundColor(Color.blue)
                    Text(Article.title)
                    Text("")
                    Text("看板").foregroundColor(Color.blue)
                    Text(Article.board)
                }
                HStack{
                    Text("作者").foregroundColor(Color.blue)
                    Text(Article.author)
                }
                HStack{
                    Text("時間").foregroundColor(Color.blue)
                    Text(Article.time)
                }
            }
            ForEach(Article.content.indices,id:\.self){
                i in
                if HTMLParser.checkURL(str:Article.content[i]){
                    AsyncImage(url: URL(string: Article.content[i]), scale: 1.0)
                }
                else {
                    Text(Article.content[i])
                }
            }
            ForEach(Article.comment.indices,id:\.self){
                i in
                CommentView()
                    .environmentObject(Article.comment[i])
            }
        }
    }
}
struct CommentView:View{
    @EnvironmentObject var comment:Comment
    func genColor(r:Double,g:Double,b:Double)->Color{
        return Color(.sRGB,red: r/255.0,green: g/255.0,blue: b/255.0)
    }
    func genState(state:String)->Text{
        if state == "推"{
            return Text(state)
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
                    .foregroundColor(genColor(r: 255, g: 255, b: 0))
                Text(":")
                    .foregroundColor(genColor(r: 204, g: 204, b: 77))
            }
            Text(comment.content)
                .foregroundColor(genColor(r: 204, g: 204, b: 77))
            Spacer()
            Text(comment.IP)
            Text(comment.date)
        }
    }
}
