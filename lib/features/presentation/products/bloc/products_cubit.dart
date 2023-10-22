import 'package:ecommerce_site/features/model/productConfig.dart';
import 'package:ecommerce_site/features/service/detailsService.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsViewCubit extends Cubit<ProductsViewState> {
  final DetailsService _detailsService;

  ProductsViewCubit(this._detailsService) : super(const ProductsViewState()) {
    initialState();
  }

  void initialState() async {
    List<ProductConfig> newData = await _detailsService.getProductsWithinLimit();
    List<CategoryConfig> categories = await _detailsService.getAllCategories();
    List<String> generalFilter = ['All Product','Stopwatch', 'Clothes', 'Cameras', 'Watches'];

    emit(state.copyWith(
      productsList: newData,
      categories: categories,
      filterList: generalFilter,
      isLoading: false,
    ));
  }

  void changeDotIndicator(){
    int num = (state.sliderCardNumber+1)%4;
    emit(state.copyWith(
      sliderCardNumber: num,
    ));
  }

  void changeFilterListNumber(int num){
    emit(state.copyWith(
      filterListNumber: num,
      filterApplied: num > 0,
    ));
  }

  void addMoreProducts() async{
    emit(state.copyWith(
      moreButtonClicked: true,
    ));
    List<ProductConfig> newData = await _detailsService.getProductsWithinLimit();
    emit(state.copyWith(
      productsList: newData,
      moreButtonClicked: false,
    ));
  }
}
