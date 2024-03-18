// import 'dart:convert';

// ProfileDataModel profileDataModelFromJson(String str) =>
//     ProfileDataModel.fromJson(json.decode(str));

// class ProfileDataModel {
//   String? status;
//   ProfileDetails? data;

//   ProfileDataModel({
//     this.status,
//     this.data,
//   });

//   factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
//       ProfileDataModel(
//         status: json["status"],
//         data: ProfileDetails.fromJson(json["data"]),
//       );
// }

// class ProfileDetails {
//   String? id;
//   String? firstName;
//   String? lastName;
//   String? mobileNumber;
//   String? alternativeNumber;
//   String? emailId;
//   num? defaultRoleId;
//   num? genderId;
//   num? dob;
//   num? aadharNumber;
//   String? panNumber;

//   String? profileSource;
//   List<Address>? address;
//   List<BankAccount>? bankAccount;
//   Customer? customer;
//   bool? isActive;
//   String? appTokenId;
//   String? webTokenId;

//   ProfileDetails({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.mobileNumber,
//     this.alternativeNumber,
//     this.emailId,
//     this.defaultRoleId,
//     this.genderId,
//     this.dob,
//     this.aadharNumber,
//     this.panNumber,
//     this.profileSource,
//     this.address,
//     this.bankAccount,
//     this.customer,
//     this.isActive,
//     this.appTokenId,
//     this.webTokenId,
//   });

//   factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
//         id: json["id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         mobileNumber: json["mobileNumber"],
//         alternativeNumber: json["alternativeNumber"],
//         emailId: json["emailId"],
//         defaultRoleId: json["defaultRoleId"],
//         genderId: json["genderId"],
//         dob: json["dob"],
//         aadharNumber: json["aadharNumber"],
//         panNumber: json["panNumber"],
//         profileSource: json["profileSource"],
//         address:
//             List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
//         bankAccount: List<BankAccount>.from(
//             json["bankAccount"].map((x) => BankAccount.fromJson(x))),
//         customer: Customer.fromJson(json["customer"]),
//         isActive: json["isActive"],
//         appTokenId: json["appTokenId"],
//         webTokenId: json["webTokenId"],
//       );
// }

// class Address {
//   String? uuid;
//   num? roleId;
//   String? address1;
//   String? address2;
//   String? landmark;
//   num? countryId;
//   num? stateId;
//   num? cityId;
//   String? type;
//   bool? isActive;
//   String? cityName;
//   String? stateName;
//   String? countryName;
//   dynamic pincode;
//   Address({
//     this.uuid,
//     this.roleId,
//     this.address1,
//     this.address2,
//     this.landmark,
//     this.countryId,
//     this.stateId,
//     this.cityId,
//     this.type,
//     this.isActive,
//     this.cityName,
//     this.stateName,
//     this.countryName,
//     this.pincode,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         uuid: json["uuid"],
//         roleId: json["roleId"],
//         address1: json["address1"],
//         address2: json["address2"],
//         landmark: json["landmark"],
//         countryId: json["countryId"],
//         stateId: json["stateId"],
//         cityId: json["cityId"],
//         pincode: json["pincode"],
//         type: json["type"],
//         isActive: json["isActive"],
//         cityName: json["cityName"],
//         stateName: json["stateName"],
//         countryName: json["countryName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "uuid": uuid,
//         "roleId": roleId,
//         "address1": address1,
//         "address2": address2,
//         "landmark": landmark,
//         "countryId": countryId,
//         "stateId": stateId,
//         "cityId": cityId,
//         "type": type,
//         "isActive": isActive,
//         "cityName": cityName,
//         "stateName": stateName,
//         "countryName": countryName,
//       };
// }

// class BankAccount {
//   String? uuid;
//   num? accountNumber;
//   num? bankId;
//   String? ifscCode;
//   String? branchName;
//   bool? status;
//   String? bankName;

//   BankAccount({
//     this.uuid,
//     this.accountNumber,
//     this.bankId,
//     this.ifscCode,
//     this.branchName,
//     this.status,
//     this.bankName,
//   });

//   factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
//         uuid: json["uuid"],
//         accountNumber: json["accountNumber"],
//         bankId: json["bankId"],
//         ifscCode: json["ifscCode"],
//         branchName: json["branchName"],
//         status: json["status"],
//         bankName: json["bankName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "uuid": uuid,
//         "accountNumber": accountNumber,
//         "bankId": bankId,
//         "ifscCode": ifscCode,
//         "branchName": branchName,
//         "status": status,
//         "bankName": bankName,
//       };
// }

// class Customer {
//   String? customerId;
//   bool? isTermsAndCondition;
//   String? termsAndConditionsId;
//   num? customerTypeId;
//   String? customerTypeName;

//   Customer({
//     this.customerId,
//     this.isTermsAndCondition,
//     this.termsAndConditionsId,
//     this.customerTypeId,
//     this.customerTypeName,
//   });

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         customerId: json["customerId"],
//         isTermsAndCondition: json["isTermsAndCondition"],
//         termsAndConditionsId: json["termsAndConditionsId"],
//         customerTypeId: json["customerTypeId"],
//         customerTypeName: json["customerTypeName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "customerId": customerId,
//         "isTermsAndCondition": isTermsAndCondition,
//         "termsAndConditionsId": termsAndConditionsId,
//         "customerTypeId": customerTypeId,
//         "customerTypeName": customerTypeName,
//       };
// }

// To parse this JSON data, do
//
//     final profileDataModel = profileDataModelFromJson(jsonString);

import 'dart:convert';

ProfileDataModel profileDataModelFromJson(String str) =>
    ProfileDataModel.fromJson(json.decode(str));

class ProfileDataModel {
  String? status;
  ProfileDetails? data;

  ProfileDataModel({
    this.status,
    this.data,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        status: json["status"],
        data: ProfileDetails.fromJson(json["data"]),
      );
}

class ProfileDetails {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? alternativeNumber;
  String? emailId;
  num? defaultRoleId;
  num? genderId;
  num? dob;
  String? profileSource;
  List<Address>? address;
  Customer? customer;
  bool? isActive;
  String? appTokenId;

  ProfileDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.alternativeNumber,
    this.emailId,
    this.defaultRoleId,
    this.genderId,
    this.dob,
    this.profileSource,
    this.address,
    this.customer,
    this.isActive,
    this.appTokenId,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNumber: json["mobileNumber"],
        alternativeNumber: json["alternativeNumber"],
        emailId: json["emailId"],
        defaultRoleId: json["defaultRoleId"],
        genderId: json["genderId"],
        dob: json["dob"],
        profileSource: json["profileSource"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        customer: Customer.fromJson(json["customer"]),
        isActive: json["isActive"],
        appTokenId: json["appTokenId"],
      );
}

class Address {
  String? uuid;
  num? roleId;
  String? address1;
  String? address2;
  String? landmark;
  num? countryId;
  num? stateId;
  num? cityId;
  num? pincode;
  String? type;
  bool? isActive;
  String? cityName;
  String? stateName;
  String? countryName;

  Address({
    this.uuid,
    this.roleId,
    this.address1,
    this.address2,
    this.landmark,
    this.countryId,
    this.stateId,
    this.cityId,
    this.pincode,
    this.type,
    this.isActive,
    this.cityName,
    this.stateName,
    this.countryName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        uuid: json["uuid"],
        roleId: json["roleId"],
        address1: json["address1"],
        address2: json["address2"],
        landmark: json["landmark"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        cityId: json["cityId"],
        pincode: json["pincode"],
        type: json["type"],
        isActive: json["isActive"],
        cityName: json["cityName"],
        stateName: json["stateName"],
        countryName: json["countryName"],
      );
}

class Customer {
  String? customerId;
  bool? isTermsAndCondition;
  String? termsAndConditionsId;
  num? customerTypeId;
  String? customerTypeName;

  Customer({
    this.customerId,
    this.isTermsAndCondition,
    this.termsAndConditionsId,
    this.customerTypeId,
    this.customerTypeName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customerId"],
        isTermsAndCondition: json["isTermsAndCondition"],
        termsAndConditionsId: json["termsAndConditionsId"],
        customerTypeId: json["customerTypeId"],
        customerTypeName: json["customerTypeName"],
      );
}
