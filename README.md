## iOS 커리어 스타터 캠프

### 계산기 프로젝트 저장소

> 프로젝트 기간 2022/05/30 ~ 2022/06/03
팀원: [@hugh](https://github.com/Hugh-github) [@bard](https://github.com/bar-d)/ 리뷰어: [@GREENOVER](https://github.com/GREENOVER)
> 


## UML
![Untitled](https://user-images.githubusercontent.com/102569735/171013972-f0c57142-b68c-4cd1-882f-5332266278bb.jpg)
# 목차

- [프로젝트 소개](#프로젝트-소개)
- [키워드](#키워드)
- [그라운드 룰](#그라운드-룰)
    - [활동시간](#활동시간)
    - [예외사항](#예외사항)
    - [의사소통 방법](#의사소통-방법)
    - [코딩 컨벤션](#코딩-컨벤션)
- [STEP 1](#STEP-1)
    - [고민한점](#고민한점)
    - [배운개념](배운개념)
- [STEP 2](#STEP-2)
    - [고민한점](#고민한점)
    - [배운개념](배운개념)

# 프로젝트 소개

- 서로 만든 계산기 프로젝트 코드 합치기 및 리팩토링

# 개발환경 및 라이브러리

[https://img.shields.io/badge/swift-5.6-orange](https://img.shields.io/badge/swift-5.6-orange)

[https://img.shields.io/badge/Xcode-13.3.1-blue](https://img.shields.io/badge/Xcode-13.3.1-blue)

# 키워드

- `merge`, `refactor`


# 그라운드 룰
## 활동시간


+ 점심시간 12:30 ~ 13:30
+ 저녁시간 18:00 ~ 20:00

## 예외사항
- 변동사항 있으면 DM 보내줄 것

## 의사소통 방법
+ 디스코드 회의실
+ 단톡방


## 코딩 컨벤션

1. Swift 코드 스타일 : [스위프트 API 가이드라인](https://gist.github.com/godrm/d07ae33973bf71c5324058406dfe42dd) 
2. 커밋 
+ 커밋 Title 규칙

	+ add: 새로운 파일 추가
	+ refactor: 코드 리팩토링
	+ style: 코드 내 들여쓰기나 부가적인 수정
	+ feat: 새로운 기능 추가
	+ fix: 버그 수정
	+ docs: 문서수정
        + chore: 중요하지 않은 일을 수정하는 경우(코드의 변화가 생산적인 것이 아닌 경우)
+ 커밋 body 규칙

	+ 현제 시제를 사용, 이전 행동과 대조하여 변경을 한 동기를 포함하는 것을 권장 문장형으로 끝내지 않기
	+ commitTitle 과 body 사이는 한 줄 띄워 구분하기
	+ commitTitle line의 글자수는 50자 이내로 제한하기
	+ commitTitle line의 마지작에 마침표(.) 사용하지 않기
	+ commitBody는 72자마다 줄 바꾸기
	+ commitBody는 어떻게 보다 무엇을, 왜 에 맞춰 작성하기

# 핵심경험

- [x]  UML을 기반으로 한 코드병합
- [x]  스토리보드 병합
- [x]  기존 코드의 리팩터링
- [x]  단위 테스트를 통해 리팩터링 과정의 코드 오류를 최소화
- [x]  제네릭을 활용하여 범용적인 타입 구현(선택)



# [STEP 1]

## 고민한점

### `Merge 방법`
1. 새롱 생성한 브랜치를 기준으로 머지를 통해 각 브랜치 별로 만들 것인가
2. 브랜치를 하나 생성해 커밋을 할 것인가
	- 이 두개의 방법이 차이가 있나?
	- 현업에서는 어떻게 코드를 통합하는가?


## 궁금한 점

### `TestCode`

- 현재 코드를 합치면서 네이밍부분이나 어느 정도의 로직이 다름  
그렇다면 테스트를 해야 하는 기준이 어떻게 될 것인가


### `Generic`
- 프로젝트 내 핵심경험 중 제네릭을 활용하여 범용적인 타입을 구현하라는 것은 큐라는 프로토콜을 만들어 활용을 하라는 것인가?

### `UML`
- UML 기준으로 작성하였다면, 누구의 컨트롤러를 가져와도 정상적으로 실행이 되어야 한다고 생각
- Action 버튼 도 서로 다르게 다켓을 설정해 로직이 다름
- 추후에 리팩토링 하는 과정에서 고쳐나가야 하는 부분인가?




## 배운개념
- `콜라보레이터 설정`

## 코드를 선택한 이유
### `Operator, Formula`
- 에러를 처리하는 방식만 다르고 로직은 같아 Operator는 바드의 코드를 사용하고 Formula는 휴의 코드를 사용  
	합쳐진 로직을 확인하고 에러를 해결하기 위해 테스트 코드 작성
### `CalculatorItemQueue`
- 휴: 배열을 사용해 큐를구현
- 바드: 더블 스택을 사용해 큐를 구현, Queue 프로토콜을 사용하여 구현
	- `dequeue`의 시간 복잡도가 더블 스택이 유리하다고 판단하여 바드의 코드 사용

### `ExpressionParser`
- 휴: 공백없이 데이터를 전달
- 바드: 공백있이 데이터를 전달
	- Controller에서 데이터를 전달할 때 임의로 공백을 넣는것보다 공백없이 데이터를 전달하는게 부합하다고 판단

### `String+extension`
- 휴: split구현
- 바드: split 및 formatNumber 구현
	- 구혀되어있는 바드의 코드 사용

### `CalCulatorView`

- 휴: 스택뷰에 들어갈 스택뷰 및 레이블 프로퍼티 구현
- 바드: 전체적인 로직 구현 완료 해놓은 상태
	- 휴의 계산기1 프로젝트가 아직 머지되지 않은 상태여서 추후에 휴 중심으로 리팩토링 해나갈 예정

