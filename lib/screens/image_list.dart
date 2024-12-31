import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/Image.dart';
import 'package:flutter/cupertino.dart';
import 'package:madcamp_w1/screens/home_screen.dart';

class imagelist extends StatefulWidget {
  const imagelist({super.key});

  @override
  State<imagelist> createState() => _imagelist();
}

class _imagelist extends State<imagelist> {
  List<Imagedata> imagelist = [
    Imagedata(
        imagenum: 1,
        imageurl: 'lib/screens/image/고양이1.png',
        imagename: 'Dog',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 2,
        imageurl: 'lib/screens/image/고양이2.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 3,
        imageurl: 'lib/screens/image/고양이3.png',
        imagename: 'Mountain',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 4,
        imageurl: 'lib/screens/image/고양이4.png',
        imagename: 'Lighthouse',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 5,
        imageurl: 'lib/screens/image/고양이5.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 6,
        imageurl: 'lib/screens/image/고양이6.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 7,
        imageurl: 'lib/screens/image/고양이7.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 8,
        imageurl: 'lib/screens/image/고양이8.png',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 9,
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
          itemCount: imagelist.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            childAspectRatio: 0.66,
          ),
          padding: const EdgeInsets.all(2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>ImageDetailScreen(
                      imageUrl: imagelist[index].imageurl ??"",
                      imageName: imagelist[index].imagename ?? "",
                      imageDate: imagelist[index].imagedate ?? "",
                    ),
                  ),
                );
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
    // height: double.infinity,
    padding: const EdgeInsets.all(5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        imageurl,
        fit: BoxFit.cover,
        height: 150,
        width: double.infinity,
      ),
    ),
  );
}
class ImageDetailScreen extends StatelessWidget{
  final String imageUrl;
  final String imageName;
  final String imageDate;
  const ImageDetailScreen({
    super.key,
    required this.imageUrl,
    required this.imageName,
    required this.imageDate,
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text(
        //     imageName,
        //   style: const TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
        backgroundColor: GlobalVariables.appBarColor,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment(0, 500),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imageUrl,
                    fit:BoxFit.cover,
                    height: 400,
                    width:double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Text(
                  'Date: $imageDate',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'lib/screens/image/meme_cat.gif',
                width:200,
                height: 200,
                fit: BoxFit.contain,
              ),
            )
          )
        ]
      )
    );
  }
}
