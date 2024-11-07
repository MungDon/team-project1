# Team Project : Traditional Korean Liquor Shop

&nbsp;     
&nbsp;     

## Project Overview
> - 기여도 : 100%;
> - 담당기능 : 상품, 관리자

&nbsp;    
&nbsp;     

## Project Tech Stack
> - **IDE** : Eclipse
> - **View** : JSP
> - **DB** : OracleDB
> - **JDBC** Driver: OJDBC
> - **Language** : Java(JDK 11)
> - **WAS** : Apache Tomcat 9.0

&nbsp;    
&nbsp;     

## Project Architecture
```text
 src
  ├─admin
  │      AdminDAO.java : 관리자 DAO
  │
  ├─cart
  │      CartDAO.java : 장바구니 DAO
  │      CartDTO.java : 장바구니 DTO
  │
  ├─category
  │      CategoryDAO.java : 상품 카테고리 DAO
  │      CategoryDTO.java : 상품 카테고리 DTO
  │
  ├─contact
  │      FaqDAO.java : 자주 묻는 질문 DAO
  │      FaqDTO.java : 자주 묻는 질문 DTO
  │      NoticeDAO.java : 공지 DAO
  │      NoticeDTO.java : 공지 DTO
  │      ProductQnaDAO.java : 상품 문의 DAO
  │      ProductQnaDTO.java : 상품 문의 DTO
  │      QnaDAO.java : 일반 문의 DAO
  │      QnaDTO.java : 일반 문의 DTO
  │      VendorQnaDAO.java : 판매자 문의 DAO
  │      VendorQnaDTO.java : 판매자 문의 DTO
  │
  ├─delivery
  │      DeliveryDAO.java : 배송 DAO
  │      DeliveryDTO.java : 배송 DTO
  │
  ├─enums
  │      ImgType.java : 이미지 타입을 나타내는 enum
  │      MemberStatus.java : 회원의 가입 상태를 나타내는 enum
  │      MemberVendor.java : 회원의 권한을 나타내는 enum
  │      ProductStatus.java : 상품의 상태를 나타내는 enum
  │
  ├─img
  │      ImgDTO.java : 이미지 DTO
  │
  ├─member
  │      MemberDAO.java : 회원 DAO
  │      MemberDTO.java : 회원 DTO
  │
  ├─mypage
  │      MypageDAO.java : 마이페이지 DAO
  │      MypageWrapper.java : 마이페이지 래퍼클래스
  │
  ├─orders
  │      OrdersDAO.java : 주문 DAO
  │      OrdersDTO.java : 주문 DTO
  │
  ├─product
  │      ProductAddServlet.java : 상품 등록 서블릿
  │      ProductDAO.java : 상품 DAO
  │      ProductDTO.java : 상품 DTO
  │      ProductUpdateServlet.java : 상품 수정 서블릿
  │
  ├─review
  │      ReviewDAO.java : 상품 후기 DAO
  │      ReviewDTO.java : 상품 후기 DTO
  │      ReviewWrapper.java : 상품 후기 래퍼 클래스
  │
  ├─search
  │      SearchDTO.java : 검색 DTO
  │
  └─util
          ImageProcess.java : 이미지 관련 기능을 모아놓은 유틸 클래스
          Util.java : 전역에서 사용하는 공통된 메서드를 모아놓은 유틸 클래스
```

&nbsp;    
&nbsp;     

## 아쉬운 점
> 가장 아쉬웠던 점은 Git을 활용한 코드 버전 관리와 협업 방식을 경험해보고 싶었지만,    
> 팀원들과 논의 끝에 Git을 사용하지 않기로 결정한 것이었습니다.    
> 그 결과, 파일을 일일이 수동으로 옮겨야 했고, 개인적으로 제 Git 저장소에 따로 백업을 하며 작업하는 데 불편함을 겪었습니다.     
> 또한, DAO 코드에서 각 파트마다 DB 커넥션 코드가 반복적으로 작성된 부분이 아쉬웠습니다.      
> 이를 공통 클래스로 추출해 상속받는 방식으로 구성했다면, 코드의 가독성과 유지보수성이 훨씬 높아졌을 것이라고 생각합니다.      
> 마지막으로, 기본적인 기능만 구현된 상태에서 프로젝트 전반에 UI/UX 부분이 다소 부족했던 점도 아쉽습니다.      
> UI/UX 부분을 좀 더 개선할 여지가 있었을 것 같습니다.     
