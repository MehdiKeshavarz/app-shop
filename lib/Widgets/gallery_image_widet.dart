import 'package:flutter/material.dart';

import '../constants/color_palette.dart';
import '../data/models/image_product_model.dart';
import 'cached_image.dart';

class GalleryImagesWidget extends StatefulWidget {
  List<ImageProductModel> galleryImages;
  String defaultImageThumbnail;
  int selectedItem = 0;
  GalleryImagesWidget(
    this.galleryImages,
    this.defaultImageThumbnail, {
    super.key,
  });

  @override
  State<GalleryImagesWidget> createState() => _GalleryImagesWidgetState();
}

class _GalleryImagesWidgetState extends State<GalleryImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/icon_star.png'),
                      const Text(
                        '4.5',
                        style: TextStyle(fontFamily: 'sm', fontSize: 12),
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: CachedImage(
                            radius: 15,
                            imageUrl: (widget.galleryImages.isEmpty)
                                ? widget.defaultImageThumbnail
                                : widget.galleryImages[widget.selectedItem]
                                    .imageUrl,
                          )),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite_deactive.png')
                    ],
                  ),
                ),
              ),
              if (widget.galleryImages.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.galleryImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15),
                            padding: const EdgeInsets.all(4),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorPalette.gery,
                                width: 1,
                              ),
                            ),
                            child: CachedImage(
                              imageUrl: widget.galleryImages[index].imageUrl,
                              radius: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              },
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
