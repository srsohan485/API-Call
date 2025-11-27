import 'package:apidio/apiconstant.dart';
import 'package:apidio/product_detail.dart';
import 'package:apidio/productmodel.dart';
import 'package:dio/dio.dart';
class ApiService{
  final Dio _dio= Dio(BaseOptions(baseUrl: ApiConstant.BASE_URL));

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


}

