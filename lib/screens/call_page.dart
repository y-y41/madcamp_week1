import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:madcamp_w1/data/person_data.dart';
import 'package:madcamp_w1/screens/image_list2.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 임포트
import 'package:madcamp_w1/screens/home_screen.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class image_url {
  static String Image_Url = "";
}

class _CallPageState extends State<CallPage> {
  String searchQuery = "";
  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Person> get filteredPeople {
    if (searchQuery.isEmpty) {
      return people;
    }
    return people
        .where((person) =>
            person.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void _addPerson(BuildContext context) {
    // Temporary variables to hold the form input
    String name = '';
    String description = '';
    String oneComment = '';
    String age = '';
    String gender = '';
    String habitat = '';
    String traits = '';
    String imageUrl = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '새로운 냥이 추가',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 다이얼로그 모서리를 둥글게
          ),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '이름',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => name = value,
                  ),
                ),
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '설명',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => description = value,
                  ),
                ),
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '한 줄 코멘트',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => oneComment = value,
                  ),
                ),
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '나이',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => age = value,
                  ),
                ),
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '성별',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => gender = value,
                  ),
                ),
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '서식 장소',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => habitat = value,
                  ),
                ),
                Container(
                  // height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: '특징',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                    onChanged: (value) => traits = value,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    String? selectedImageUrl = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => imagelist2()),
                    );
                    if (selectedImageUrl != null) {
                      setState(() {
                        imageUrl = selectedImageUrl;
                      });
                    }
                  },
                  child: const Text(
                    'Picture',
                    style: TextStyle(
                        color: Color(0xFF0E87C8), fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    people.add(Person(
                      name: name,
                      description: description,
                      oneComment: oneComment,
                      age: age,
                      gender: gender,
                      habitat: habitat,
                      traits: traits,
                      imageUrl: imageUrl,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                '추가',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true, // AppBar를 상태바 뒤로 확장
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SafeArea를 추가하여 상태바 충돌 방지
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Container(
                height: 46,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFF5F5F5),
                ),
                child: TextField(
                  onChanged: _updateSearchQuery,
                  decoration: const InputDecoration(
                    hintText: "검색",
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.search),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildList(filteredPeople, context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPerson(context), // + 버튼 클릭 시 동작
        child: const Icon(Icons.add_rounded,
            size: 32, color: Colors.white), // 흰색 + 아이콘, 크기 조정
        backgroundColor: GlobalVariables.appBarColor, // 버튼 배경색을 파란색으로 설정
        shape: CircleBorder(), // 버튼을 완전히 원형으로 유지
        elevation: 6, // 버튼의 그림자 깊이
      ),
    );
  }

  Widget _buildList(List<Person> people, BuildContext context) =>
      ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return GestureDetector(
            onTap: () => _showPersonDetails(context, person),
            child:
                _customTile(person.name, person.description, person.imageUrl),
          );
        },
      );

  void _showPersonDetails(BuildContext context, Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 다이얼로그 모서리를 둥글게
          ),
          backgroundColor: Colors.white,
          content: Container(
            // margin: EdgeInsets.symmetric(horizontal: 40),
            // padding: EdgeInsets.symmetric(horizontal: 35),
            width: MediaQuery.of(context).size.width - 40, // 다이얼로그 너비
            child: Column(
              mainAxisSize: MainAxisSize.min, // 다이얼로그 높이를 내용에 맞게 조절
              // crossAxisAlignment: CrossAxisAlignment.start, // 모든 텍스트 왼쪽 정렬
              children: [
                // 닫기 버튼 오른쪽 상단
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(), // 닫기 버튼
                  ),
                ),
                // 고양이 이미지
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ClipOval(
                            child: Image.asset(
                              person.imageUrl,
                              width: 150, // 이미지 너비
                              height: 150, // 이미지 높이
                              fit: BoxFit.cover, // 이미지 비율 유지
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/카고.png', // 실패 시 대체 이미지
                                width: 150,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 13), // 이미지와 텍스트 간격
                        // 고양이 이름
                        Center(
                          child: Text(
                            person.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4), // 이름과 설명 간격
                        // 담당자 및 전화번호
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              // 전화번호 추출 (숫자만 남기기)
                              final phone = person.description
                                  .replaceAll(RegExp(r'[^\d+]'), '');
                              final Uri telUri =
                                  Uri(scheme: "tel", path: phone); // tel 스키마 생성
                              if (await canLaunchUrl(telUri)) {
                                // 전화 앱 실행 가능 여부 확인
                                await launchUrl(telUri); // 전화 앱 실행
                              } else {
                                throw 'Could not launch $telUri'; // 에러 처리
                              }
                            },
                            child: Text(
                              person.description, // description이 전화번호를 포함
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0E87C8), // 클릭 가능성을 시각적으로 표현
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4), // 설명과 코멘트 간격
                        Center(
                          child: Text(
                            person.oneComment,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25), // 추가 정보와 간격
                        // 추가 정보 섹션
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                          children: [
                            Text(
                              "3살 / ${person.gender}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 8), // 항목 간 간격
                            Text(
                              "서식장소: ${person.habitat}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 8), // 항목 간 간격
                            Text(
                              "특징: ${person.traits}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25), // 추가 정보와 인스타그램 링크 간격
                        // 인스타그램 링크
                        GestureDetector(
                          onTap: () async {
                            const url =
                                "https://instagram.com/kaist_cat_network"; // URL 정의
                            final Uri uri = Uri.parse(url); // URL을 Uri 객체로 변환

                            if (await canLaunchUrl(uri)) {
                              // 외부 브라우저/앱에서 URL 열기
                              await launchUrl(
                                uri,
                                mode: LaunchMode
                                    .externalApplication, // 외부 애플리케이션 사용
                              );
                            } else {
                              throw 'Could not launch $url'; // URL 열기 실패 시 에러 처리
                            }
                          },
                          child: Text(
                            "카고쉼 인스타: @kaist_cat_network",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0E87C8), // 파란색 링크 스타일
                              // decoration: TextDecoration.underline, // 밑줄 추가
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 16), // 하단 버튼과의 간격
                // 하단의 아이콘 버튼들
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // 버튼을 오른쪽으로 정렬
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_rounded,
                          color: Colors.grey), // 수정 아이콘
                      tooltip: '수정',
                      onPressed: () =>
                          _editPerson(context, person), // 수정 다이얼로그 호출
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.delete_simple,
                          color: Colors.grey), // 삭제 아이콘
                      tooltip: '삭제',
                      onPressed: () {
                        setState(() {
                          people.remove(person); // 항목 삭제
                        });
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editPerson(BuildContext context, Person person) {
    TextEditingController nameController =
        TextEditingController(text: person.name);
    TextEditingController descriptionController =
        TextEditingController(text: person.description);
    TextEditingController oneCommentController =
        TextEditingController(text: person.oneComment);
    TextEditingController ageController =
        TextEditingController(text: person.age);
    TextEditingController genderController =
        TextEditingController(text: person.gender);
    TextEditingController habitatController =
        TextEditingController(text: person.habitat);
    TextEditingController traitsController =
        TextEditingController(text: person.traits);
    TextEditingController imageUrlController =
        TextEditingController(text: person.imageUrl);

    bool isSaved = false; // 저장 상태를 나타내는 변수

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('정보 수정'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // 다이얼로그 모서리를 둥글게
              ),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            labelText: '이름',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            labelText: '설명',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      // height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: oneCommentController,
                        decoration: const InputDecoration(
                            labelText: '한 줄 코멘트',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      // height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: ageController,
                        decoration: const InputDecoration(
                            labelText: '나이',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      // height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: genderController,
                        decoration: const InputDecoration(
                            labelText: '성별',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      // height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: habitatController,
                        decoration: const InputDecoration(
                            labelText: '서식 장소',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      // height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 11),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: traitsController,
                        decoration: const InputDecoration(
                            labelText: '특징',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          String? selectedImageUrl = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => imagelist2()),
                          );
                          if (selectedImageUrl != null) {
                            setState(() {
                              imageUrlController.text = selectedImageUrl;
                            });
                          }
                        },
                        child: const Text(
                          'Picture',
                          style: TextStyle(
                              color: Color(0xFF0E87C8),
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child:
                      const Text('취소', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    if (!isSaved) {
                      // 저장 상태 업데이트
                      setState(() {
                        person.name = nameController.text;
                        person.description = descriptionController.text;
                        person.oneComment = oneCommentController.text;
                        person.age = ageController.text;
                        person.gender = genderController.text;
                        person.habitat = habitatController.text;
                        person.traits = traitsController.text;
                        person.imageUrl = imageUrlController.text;
                        isSaved = true; // 저장 완료로 상태 변경
                      });

                      // 외부 상태 업데이트
                      this.setState(() {});
                    } else {
                      // 팝업 스택을 모두 닫음
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                  child: Text(isSaved ? '수정 완료' : '저장',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _customTile(String title, String subtitle, String imageUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          height: 94,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(imageUrl),
                  onBackgroundImageError: (exception, stackTrace) {
                    print('Failed to load image: $exception');
                  },
                  child: ClipOval(
                    child: Image.asset(
                      imageUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/고양이.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 24, color: Colors.grey),
              ],
            ),
          ),
        ),
      );
}
