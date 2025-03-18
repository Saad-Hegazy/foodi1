import 'package:get/get.dart';
import '../../core/services/services.dart';

class ItemsModel {
  int? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  var itemsCount;
  int? itemsActive;
  int? itemsquantityinbox;
  num? itemsPrice;
  num? itemspricrofbox;
  num? itemspricrofboxmerchant;
  num? itemspricrofboxmosque;
  num? itemsPriceMerchant;
  num? itemsPriceMosque;
  num? itemsDescount;
  num? itemsDescountMosque;
  num? itemsDescountMerchant;
  String? itemsDate;
  int? itemsCat;
  int? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  String? categoriesDatetime;
  int? favorite;
  ItemsModel(
      {this.itemsId,
        this.itemsName,
        this.itemsNameAr,
        this.itemsDesc,
        this.itemsDescAr,
        this.itemsImage,
        this.itemsCount,
        this.itemsActive,
        this.itemsquantityinbox,
        this.itemsPrice,
        this.itemspricrofbox,
        this.itemspricrofboxmerchant,
        this.itemspricrofboxmosque,
        this.itemsPriceMerchant,
        this.itemsPriceMosque,
        this.itemsDescount,
        this.itemsDescountMosque,
        this.itemsDescountMerchant,
        this.itemsDate,
        this.itemsCat,
        this.categoriesId,
        this.categoriesName,
        this.categoriesNameAr,
        this.categoriesImage,
        this.categoriesDatetime,
        this.favorite});
  MyServices myServices = Get.find();

  ItemsModel.fromJson(Map<dynamic, dynamic> json) {
    itemsId = json['items_id'];
    itemsName = json['items_name'];
    itemsNameAr = json['items_name_ar'];
    itemsDesc = json['items_desc'];
    itemsDescAr = json['items_desc_ar'];
    itemsImage = json['items_image'];
    itemsCount = json['items_count'];
    itemsActive = json['items_active'];
    itemsquantityinbox = json['items_quantityinbox'];
    itemsPrice = json['items_price'];
    itemspricrofbox = json['items_pricrofbox'];
    itemspricrofboxmerchant = json['items_pricrofbox_merchant'];
    itemspricrofboxmosque = json['items_pricrofbox_mosque'];
    itemsPriceMerchant = json['items_price_merchant'];
    itemsPriceMosque = json['items_price_mosque'];
    itemsDescount = json['items_descount'];
    itemsDescountMosque = json['items_descount_mosque'];
    itemsDescountMerchant = json['items_descount_Merchant'];
    itemsDate = json['items_date'];
    itemsCat = json['items_cat'];
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesImage = json['categories_image'];
    categoriesDatetime = json['categories_datetime'];
    favorite = json['favorite'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items_id'] = itemsId;
    data['items_name'] = itemsName;
    data['items_name_ar'] = itemsNameAr;
    data['items_desc'] = itemsDesc;
    data['items_desc_ar'] = itemsDescAr;
    data['items_image'] = itemsImage;
    data['items_count'] = itemsCount;
    data['items_active'] = itemsActive;
    data['items_quantityinbox'] = itemsquantityinbox;
    data['items_price'] = itemsPrice;
    data['items_pricrofbox'] = itemspricrofbox;
    data['items_pricrofbox_merchant'] = itemspricrofboxmerchant;
    data['items_pricrofbox_mosque'] = itemspricrofboxmosque;
    data['items_price_merchant'] = itemsPriceMerchant;
    data['items_price_mosque'] = itemsPriceMosque;
    data['items_descount'] = itemsDescount;
    data['items_descount_mosque'] = itemsDescountMosque;
    data['items_descount_Merchant'] = itemsDescountMerchant;
    data['items_date'] = itemsDate;
    data['items_cat'] = itemsCat;
    data['categories_id'] = categoriesId;
    data['categories_name'] = categoriesName;
    data['categories_name_ar'] = categoriesNameAr;
    data['categories_image'] = categoriesImage;
    data['categories_datetime'] = categoriesDatetime;
    return data;
  }

  num? get itemPrice{
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
            if(itemsDescount!>0){
              return itemsPrice!- itemsPrice! * itemsDescount!/100;
            }else{
              return  itemsPrice!;
            }
      case  "mosque":
        if(itemsDescountMosque!>0){
          return itemsPriceMosque!- itemsPriceMosque! * itemsDescountMosque!/100;
        }else{
          return  itemsPriceMosque!;
        }
      case  "Merchant":
        if(itemsDescountMerchant!>0){
          return itemsPriceMerchant!- itemsPriceMerchant! * itemsDescountMerchant!/100;
        }else{
          return  itemsPriceMerchant!;
        }
    }
    return 0;
  }

  num? get itemPriceBox{
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsDescount!>0){
          return itemspricrofbox! - itemspricrofbox! * itemsDescount!/100;
        }else{
          return  itemspricrofbox!;
        }
      case  "mosque":
        if(itemsDescountMosque!>0){
          return itemspricrofboxmosque! - itemspricrofboxmosque! * itemsDescountMosque!/100;
        }else{
          return  itemspricrofboxmosque!;
        }
      case  "Merchant":
        if(itemsDescountMerchant!>0){
          return itemspricrofboxmerchant! - itemspricrofboxmerchant! * itemsDescountMerchant!/100;
        }else{
          return  itemspricrofboxmerchant!;
        }
    }
    return 0;
  }

  get amountofDiscount{
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        if(itemsDescount! >0){
          return itemsDescount;
        }else{
          return 0 ;
        }
      case  "mosque":
        if(itemsDescountMosque! >0){
          return itemsDescountMosque;
        }else{
          return 0 ;
        }
      case  "Merchant":
        if(itemsPriceMerchant! >0){
          return itemsPriceMerchant;
        }else{
          return 0 ;
        }
    }
  }

  get pricewithoutDiscount{
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        return  itemsPrice!;
      case  "mosque":
        return  itemsPriceMosque!;
      case  "Merchant":
        return  itemsPriceMerchant!;
    }
  }

  get priceBoxwithoutDiscount{
    switch(myServices.sharedPreferences.getString("userType")){
      case  "Normal User":
        return  itemsPrice! * itemsquantityinbox!;
      case  "mosque":
        return  itemsPriceMosque!* itemsquantityinbox!;
      case  "Merchant":
        return  itemsPriceMerchant!* itemsquantityinbox!;
    }
  }
}