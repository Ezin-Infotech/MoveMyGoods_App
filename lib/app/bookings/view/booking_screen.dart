import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../utils/common widgets/custom_text.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  BookingProvider? bookingProvider;

  @override
  void initState() {
    super.initState();
    bookingProvider = context.read<BookingProvider?>();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      padding: 0,
      children: Column(
        children: [
          SizedBox(
            height: Responsive.height * 30,
            child: MapPicker(
              iconWidget: const Icon(
                Icons.location_on,
                size: 50,
                color: Colors.red,
              ),
              mapPickerController: bookingProvider!.mapPickerController,
              child: Consumer<BookingProvider>(
                builder: (ctx, obj, _) {
                  return GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapType: MapType.hybrid,
                    initialCameraPosition: obj.cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      obj.controller.complete(controller);
                    },
                    onCameraMoveStarted: () {
                      obj.mapPickerController.mapMoving!();
                    },
                    onCameraMove: (cameraPosition) {
                      obj.cameraPosition = cameraPosition;
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.height * 2),
                const CustomText(
                  text: 'Source *',
                ),
                const SizeBoxH(8),
                SizedBox(
                  height: Responsive.height * 6,
                  child: DropDownSearchField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return items.where((item) {
                        return item.toLowerCase().contains(
                              pattern.toLowerCase(),
                            );
                      }).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        leading: const Icon(Icons.shopping_cart),
                        title: Text(suggestion),
                        // subtitle: Text('\$${suggestion['price']}'),
                      );
                    },
                    onSuggestionSelected: (suggestion) {},
                    displayAllSuggestionWhenTap: true,
                  ),
                ),
                BookingTextFieldWidgets(
                  hintText: 'Mysore, Karnataka',
                  controller: bookingProvider?.destinationController,
                  labeText: 'Destination *',
                ),
                const SizeBoxH(10),
                const CustomText(
                  text: 'Goods Type *',
                ),
                const SizeBoxH(8),
                const DropdownInsideTextFormField(),
                BookingTextFieldWidgets(
                  hintText: '300',
                  controller: bookingProvider?.goodsValueController,
                  labeText: 'Goods Value *',
                  keyboardType: TextInputType.number,
                ),
                BookingTextFieldWidgets(
                  hintText: '6',
                  controller: bookingProvider?.numberOfLabourController,
                  labeText: 'Number of Labours *',
                  keyboardType: TextInputType.number,
                ),
                const SizeBoxH(10),
                const CustomText(
                  text: 'Goods Weight *',
                ),
                const SizeBoxH(8),
                const DropdownInsideTextFormField(),
                const SizeBoxH(8),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      boxShadow: [
                        BoxShadow(
                          color:
                              AppColors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 8, // Blur radius
                          // offset: const Offset(0, 3),
                        ),
                        BoxShadow(
                          color:
                              AppColors.grey.withOpacity(0.8), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 2, // Blur radius
                          // offset: const Offset(0, 3),
                        ),
                        BoxShadow(
                          color:
                              AppColors.grey.withOpacity(0.7), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 1, // Blur radius
                          // offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(width: 1, color: const Color(0xffDBDBDB))),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const MyToggleIconButton(),
                              Text(
                                'Upto 750kg  ₹ 312.5',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                Image.asset(
                  AppImages.smallvehicleImage,
                  width: Responsive.width * 216,
                  height: Responsive.height * 16,
                ),

                SizeBoxH(Responsive.height * 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total Amount:394/-',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: const Color(0xff0D9F00)),
                    ),
                    SizeBoxV(Responsive.width * 25),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 28,
                    )
                  ],
                ),
                SizeBoxH(Responsive.height * 0.7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '*The price is an indicative and actual pricemay vary ',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xffF90000)),
                    ),
                  ],
                ),
                SizeBoxH(Responsive.height * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidgets(
                      buttonText: 'Continue',
                      onPressed: () {
                        // context.push(const LoginScreen());
                      },
                    ),
                  ],
                ),
                SizeBoxH(Responsive.height * 4),
                Text(
                  '*Receiver Details',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xff222222)),
                ),
                BookingTextFieldWidgets(
                  hintText: 'Name',
                  controller: bookingProvider?.receiverNameController,
                  labeText: 'Name',
                ),
                BookingTextFieldWidgets(
                  hintText: 'Email',
                  controller: bookingProvider?.receiverEmailController,
                  labeText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                BookingTextFieldWidgets(
                  hintText: 'Number',
                  controller: bookingProvider?.receiverMobileNoController,
                  labeText: 'Mobile No.',
                  keyboardType: TextInputType.phone,
                ),
                const SizeBoxH(10),
                const CustomText(
                  text: 'Reference Numbers',
                ),
                const SizeBoxH(8),
                const DropdownInsideTextFormField(),

                const SizeBoxH(10),
                const CustomText(
                  text: 'Location',
                ),
                const SizeBoxH(8),
                const DropdownInsideTextFormField(),
                BookingTextFieldWidgets(
                  hintText: '(eg.DUMPA1234)',
                  controller: bookingProvider?.receiverPanNoController,
                  labeText: 'PAN No.',
                ),
                BookingTextFieldWidgets(
                  hintText: '(eg.GHXXXXXXXX000)',
                  controller: bookingProvider?.receiverGstNoController,
                  labeText: 'GST No.',
                ),
                SizeBoxH(Responsive.height * 2),
                Text(
                  '*Shipper Details',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: const Color(0xff222222)),
                ),
                // SizeBoxH(Responsive.height * 1),
                BookingTextFieldWidgets(
                  hintText: 'Name',
                  controller: bookingProvider?.shipperNameController,
                  labeText: 'Name',
                ),
                BookingTextFieldWidgets(
                  hintText: 'Email',
                  controller: bookingProvider?.shipperemailController,
                  labeText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                BookingTextFieldWidgets(
                  hintText: 'Number',
                  controller: bookingProvider?.shipperMobileNoController,
                  labeText: 'Mobile No.',
                  keyboardType: TextInputType.phone,
                ),

                BookingTextFieldWidgets(
                  hintText: '(eg.DUMPA1234)',
                  controller: bookingProvider?.shipperpanNOController,
                  labeText: 'PAN No.',
                ),
                BookingTextFieldWidgets(
                  hintText: '(eg.GHXXXXXXXX000)',
                  controller: bookingProvider?.shipperGstNoController,
                  labeText: 'GST No.',
                ),
                SizeBoxH(Responsive.height * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidgets(
                      buttonText: 'Proceed to Pay',
                      onPressed: () {
                        // context.push(const LoginScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> items = ['Item 1', 'Item 2', 'Item 3'];
