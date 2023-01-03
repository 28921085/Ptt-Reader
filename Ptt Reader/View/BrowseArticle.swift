import SwiftUI
//瀏覽文章介面
struct BrowseArticle: View {
    @EnvironmentObject var data:HTMLGetter
    @Binding var blackStyle:Bool
    var body: some View {
        NavigationView{
            VStack{
                if data.Title.count == 0{
                    Rectangle()
                        .fill(blackStyle ? Color.black : Color.white)
                        .scaledToFill()
                        .overlay(
                    VStack{
                        Text("loading")
                            .foregroundColor(blackStyle ? Color.white : Color.black)
                    }
                        )
                }
                else{
                    List{
                        ForEach(data.Title.indices, id:\.self){
                            i in
                            NavigationLink{
                                Articals(blackStyle: $blackStyle)
                                    .onAppear{
                                        data.ArticalTitle=[]
                                        data.getArticleInformation(whichBoard: data.Title[i].ID)
                                    }
                                    .environmentObject(data.Title[i])
                                    .environmentObject(data)
                                
                            }label: {
                                TitleView(title: $data.Title[i],blackStyle:$blackStyle)
                            }
                        }
                        .listRowBackground(blackStyle ? Color.black : Color.white)
                        .listRowSeparatorTint(blackStyle ? Color.white : Color.black)
                    }
                }
            }
            .navigationTitle("所有看版")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
//看板介面
struct Articals:View{
    @EnvironmentObject var title:BoardTitle
    @EnvironmentObject var data:HTMLGetter
    @Binding var blackStyle : Bool
    @State private var show = false
    @State private var index = -1
    
    var body: some View {
        if data.ArticalTitle.count == 0{
            Rectangle()
                .fill(blackStyle ? Color.black : Color.white)
                .scaledToFill()
                .overlay(
                    VStack{
                        Text("loading")
                            .foregroundColor(blackStyle ? Color.white : Color.black)
                    }
                )
        }
        else{
            HStack{
                pageBtn(URL: $data.lastPage, next: false)
                    .environmentObject(data)
                Spacer()
                pageBtn(URL: $data.nextPage, next: true)
                    .environmentObject(data)
            }
            List{
                ForEach(data.ArticalTitle.indices, id:\.self){
                    i in
                    ArticatTitleView(title: $data.ArticalTitle[i],blackStyle:$blackStyle)
                        .onTapGesture {
                            show = true
                            index = i
                        }
                }
                .navigationTitle("\(title.name)版")
                .listRowBackground(blackStyle ? Color.black : Color.white)
                .listRowSeparatorTint(blackStyle ? Color.white : Color.black)
            }
            .sheet(isPresented: $show) {
                ArticleContent(blackStyle: $blackStyle)
                    .onAppear{
                        data.ArticleInfo=Article()
                        data.getArticle(URL: data.ArticalTitle[index].link)
                    }
            }
        }
    }
}
//文章內文介面
struct ArticleContent:View{
    @EnvironmentObject var data:HTMLGetter
    @Binding var blackStyle:Bool
    var body:some View{
        if data.ArticleInfo.comment.count == 0{
            Rectangle()
                .fill(blackStyle ? Color.black : Color.white)
                .scaledToFill()
                .overlay(
                    VStack{
                        Text("loading")
                            .foregroundColor(blackStyle ? Color.white : Color.black)
                    }
                )
        }
        else{
            List{
                VStack{
                    ArticleView(Article: data.ArticleInfo,blackStyle:$blackStyle)
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .listRowBackground(blackStyle ? Color.black : Color.white)
                .listRowSeparatorTint(blackStyle ? Color.white : Color.black)
            }
        }
    }
}
