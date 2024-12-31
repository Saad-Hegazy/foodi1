import '../../../core/class/crud.dart';
import '../../../linkabi.dart';

class ImagesliderData{
  Crud crud;
  ImagesliderData(this.crud);
  getData(String usersType) async{
    var response = await crud.postData(AppLink.imageSlider,{
      "userstype": usersType,
    });

    return  response.fold((l)=>l,(r)=>r);
  }

}