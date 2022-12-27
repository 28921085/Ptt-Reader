import SwiftUI
class BoardTitle:ObservableObject{
    var name:String
    var popular:String
    var ID:String
    var popularPost:String
    init(name:String,popular:String,ID:String,popularPost:String){
        self.name=name
        self.popular=popular
        self.ID=ID
        self.popularPost=popularPost
    }
}
class ArticleTitle: ObservableObject{
    var title:String
    var author:String
    var date:String
    var popular:String
    var link:String
    init(title:String,author:String,date:String,popular:String,link:String){
        self.title=title
        self.author=author
        self.date=date
        self.popular=popular
        self.link=link
    }
}
class Article:ObservableObject{
    var author:String
    var board:String
    var title:String
    var time:String
    var content:[String]
    var comment:[Comment]
    /*init(author:String,title:String,time:String,content:String,comment:[Comment]){
        self.author=author
        self.title=title
        self.time=time
        self.content=content
        self.comment=comment
    }*/
    init(content:[String]){
        self.author=""
        self.board=""
        self.title=""
        self.time=""
        self.content=content
        self.comment=[]
    }
    init(){
        self.author=""
        self.board=""
        self.title=""
        self.time=""
        self.content=[]
        self.comment=[]
    }
}
class Comment:ObservableObject{
    var state:String
    var author:String
    var content:String
    var IP:String
    var date:String
    var reply:String
    init(){
        self.state=""
        self.author=""
        self.content=""
        self.IP=""
        self.date=""
        self.reply=""
    }
}
