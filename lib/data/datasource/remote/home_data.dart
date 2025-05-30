

import '../../../core/class/crud.dart';
import '../../../linkabi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);
  getData(String descountType, String userstype) async {
    var response = await crud.postData(AppLink.homepage, {
        "descountType":descountType,
        "userstype":userstype,
    });
    return response.fold((l) => l, (r) => r);
  }
  searchData(String search) async {
    var response = await crud.postData(AppLink.searchitems, {"search": search});
    return response.fold((l) => l, (r) => r);
  }
}