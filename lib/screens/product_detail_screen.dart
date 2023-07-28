import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Widgets/loading_items.dart';
import 'package:shop_app/data/models/product_model.dart';

import '../Widgets/color_variant_list_widget.dart';
import '../Widgets/gallery_image_widet.dart';
import '../Widgets/product_description_widget.dart';
import '../Widgets/product_property_widget.dart';
import '../Widgets/storage_variant_list_widget.dart';
import '../bloc/basket_bloc/basket_bloc.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../constants/color_palette.dart';
import '../data/models/product_variant_model.dart';
import '../data/models/variant_type_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductInitializeEvent(
        productId: widget.product.id!, categoryId: widget.product.categoryId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductLoadingState) ...[
                  const SliverFillRemaining(
                    child: LoadingItems(
                      title: 'درحال جستجوی اطلاعات محصول',
                    ),
                  )
                ],

                if (state is ProductLoadedState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 30, left: 30, bottom: 20, top: 20),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 16),
                            Image.asset('assets/images/icon_apple_blue.png'),
                            Expanded(
                                child:
                                    state.productCategory.fold((errorMessage) {
                              return const Text(
                                'اطلاعات محصول',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontFamily: 'sb', fontSize: 16),
                              );
                            }, (productCategory) {
                              return Text(
                                productCategory.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'sb', fontSize: 16),
                              );
                            })),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/icon_back.png'),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  )
                },
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: Text(
                      widget.product.name ?? '',
                      style: const TextStyle(fontFamily: 'sb', fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                if (state is ProductLoadedState) ...[
                  state.imageProductList.fold((errorMessage) {
                    return const SliverToBoxAdapter(
                        child: Text('عکس های این محصول موجود نمی باشد!'));
                  }, (imageList) {
                    return GalleryImagesWidget(
                        imageList, widget.product.thumbnail!);
                  }),
                ],
                //Color selection
                if (state is ProductLoadedState) ...{
                  state.productVariant.fold(
                    (errorMessage) {
                      return const SliverToBoxAdapter(
                          child: Text('این محصول سویه ندارد'));
                    },
                    (variantList) {
                      return VariantContainerGenerator(variantList);
                    },
                  )
                },
                //Memory selection

                if (state is ProductLoadedState) ...{
                  state.productProperty.fold(
                    (errorMessage) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text('این محصول مشخصات فنی ندارد'),
                        ),
                      );
                    },
                    (productProperty) {
                      return GetProductProperty(propertyList: productProperty);
                    },
                  )
                },
                GetProductDescription(product: widget.product),
                SliverToBoxAdapter(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 44.0, right: 44.0, top: 15),
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: ColorPalette.gery),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/icon_left_category.png'),
                          const SizedBox(width: 5),
                          const Text(
                            'مشاهده همه',
                            style: TextStyle(
                                fontFamily: 'sm', color: ColorPalette.blue),
                          ),
                          const Spacer(),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 26,
                                width: 26,
                                margin: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              Positioned(
                                right: 15,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              Positioned(
                                right: 30,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              Positioned(
                                right: 45,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              Positioned(
                                right: 60,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    '+10',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'sb',
                                        color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            ':نظرات کاربران',
                            style: TextStyle(fontFamily: 'sb'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Buttons
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PriceTagButton(),
                        AddToBasketButton(
                          product: widget.product,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariantModel> productVariantList;
  const VariantContainerGenerator(
    this.productVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant),
            }
          }
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  final ProductVariantModel productVariant;
  const VariantGeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44.0, right: 44.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: const TextStyle(fontSize: 14, fontFamily: 'sb'),
          ),
          const SizedBox(height: 8),
          if (productVariant.variantType.type == VariantType.COLOR) ...[
            ColorVariantList(productVariant.variantList),
          ],
          if (productVariant.variantType.type == VariantType.STORAGE) ...{
            StorageVariantList(productVariant.variantList),
          }
        ],
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  final ProductModel product;
  const AddToBasketButton({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
          onTap: () {
            context
                .read<ProductBloc>()
                .add(ProductAddToBasket(product: product));

            context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
          },
          child: Container(
            height: 60,
            width: 140,
            decoration: BoxDecoration(
                color: ColorPalette.blue,
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: const SizedBox(
              height: 53,
              width: 160,
              child: Center(
                child: Text(
                  'افزودن به سبد خرید',
                  style: TextStyle(
                      fontFamily: 'sb', color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
              color: ColorPalette.green,
              borderRadius: BorderRadius.circular(15)),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: SizedBox(
              height: 53,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                          color: Colors.white, fontSize: 12, fontFamily: 'sm'),
                    ),
                    const SizedBox(width: 5),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '48,250,000',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '46,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SM',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            '%3',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'sb',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
