# 📚 감정 일기 - Emoji Diary
---
이스트 소프트 iOS 4기의 UI 실습 프로젝트 입니다. SwiftUI를 활용하여 일기를 CRUD 할 수 있는 iOS 애플리케이션 프로토타입을 구현하였습니다. 이미지와 텍스트를 사용해서 기록 할 수 있습니다.

## 🔔개발 환경
![Platform](https://img.shields.io/badge/Platform-iOS-blue) ![Xcode](https://img.shields.io/badge/Xcode-16.4-blue) ![iOS](https://img.shields.io/badge/iOS-16.0+-gray) ![Swift](https://img.shields.io/badge/Swift-6.1.2-orange) 


## 🔔주요 기능 시연 영상
| 메인 | 생성 | 수정/삭제 | 통계 | 세팅 |
| --- | --- | --- | --- | --- |
|  <img width="250" height="400" alt="1c8be71c9f83516146bfa111b6ef004906120a0d" src="https://github.com/user-attachments/assets/14b35910-d6de-4ec9-ab1d-98fb23f6e4e3" />   |   <img width="200" height="400" src="https://github.com/user-attachments/assets/1ba5f51c-a45a-4190-a4a3-a18a864b3d3c" />  |  <img width="200" height="400" src="https://github.com/user-attachments/assets/54ef95b0-8e88-4aa3-a858-a98d78be946a" />   |  <img width="200" height="400" src="https://github.com/user-attachments/assets/709eab63-ed0a-4de0-8afa-5980463a0907" />   |  <img width="250" height="400" alt="720dd836ecbe5c34bcde39cf5031e854c74cabc3" src="https://github.com/user-attachments/assets/6b638372-d856-41cd-a424-bee98844068e" />   |


 





## 🔔 Convention

### ✔️브랜치 컨벤션

1. **기본 브랜치 설정**  
- main : 수정 및 구현이 완료된 안정적인 구동이 가능한 코드가 있습니다.  
- Feature : main branch에 합치기 전, 하위 브랜치들을 통합하고 수정합니다.  
- feat/ .. : Feature 브랜치에 통합시키는 하위 브랜치입니다. 기능 개발 브랜치입니다.  
  
2. **Git Flow 방식**
- Local Branch -> Feature -> merge main
<img width="650" height= "325" alt="Image" src="https://github.com/user-attachments/assets/268b4a70-4f26-4fae-b366-753e51bfc89e" />


### ✔️코드 컨벤션
- SSG( Swift Style Guide) 참조.
- 주로 참고했던 규칙들 입니다.
  
```swift
1. 코드 레이아웃
- 들여쓰기 탭으로 통일.
- 콜론(:) 사용 시 오른쪽에만 공백.
- 연산자 함수 정의는 앞,뒤로 공백.

2. 줄바꿈
- 파라미터 이름 기준 줄바꾼
- 클로저 2개 이상 존재 시 줄바꿈.

3. 빈 줄
- 빈 줄에는 공백 X.

4. 네이밍
- 클래스, 열거형(emum), 프로토콜: UpperCamelCase
- 함수: lowerCamelCase, 액션함수는 "주어+동사+목적어" 형태 사용
- 변수, 상수: lowerCamelCase
- 열거형(enum)의 case: lowerCamelCase
```
### ✔️PR 템플릿
- **작업 태그**  
Feat : 기능 추가  
help wanted: 의견 요청  
fix: 버그수정

```swift
## 🤔 배경
<!--
> PR을 하게 된 문제상황, 배경 등 개요에 대해서 작성해주세요!
-->

## 📃 작업 내역
<!--
> PR에서 한 작업을 작성해주새요!
> e.g. - 첫번째 작업
-->

## ✅ 리뷰 노트
<!--
> 구현 시에 고민이었던 점들 혹은 특정 부분에 대한 의도가 있었다면 PR 리뷰의 이해를 돕기 위해 서술해주세요!
>
> 리뷰어에게 특정 부분에 대한 '집중' 혹은 '코멘트' 혹은 '질문을 요청'하는 경우에 작성하면 좋아요!
>
> e.g. 이 부분은 불변성을 띄도록 하기 위해 struct를 사용했습니다.
-->

## 🎨 스크린샷

<!-- UI 변경사항이 있는 경우 스크린샷을 첨부해주세요. -->

```



## 🔔 팀원 소개
| 서정원 | 왕은영 | 강지원 |
| --- | --- | --- |
|<img width="203" height="202" alt="KakaoTalk_Photo_2025-08-19-04-20-43" src="https://github.com/user-attachments/assets/995bf4ab-4630-440f-a07c-e4326c97a91c" /> | <img width="203" height="202" alt="KakaoTalk_Photo_2025-08-19-04-30-35" src="https://github.com/user-attachments/assets/6fb52c81-d946-4e41-8bd6-14f89e535271" /> | <img width="201" height="202" alt="KakaoTalk_Photo_2025-08-19-04-20-34" src="https://github.com/user-attachments/assets/32f6361c-f443-4203-b2d1-b48f9277d7e4" />|
| IOS, 팀장 | IOS | IOS |
