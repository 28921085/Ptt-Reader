import SwiftUI
import Kanna
import Alamofire
struct KannaTest: View {
    @State private var text=""
    
    func processHTML(str:String){
        if let doc = try? HTML(html: str, encoding: .utf8) {
            print(type(of: doc))
            //print(doc.title)
            //print(doc.xpath("//div[3]")[0].text)
            text=""
            
            var cnt=0
            //標題
            for t in doc.xpath("//*[@class='title']"){
                cnt+=1
                print(t.text)
                print(type(of: t.text))
                text+="@\(cnt) "
                text += t.text ?? "" 
                text+="\n"
                
            }
            
            //推文數
            
            
            for t in doc.xpath("//*[@class='nrec']"){
                cnt+=1
                
                print(t.text)
                
                text+="@\(cnt) "
                text += t.text ?? "" 
                text+="\n"
                
            }
                                  
            /*
             //內文
            for t in doc.xpath("//div[3]"){
                cnt+=1
                print(t.text)
                text+="@\(cnt) "
                text+=t.text ?? ""
            }
             */
            // Search for nodes by CSS
            /*
            for link in doc.css("div[id^='main-content']") {
                print(link)
                //print(link["href"])
            }
            
            // Search for nodes by XPath
            for link in doc.xpath("//a | //link") {
                print(link.text)
                print(link["href"])
            }
             */
        }
        
    
    }
    func test2(str:String){
        //print(str)
        var cnt=0
        if let doc = try? HTML(html: str, encoding: .utf8) {
            
            for t in doc.xpath("//*[@class='board']"){
                cnt+=1
                text+="@\(cnt) "
                text+=t.text ?? ""
                print(t.text)
            }
             
        }
    }
    func test3(str:String){
        //print(str)
        var cnt=0
        if let doc = try? HTML(html: str, encoding: .utf8) {
            var tmp:[ArticleTitle]=[]
            for t in doc.xpath("//*[@class='title']/a"){
                //print(t["href"])
                //cnt+=1
                //text+="@\(cnt) "
                //text+=t.text ?? ""
                //print(t.text)
                tmp.append(ArticleTitle(title: t.text ?? "", author:  "", date: "", popular: "",link: t["href"] ?? ""))
            }
            for au in doc.xpath("//*[@class='author']"){
                //print(t["href"])
                //cnt+=1
                //text+="@\(cnt) "
                //text+=au.text ?? ""
                //print(t.text)
                tmp[cnt].author = au.text ?? ""
                cnt+=1
            }
            cnt=0
            // popular.      
            for date in doc.xpath("//*[@class='date']"){
                //print(t["href"])
                //cnt+=1
                //text+="@\(cnt) "
                //text+=au.text ?? ""
                //print(t.text)
                tmp[cnt].date = date.text ?? ""
                cnt+=1
            }
            cnt=0
            for pop in doc.xpath("//*[@class='nrec']/span"){
                //print(t["href"])
                //cnt+=1
                //text+="@\(cnt) "
                //text+=au.text ?? ""
                //print(t.text)
                tmp[cnt].popular = pop.text ?? ""
                cnt+=1
            }
            for i in tmp{
                print("#\n\(i.title)\n\(i.author)\n\(i.date)\n\(i.popular)\n\(i.link)")
            }
        }
    }
    func test4(str:String){
        if let doc = try? HTML(html: str, encoding: .utf8) {
            for t in doc.xpath("//*[@id='main-content']"){
                print("####\n")
                print(t.text)
                var tmp=t.text ?? ""
                var tp=tmp.components(separatedBy: "※ 發信站")
                text += tp[0]
                print("494898\n")
                print(tp[1])
                var tt=tp[1].split(separator: "\n")
                print("8498484\n")
                print(tt[0])
            }
        }
    }
    func getHTML(){
        //let url = URL(string : "https://www.ptt.cc/bbs/index.html")!
        //let url = URL(string : "https://www.ptt.cc/bbs/Gossiping/index.html")!
        let url = URL(string : "https://www.ptt.cc/bbs/Gossiping/M.1671455875.A.134.html")!
        //let url = URL(string : "https://www.ptt.cc/bbs/Gossiping/M.1671358230.A.690.html")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod="GET"
        urlRequest.setValue("over18=1", forHTTPHeaderField: "Cookie")
        urlRequest.httpShouldHandleCookies=true
        AF.request(urlRequest).responseString{
            response in
            if let html = response.data,let htmlDoc=String(data:html,encoding: .utf8){
                //"※"
                //text=htmlDoc
                test4(str: htmlDoc)
                print(type(of: htmlDoc))
                //processHTML(str: text)
            }
        }
        /*AF.request(urlRequest).
        Alamofire.Request(urlRequest).responseString{
            response in
            if let html = response.data,let htmldata=String(data:html,encoding: .utf8){
                text=htmldata
                print(text)
            }
        }*/
    }
    @StateObject private var data=HTMLGetter()
    var body: some View {
        VStack {
            ScrollView{
                if data.ArticleInfo.comment.count != 0{
                    VStack(alignment: .leading){
                        ForEach(data.ArticleInfo.content.indices,id:\.self){
                            i in
                            Text(data.ArticleInfo.content[i])
                        }
                        ArticleView(Article: data.ArticleInfo)
                    }
                    
                     
                    /*
                    VStack{
                        ForEach(data.ArticleInfo.comment.indices,id:\.self){
                            i in
                            HStack{
                                Text(data.ArticleInfo.comment[i].state)
                                Text(data.ArticleInfo.comment[i].author)
                                Text(data.ArticleInfo.comment[i].content)
                                Text(data.ArticleInfo.comment[i].IP)
                            }
                            
                        }
                    }
                     */
                    
                }
                else{
                    Text("loading")
                }
            }
            Button{
                var URL = "/bbs/Gossiping/M.1671455875.A.134.html"
                data.getArticle(URL: URL)
                //getHTML()
                //print(text)
                //print(HTMLGetter.getHTML(URLstr:"https://www.ptt.cc/bbs/index.html"))
            }label:{
                Text("get")
            }
        }
    }
}
