class ApiConstant{
  static const String BASE_URL="https://dummyjson.com/";
  static const String products="/products";
  static String productDetails(int productId) => "/products/$productId";
  static const String login="auth/login";
}