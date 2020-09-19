import 'package:food_delivery/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:food_delivery/ModelClass/ModelMealDeals.dart';

class MealDealsItemsBloc extends BaseBloc<ResMealDeals> {
  Stream<ResMealDeals> get mealDealsItems => fetcher.stream;
  fetchMealDealsItems(String url) async {
    ResMealDeals mealDeals = await repository.fetchMealDealsItems(url);
    fetcher.sink.add(mealDeals);
  }
}

final mealDealsItemsBloc = MealDealsItemsBloc();
