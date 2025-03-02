import 'itemsmodel.dart';

class CartModel {
  int? countitems;
  int? cartId;
  int? cartUsersid;
  int? cartItemsid;
  num? cartitemprice;
  int? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  var itemsCount;
  int? itemsActive;
  int? itemsquantityinbox;
  int? cartitemisbox;
  int? cartitemcount;
  num? itemspricrofbox;
  num? itemspricrofboxmerchant;
  num? itemspricrofboxmosque;
  num? itemsPrice;
  num? totalitemsPrice;
  num? itemsDescount;
  num? itemsPriceMerchant;
  num? itemsDescountMerchant;
  num? itemsPriceMosque;
  num? itemsDescountMosque;
  String? itemsDate;
  int? itemsCat;

  CartModel(
      {
        this.countitems,
        this.cartId,
        this.cartUsersid,
        this.cartItemsid,
        this.cartitemprice,
        this.itemsId,
        this.itemsName,
        this.itemsNameAr,
        this.itemsDesc,
        this.itemsDescAr,
        this.itemsImage,
        this.itemsCount,
        this.itemsActive,
        this.itemsquantityinbox,
        this.cartitemisbox,
        this.cartitemcount,
        this.itemspricrofbox,
        this.itemspricrofboxmerchant,
        this.itemspricrofboxmosque,
        this.itemsPrice,
        this.totalitemsPrice,
        this.itemsDescount,
        this.itemsPriceMerchant,
        this.itemsDescountMerchant,
        this.itemsPriceMosque,
        this.itemsDescountMosque,
        this.itemsDate,
        this.itemsCat});

  CartModel.fromJson(Map<String, dynamic> json) {
    countitems = json['countitems'];
    cartId = json['cart_id'];
    cartUsersid = json['cart_usersid'];
    cartItemsid = json['cart_itemsid'];
    cartitemprice = json['cart_itemprice'];
    itemsId = json['items_id'];
    itemsName = json['items_name'];
    itemsNameAr = json['items_name_ar'];
    itemsDesc = json['items_desc'];
    itemsDescAr = json['items_desc_ar'];
    itemsImage = json['items_image'];
    itemsCount = json['items_count'];
    itemsActive = json['items_active'];
    itemsquantityinbox = json['items_quantityinbox'];
    cartitemisbox = json['cart_itemisbox'];
    cartitemcount = json['cart_itemcount'];
    itemsPrice = json['items_price'];
    totalitemsPrice = json['itemsprice'];
    itemspricrofbox = json['items_pricrofbox'];
    itemspricrofboxmerchant = json['items_pricrofbox_merchant'];
    itemspricrofboxmosque = json['items_pricrofbox_mosque'];
    itemsDescount = json['items_descount'];
    itemsPriceMerchant = json['items_price_merchant'];
    itemsPriceMosque = json['items_price_mosque'];
    itemsDescountMosque = json['items_descount_mosque'];
    itemsDescountMerchant = json['items_descount_Merchant'];
    itemsDate = json['items_date'];
    itemsCat = json['items_cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countitems'] = countitems;
    data['cart_id'] = cartId;
    data['cart_usersid'] = cartUsersid;
    data['cart_itemsid'] = cartItemsid;
    data['cart_itemprice'] =cartitemprice;
    data['items_id'] = itemsId;
    data['items_name'] = itemsName;
    data['items_name_ar'] = itemsNameAr;
    data['items_desc'] = itemsDesc;
    data['items_desc_ar'] = itemsDescAr;
    data['items_image'] = itemsImage;
    data['items_count'] = itemsCount;
    data['items_active'] = itemsActive;
    data['items_quantityinbox'] = itemsquantityinbox;
    data['cart_itemisbox'] = cartitemisbox;
    data['cart_itemcount'] = cartitemcount;
    data['items_price'] = itemsPrice;
    data['itemsprice']=totalitemsPrice;
    data['items_pricrofbox'] = itemspricrofbox;
    data['items_pricrofbox_merchant'] = itemspricrofboxmerchant;
    data['items_pricrofbox_mosque'] = itemspricrofboxmosque;
    data['items_descount'] = itemsDescount;
    data['items_price_merchant'] = itemsPriceMerchant;
    data['items_price_mosque'] = itemsPriceMosque;
    data['items_descount_mosque'] = itemsDescountMosque;
    data['items_descount_Merchant'] = itemsDescountMerchant;
    data['items_date'] = itemsDate;
    data['items_cat'] = itemsCat;
    return data;
  }


  ItemsModel toItemsModel() {
    return ItemsModel(
      itemsId: itemsId,
      itemsName: itemsName,
      itemsNameAr: itemsNameAr,
      itemsDesc: itemsDesc,
      itemsDescAr: itemsDescAr,
      itemsImage: itemsImage,
      itemsCount: itemsCount,
      itemsActive: itemsActive,
      itemsquantityinbox: itemsquantityinbox,
      itemsPrice: itemsPrice,
      itemspricrofbox: itemspricrofbox,
      itemsDescount: itemsDescount,
      itemsDate: itemsDate,
      itemsCat: itemsCat,
      // Add other matching fields as needed
    );
  }
}