import 'dart:convert';

import 'package:ecommerce_site/features/api/detailsProvider.dart';
import 'package:ecommerce_site/features/model/productConfig.dart';

class DetailsRepository implements IDetailsRepository {
  IDetailsProvider provider;

  DetailsRepository({
    required this.provider,
  });

  @override
  Future<List<ProductConfig>> getAllProducts() async {
    List<ProductConfig> response = [];
    try {
      final apiResponse = await provider.getAllProducts();

      if (apiResponse.statusCode != 200) {
        print(apiResponse.body);
        throw Exception(apiResponse.statusCode);
      }
      Map<String, dynamic> productsList = json.decode(apiResponse.body);

      for (var product in productsList['data']) {
        List<String> imageUrls = [];
        for(String urls in product['images']){
          imageUrls.add(urls);
        }
        response.add(ProductConfig(
          title: product['title'],
          id: product['id'],
          price: product['price'],
          imageUrls: imageUrls,
          category: CategoryConfig(
              name: product['category']['name'],
              id: product['category']['id'],
              image: product['category']['image']),
          description: product['description'],
        ));
      }

      return response;
    } on Exception catch (e, stacktrace) {
      return response;
      // throw Exception();
    }
  }

  @override
  Future<ProductConfig> getProductById(int productId) async {
    try {
      final apiResponse = await provider.getProductById(productId);

      if (apiResponse.statusCode != 200) {
        print(apiResponse.body);
        throw Exception(apiResponse.statusCode);
      }
      Map<String, dynamic> product = json.decode(apiResponse.body);

      List<String> imageUrls = [];
      for(String urls in product['images']){
        imageUrls.add(urls);
      }
      return ProductConfig(
        title: product['title'],
        id: product['id'],
        price: product['price'],
        imageUrls: imageUrls,
        category: CategoryConfig(
            name: product['category']['name'],
            id: product['category']['id'],
            image: product['category']['image']),
        description: product['description'],
      );

      // return response;
    } on Exception catch (e, stacktrace) {
      return ProductConfig(
        title: '',
        id: -1,
        price: 0,
        imageUrls: [],
        category: CategoryConfig(name: '', id: 0, image: ''),
        description: '',
      );
    }
  }

  @override
  Future<List<ProductConfig>> getProductsWithLimit(int offset, int limit) async {
    List<ProductConfig> response = [];
    try {
      final apiResponse = await provider.getProductsByLimit(offset, limit);

      if (apiResponse.statusCode != 200) {
        print(apiResponse.body);
        throw Exception(apiResponse.statusCode);
      }
      var productsList = json.decode(apiResponse.body);

      for (var product in productsList) {
        List<String> imageUrls = [];
        for(String urls in product['images']){
          imageUrls.add(urls);
        }
        response.add(ProductConfig(
          title: product['title'],
          id: product['id'],
          price: product['price'],
          imageUrls: imageUrls,
          category: CategoryConfig(
              name: product['category']['name'],
              id: product['category']['id'],
              image: product['category']['image']),
          description: product['description'],
        ));
      }

      return response;
    } on Exception catch (e, stacktrace) {
      return response;
      // throw Exception();
    }
  }

  @override
  Future<List<CategoryConfig>> getAllCategories() async {
    List<CategoryConfig> response = [];
    try {
      final apiResponse = await provider.getAllCategories();

      if (apiResponse.statusCode != 200) {
        print(apiResponse.body);
        throw Exception(apiResponse.statusCode);
      }
      var productsList = json.decode(apiResponse.body);

      for (var product in productsList) {
        response.add(CategoryConfig(
          id: product['id'],
          image: product['image'],
          name: product['name'],
        ));
      }

      return response;
    } on Exception catch (e, stacktrace) {
      return response;
      // throw Exception();
    }
  }

  @override
  Future<List<ProductConfig>> filterProductsList(String filter) async {
    List<ProductConfig> response = [];
    try {
      final apiResponse = await provider.filterProductsList(filter);

      if (apiResponse.statusCode != 200) {
        print(apiResponse.body);
        throw Exception(apiResponse.statusCode);
      }
      var productsList = json.decode(apiResponse.body);

      for (var product in productsList) {
        List<String> imageUrls = [];
        for(String urls in product['images']){
          imageUrls.add(urls);
        }
        response.add(ProductConfig(
          title: product['title'],
          id: product['id'],
          price: product['price'],
          imageUrls: imageUrls,
          category: CategoryConfig(
              name: product['category']['name'],
              id: product['category']['id'],
              image: product['category']['image']),
          description: product['description'],
        ));
      }

      return response;
    } on Exception catch (e, stacktrace) {
      return response;
      // throw Exception();
    }
  }
}

abstract class IDetailsRepository {
  Future<List<ProductConfig>> getAllProducts();
  Future<ProductConfig> getProductById(int productId);
  Future<List<ProductConfig>> getProductsWithLimit(int offset, int limit);
  Future<List<CategoryConfig>> getAllCategories();
  Future<List<ProductConfig>> filterProductsList(String filter);

}
