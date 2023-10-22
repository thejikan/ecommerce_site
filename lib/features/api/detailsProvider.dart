import 'dart:collection';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetailsProvider extends IDetailsProvider {

  String baseUrl = 'https://api.escuelajs.co';

  @override
  Future<http.Response> getAllProducts() async {
    String endPointPath = '$baseUrl/api/v1/products';


    return await http.get(
      Uri.parse(endPointPath),
    );
  }

  @override
  Future<http.Response> getProductsByLimit(int offset, int limit) async {
    String endPointPath = '$baseUrl/api/v1/products?offset=${offset.toString()}&limit=${limit.toString()}';

    return await http.get(
      Uri.parse(endPointPath),
    );
  }

  @override
  Future<http.Response> getProductById(int id) async {
    String endPointPath = '$baseUrl/api/v1/products/${id.toString()}';


    return await http.get(
      Uri.parse(endPointPath),
    );
  }

  @override
  Future<http.Response> getAllCategories() async {
    String endPointPath = '$baseUrl/api/v1/categories';


    return await http.get(
      Uri.parse(endPointPath),
    );
  }

  @override
  Future<http.Response> filterProductsList(String filter) async {
    String endPointPath = '$baseUrl/api/v1/products/?$filter';


    return await http.get(
      Uri.parse(endPointPath),
    );
  }

}

abstract class IDetailsProvider {
  Future<http.Response> getAllProducts();
  Future<http.Response> getProductsByLimit(int offset, int limit);
  Future<http.Response> getProductById(int id);
  Future<http.Response> getAllCategories();
  Future<http.Response> filterProductsList(String filter);
}
