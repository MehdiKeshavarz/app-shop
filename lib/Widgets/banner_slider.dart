import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/cached_image.dart';
import 'package:shop_app/data/models/banner_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/color_palette.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerModel> bannerList;
  BannerSlider({super.key, required this.bannerList});

  PageController pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: CachedImage(
                  imageUrl: bannerList[index].thumbnail,
                  radius: 15.0,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: pageController, // PageController
            count: bannerList.length,
            effect: const ExpandingDotsEffect(
                dotColor: Colors.white,
                activeDotColor: ColorPalette.blueIndicator,
                expansionFactor: 4,
                dotHeight: 10,
                dotWidth: 10), // your preferred effect
          ),
        )
      ],
    );
  }
}
