import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/image_list2.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 임포트

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class image_url {
  static String Image_Url = "";
}

class _CallPageState extends State<CallPage> {
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
          title: const Text('새로운 냥이 추가'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: '이름'),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: '설명'),
                  onChanged: (value) => description = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: '한 줄 코멘트'),
                  onChanged: (value) => oneComment = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: '나이'),
                  onChanged: (value) => age = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: '성별'),
                  onChanged: (value) => gender = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: '서식 장소'),
                  onChanged: (value) => habitat = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: '특징'),
                  onChanged: (value) => traits = value,
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
                  child: const Text('Picture'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
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
              child: const Text('추가'),
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
        backgroundColor: Color(0xFF0E87C8), // 버튼 배경색을 파란색으로 설정
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
            // padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width * 0.55, // 다이얼로그 너비
            child: Column(
              mainAxisSize: MainAxisSize.min, // 다이얼로그 높이를 내용에 맞게 조절
              crossAxisAlignment: CrossAxisAlignment.start, // 모든 텍스트 왼쪽 정렬
              children: [
                // 닫기 버튼 오른쪽 상단
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(), // 닫기 버튼
                  ),
                ),
                // 고양이 이미지
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      person.imageUrl,
                      width: 150, // 이미지 너비
                      height: 150, // 이미지 높이
                      fit: BoxFit.cover, // 이미지 비율 유지
                      errorBuilder: (context, error, stackTrace) => Image.asset(
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
                const SizedBox(height: 8), // 이름과 설명 간격
                // 담당자 및 전화번호
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      // 전화번호 추출 (숫자만 남기기)
                      final phone =
                          person.description.replaceAll(RegExp(r'[^\d+]'), '');
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
                        color: Colors.green, // 클릭 가능성을 시각적으로 표현
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8), // 설명과 코멘트 간격
                Text(
                  person.oneComment,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16), // 추가 정보와 간격
                // 추가 정보 섹션
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                  children: [
                    Text(
                      "3살 / ${person.gender}",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 8), // 항목 간 간격
                    Text(
                      "서식장소: ${person.habitat}",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 8), // 항목 간 간격
                    Text(
                      "특징: ${person.traits}",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // 추가 정보와 인스타그램 링크 간격
                // 인스타그램 링크
                GestureDetector(
                  onTap: () async {
                    const url =
                        "https://instagram.com/kaist_cat_network"; // URL 정의
                    final Uri uri = Uri.parse(url); // URL을 Uri 객체로 변환
                    if (await canLaunchUrl(uri)) {
                      // Uri를 사용하여 URL 열기 가능 여부 확인
                      await launchUrl(uri); // URL 열기
                    } else {
                      throw 'Could not launch $url'; // URL 열기 실패 시 에러 처리
                    }
                  },
                  child: Text(
                    "카이스트 고양이 쉼터 인스타: @kaist_cat_network",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 16), // 하단 버튼과의 간격
                // 하단의 아이콘 버튼들
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // 버튼을 오른쪽으로 정렬
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.edit, color: Colors.blue), // 수정 아이콘
                      tooltip: '수정',
                      onPressed: () =>
                          _editPerson(context, person), // 수정 다이얼로그 호출
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.delete, color: Colors.red), // 삭제 아이콘
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
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: '이름'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: '설명'),
                    ),
                    TextField(
                      controller: oneCommentController,
                      decoration: const InputDecoration(labelText: '한 줄 코멘트'),
                    ),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(labelText: '나이'),
                    ),
                    TextField(
                      controller: genderController,
                      decoration: const InputDecoration(labelText: '성별'),
                    ),
                    TextField(
                      controller: habitatController,
                      decoration: const InputDecoration(labelText: '서식 장소'),
                    ),
                    TextField(
                      controller: traitsController,
                      decoration: const InputDecoration(labelText: '특징'),
                    ),
                    TextButton(
                      onPressed: () async {
                        String? selectedImageUrl = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => imagelist2()),
                        );
                        if (selectedImageUrl != null) {
                          setState(() {
                            imageUrlController.text = selectedImageUrl;
                          });
                        }
                      },
                      child: const Text('Picture'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소'),
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
                  child: Text(isSaved ? '수정 완료' : '저장'),
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
