import 'package:flutter/material.dart';
import 'package:notifier/main_notifier.dart';
import 'package:product/BlocClass/MainModelBlocClass/OrderListBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelOrderList.dart';
import 'package:product/generated/i18n.dart';
import 'Widgets/OrderListWidgets.dart';

void main() => runApp(new OrderScreen());

class OrderScreen extends StatefulWidget {
  updateOrder() => createState().updateOrderListData();
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  //This is callback function
  updateOrderListData() => orderListBloc.fetchOrderList(
      SharedManager.shared.userID, '0', APIS.orderList);

  @override
  Widget build(BuildContext context) {
    (SharedManager.shared.isLoggedIN == 'yes')
        ? orderListBloc.fetchOrderList(
            SharedManager.shared.userID, '0', APIS.orderList)
        : new Text('');
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.history_order, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: (SharedManager.shared.isLoggedIN == 'yes')
          ? StreamBuilder(
              stream: orderListBloc.orderList,
              builder: (context, AsyncSnapshot<ResOrderList> snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data.orderList;
                  if (result.length > 0) {
                    return new Container(
                        color: AppColor.grey[100],
                        child: Column(
                          children: <Widget>[
                            new Divider(
                              color: AppColor.grey[200],
                            ),
                            new Expanded(
                              child: new ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return Notifier.of(context)
                                      .register<String>('action', (data) {
                                    return OrderListCard(result[index]);
                                  });
                                },
                              ),
                            )
                          ],
                        ));
                  } else {
                    return dataFound(context, S.current.no_order_found,
                        AssetImage(AppImages.cartDefaultImage), "0");
                  }
                } else {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              },
            )
          : setLockedAccessWidgets(context, false),
    );
  }
}
