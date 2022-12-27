import SwiftUI
import Alamofire
import Kanna
class HTMLGetter: ObservableObject{
    @Published var Title:[BoardTitle]=[]
    @Published var ArticalTitle:[ArticleTitle]=[]
    @Published var ArticleInfo:Article=Article()
    @Published var lastPage:String=""
    @Published var nextPage:String=""
    func getHTML(URLstr:String,op:String,arg:String=""){
        let url = URL(string : URLstr)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="GET"
        urlRequest.setValue("over18=1", forHTTPHeaderField: "Cookie")
        urlRequest.httpShouldHandleCookies=true
        AF.request(urlRequest).responseString{
            response in
            if let html = response.data,let htmlDoc=String(data:html,encoding: .utf8){
                if let doc = try? HTML(html: htmlDoc, encoding: .utf8) {
                    if op == "title"{
                        var buffer:[BoardTitle]=[]
                        for t in doc.xpath("//*[@class='board']"){
                            var tmp = HTMLParser.removeSpace(str: t.text ?? "")
                            buffer.append(HTMLParser.str2BoardTitle(str: tmp))
                        }
                        self.Title=buffer
                    }
                    else if op == "articles"{
                        var buffer:[ArticleTitle]=[]
                        var cnt = 0
                        for t in doc.xpath("//*[@class='title']/a"){
                            buffer.append(ArticleTitle(title: t.text ?? "", author:  "", date: "", popular: "",link: t["href"] ?? ""))
                            //print("\(cnt)")
                            cnt+=1
                        }
                        cnt = 0
                        for au in doc.xpath("//*[@class='author']"){
                            //print("\(cnt)")
                            buffer[cnt].author = au.text ?? ""
                            cnt+=1
                        }
                        cnt=0
                        for date in doc.xpath("//*[@class='date']"){
                            buffer[cnt].date = date.text ?? ""
                            cnt+=1
                        }
                        cnt=0
                        for pop in doc.xpath("//*[@class='nrec']/span"){
                            buffer[cnt].popular = pop.text ?? ""
                            cnt+=1
                        }
                        buffer.reverse()
                        var nextPage=""
                        var lastpage=""
                        for pg in doc.xpath("//*[@class='btn wide']"){
                            var txt = pg["href"] ?? ""
                            if let range = txt.range(of: "index."){
                                let index = txt.distance(from: txt.startIndex, to: range.lowerBound)
                                //nothing
                            }
                            else if let range = txt.range(of: "index1."){ 
                                //nothing
                            }
                            else{
                                if lastpage == ""{
                                    lastpage = txt
                                }
                                else{
                                    nextPage = txt
                                }
                            }
                        }
                        if let range = lastpage.range(of: "index2."){
                            let index = lastpage.distance(from: lastpage.startIndex, to: range.lowerBound)
                            if nextPage == ""{
                                swap(&lastpage, &nextPage)
                            }
                        }
                        print("last : \(lastpage)")
                        print("next : \(nextPage)")
                        self.lastPage=lastpage
                        self.nextPage=nextPage
                        self.ArticalTitle=buffer
                    }
                    else if op == "articleInfo"{
                        for t in doc.xpath("//*[@id='main-content']"){
                            var str=t.text ?? ""
                            self.ArticleInfo=HTMLParser.str2Artical(str: str, articleURL: URLstr)
                            //print(self.ArticleInfo.content[2])
                            
                        }
                        var cnt=0
                        for t in doc.xpath("//*[@class='article-meta-value']"){
                            if cnt == 0{
                                self.ArticleInfo.author = t.text ?? ""
                            }
                            else if cnt == 1{
                                self.ArticleInfo.board = t.text ?? ""
                            }
                            else if cnt == 2{
                                self.ArticleInfo.title = t.text ?? ""
                            }
                            else{
                                self.ArticleInfo.time = t.text ?? ""
                            }
                            cnt+=1
                        }
                    }
                }
                
                
            }
        }
    }
    func getBoardInformation(){
        getHTML(URLstr: "https://www.ptt.cc/bbs/index.html",op:"title")
    }
    func getArticleInformation(whichBoard :String){
        getHTML(URLstr: "https://www.ptt.cc/bbs/\(whichBoard)/index.html", op: "articles")
    }
    func getArticle(URL : String){
        getHTML(URLstr: "https://www.ptt.cc\(URL)", op: "articleInfo")
    }
    func getPage(page:String){
        getHTML(URLstr: "https://www.ptt.cc\(page)", op: "articles")
    }
}

