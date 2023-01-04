import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

class GeeTextDropdown extends StatefulWidget {
  const GeeTextDropdown(
      {super.key,
      this.width = 270,
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
  String? currentValue;

  void onChanged(String? value) {
    setState(() {
      currentValue = value!;
    });
    widget.onChanged(value);
  }

  @override
  void initState() {
    currentValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: GeeColors.secondary3),
      ),
      width: widget.width,
      height: widget.heigth,
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
                height: widget.heigth - 10,
                child: Center(
                  child: Text(
                    value,
                    style: GeeTextStyles.heading5.copyWith(
                        color: value == "Empty"
                            ? GeeColors.gray6
                            : GeeColors.gray2),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
