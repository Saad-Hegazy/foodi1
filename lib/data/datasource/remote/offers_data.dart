import '../../../core/class/crud.dart';
import '../../../linkabi.dart';

class OffersData{
  Crud crud;
  OffersData(this.crud);
  getData(String usersType) async{
    var response = await crud.postData(AppLink.offers,{"descountType": usersType,});

    return  response.fold((l)=>l,(r)=>r);
  }

}