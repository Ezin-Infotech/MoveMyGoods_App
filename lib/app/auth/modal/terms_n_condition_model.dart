import 'dart:convert';

GetTermsNConditionModel getTermsNConditionModelFromJson(String str) =>
    GetTermsNConditionModel.fromJson(json.decode(str));

class GetTermsNConditionModel {
  String? status;
  TermsNConditionData? data;

  GetTermsNConditionModel({
    this.status,
    this.data,
  });

  factory GetTermsNConditionModel.fromJson(Map<String, dynamic> json) =>
      GetTermsNConditionModel(
        status: json["status"],
        data: TermsNConditionData.fromJson(json["data"]),
      );
}

class TermsNConditionData {
  num? totalSize;
  List<TermsNConditionList>? list;

  TermsNConditionData({
    this.totalSize,
    this.list,
  });

  factory TermsNConditionData.fromJson(Map<String, dynamic> json) =>
      TermsNConditionData(
        totalSize: json["totalSize"],
        list: List<TermsNConditionList>.from(
            json["list"].map((x) => TermsNConditionList.fromJson(x))),
      );
}

class TermsNConditionList {
  String? uuid;
  num? roleId;
  String? name;
  String? version;
  String? termsAndConditions;
  bool? isActive;
  num? createdDate;
  num? modifiedDate;
  String? comments;
  String? role;

  TermsNConditionList({
    this.uuid,
    this.roleId,
    this.name,
    this.version,
    this.termsAndConditions,
    this.isActive,
    this.createdDate,
    this.modifiedDate,
    this.comments,
    this.role,
  });

  factory TermsNConditionList.fromJson(Map<String, dynamic> json) =>
      TermsNConditionList(
        uuid: json["uuid"],
        roleId: json["roleId"],
        name: json["name"],
        version: json["version"],
        termsAndConditions: json["termsAndConditions"],
        isActive: json["isActive"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        comments: json["comments"],
        role: json["role"],
      );
}
