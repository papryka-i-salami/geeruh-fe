import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

enum Priority {
  top,
  high,
  medium,
  low,
}

final Map<Priority, Image> priorityImages = {
  Priority.top: Image.asset('images/PriorityTop.png'),
  Priority.high: Image.asset('images/PriorityHigh.png'),
  Priority.medium: Image.asset('images/PriorityMedium.png'),
  Priority.low: Image.asset('images/PriorityLow.png'),
};
final Map<Priority, String> _priorityName = {
  Priority.top: 'Top',
  Priority.high: 'High',
  Priority.medium: 'Medium',
  Priority.low: 'Low',
};

class GeePriorityDropdown extends StatefulWidget {
  const GeePriorityDropdown({super.key, this.width = 180, this.heigth = 40});

  final double width;
  final double heigth;

  @override
  State<GeePriorityDropdown> createState() => _PriorityDropdown();
}

class _PriorityDropdown extends State<GeePriorityDropdown> {
  double get width => widget.width;
  double get heigth => widget.heigth;
  Priority currentValue = Priority.medium;

  void onChanged(Priority? value) {
    setState(() {
      currentValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Priority>(
          isExpanded: true,
          value: currentValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.transparent,
          ),
          style: GeeTextStyles.paragraph3.copyWith(color: GeeColors.gray1),
          onChanged: onChanged,
          items: Priority.values
              .toList()
              .map<DropdownMenuItem<Priority>>((Priority value) {
            return DropdownMenuItem<Priority>(
              value: value,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: heigth - 10,
                    height: heigth - 10,
                    child: priorityImages[value],
                  ),
                  const SizedBox(width: 10),
                  Text(_priorityName[value] ?? ""),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
