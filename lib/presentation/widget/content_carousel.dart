import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final carouselSliderNumberProvider = StateProvider<int>((ref) => 0);

class ContentCarousel extends ConsumerWidget {
  const ContentCarousel({super.key});

  static const List<List<String>> imageList = [
    ['縣陵先生図鑑', '/teacher'],
    //['KRGPグランプリ優秀作品', '/krgp'],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int carouselSliderNumber = ref.watch(carouselSliderNumberProvider);

    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                ref.read(carouselSliderNumberProvider.notifier).state =
                    carouselSliderNumber = index;
              }),
          itemCount: imageList.length,
          itemBuilder: (context, index, realIndex) => GestureDetector(
              onTap: () {
                context.push(imageList[index][1]);
              },
              child: Card(
                  child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: index == 1
                        ? const AssetImage('assets/images/background/krgp.png')
                        : const AssetImage(
                            'assets/images/background/teacher.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(imageList[index][0],
                      style:
                          const TextStyle(fontSize: 24, color: Colors.black)),
                ),
              ))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.map((url) {
            int index = imageList.indexOf(url);
            return Container(
              width: 10,
              height: 10,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: carouselSliderNumber == index
                    ? const Color.fromRGBO(186, 25, 35, 1)
                    : const Color.fromRGBO(186, 25, 35, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
