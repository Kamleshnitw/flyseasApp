import 'dart:convert';

ProfileDetailResponse profileDetailResponseFromJson(String str) => ProfileDetailResponse.fromJson(json.decode(str));

String profileDetailResponseToJson(ProfileDetailResponse data) => json.encode(data.toJson());

class ProfileDetailResponse {
  ProfileDetailResponse({
    required this.success,
    required this.profile,
  });

  bool success;
  Profile profile;

  factory ProfileDetailResponse.fromJson(Map<String, dynamic> json) => ProfileDetailResponse(
    success: json["success"],
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "profile": profile.toJson(),
  };
}

class Profile {
  Profile({
    required this.name,
    required this.phone,
    required this.city,
    required this.category,
    required this.kycStatus,
    required this.kycDetails,
    required this.bankDetail,
  });

  String name;
  String phone;
  City city;
  Category? category;
  int kycStatus;
  KycDetails? kycDetails;
  BankDetail? bankDetail;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"],
    phone: json["phone"],
    city: City.fromJson(json["city"]),
    category: json["category"]!=null ? Category.fromJson(json["category"]) : null,
    kycStatus: json["kyc_status"],
    kycDetails: json["kyc_details"]!=null ? KycDetails.fromJson(json['kyc_details']) : null,
    bankDetail: json["bank_detail"]!=null ? BankDetail.fromJson(json['bank_detail']) : null,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "city": city.toJson(),
    "category": category?.toJson(),
    "kyc_status": kycStatus,
    "kyc_details": kycDetails?.toJson(),
    "bank_detail": bankDetail?.toJson(),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.thumbnailImage,
    required this.bannerImage,
    required this.isFeature,
  });

  int id;
  String name;
  int thumbnailImage;
  int bannerImage;
  int isFeature;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    bannerImage: json["banner_image"],
    isFeature: json["is_feature"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "banner_image": bannerImage,
    "is_feature": isFeature,
  };
}

class City {
  City({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class KycDetails {
  KycDetails({
    required this.id,
    required this.userId,
    required this.shopName,
    required this.shopFrontImage,
    required this.shopFullAddress,
    required this.ownerName,
    required this.otherDocument,
    required this.otherDocumentFile,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String shopName;
  String shopFrontImage;
  String shopFullAddress;
  String ownerName;
  String otherDocument;
  String otherDocumentFile;
  String createdAt;
  String updatedAt;

  factory KycDetails.fromJson(Map<String, dynamic> json) => KycDetails(
    id: json["id"],
    userId: json["user_id"],
    shopName: json["shop_name"],
    shopFrontImage: json["shop_front_image"],
    shopFullAddress: json["shop_full_address"],
    ownerName: json["owner_name"],
    otherDocument: json["other_document"],
    otherDocumentFile: json["other_document_file"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_name": shopName,
    "shop_front_image": shopFrontImage,
    "shop_full_address": shopFullAddress,
    "owner_name": ownerName,
    "other_document": otherDocument,
    "other_document_file": otherDocumentFile,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class BankDetail {
  BankDetail({
    required this.id,
    required this.userId,
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.ifscCode,
    required this.address,
    required this.status
  });

  int id;
  int userId;
  String accountHolderName;
  String accountNumber;
  String bankName;
  String ifscCode;
  String address;
  String status;

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
    id: json["id"],
    userId: json["user_id"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    address: json["address"],
    status: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "address": address,
    "status": status
  };
}


