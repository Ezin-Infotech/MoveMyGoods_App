import 'package:flutter/material.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';

import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/material/dropdown.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    return CommonScaffold(
        children: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MapScreen()
        const CustomText(
          text: 'Source *',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: 'mysore,karnadaka',
          keyboardType: TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
        ),
        const SizeBoxH(10),
        const CustomText(
          text: 'Source *',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: 'mysore,karnadaka',
          keyboardType: TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
        ),
        const SizeBoxH(10),
        const CustomText(
          text: 'Destination *',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: 'mysore,karnadaka',
          keyboardType: TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
        ),
        const SizeBoxH(10),
        const CustomText(
          text: 'Goods Type *',
        ),
        const SizeBoxH(8),
        const DropdownInsideTextFormField(),
        const SizeBoxH(10),
        const CustomText(
          text: 'Goods Value *',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: 'mysore,karnadaka',
          keyboardType: TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
        ),
        const SizeBoxH(10),
        const CustomText(
          text: 'Number of Labours *',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: 'mysore,karnadaka',
          keyboardType: TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
        ),
        const SizeBoxH(10),
        const CustomText(
          text: 'Goods Weight *',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: 'mysore,karnadaka',
          keyboardType: TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
        ),
        const SizeBoxH(8),
      ],
    ));
  }
}

class CustomText extends StatelessWidget {
  final String? text;
  const CustomText({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: context.textTheme.displaySmall!.copyWith(
          color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w500),
    );
  }
}

class DropdownInsideTextFormField extends StatefulWidget {
  const DropdownInsideTextFormField({super.key});

  @override
  _DropdownInsideTextFormFieldState createState() =>
      _DropdownInsideTextFormFieldState();
}

class _DropdownInsideTextFormFieldState
    extends State<DropdownInsideTextFormField> {
  String selectedOption = '';
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(4)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(4)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffDBDBDB), width: 1),
            borderRadius: BorderRadius.circular(4)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffDBDBDB), width: 1),
            borderRadius: BorderRadius.circular(4)),
      ),
      value: selectedValue,
      hint: const Text('Select Item'),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please select an item';
        }
        return null; // means valid
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class WeightWidgets extends StatelessWidget {
  final String? text;

  const WeightWidgets({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: [
            const MyToggleIconButton(),
            Text(
              text ?? 'Upto 750kg  ₹ 312.5',
              style: context.textTheme.bodyMedium!.copyWith(),
            ),
          ],
        );
      },
    );
  }
}

List<String> items = ['Item 1', 'Item 2', 'Item 3'];

class MyToggleIconButton extends StatefulWidget {
  const MyToggleIconButton({super.key});

  @override
  _MyToggleIconButtonState createState() => _MyToggleIconButtonState();
}

class _MyToggleIconButtonState extends State<MyToggleIconButton> {
  bool isToggled = false; // Initial state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggle Icon Example'),
      ),
      body: Center(
        child: IconButton(
          icon: isToggled
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            setState(() {
              isToggled = !isToggled;
            });
          },
        ),
      ),
    );
  }
}
