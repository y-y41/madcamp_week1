import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/image_list2.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class image_url{
  static String Image_Url="";
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
                  onPressed: () async{
                    String? selectedImageUrl =await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => imagelist2()),
                    );
                    if(selectedImageUrl !=null){
                      setState(() {
                        imageUrl=selectedImageUrl;
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
      appBar: AppBar(
        title: const Text('Cat List Page'),
      ),
      body: _buildList(people, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPerson(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  Widget _buildList(List<Person> people, BuildContext context) => ListView.builder(
    itemCount: people.length,
    itemBuilder: (context, index) {
      final person = people[index];
      return GestureDetector(
        onTap: () => _showPersonDetails(context, person),
        child: _customTile(person.name, person.description, person.imageUrl),
      );
    },
  );

  void _showPersonDetails(BuildContext context, Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // 화면의 80% 너비
            height: MediaQuery.of(context).size.height * 0.6, // 화면의 60% 높이
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        person.imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/placeholder.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            person.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            person.description,
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            person.oneComment,
                            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "나이: ${person.age}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  "성별: ${person.gender}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  "서식 장소: ${person.habitat}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  "특징: ${person.traits}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  "카이스트 고양이 쉼터 인스타: @kaist_cat_network",
                  style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('닫기'),
            ),
            TextButton(
              onPressed: () => _editPerson(context, person),
              child: const Text('수정'),
            ),
            TextButton(
              onPressed: () {
                // 리스트에서 제거
                setState(() {
                  people.remove(person);
                });

                // 모든 팝업 닫기
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                '삭제',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editPerson(BuildContext context, Person person) {
    TextEditingController nameController = TextEditingController(text: person.name);
    TextEditingController descriptionController = TextEditingController(text: person.description);
    TextEditingController oneCommentController = TextEditingController(text: person.oneComment);
    TextEditingController ageController = TextEditingController(text: person.age);
    TextEditingController genderController = TextEditingController(text: person.gender);
    TextEditingController habitatController = TextEditingController(text: person.habitat);
    TextEditingController traitsController = TextEditingController(text: person.traits);
    TextEditingController imageUrlController = TextEditingController(text: person.imageUrl);

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
                      onPressed: () async{
                        String? selectedImageUrl =await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => imagelist2()),
                        );
                        if(selectedImageUrl !=null){
                          setState(() {
                            imageUrlController.text=selectedImageUrl;
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
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                print('Failed to load image: $exception');
              },
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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

