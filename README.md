# favoriteToilet

## 초기계획 - [Wiki](https://github.com/sungju-kim/favoriteToilet/wiki/7-26-프로젝트-초기-계획)

## 구현사항

- 초기화면 구현
  - Apple로 로그인 버튼 구현 (OAuth 기능 미구현)
- 지도탭 MapView 구현
  - 사용자 위치정보 받아와서 지도에 표시
- 사용자 위치기준 3km 반경 화장실  표시

## 실행화면

<img width="320" src="https://user-images.githubusercontent.com/78553659/182527470-88e647b9-b4de-44af-8c9a-65acf693353d.gif">

## 트러블 슈팅

### 사용자 위치 업데이트 주기

**문제**

서버에 사용자 위치기반 데이터를 요청하는 주기에 대한 고민

**고민**

1. 사용자 위치를 받아올때마다 서버에 요청하여 갱신
   - 매초마다 사용자의 위치가 갱신이 될경우 매초마다 서버에 새로운 데이터를 요청
   - 서버 부하 발생 예측
2. 특정 거리를 두고 범위를 벗어났을때 서버에 요청하여 갱신
   - 사용자위치 정확도가 정확하지 않을때 계속적인 요청 발생 가능
   - 사용자가 원치 않는 갱신 가능
3. 특정 시간간격을 두고 서버에 요청하여 갱신
   - 시간간격이 짧으면 불필요한 요청 발생 가능
   - 시간간격이 길면 사용자 경험 저하 발생 가능
   - 사용자가 원치 않는 갱신 가능
4. 특정 이벤트마다 갱신 (사용자가 앱으로 다시 돌아올때, 지도탭으로 돌아올때, 사용자가 요청할때 등 )
   - 이벤트가 발생하지 않으면 위치기반 화장실 정보의 부정확성 증가

**해결방안**

특정 이벤트와 이벤트 사이의 시간차이가 길지 않을것으로 판단하여 특정이벤트마다 갱신하기로 결정

- 사용자가 원할때 갱신 가능
- 위치정보가 필요할 때만 갱신 가능

**구현**

사용자 위치정보를 받아서 메모리에 저장, 10개가 넘어가면 비우도록 로직 구현

- 서버에 화장실정보를 요청하지 않더라도 지도에는 현재 사용자위치 갱신가능

**구현예정**

특정 이벤트시 갱신

- 앱으로 돌아올때
- 지도탭으로 돌아올때
- 사용자가 요청할때



### 객체간 데이터 전달방법

**문제**

`MapViewModel` 과 `MapViewDeleagate` 두 객체에서 전달된 사용자 위치, 근처 화장실 정보를 바탕으로 생성된 `Marker`를 화면에 표시하기

**고민**

- `MapViewModel`에서 사용자 위치가 전달될때와 `MapViewDelegate`에서 생성된 `Marker`를 전달하는 시기가 다른 문제.

**해결방안**

- `MapViewController`에 사용자 위치 저장해두기
  - 가장 간단한 해결방법이지만, `ViewController`가 데이터를 가지고 있어야하는 문제
- 두 객체에서 값이 모두 전달되었을때 실행할 수 있도록 구현

**구현**

Rx의 `Observable.combineLatest` 메소드를 사용하여 두객체에서 값이 모두 전달되었을때 실행 하도록 구현.

