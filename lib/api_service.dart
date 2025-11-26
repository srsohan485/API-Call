import 'package:apidio/apiconstant.dart';
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


}

