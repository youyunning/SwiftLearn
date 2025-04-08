//
//  ContentView.swift
//  Memorize
//
//  Created by yunning you on 2025/4/7.
//

import SwiftUI

struct ContentView: View {
    var emojis : Array = ["🎾","🚐","🚘","⛺️","🐽","🐮","🦊","🚐1","🚘2","⛺️3","🐽4","🐮5","🦊6"]
  @State  var emojiCount  = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
         
            Spacer()
            cardCountAdjusters
        }
          
    }
    var cardCountAdjusters : some View {
            HStack{
                remove
                 Spacer()
                 add
            }.font(.largeTitle).padding(.horizontal)
        }
    var cards : some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]){
            ForEach(emojis[0 ..< emojiCount], id: \.self,content: {emoji in CardView(content: emoji)
                    .aspectRatio(2/3, contentMode: .fit)
            })
               
        }.padding(.horizontal).foregroundStyle(.purple)
    }
    
    func cardCountAdjust(by offset : Int, symbol : String) -> some View{
        Button(action :{
            emojiCount += offset
        }, label: {
            Image(systemName: symbol)
        }).disabled(emojiCount + offset < 1 || emojiCount + 1 > emojis.count)

        
    }	
    var remove :some View{
        return cardCountAdjust(by: -1, symbol: "minus.circle")
    }
    var add : some View{
        return cardCountAdjust(by: +1, symbol: "plus.app")
    }
    
}
struct CardView :View{
    var content : String
  @State  var isFaceUp: Bool = true
    var body: some View {
        ZStack(alignment: .center, content:{
            let shape =   RoundedRectangle(cornerRadius: 20.0)
            Group{
                shape
                    .stroke(lineWidth: 3)//只勾勒出形状，外边缘
                shape.fill(.white)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            shape.fill().opacity(isFaceUp ? 0 : 1)

//                .foregroundStyle(.orange)
//                .padding()
        }).onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct Contentview_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
//           .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()

}
