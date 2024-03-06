import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController goodsTypeController = TextEditingController();
  TextEditingController goodsValueController = TextEditingController();
  TextEditingController numberOfLabourController = TextEditingController();
  TextEditingController goodsWeightController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverEmailController = TextEditingController();
  TextEditingController receiverMobileNoController = TextEditingController();
  TextEditingController receiverRefrenceNumberController =
      TextEditingController();
  TextEditingController receiverLocationController = TextEditingController();
  TextEditingController receiverPanNoController = TextEditingController();
  TextEditingController receiverGstNoController = TextEditingController();
  TextEditingController shipperNameController = TextEditingController();
  TextEditingController shipperemailController = TextEditingController();
  TextEditingController shipperMobileNoController = TextEditingController();
  TextEditingController shipperpanNOController = TextEditingController();
  TextEditingController shipperGstNoController = TextEditingController();

  String selectedOption = 'DOCTOR';

  List<String> lists = [
    'DOCTOR',
    'ENGINEER',
    'DEVELOPER',
    'SOCIALWORK',
    'BUISSINESS',
    'OTHER'
  ];
}
