import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/repositories/basket_repository.dart';
import 'package:shop_app/di/locator.dart';

import '../../data/models/cart_item_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketRepository basketRepository = locator<BasketRepository>();
  BasketBloc() : super(BasketInitialState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await basketRepository.getAllBasketItems();
      var finalPrice = await basketRepository.getBasketFinalPrice();
      emit(BasketCompletedState(
        listItemBasket: basketItemList,
        finalPrice: finalPrice,
      ));
    });
  }
}
