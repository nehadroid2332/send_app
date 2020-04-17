import 'package:location/location.dart';
import 'package:sendapp/model/card.dart';
import 'package:sendapp/model/category.dart';
import 'package:sendapp/model/product.dart';
import 'package:sendapp/services/network_repository.dart';
import 'package:sendapp/utils/toole.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CategoriesRepository {
  final NetworkRepository _networkRepository = NetworkRepository();

  Future<List<Category>> getCategories() async {
    try {
      final response = await _networkRepository.getCategories();

      var list = response.data["data"] as List;
      return list.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Product>> getProductById({String productId}) async {
    try {
      final response = await _networkRepository.getProducts(
          id: productId, position: await location.getLocation());
      var list = response.data["data"] as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
