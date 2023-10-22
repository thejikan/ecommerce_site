import 'dart:convert';

import 'package:ecommerce_site/features/model/productConfig.dart';

class DetailsModel {
  List<ProductConfig> productsData;
  List<CategoryConfig> allCategories;
  int noOfProducts;
  int paginationLimit;
  String userId;

  DetailsModel({
    this.productsData = const [],
    this.allCategories = const [],
    this.userId = '',
    this.noOfProducts = 0,
    this.paginationLimit = 10,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productsData': productsData,
    };
  }

  factory DetailsModel.fromMap(Map<String, dynamic> map) {
    return DetailsModel(
      productsData: map['productsData'] as List<ProductConfig>,
    );
  }

  factory DetailsModel.empty() {
    return DetailsModel(
      productsData: [],
      allCategories: [],
      userId: '',
      noOfProducts: 0,
      paginationLimit: 10,
    );
  }

  factory DetailsModel.fromQueryMap(Map<String, dynamic> map) {
    return DetailsModel(
      productsData: map['productsData'] as List<ProductConfig>? ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsModel.fromJson(String source) =>
      DetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
