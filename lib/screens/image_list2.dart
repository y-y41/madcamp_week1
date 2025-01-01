import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/Image.dart';
import 'package:flutter/cupertino.dart';
import 'package:madcamp_w1/screens/call_page.dart';

class imagelist2 extends StatefulWidget {
  const imagelist2({super.key});

  @override
  State<imagelist2> createState() => _imagelist2();
}

class _imagelist2 extends State<imagelist2> {
  List<Imagedata> imagelist = [
    Imagedata(
      imagenum: 1,
      imageurl: 'lib/screens/image/카고쉼 캐릭터.png',
      imagename: '카고쉼',
      imagedate: '2024년 12월 27일',
      imageloc: '전 기숙사에 동아리원 배치',
    ),
    Imagedata(
      imagenum: 2,
      imageurl: 'lib/screens/image/고쥬 이미지.png',
      imagename: '고쥬',
      imagedate: '2024년 12월 27일',
      imageloc: '북측 기숙사',
    ),
    Imagedata(
      imagenum: 3,
      imageurl: 'lib/screens/image/망망이 이미지.png',
      imagename: '망망이',
      imagedate: '2024년 12월 27일',
      imageloc: '기계과 N7건물',
    ),
    Imagedata(
      imagenum: 4,
      imageurl: 'lib/screens/image/먼지 이미지.png',
      imagename: '먼지',
      imagedate: '2024년 12월 27일',
      imageloc: '열린길',
    ),
    Imagedata(
      imagenum: 5,
      imageurl: 'lib/screens/image/복만이 이미지.png',
      imagename: '복만이',
      imagedate: '2024년 12월 27일',
      imageloc: '사랑관&소망관',
    ),
    Imagedata(
      imagenum: 6,
      imageurl: 'lib/screens/image/봉송이 이미지.png',
      imagename: '봉송이',
      imagedate: '2024년 12월 27일',
      imageloc: '사랑관&소망관',
    ),
    Imagedata(
      imagenum: 7,
      imageurl: 'lib/screens/image/심바 이미지.png',
      imagename: '심바',
      imagedate: '2024년 12월 27일',
      imageloc: '희망관 앞 편의점',
    ),
    Imagedata(
      imagenum: 8,
      imageurl: 'lib/screens/image/제리 이미지.png',
      imagename: '제리',
      imagedate: '2024년 12월 27일',
      imageloc: '북측 매점',
    ),
    Imagedata(
      imagenum: 9,
      imageurl: 'lib/screens/image/고양이2.png',
      imagename: '키키',
      imagedate: '2024년 8월 27일',
      imageloc: '대전 유성구 대학로 291 양분순빌딩 E16-1 102호',
    ),
    Imagedata(
        imagenum: 10,
        imageurl: 'lib/screens/image/고양이3.png',
        imagename: '아롱',
        imagedate: '2023년 10월 17일',
        imageloc: '대전 유성구 대학로 291 구성동 400'),
    Imagedata(
        imagenum: 11,
        imageurl: 'lib/screens/image/고양이4.png',
        imagename: '포리',
        imagedate: '2024년 2월 8일',
        imageloc: '대전 유성구 어은동 52-10'),
    Imagedata(
        imagenum: 12,
        imageurl: 'lib/screens/image/고양이5.png',
        imagename: '벼루',
        imagedate: '2022년 10월 19일',
        imageloc: '대전 유성구 대학로 291 구성동 53-3'),
    Imagedata(
        imagenum: 13,
        imageurl: 'lib/screens/image/고양이6.png',
        imagename: '마루',
        imagedate: '2024년 6월 13일',
        imageloc: '대전 유성구 대학로 291 어은동 44'),
    Imagedata(
        imagenum: 14,
        imageurl: 'lib/screens/image/고양이7.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 15,
        imageurl: 'lib/screens/image/고양이8.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 16,
        imageurl: 'lib/screens/image/고양이9.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 10,
        imageurl: 'lib/screens/image/고양이10.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 11,
        imageurl: 'lib/screens/image/고양이11.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 12,
        imageurl: 'lib/screens/image/고양이12.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 13,
        imageurl: 'lib/screens/image/고양이13.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 14,
        imageurl: 'lib/screens/image/고양이14.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 15,
        imageurl: 'lib/screens/image/고양이15.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 16,
        imageurl: 'lib/screens/image/고양이16.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 17,
        imageurl: 'lib/screens/image/고양이17.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 18,
        imageurl: 'lib/screens/image/고양이18.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 19,
        imageurl: 'lib/screens/image/고양이19.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 20,
        imageurl: 'lib/screens/image/고양이20.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 21,
        imageurl: 'assets/images/카고.png',
        imagename: '카고',
        imagedate: '2025-01-01'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "이미지 선택",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
          itemCount: imagelist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          padding: const EdgeInsets.all(2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                image_url.Image_Url = imagelist[index].imageurl ?? "";
                Navigator.pop(context, imagelist[index].imageurl);
              },
              child: imageContainer(
                imageurl: imagelist[index].imageurl ?? "",
              ),
            );
          }),
    );
  }
}

Widget imageContainer({
  required String imageurl,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(2, 2),
        )
      ],
    ),
    padding: const EdgeInsets.all(5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        imageurl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    ),
  );
}
