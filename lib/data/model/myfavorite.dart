class MyFavoriteModel {
  int? favoriteId;
  int? favoriteUsersid;
  int? favoriteItemsid;
  int? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  int? itemsCount;
  int? itemsActive;
  int? itemsquantityinbox;
  num? itemsPrice;
  num? itemspricrofbox;
  num? itemspricrofboxmerchant;
  num? itemspricrofboxmosque;
  num? itemsDescount;
  String? itemsDate;
  int? itemsCat;
  int? usersId;

  MyFavoriteModel(
      {this.favoriteId,
        this.favoriteUsersid,
        this.favoriteItemsid,
        this.itemsId,
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
        this.itemsDescount,
        this.itemsDate,
        this.itemsCat,
        this.usersId});

  MyFavoriteModel.fromJson(Map<String, dynamic> json) {
    favoriteId = json['favorite_id'];
    favoriteUsersid = json['favorite_usersid'];
    favoriteItemsid = json['favorite_itemsid'];
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
    itemsDescount = json['items_descount'];
    itemsDate = json['items_date'];
    itemsCat = json['items_cat'];
    usersId = json['users_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favorite_id'] = favoriteId;
    data['favorite_usersid'] = favoriteUsersid;
    data['favorite_itemsid'] = favoriteItemsid;
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
    data['items_descount'] = itemsDescount;
    data['items_date'] = itemsDate;
    data['items_cat'] = itemsCat;
    data['users_id'] = usersId;
    return data;
  }
}