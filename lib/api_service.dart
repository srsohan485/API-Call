// import 'package:apidio/apiconstant.dart';
// import 'package:apidio/product_detail.dart';
// import 'package:apidio/productmodel.dart';
// import 'package:dio/dio.dart';
// class ApiService{
//   final Dio _dio= Dio(BaseOptions(baseUrl: ApiConstant.BASE_URL));
//
//   Future<ProductModel> getAllProducts()async{
//     try {
//       final jsonResponse = await _dio.get(ApiConstant.products);
//       if(jsonResponse.statusCode == 200) {
//         return ProductModel.fromJson(jsonResponse.data);
//       }else{
//         throw Exception("Failed to get Products");
//       }
//     }catch(error){
//       rethrow;
//     }
//   }
//
//   Future<ProductDetails> getProductDetails(int productId)async{
//     try {
//       final jsonResponse = await _dio.get(ApiConstant.productDetails(productId));
//       if(jsonResponse.statusCode == 200) {
//         return ProductDetails.fromJson(jsonResponse.data);
//       }else{
//         throw Exception("Failed to get Products");
//       }
//     }catch(error){
//       rethrow;
//     }
//   }
//
//
// }
//






import 'dart:convert';

import 'package:apidio/apiconstant.dart';
import 'package:apidio/login_model.dart';
import 'package:apidio/product_detail.dart';
import 'package:apidio/productmodel.dart';
import 'package:dio/dio.dart';
class ApiService{
  // final Dio _dio= Dio(BaseOptions(baseUrl: ApiConstant.BASE_URL));
  late Dio _dio;
  ApiService(){
    _dio=Dio(BaseOptions(baseUrl:ApiConstant.BASE_URL,
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30))
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true
      )
    );
  }

  Future<ProductModel> getAllProducts()async{
    try {
      final jsonResponse = await _dio.get(ApiConstant.products);
      if(jsonResponse.statusCode == 200) {
        return ProductModel.fromJson(jsonResponse.data);
      }else{
        throw Exception("Failed to get Products");
      }
    }catch(error){
      rethrow;
    }
  }

  Future<ProductDetails> getProductDetails(int productId)async{
    try {
      final jsonResponse = await _dio.get(ApiConstant.productDetails(productId));
      if(jsonResponse.statusCode == 200) {
        return ProductDetails.fromJson(jsonResponse.data);
      }else{
        throw Exception("Failed to get Products");
      }
    }catch(error){
      rethrow;
    }
  }

  Future<LoginModel> logInUser(String username, String password) async {
    try {
      final jsonResponse = await _dio.post(ApiConstant.login,
          data: {
            "username": username,
            "password": password
          });

      if (jsonResponse.statusCode == 200) {
        // Explicitly cast the data to Map<String, dynamic>
        return LoginModel.fromJson(jsonResponse.data);
      } else {
        return LoginModel.fromJson(jsonResponse.data);
        // throw Exception("Login failed with status: ${jsonResponse.statusCode}");
      }
    } catch (error) {
      rethrow;
    }
  }


}


