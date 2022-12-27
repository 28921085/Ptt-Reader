import SwiftUI
import Kanna
struct HTMLParser{
    static func removeSpace(str:String)->String{
        var tmp=""
        for i in str{
            if i != " "{
                tmp += String(i)
            }
        }
        return tmp
    }
    static func str2BoardTitle(str:String)->BoardTitle{
        var tmp=str.split(separator: Character("\n"))
        
        //return BoardTitle(name: "1", popular: "2", ID: "3", popularPost: "4")
        return BoardTitle(name: String(tmp[2]), popular: String(tmp[1]), ID: String(tmp[0]), popularPost: String(tmp[3]))
    }
    static func checkIP(str:String)->Bool{
        var dot=0
        var num=0
        for i in str{
            if i == "."{
                dot += 1
            }
            else if i >= "0" && i <= "9"{
                num += 1
            }
            else{
                return false
            }
        }
        if num >= 4 && num <= 12 && dot == 3{
            return true
        }
        return false
    }
    static func checkDate(str:String)->Bool{
        var cnt=0
        var cnt2=0
        for i in str{
            if i == "/"{
                cnt += 1
            }
            else if i >= "0" && i <= "9"{
                cnt2 += 1
            }
        }
        if cnt == 1 && cnt2 == 4{
            return true
        }
        return false
    }
    static func str2Comment(str:String)->[Comment]{
        var tmp = str.split(separator: "\n")
        var comments:[Comment]=[]
        var tp:Comment=Comment()
        for i in tmp{
            //print("---\(i)")
            var content=i.split(separator: " ")
            var state=0
            var idx=0
            while idx < content.count{
                //print("\(state) \(idx) #\(content[idx])#")
                if state == 0{
                    tp=Comment()
                    tp.state = String(content[idx])
                }
                else if state == 1{
                    var au = content[idx].split(separator: ":")
                    tp.author = String(au[0])
                }
                else if state == 3{
                    tp.date = String(content[idx])
                }
                else if state == 4{
                    tp.date += " "
                    tp.date += String(content[idx])
                }
                else{
                    if checkIP(str:String(content[idx])){
                        tp.IP = String(content[idx])
                    }
                    else if checkDate(str: String(content[idx])){
                        tp.date = String(content[idx])
                        state += 1
                    }
                    else{
                        tp.content += " "
                        tp.content += String(content[idx])
                        state -= 1
                    }
                }
                //print("\(state)")
                idx += 1
                state += 1
            }
            comments.append(tp)
            
        }
        return comments
    }
    static func str2Artical(str:String,articleURL:String)->Article{
        var tmp=str.components(separatedBy: "※ 發信站")
        var content=tmp[0]
        var comment=tmp[1]
        var pureComment=comment.components(separatedBy: articleURL)
        var comments=HTMLParser.str2Comment(str: pureComment[1])
        var Content=content.split(separator: "\n")
        var pureContent:[String]=[]
        var idx=1
        while idx < Content.count{
            pureContent.append(String(Content[idx])) 
            idx += 1
        }
        var buffer=Article(content: pureContent)
        buffer.comment=comments
        return buffer
    }
    static func checkURL(str:String)->Bool{
        if let range = str.range(of: "http"){
            let index = str.distance(from: str.startIndex, to: range.lowerBound)
            if index != 0 {
                //print("\(str) false1")
                return false
            }
        }
        else{
            //print("\(str) false2")
            return false
        }
        var cnt=0
        var cnt2=0
        for i in str{
            if i == "/"{
                cnt += 1
            }
            else if i == ":"{
                cnt2 += 1
            }
        }
        if cnt >= 2 && cnt2 == 1{
            //print("\(str) true")
            return true
        }
        //print("\(str) false3 \(cnt) \(cnt2)")
        return false
    }
}

