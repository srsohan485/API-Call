import 'package:apidio/api_service.dart';
import 'package:apidio/productmodel.dart';
import 'package:flutter/material.dart';
class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key,required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ApiService apiService=ApiService();
  @override
  void initState() {
    super.initState();
    apiService.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: apiService.getProductDetails(widget.productId),
          builder: (context,asyncSnapshot){

            if(asyncSnapshot.connectionState == ConnectionState.waiting){  //Loding Check
              return Center(child: CircularProgressIndicator());
            }

            if(asyncSnapshot.hasError){  //Error Check
              return Center(child: Text("Error Fetching Products: ${asyncSnapshot.error}"),);
            }

            if(!asyncSnapshot.hasData){  //Data Ace Kina Check
              return Center(child: Text("No Product Details Available"));
            }

            //Desing Part
            final productDetails=(asyncSnapshot.data);
            return Column(
              children: [
                Image.network(productDetails?.thumbnail ?? "",
                  height: 250,
                ),
                Text(productDetails?.title?? ""),
                Text(productDetails?.price.toString()?? ""),
                Text(productDetails?.discountPercentage.toString()?? ""),
                Text(productDetails?.description?? ""),

              ],
            );

          }

      ),
    );
  }
}
