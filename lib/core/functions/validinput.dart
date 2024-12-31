import 'package:get/get_utils/src/get_utils/get_utils.dart';

  validInput(String val,int min,int max,String type){
      if(type=="username"){

          if(!GetUtils.isUsername(val)){

            return "not valid user Name";
      }
    }
      if(type=="email"){

        if(!GetUtils.isEmail(val)){

          return "not valid Email";
        }
      }
      if(type=="phone"){

        if(!GetUtils.isPhoneNumber(val)){

          return "not valid phone";
        }
      }
      if(val.isEmpty){
        return "value can not be Empty";
      }
      if(val.length<min){
        return "value can not be less than $min";
      }
      if(val.length>max){
        return "value can not be larger than $max";
      }
  }