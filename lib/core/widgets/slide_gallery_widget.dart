import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/widgets/custom_cached_image.dart';

class SlideGalleryWidget extends StatelessWidget {
  final List<String>? images;
  const SlideGalleryWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return const SizedBox.shrink();
    }
    return carousel.CarouselSlider(
      items: images!.map((img) {
        return Builder(
          builder: (BuildContext context) {
            return CustomCachedImage(
              image: img,
              height: Get.height,
            );
          },
        );
      }).toList(),
      options: carousel.CarouselOptions(
        height: Get.height,
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
