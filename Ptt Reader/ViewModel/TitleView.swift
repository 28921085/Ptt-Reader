import SwiftUI

struct TitleView: View {
    @Binding var title:BoardTitle
    func genColor(r:Double,g:Double,b:Double)->Color{
        return Color(.sRGB,red: r/255.0,green: g/255.0,blue: b/255.0)
    }
    func popular(num:String)->Text{
        var n = Int(num) ?? 0 
        if n > 99999{
            return Text("爆！")
                .foregroundColor(genColor(r: 255, g: 0, b: 255))
        }
        else if n > 59999{
            return Text("爆！")
                .foregroundColor(genColor(r: 255, g: 255, b: 0))
        }
        else if n > 29999{
            return Text("爆！")
                .foregroundColor(genColor(r: 0, g: 255, b: 0))
        }
        else if n > 9999{
            return Text("爆！")
                .foregroundColor(genColor(r: 0, g: 255, b: 255))
        }
        else if n > 4999{
            return Text("爆！")
                .foregroundColor(genColor(r: 0, g: 0, b: 255))
        }
        else if n > 1999{
            return Text("爆！")
                .foregroundColor(genColor(r: 255, g: 0, b: 0))
        }
        else if n > 999{
            return Text("爆！")
                .foregroundColor(genColor(r: 255, g: 255, b: 255))
        }
        else if n > 99{
            return Text("HOT")
                .foregroundColor(genColor(r: 255, g: 255, b: 255))
        }
        else if n > 49{
            return Text(num)
                .foregroundColor(genColor(r: 255, g: 0, b: 0))
        }
        else if n > 10{
            return Text(num)
                .foregroundColor(genColor(r: 255, g: 255, b: 0))
        }
        else if n > 1 {
            return Text(num)
                .foregroundColor(genColor(r: 128, g: 128, b: 128))
        }
        else{
            return Text("")
        }
    }
    var body: some View {
        VStack{
            HStack{
                Text(title.ID)
                    .listTitle()
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .frame(width: 60, height: 30)
                    .overlay(popular(num: title.popular))
                
            }
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [Color.gray,Color.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                    .overlay(Text(title.name))
                Spacer()
                Text(title.popularPost)
            }
        }
    }
}
extension Text{
    func listTitle()->some View{
        self
            .font(.title)
            .fontWeight(.heavy)
    }
    
}
struct ArticatTitleView:View{
    @Binding var title:ArticleTitle
    func genPopular(num:String)->Text{
        if num == "爆"{
            return Text(num)
                .foregroundColor(Color.red)
                .font(.system(size: 20))
        }
        else if num.count == 1{
            return Text(num)
                .foregroundColor(Color.green)
                .font(.system(size: 20))
        }
        else {
            return Text(num)
                .foregroundColor(Color.yellow)
                .font(.system(size: 20))
        }
    }
    var body:some View{
        HStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 30, height: 30)
                .opacity(0)
                .overlay(genPopular(num: title.popular))
            VStack(alignment: .leading){
                Text(title.title)
                    .font(.system(size: 20))
                HStack{
                    Text(title.author)
                        .foregroundColor(Color.gray)
                    Spacer()
                    Text(title.date)
                }
            }
        }
    }
}
struct pageBtn: View {
    @Binding var URL:String
    @EnvironmentObject var data:HTMLGetter
    var next:Bool
    var body: some View {
        if URL == ""{
            Button{
                
            }label:{
                ZStack{
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 60, height: 30)
                    if next{
                        Text("下一頁").foregroundColor(Color.black)
                    }
                    else{
                        Text("上一頁").foregroundColor(Color.black)
                    }
                }
            }
        }
        else{
            Button{
                data.ArticalTitle=[]
                data.getPage(page: URL)
            }label: {
                ZStack{
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 60, height: 30)
                    if next{
                        Text("下一頁")
                            .foregroundColor(Color.white)
                    }
                    else{
                        Text("上一頁")
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}
