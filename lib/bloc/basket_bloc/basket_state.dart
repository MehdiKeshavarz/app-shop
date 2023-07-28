part of 'basket_bloc.dart';

@immutable
abstract class BasketState {}

class BasketInitialState extends BasketState {}

class BasketCompletedState extends BasketState {
  final Either<String, List<CartItemMode>> listItemBasket;
  final int finalPrice;

  BasketCompletedState({
    required this.listItemBasket,
    required this.finalPrice,
  });
}
