import '../../../core/class/crud.dart';
import '../../../linkabi.dart';


class CartData {
  Crud crud;
  CartData(this.crud);
  addCart(String usersid, String itemsid,String isbox, String itempriceforunit,int countitembyunit) async {
    var response = await crud
        .postData(AppLink.cartadd, {
      "usersid": usersid,
      "itemsid": itemsid,
      "isbox" :isbox,
      "itempriceforunit": itempriceforunit,
      "countitembyunit":countitembyunit.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteCart(String usersid, String itemsid) async {
    var response = await crud
        .postData(AppLink.cartdelete, {
      "usersid": usersid,
      "itemsid": itemsid,
    });
    return response.fold((l) => l, (r) => r);
  }

  getCountCart(String usersid, String itemsid) async {
    var response = await crud.postData(
        AppLink.cartgetcountitems, {"usersid": usersid, "itemsid": itemsid});
    return response.fold((l) => l, (r) => r);
  }
  getItemCount(String usersid,String userstype, String itemsid) async {
    var response = await crud.postData(
        AppLink.itemcount, {"usersid": usersid,"userstype":userstype, "itemsid": itemsid});
    return response.fold((l) => l, (r) => r);
  }
  viewCart(String usersid, String usersType) async {
    var response = await crud.postData(AppLink.cartview, {
      "usersid": usersid,
      "userstype": usersType,
    });
    return response.fold((l) => l, (r) => r);
  }

  cartitemsView(String usersid, String usersType, String itemsid) async {
    var response = await crud.postData(AppLink.cartview, {
      "usersid": usersid,
      "userstype": usersType,
      "itemsid": itemsid,
    });
    return response.fold((l) => l, (r) => r);
  }


  checkCoupon(String couponname) async {
    var response =
    await crud.postData(AppLink.checkcoupon, {"couponname": couponname});
    return response.fold((l) => l, (r) => r);
  }
}