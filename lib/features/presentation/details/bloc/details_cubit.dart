import 'package:ecommerce_site/features/model/productConfig.dart';
import 'package:ecommerce_site/features/service/detailsService.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_state.dart';

class DetailsViewCubit extends Cubit<DetailsViewState> {
  final DetailsService _detailsService;
  final int productId;

  DetailsViewCubit(this._detailsService, this.productId)
      : super(const DetailsViewState()) {
    initialState();
  }

  void initialState() async {
    ProductConfig data = await _detailsService.getProductById(productId);
    List<String> imageUrls = data.imageUrls;
    imageUrls.add(data.category.image);

    emit(state.copyWith(
      productId: data.id,
      title: data.title,
      price: data.price,
      imageUrls: imageUrls,
      description: data.description,
      categoryName: data.category.name,
      categoryId: data.category.id,
      categoryImage: data.category.image,
      isLoading: false,
    ));
  }

  void changeDotIndicator(){
    int num = (state.sliderCardNumber+1)%4;
    emit(state.copyWith(
      sliderCardNumber: num,
    ));
  }
}
