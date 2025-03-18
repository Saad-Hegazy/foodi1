import '../../../core/class/crud.dart';
import '../../../linkabi.dart';

class checkCouponData {
  Crud crud;
  checkCouponData(this.crud);
  checkCoupon(String couponname) async {
    var response =
    await crud.postData(AppLink.checkcoupon, {"couponname": couponname});
    return response.fold((l) => l, (r) => r);
  }
}