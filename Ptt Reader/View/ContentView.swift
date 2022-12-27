import SwiftUI
struct ContentView: View {
    @StateObject private var BoardQuery=HTMLGetter()
    var body: some View {
        TabView{
            MainPage()
                .tabItem{
                    Label("主頁面", systemImage: "house.fill")
                }
            BrowseArticle()
                .tabItem{
                    Label("瀏覽文章", systemImage: "house.fill")
                }
                .environmentObject(BoardQuery)
                .onAppear{
                    BoardQuery.Title=[]
                    BoardQuery.getBoardInformation()
                }
            /*
            QuickBrowseArticle()
                .tabItem{
                    Label("搜尋文章", systemImage: "house.fill")
                }
                .environmentObject(BoardQuery)
                .onAppear{
                    BoardQuery.Title=[]
                    BoardQuery.ArticalTitle=[]
                }
             */
        }
    }
}
