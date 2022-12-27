import SwiftUI

struct QuickBrowseArticle: View {
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
