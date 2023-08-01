import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Widgets/cached_image.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/utils/double_extention.dart';

import '../bloc/product_bloc/product_bloc.dart';
import '../constants/color_palette.dart';

class ProductItemCard extends StatelessWidget {
  final ProductModel productItem;
  const ProductItemCard({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    var discountedPrice = productItem.price! + productItem.discountPrice!;
    num present =
        ((productItem.price! - discountedPrice) / productItem.price!) * 100;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (MaterialPageRoute) {
          return BlocProvider<ProductBloc>(
              create: (context) => ProductBloc(),
              child: ProductDetailScreen(
                product: productItem,
              ));
        }));
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: 98,
                  width: 98,
                  child: CachedImage(
                    imageUrl: productItem.thumbnail,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset("assets/images/active_fav_product.png"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      child: Text(
                        '%${present.round()}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'sb',
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                  child: Text(
                    productItem.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'sb', fontSize: 14),
                  ),
                ),
                Container(
                  height: 53,
                  decoration: const BoxDecoration(
                    color: ColorPalette.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorPalette.blue,
                        blurRadius: 25,
                        spreadRadius: -10,
                        offset: Offset(0.0, 15.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                              'assets/images/icon_right_arrow_cricle.png'),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              productItem.price!.convertToPrice(),
                              style: const TextStyle(
                                fontFamily: 'sm',
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              productItem.discountPrice!.convertToPrice(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'sb',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'تومان',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'sm'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
