//Add New Address Bloc
import 'package:food_delivery/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:food_delivery/ModelClass/ModelAddNewAddress.dart';

class AddnewAddressBloc extends BaseBloc<ResAddAddress> {
  Stream<ResAddAddress> get addNewAddress => fetcher.stream;
  addNewAddressForOrder(dynamic param) async {
    // ResAddAddress addNewAddress = await repository.addNewAddressForOrder(param);
    // fetcher.sink.add(addNewAddress);
  }
}

final addNewAddressBloc = AddnewAddressBloc();
