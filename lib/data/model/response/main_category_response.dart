import 'dart:convert';

MainCategoryListResponse mainCategoryListResponseFromJson(String str) => MainCategoryListResponse.fromJson(json.decode(str));

String mainCategoryListResponseToJson(MainCategoryListResponse data) => json.encode(data.toJson());

class MainCategoryListResponse {
  MainCategoryListResponse({
    required this.success,
    required this.mainCategory,
  });

  bool success;
  List<MainCategory> mainCategory;

  factory MainCategoryListResponse.fromJson(Map<String, dynamic> json) => MainCategoryListResponse(
    success: json["success"],
    mainCategory: List<MainCategory>.from(json["main_category"].map((x) => MainCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "main_category": List<dynamic>.from(mainCategory.map((x) => x.toJson())),
  };
}

class MainCategory {
  MainCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.isSelected,
  });

  int id;
  String name;
  String icon;
  String description;
  bool isSelected;

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    isSelected: json["is_selected"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "is_selected": isSelected,
  };
}
