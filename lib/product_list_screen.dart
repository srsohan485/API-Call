import 'package:apidio/api_service.dart';
import 'package:apidio/product_detail_screen.dart';
import 'package:apidio/productmodel.dart';
import 'package:flutter/material.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  ApiService apiService=ApiService();

  @override
  void initState() {  //data asar sathe sathe coll hoy
    super.initState();
    apiService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getAllProducts(),
      builder: (context, asyncSnapshot) {

        if(asyncSnapshot.connectionState == ConnectionState.waiting){  //Loding Check
          return Center(child: CircularProgressIndicator());
        }

        if(asyncSnapshot.hasError){  //Error Check
          return Center(child: Text("Error Fetching Products: ${asyncSnapshot.error}"),);
        }

        if(!asyncSnapshot.hasData || (asyncSnapshot.data?.products?.isEmpty ?? true)){  //Data Ace Kina Check
          return Center(child: Text("No Product Available"));
        }

        return Scaffold(
          body: ListView.builder(
            itemCount: asyncSnapshot.data?.products?.length,
              itemBuilder: (context,index){
              Product product=asyncSnapshot.data!.products![index];
                return ListTile(
                  leading: Image.network(product.thumbnail ?? ""),
                  title: Text(product.title ?? ""),
                  subtitle: Text(product.price.toString()),
                  onTap: (){

                    final productId=product.id;
                    if(productId == null)return;

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ProductDetailScreen(productId: productId)));
                  },
                );
              }
          ),
        );
      }
    );
  }
}
