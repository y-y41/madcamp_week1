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
      appBar: AppBar(
        title: const Text("Image"),
        centerTitle: true,
      ),
      body: GridView.builder(
          itemCount: imagelist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            childAspectRatio: 0.66,
          ),
          padding: const EdgeInsets.all(2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap:(){
                image_url.Image_Url=imagelist[index].imageurl ??"";
                Navigator.pop(context,imagelist[index].imageurl);
              },
              child: imageContainer(
                imageurl: imagelist[index].imageurl ??"",
              ),
            );
            // return imageContainer(
            //   imageurl: imagelist[index].imageurl ?? "",
            // );
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
      child: Image.network(
        imageurl,
        fit: BoxFit.cover,
        height: 150,
        width: double.infinity,
      ),
    ),
  );
}
