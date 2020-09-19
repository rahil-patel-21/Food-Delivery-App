import 'package:food_delivery/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:food_delivery/ModelClass/ModelOrderList.dart';

class OrderListBloc extends BaseBloc<ResOrderList> {
  Stream<ResOrderList> get orderList => fetcher.stream;
  fetchOrderList(String userID, String isAll, String strUrl) async {
    ResOrderList resDetails =
        await repository.fetchAllOrders(strUrl, userID, isAll);
    fetcher.sink.add(resDetails);
  }
}

final orderListBloc = OrderListBloc();
