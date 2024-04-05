import 'dart:convert';

BakeryHomeResponse bakeryHomeResponseFromJson(String str) => BakeryHomeResponse.fromJson(json.decode(str));

String bakeryHomeResponseToJson(BakeryHomeResponse data) => json.encode(data.toJson());

class BakeryHomeResponse {
  BakeryHomeResponse({
    required this.success,
    required this.kycStatus,
    required this.sliders,
    required this.banners,
    required this.category,
    required this.groupProducts,
    required this.newArrival,
  });

  bool success;
  int kycStatus;
  List<Slider> sliders;
  List<Banner> banners;
  List<Category> category;
  List<GroupProduct> groupProducts;
  List<BakeryProduct> newArrival;

  factory BakeryHomeResponse.fromJson(Map<String, dynamic> json) => BakeryHomeResponse(
    success: json["success"],
    kycStatus: json["kyc_status"],
    sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    groupProducts: List<GroupProduct>.from(json["group_product"].map((x) => GroupProduct.fromJson(x))),
    newArrival: List<BakeryProduct>.from(json["new_arrivals"].map((x) => BakeryProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "kyc_status": kycStatus,
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "group_product": List<dynamic>.from(groupProducts.map((x) => x.toJson())),
    "new_arrivals": List<dynamic>.from(newArrival.map((x) => x.toJson())),
  };
}

class Banner {
  Banner({
    required this.bannerType,
    required this.bannerImages,
  });

  String bannerType;
  List<String> bannerImages;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    bannerType: json["banner_type"],
    bannerImages: List<String>.from(json["banner_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "banner_type": bannerType,
    "banner_images": List<dynamic>.from(bannerImages.map((x) => x)),
  };
}

class BakeryProduct {
  BakeryProduct({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.productName,
    required this.isLoading,
    required this.attributes,
    required this.variation,
  });

  int id;
  int categoryId;
  int subCategoryId;
  String productName;
  bool isLoading;
  List<Attribute> attributes;
  List<Variation> variation;

  factory BakeryProduct.fromJson(Map<String, dynamic> json) => BakeryProduct(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    productName: json["product_name"],
    isLoading: false,
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    variation: List<Variation>.from(json["variation"].map((x) => Variation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "product_name": productName,
    "isLoading" : isLoading,
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "variation": List<dynamic>.from(variation.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    required this.variationName,
    required this.variationValue,
  });

  String variationName;
  List<String> variationValue;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    variationName: json["variation_name"],
    variationValue: List<String>.from(json["variation_value"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "variation_name": variationName,
    "variation_value": List<dynamic>.from(variationValue.map((x) => x)),
  };
}

class Variation {
  Variation({
    required this.combinationName,
    required this.thumbnail,
    required this.gallery,
    required this.tax,
    required this.hsnCode,
    required this.description,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.mrpPrice,
    required this.discountPrice,
    required this.discountType,
    required this.skuCode,
    required this.quantity,
    required this.inCart,
    required this.cartQuantity,
  });

  String combinationName;
  String thumbnail;
  List<String> gallery;
  String tax;
  String hsnCode;
  String description;
  String purchasePrice;
  String sellingPrice;
  String mrpPrice;
  String discountPrice;
  String discountType;
  String skuCode;
  String quantity;
  bool inCart;
  int cartQuantity;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    combinationName: json["combination_name"],
    thumbnail: json["thumbnail"],
    gallery: List<String>.from(json["gallery"].map((x) => x)),
    tax: json["tax"],
    hsnCode: json["hsn_code"],
    description: json["description"],
    purchasePrice: json["purchase_price"],
    sellingPrice: json["selling_price"],
    mrpPrice: json["mrp_price"],
    discountPrice: json["discount_price"],
    discountType: json["discount_type"],
    skuCode: json["sku_code"],
    quantity: json["quantity"],
    inCart: json["in_cart"],
    cartQuantity: json["cart_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "combination_name": combinationName,
    "thumbnail": thumbnail,
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "tax": tax,
    "hsn_code": hsnCode,
    "description": description,
    "purchase_price": purchasePrice,
    "selling_price": sellingPrice,
    "mrp_price": mrpPrice,
    "discount_price": discountPrice,
    "discount_type": discountType,
    "sku_code": skuCode,
    "quantity": quantity,
    "in_cart": inCart,
    "cart_quantity": cartQuantity,
  };
}



class Category {
  Category({
    required this.id,
    required this.name,
    required this.thumbnailImage,
  });

  int id;
  String name;
  String thumbnailImage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_image": thumbnailImage,
  };
}

class Slider {
  Slider({
    required this.sliderType,
    required this.sliderImages,
  });

  String sliderType;
  List<String> sliderImages;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    sliderType: json["slider_type"],
    sliderImages: List<String>.from(json["slider_images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "slider_type": sliderType,
    "slider_images": List<dynamic>.from(sliderImages.map((x) => x)),
  };
}

class GroupProduct {
  GroupProduct({
    required this.id,
    required this.groupName,
    required this.products
  });

  int id;
  String groupName;
  List<BakeryProduct> products;

  factory GroupProduct.fromJson(Map<String, dynamic> json) => GroupProduct(
    id: json["id"],
    groupName: json["group_name"],
    products: List<BakeryProduct>.from(json["products"].map((x) => BakeryProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "group_name": groupName,
    "products": products,
  };
}


