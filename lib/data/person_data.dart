import 'package:flutter/material.dart';

class Person {
  String name;
  String description;
  String oneComment;
  String age;
  String gender;
  String habitat;
  String traits;
  String imageUrl;

  Person({
    required this.name,
    required this.description,
    required this.oneComment,
    required this.age,
    required this.gender,
    required this.habitat,
    required this.traits,
    required this.imageUrl,
  });
}

final List<Person> people = [
  // 초기 데이터
  Person(
    name: "카고쉼",
    description: "카이스트 고양이 쉼터",
    oneComment: "카이스트 유일한 고양이 관리 동아리",
    age: "2019년 설립",
    gender: "고양이",
    habitat: "전 기숙사에 동아리원 배치",
    traits: "급식 사업 및 TNR(중성화), 굿즈 제작 등을 진행",
    imageUrl: 'lib/screens/image/카고쉼 캐릭터.png',
  ),
  Person(
    name: "고쥬",
    description: "담당자: 010-0000-0000",
    oneComment: "핑크 발바닥 젤리 애교 고양이",
    age: "5살",
    gender: "수컷",
    habitat: "북측 기숙사",
    traits: "잠맘보 고양이버전",
    imageUrl: 'lib/screens/image/고쥬 이미지.png',
  ),
  Person(
    name: "망망이",
    description: "담당자: 010-0000-0000",
    oneComment: "검은 고양이 네로~ 네로~",
    age: "3살",
    gender: "암컷",
    habitat: "기계과 N7건물",
    traits: "아름이가 낳은 5남매 중 막내 공주님",
    imageUrl: 'lib/screens/image/망망이 이미지.png',
  ),
  Person(
    name: "먼지",
    description: "담당자: 010-0000-0000",
    oneComment: "제작자 원픽 너무 너무 너무 귀여워",
    age: "1살",
    gender: "수컷",
    habitat: "열린길",
    traits: "생각보다 발견하기 어려움.....",
    imageUrl: 'lib/screens/image/먼지 이미지.png',
  ),
  Person(
    name: "복만이",
    description: "담당자: 010-0000-0000",
    oneComment: "봉송이 남친",
    age: "4살",
    gender: "진정한 수컷",
    habitat: "사랑관&소망관",
    traits: "봉송이한테 밥을 빼앗긴다는 소문이....",
    imageUrl: 'lib/screens/image/복만이 이미지.png',
  ),
  Person(
    name: "봉송이",
    description: "담당자: 010-0000-0000",
    oneComment: "복만이 여친",
    age: "4살",
    gender: "암컷",
    habitat: "사랑관&소망관",
    traits: "대표 뚱냥이",
    imageUrl: 'lib/screens/image/봉송이 이미지.png',
  ),
  Person(
    name: "심바",
    description: "담당자: 010-0000-0000",
    oneComment: "카이스트 고양이 모델 심바",
    age: "2살",
    gender: "수컷",
    habitat: "희망관 앞 편의점 근처",
    traits: "꽃을 좋아함",
    imageUrl: 'lib/screens/image/심바 이미지.png',
  ),
  Person(
    name: "제리",
    description: "담당자: 010-0000-0000",
    oneComment: "매점 츄르 도둑",
    age: "1살",
    gender: "암컷",
    habitat: "북측 매점 근처",
    traits: "활발하고 영리함",
    imageUrl: 'lib/screens/image/제리 이미지.png',
  ),
];
