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
        imageurl: 'https://picsum.photos/id/870/200/300?grayscale&blur=2',
        imagename: 'Dog',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 2,
        imageurl: 'https://picsum.photos/200/300/?blur',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 3,
        imageurl: 'https://picsum.photos/200/300?grayscale',
        imagename: 'Mountain',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 4,
        imageurl: 'https://picsum.photos/seed/picsum/200/300',
        imagename: 'Lighthouse',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 5,
        imageurl: 'https://picsum.photos/id/237/200/300',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 6,
        imageurl: 'https://picsum.photos/id/13/2500/1667',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 7,
        imageurl: 'https://picsum.photos/id/20/3670/2462',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 8,
        imageurl: 'https://picsum.photos/id/26/4209/2769',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 9,
        imageurl: 'https://picsum.photos/id/27/3264/1836',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 10,
        imageurl: 'https://picsum.photos/id/34/3872/2592',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 11,
        imageurl: 'https://picsum.photos/id/36/4179/2790',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 12,
        imageurl: 'https://picsum.photos/id/40/4106/2806',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 13,
        imageurl: 'https://picsum.photos/id/41/1280/805',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 14,
        imageurl: 'https://picsum.photos/id/42/3456/2304',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 15,
        imageurl: 'https://picsum.photos/id/50/4608/3072',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 16,
        imageurl: 'https://picsum.photos/id/53/1280/1280',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 17,
        imageurl: 'https://picsum.photos/id/57/2448/3264',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 18,
        imageurl: 'https://picsum.photos/id/61/3264/2448',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 19,
        imageurl: 'https://picsum.photos/id/67/2848/4288',
        imagename: 'Laptop',
        imagedate: '2024-12-27'),
    Imagedata(
        imagenum: 20,
        imageurl: 'https://picsum.photos/id/74/4288/2848',
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