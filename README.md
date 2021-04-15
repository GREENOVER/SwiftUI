# SwiftUI Exercise Project
### SwiftUI에 대해 학습하고 기본적인 시도와 계산기 UI를 구현해본 연습 프로젝트
[TIL for Optional Chaining](https://github.com/GREENOVER/Today-I-Learned/blob/master/2021/TIL_2021.04.14.md)
***
#### What I learned✍️
- MVC & MVVM
- VStack / HStack / ZStack
- TupleView
- some
- Modifier for Chaining
- Property Wrappers
    - @State
    - @Binding

#### What have I done🧑🏻‍💻
- SwiftUI는 이미 바인딩이 되어있어 기존 UIKit의 MVC 아키텍쳐 패턴과 달리 데이터 값이 변하면 뷰모델에서 뷰를 자체적으로 테스트할 수 있게 바로 Xcode상에서 화면에 자동으로 뷰가 변경됨으로 테스트할 때 시뮬레이터를 구동하지 않아도 되는 편리함이 있어 MVVM 아키텍쳐 패턴에 적합하다.
- UIKit의 다양한 StackView가 SwiftUI에서는 VStack/HStack/ZStack등으로 사용되며 한 뷰를 구성함으로 구조적으로 어느 스택안에 어떤 요소를 넣을건지 잘 생각해보는 학습을 하였으며 SwiftIUI를 이용하여 기초적인 뷰를 구성할 수 있다.
- 서로 다른 뷰간에 데이터 값의 변화를 감지할때는 @State와 @Binding이라는 Property Wrappers를 이용하여 자동으로 데이터 값의 변화를 파악할 수 있다.
    - @State: 데이터의 상태 변화를 감지하도록 사용
    - @Binding: 정의된 @State 변수를 사용하고 해당 값을 넘겨받을거란 의미로 다른 부분에서 일어나도 자동 연결 변경됨
- Modifier(.)을 통해 UI요소에 대해 옵셔널 체이닝처럼 체이닝을 구성할 수 있다. 보통 줄바꿈으로 체이닝을 시키지만 사실상 의미는 붙어있어 체이닝처럼 작동하는 원리
- return값이 생략되어 Text / Color, ZStack 처럼 구성하고 쓰이는데 사실상 return값이 있는것과 마찬가지로 한 뷰에 한 return값만 들어가도록 구성되어야한다. 그렇지 않다면 아래와 같은 현상이 일어난다.
- return값이 안보인다고 구조적으로 구성하지 않는다면 뷰 영역에 한 뷰가 아닌 여러 뷰가 나타나게 된다. 이는 Xcode에서 이것에 대해 혼동되어 두개 다 따로 구성하게 되는것이며 시뮬레이터 작동 시 튜플뷰로 인식하여 기본적으로 VStack으로 보여지게 된다.

#### Trouble Shooting👨‍🔧
##### 1)
- 문제점: 아래 코드와 같이 body 인스턴스에 여러 UI 요소들을 나열했을때 뷰 화면에서 여러 뷰가 보이게 되고 시뮬레이터 동작시에는 의도하지 않았는데 VStack으로 구현되게 되었다.
  ```Swift
  ZStack {
      Color.green
      Text("Thinking")
      .padding()
  }
  Color.blue
  Text("Green's SwiftUI Test!")
      .padding()
      .foregroundColor(.green)
      .font(.largeTitle)
      .background(Color.black)
  Color.blue
      .ignoresSafeArea(.all)
  RoundedRectangle(cornerRadius: 50)
      .ignoresSafeArea(.all)
  ```
<img src = "https://github.com/GREENOVER/SwiftUI/blob/main/InXcode.png" width="50%" height="50%">
<img src = "https://github.com/GREENOVER/SwiftUI/blob/main/InSimulator.png" width="50%" height="50%">

- 원인: return 키워드는 생략된것이지 하나만 존재해야하는데 안보인다고 SwiftUI에서는 없구나 라고 생각을하여 스택안에 텍스트를 넣고 여러 요소들을 배치해야했었다. 그런데 이걸 전부 빼버린다면 전부의 요소에 return 키워드가 생략이 되었지만 붙어있는것이다. 이걸 Xcode는 어떤 뷰를 리턴해줄지 혼동이 와 여러뷰가 뷰 영역에서 잡히는는것이다. 또한 시뮬레이터를 구동시켰을때 이 여러 리턴값이 붙어있는 뷰를 튜플뷰로 판단하여 기본적으로 VStack처럼 위에서부터 순서대로 표현했던것이다.
- 해결방법: 아래 코드와 값이 원하는 VStack안에 해당 요소들을 전부 넣어줌으로 튜플뷰를 없애고 혼동을 피해줄 수 있다.
  ```Swift
  VStack {
    ZStack {
        Color.green
        Text("Thinking")
        .padding()
    }
    Color.blue
    Text("Green's SwiftUI Test!")
        .padding()
        .foregroundColor(.green)
        .font(.largeTitle)
        .background(Color.black)
    Color.blue
        .ignoresSafeArea(.all)
    RoundedRectangle(cornerRadius: 50)
        .ignoresSafeArea(.all)
  }
  ```
##### 2)
- 문제점: 1번 문제와 같이 튜플뷰로 강제적으로 주어질때 만약 Color요소가 사용되어 배경색이던 어떤것이던 칠해지게된다면 1번의 이미지와 같이 사이 공백이 나타나게된다.
- 원인: 아직 딱 뚜렷한 원인을 찾지 못하고 계속 참고하고 있지만 아마 추측하자면 튜플뷰로 구성되었을때 Color요소가 들어간것만 사이 공백이 주어지고 텍스트는 사이 공백이 주어지지 않는것으로 봐서 Color요소의 공백을 없애려면 ignoreSafeArea의 사용대신 Color의 사이즈 및 프레임을 조정해줘야될것같다.
- 해결책: 여러 해결책을 찾으려 서핑하다 좀 적용될 수 있는 부분의 링크를 가져와보았다. 아직 미완성인채로.. 해결이 되면 다시 공유할 예정! (아래 링크의 마지막 Color as a View 부분을 보면된다.)   
  [SwiftUI TupleView Trouble](https://troz.net/post/2020/swiftui-color/)

