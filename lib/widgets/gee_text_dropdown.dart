import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

class GeeTextDropdown extends StatefulWidget {
  const GeeTextDropdown(
      {super.key,
      this.width = 180,
      this.heigth = 40,
      required this.items,
      required this.initialValue,
      required this.onChanged});

  final double width;
  final double heigth;
  final List<String> items;
  final String initialValue;
  final Function onChanged;

  @override
  State<GeeTextDropdown> createState() => _GeeTextDropdown();
}

class _GeeTextDropdown extends State<GeeTextDropdown> {
  double get width => widget.width;
  double get heigth => widget.heigth;
  String get initialValue => widget.initialValue;
  String currentValue = "Empty";

  void onChanged(String? value) {
    setState(() {
      currentValue = value!;
    });
    widget.onChanged(value);
  }

  @override
  void initState() {
    currentValue = initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: currentValue,
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          style: GeeTextStyles.paragraph3.copyWith(color: GeeColors.gray1),
          onChanged: onChanged,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                height: heigth - 10,
                child: Text(value,
                    style: GeeTextStyles.heading5
                        .copyWith(color: GeeColors.gray2)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
