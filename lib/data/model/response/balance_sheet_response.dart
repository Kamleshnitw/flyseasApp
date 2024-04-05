import 'dart:convert';

BalanceSheetResponse balanceSheetResponseFromJson(String str) => BalanceSheetResponse.fromJson(json.decode(str));

String balanceSheetResponseToJson(BalanceSheetResponse data) => json.encode(data.toJson());

class BalanceSheetResponse {
  BalanceSheetResponse({
    required this.success,
    required this.amount,
    required this.walletHistory,
  });

  bool success;
  String amount;
  List<WalletHistory> walletHistory;

  factory BalanceSheetResponse.fromJson(Map<String, dynamic> json) => BalanceSheetResponse(
    success: json["success"],
    amount: json["amount"],
    walletHistory: List<WalletHistory>.from(json["wallet_history"].map((x) => WalletHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "amount": amount,
    "wallet_history": List<dynamic>.from(walletHistory.map((x) => x.toJson())),
  };
}

class WalletHistory {
  WalletHistory({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.date,
  });

  int id;
  int userId;
  String type;
  String amount;
  String date;

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    amount: json["amount"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "amount": amount,
    "date": date,
  };
}
