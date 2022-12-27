import SwiftUI
//瀏覽文章介面
struct BrowseArticle: View {
    @EnvironmentObject var data:HTMLGetter
    var body: some View {
        NavigationView{
            VStack{
                if data.Title.count == 0{
                    VStack{
                        Text("loading")
                    }
                }
                else{
                    List{
                        ForEach(data.Title.indices, id:\.self){
                            i in
                            NavigationLink{
                                Articals()
                                    .onAppear{
                                        data.ArticalTitle=[]
                                        data.getArticleInformation(whichBoard: data.Title[i].ID)
                                    }
                                    .environmentObject(data.Title[i])
                                    .environmentObject(data)
                                
                            }label: {
                                TitleView(title: $data.Title[i])
                            }
                        }
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
    @State private var show = false
    @State private var index = -1
    
    var body: some View {
        if data.ArticalTitle.count == 0{
            Text("loading")
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
                    
                    ArticatTitleView(title: $data.ArticalTitle[i])
                        .onTapGesture {
                            show = true
                            index = i
                        }
                    
                    //                    NavigationLink{
                    //                        ArticleContent()
                    //                            .onAppear{
                    //                                data.ArticleInfo=Article()
                    //                                data.getArticle(URL: data.ArticalTitle[i].link)
                    //                            }
                    //                            .environmentObject(data)
                    //                    }label:{
                    //                        ArticatTitleView(title: $data.ArticalTitle[i])
                    //                    }
                }
                .navigationTitle("\(title.name)版")
            }
            .sheet(isPresented: $show) {
                ArticleContent()
                    .onAppear{
                        data.ArticleInfo=Article()
                        data.getArticle(URL: data.ArticalTitle[index].link)
                    }
            }
        }
        
        /*
         VStack{
         Text("https://www.ptt.cc/bbs/\(title.ID)/index.html")
         //ArticatTitleView(title:$title)
         .navigationTitle("\(title.name)版")
         }
         */
    }
}
//文章內文介面
struct ArticleContent:View{
    @EnvironmentObject var data:HTMLGetter
    var body:some View{
        if data.ArticleInfo.comment.count == 0{
            Text("loading")
        }
        else{
            List{
                VStack{
                    ArticleView(Article: data.ArticleInfo)
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
