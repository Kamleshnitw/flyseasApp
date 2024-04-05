import 'dart:convert';

AddressListResponse addressListResponseFromJson(String str) => AddressListResponse.fromJson(json.decode(str));

String addressListResponseToJson(AddressListResponse data) => json.encode(data.toJson());

class AddressListResponse {
  AddressListResponse({
    required this.addresses,
  });

  List<Address> addresses;

  factory AddressListResponse.fromJson(Map<String, dynamic> json) => AddressListResponse(
    addresses: List<Address>.from(json["address_list"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "address_list": List<dynamic>.from(addresses.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    required this.id,
    //required this.userId,
    //required this.name,
    required this.country,
    //required this.state,
    //required this.city,
    required this.pincode,
    required this.stateName,
    required this.cityName,
    //required this.phone,
    required this.address,
    //required this.addressType,
    required this.isSelected,
  });

  int id;
  //int userId;
  //String name;
  String country;
  //StateData state;
  //City city;
  String pincode;
  String stateName;
  String cityName;
  //String phone;
  String address;
  //String addressType;
  bool isSelected;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    //userId: json["user_id"],
    //name: json["name"],
    country: json["country"],
    //state: StateData.fromJson(json["state"]),
    //city: City.fromJson(json["city"]),
    pincode: json["pincode"],
    stateName: json["state"],
    cityName: json["city"],
    //phone: json["phone"].toString(),
    address: json["address"],
    //addressType: json["address_type"],
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    //"user_id": userId,
    //"name": name,
    "country": country,
    //"state": state.toJson(),
    //"city": city.toJson(),
    "pincode": pincode,
    "state": stateName,
    "city": cityName,
    //"phone": phone,
    "address": address,
    //"address_type": addressType,
    "is_selected": isSelected,
  };
}

