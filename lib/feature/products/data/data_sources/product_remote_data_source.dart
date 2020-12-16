import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  /// Calls the https://ranting.twisdev.com/index.php/rest/items/search/api_key/teampsisthebest/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() => _getProductsFromUrl(
      'https://ranting.twisdev.com/index.php/rest/items/search/api_key/teampsisthebest/');

  Future<List<ProductModel>> _getProductsFromUrl(String url) async {
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      return List<ProductModel>.from(
          decodedJson.map((i) => ProductModel.fromJson(i)));
    } else {
      throw ServerException();
    }
  }
}
