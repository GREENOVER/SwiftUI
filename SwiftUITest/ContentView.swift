import SwiftUI

struct ContentView: View {
// MARK: Notes for SwiftUI
/* some의 의미는 View를 채택한걸 반환
   return 키워드는 생략된 것
   ZStack을 사용하면 UI가 겹침
   Opaque Types: 불투명한 타입*/
    
// MARK: Test for SwiftUI TupleView
//        ZStack {
//            Color.green
//            Text("Thinking")
//                .padding()
//        }
//        Color.blue
//        Text("Green's SwiftUI Test!")
//            .padding()
//            .foregroundColor(.green)
//            .font(.largeTitle)
//            .background(Color.black)
//        Color.blue
//            .ignoresSafeArea(.all)
//        RoundedRectangle(cornerRadius: 50)
//            .ignoresSafeArea(.all)

// MARK: Calculator
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            CalculatorView(buttons: buttons)
        }
    }
}

// MARK: 계산기의 전체를 나타내는 뷰
struct CalculatorView: View {
    let buttons: [[CalculatorButton]]
    @State var displayText: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text(displayText)
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            }
            .padding(10)
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(button: button, displayText: $displayText)
                    }
                }
            }
        }
    }
}

// MARK: 계산기의 각 버튼들을 구성하는 뷰
struct CalculatorButtonView: View {
    var button: CalculatorButton
    @Binding var displayText: String
    
    var body: some View {
        Button(action: {
            displayText.append(button.title)
        }, label: {
            Text(button.title)
                .font(.system(size: 30))
                .frame(width: buttonWidth(button: button),
                       height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(buttonWidth(button: button))
        })
    }
    
    // 0과 나머지 버튼에 대한 넓이를 스크린 사이즈를 통해 계산하는 메서드
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        } else {
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: 계산기 버튼에 대한 타입 지정
enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .equals: return "="
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}
