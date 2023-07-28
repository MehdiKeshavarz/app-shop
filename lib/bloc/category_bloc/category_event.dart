part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class FetchCategoryEvent extends CategoryEvent {}

class FetchCategoryProductEvent extends CategoryEvent {
  final String categoryId;

  FetchCategoryProductEvent({required this.categoryId});
}
