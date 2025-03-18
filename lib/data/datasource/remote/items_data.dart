import '../../../core/class/crud.dart';
import '../../../linkabi.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);
  getData(String  id,  String page , String recordsPerPage) async {
    var response = await crud.postData(AppLink.items, {
      "id" : id,
      "page":page,
      "recordsPerPage":recordsPerPage,
    });
    return response.fold((l) => l, (r) => r);
  }
}