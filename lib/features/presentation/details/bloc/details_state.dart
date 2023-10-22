part of 'details_cubit.dart';

class DetailsViewState extends Equatable {
  final int productId;
  final bool isLoading;
  final String title;
  final int price;
  final List<String> imageUrls;
  final String description;
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  final int sliderCardNumber;

  const DetailsViewState({
    this.productId = 0,
    this.isLoading = true,
    this.title = '',
    this.price = 0,
    this.imageUrls = const [],
    this.description = '',
    this.categoryId = 0,
    this.categoryName = '',
    this.categoryImage = '',
    this.sliderCardNumber = 0,
  });

  DetailsViewState copyWith({
    int? productId,
    bool? isLoading,
    String? title,
    int? price,
    List<String>? imageUrls,
    String? description,
    int? categoryId,
    String? categoryName,
    String? categoryImage,
    int? sliderCardNumber,
  }) {
    return DetailsViewState(
      productId: productId ?? this.productId,
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryImage: categoryImage ?? this.categoryImage,
      sliderCardNumber: sliderCardNumber ?? this.sliderCardNumber,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        isLoading,
        title,
        price,
        imageUrls,
        description,
        categoryId,
        categoryName,
        categoryImage,
        sliderCardNumber,
      ];
}
