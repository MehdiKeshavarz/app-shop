import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Widgets/cached_image.dart';
import 'package:shop_app/bloc/basket_bloc/basket_bloc.dart';
import 'package:shop_app/constants/color_palette.dart';
import 'package:shop_app/data/models/cart_item_model.dart';
import 'package:shop_app/utils/extension_color.dart';
import 'package:zarinpal/zarinpal.dart';

import '../Widgets/custom_appbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PaymentRequest _paymentRequest = PaymentRequest();
  @override
  void initState() {
    context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
    super.initState();
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('this is for test application appleShop');
    _paymentRequest.setCallbackURL('mehdikeshavarz://apple_shop');
  }

  @override
  Widget build(BuildContext context) {
    bool showButtonPrice = false;
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: CustomAppBar(
                        textTitle: 'سبدخرید',
                        isSearch: false,
                      ),
                    ),
                    if (state is BasketCompletedState) ...{
                      state.listItemBasket.fold((errorMessage) {
                        return SliverToBoxAdapter(
                          child: Text(errorMessage),
                        );
                      }, (basketItem) {
                        if (basketItem.isNotEmpty) showButtonPrice = true;
                        if (basketItem.isNotEmpty) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: basketItem.length,
                              (context, index) {
                                return CartItem(
                                    cartItemModel: basketItem[index]);
                              },
                            ),
                          );
                        } else {
                          return const SliverToBoxAdapter(
                            child: Center(
                                child: Text(
                              'سبد خرید شما خالی است',
                              style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 20,
                              ),
                            )),
                          );
                        }
                      })
                    },
                    const SliverPadding(padding: EdgeInsets.only(bottom: 64.0))
                  ],
                ),
                if (state is BasketCompletedState) ...{
                  if (showButtonPrice) ...{
                    FinalPriceButton(
                      basketFinalPrice: state.finalPrice,
                    )
                  }
                }
              ],
            ),
          );
        },
      ),
    );
  }
}

class FinalPriceButton extends StatelessWidget {
  //final PaymentRequest paymentRequest;
  final int? basketFinalPrice;
  const FinalPriceButton({
    super.key,
    this.basketFinalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44.0, left: 44.0, bottom: 20.0),
      child: SizedBox(
        height: 53,
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontFamily: 'sb', fontSize: 18),
              backgroundColor: ColorPalette.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('تومان'),
                const SizedBox(width: 6),
                Text('$basketFinalPrice'),
              ],
            )),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartItemMode cartItemModel;
  const CartItem({
    super.key,
    required this.cartItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
      height: 249,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          cartItemModel.name!,
                          style: const TextStyle(
                            fontFamily: 'sb',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'گارانتی18 ماه مدیاپردازش',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'sm',
                              color: ColorPalette.gery),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2.0),
                                child: Text(
                                  '%3',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'sb',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "تومان",
                              style: TextStyle(fontSize: 14, fontFamily: 'sb'),
                            ),
                            const Text(
                              "12.234.000",
                              style: TextStyle(fontSize: 14, fontFamily: 'sb'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          runSpacing: 3,
                          spacing: 14,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: ColorPalette.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 4),
                                    const Text(
                                      'حذف',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'sb',
                                          fontSize: 12,
                                          color: ColorPalette.red),
                                    ),
                                    const SizedBox(width: 4),
                                    Image.asset('assets/images/icon_trash.png')
                                  ],
                                ),
                              ),
                            ),
                            OptionChip(title: 'بنفش', color: 'ca03fc'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 98,
                  width: 98,
                  child: CachedImage(
                    imageUrl: cartItemModel.thumbnail,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: ColorPalette.gery.withOpacity(0.3),
              dashGapLength: 3.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(fontFamily: 'sb', fontSize: 14),
                ),
                const SizedBox(width: 5),
                Text(
                  '${cartItemModel.realPrice}',
                  style: const TextStyle(fontSize: 16, fontFamily: 'sb'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  String? color;
  String title;
  OptionChip({
    this.color,
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: ColorPalette.gery),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parsToColor(),
                ),
              )
            },
            const SizedBox(width: 4),
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                  fontFamily: 'sb', fontSize: 12, color: ColorPalette.gery),
            ),
          ],
        ),
      ),
    );
  }
}
