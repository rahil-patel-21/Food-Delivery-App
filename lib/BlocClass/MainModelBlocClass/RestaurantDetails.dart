import 'package:food_delivery/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:food_delivery/ModelClass/ModelRestaurantDetails.dart';

class RestaurantDetails extends BaseBloc<ResRestaurantDetails> {
  Stream<ResRestaurantDetails> get restaurantDetails => fetcher.stream;
  fetchRestaurantDetails(String resId, String strUrl) async {
    ResRestaurantDetails resDetails =
        await repository.fetchRestaurantDetails(resId, strUrl);
    fetcher.sink.add(resDetails);
  }
}

final resDetailsBloc = RestaurantDetails();
