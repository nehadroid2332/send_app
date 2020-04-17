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
/*//      fixme: this is not happened here--------------------------------------------
      CreditCard cardDetails = CreditCard(
        name: "kamal",
        expMonth: 4,
        expYear: 2021,
        cvc: "314",
        number: "4000056655665556",
      );
      StripePayment.setOptions(
          StripeOptions(publishableKey: "pk_test_gpbwlVeCBVrxNqdUW3FXiNtY", merchantId: "Test", androidPayMode: 'test'));
      StripePayment.createTokenWithCard(
        cardDetails,
      ).then((token) {
        print(token.tokenId);
      });
//todo remove above test code---------------------------------------------------------*/
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
//      fixme: uncomment this location code
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
