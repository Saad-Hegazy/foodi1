import '../../../../core/class/crud.dart';
import '../../../../linkabi.dart';

class OrdersArchiveData {
  Crud crud;
  OrdersArchiveData(this.crud);
  getData(String userid) async {
    var response = await crud.postData(AppLink.ordersarchive, {"id": userid});
    return response.fold((l) => l, (r) => r);
  }
  deleteData(String orderid) async {
    var response = await crud.postData(AppLink.ordersdelete, {"orderid": orderid});
    return response.fold((l) => l, (r) => r);
  }
  rating(String orderid ,String comment,String rating) async {
    var response = await crud.postData(AppLink.rating, {"id": orderid ,"comment": comment,"rating": rating });
    return response.fold((l) => l, (r) => r);
  }

}