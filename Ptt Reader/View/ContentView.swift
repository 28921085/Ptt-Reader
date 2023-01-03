import SwiftUI
struct ContentView: View {
    @StateObject private var BoardQuery=HTMLGetter()
    @State private var blackStyle:Bool=false
    var body: some View {
        TabView{
            MainPage(blackStyle: $blackStyle)
                .tabItem{
                    Label("主頁面", systemImage: "house.fill")
                }
            BrowseArticle(blackStyle:$blackStyle)
                .tabItem{
                    Label("瀏覽文章", systemImage: "book.circle.fill")
                }
                .environmentObject(BoardQuery)
                .onAppear{
                    BoardQuery.Title=[]
                    BoardQuery.getBoardInformation()
                }
        }
    }
}
