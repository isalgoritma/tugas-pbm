import 'dart:convert';

import 'package:http/http.dart'
    as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/product_model.dart';

class ProductService {

  final storage =
      const FlutterSecureStorage();

  final String baseUrl =
      "https://task.itprojects.web.id";

  Future<List<Product>>
      getProducts() async {

    try {

      String? token =
          await storage.read(
        key: 'token',
      );

      final url = Uri.parse(
        '$baseUrl/api/products',
      );

      final response =
          await http.get(

        url,

        headers: {

          'Authorization':
              'Bearer $token',

          'Accept':
              'application/json',
        },
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        List productsJson = [];

        if (data['data']
            is List) {

          productsJson =
              data['data'];
        }

        else if (
            data['data'] !=
                    null &&
                data['data']
                        ['products']
                    is List) {

          productsJson =
              data['data']
                  ['products'];
        }

        else if (
            data['data'] !=
                    null &&
                data['data']
                        ['data']
                    is List) {

          productsJson =
              data['data']
                  ['data'];
        }

        return productsJson
            .map((json) {

          return Product.fromJson(
            json,
          );

        }).toList();

      } else {

        return [];
      }

    } catch (e) {

      // ignore: avoid_print
      print(e);

      return [];
    }
  }

  Future<bool> addProduct(

    String name,
    int price,
    String description,

  ) async {

    try {

      String? token =
          await storage.read(
        key: 'token',
      );

      final url = Uri.parse(
        '$baseUrl/api/products',
      );

      final response =
          await http.post(

        url,

        headers: {

          'Authorization':
              'Bearer $token',

          'Content-Type':
              'application/json',

          'Accept':
              'application/json',
        },

        body: jsonEncode({

          'name': name,

          'price': price,

          'description':
              description,
        }),
      );

      return response.statusCode ==
              200 ||
          response.statusCode ==
              201;

    } catch (e) {

      // ignore: avoid_print
      print(e);

      return false;
    }
  }

  Future<bool> deleteProduct(
    int id,
  ) async {

    try {

      String? token =
          await storage.read(
        key: 'token',
      );

      final url = Uri.parse(
        '$baseUrl/api/products/$id',
      );

      final response =
          await http.delete(

        url,

        headers: {

          'Authorization':
              'Bearer $token',

          'Accept':
              'application/json',
        },
      );

      return response.statusCode ==
              200 ||
          response.statusCode ==
              201;

    } catch (e) {

      // ignore: avoid_print
      print(e);

      return false;
    }
  }
}