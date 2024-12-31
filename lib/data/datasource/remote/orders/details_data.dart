import '../../../../core/class/crud.dart';
import '../../../../linkabi.dart';

class OrdersDetailsData {
  Crud crud;
  OrdersDetailsData(this.crud);
  getData(String id,String usersType) async {
    var response = await crud.postData(AppLink.ordersdetails, {"id": id ,"userstype" :usersType});
    return response.fold((l) => l, (r) => r);
  }
}