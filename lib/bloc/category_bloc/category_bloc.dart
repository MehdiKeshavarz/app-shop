import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/repositories/category_repository.dart';
import 'package:shop_app/di/locator.dart';

import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository = locator<CategoryRepository>();
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      var categoryList = await categoryRepository.getCategoryData();
      categoryList.fold(
        (error) => emit(CategoryError(messageError: error)),
        (categoryList) => emit(CategoryLoaded(categoryList: categoryList)),
      );
    });

    on<FetchCategoryProductEvent>((event, emit) async {
      emit(CategoryLoading());
      var categoryProductList =
          await categoryRepository.getProductCategoryData(event.categoryId);
      emit(CategoryProductLoaded(categoryProductList: categoryProductList));
    });
  }
}
