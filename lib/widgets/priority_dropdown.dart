import 'package:flutter/material.dart';
import 'package:geeruh/theme.dart';

final List<String> priorityLevel = <String>['Low', 'Medium', 'High', 'Top'];
final List<Image> priorityImages = <Image>[
  Image.asset('images/PriorityLow.png'),
  Image.asset('images/PriorityMedium.png'),
  Image.asset('images/PriorityHigh.png'),
  Image.asset('images/PriorityTop.png'),
];

String? currentValue = priorityLevel[0];

class PriorityDropdown extends StatefulWidget {
  const PriorityDropdown({super.key, this.width = 150, this.heigth = 40});

  final double width;
  final double heigth;

  @override
  State<PriorityDropdown> createState() => _PriorityDropdown();
}

class _PriorityDropdown extends State<PriorityDropdown> {
  double get width => widget.width;
  double get heigth => widget.heigth;

  void onChanged(String? value) {
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
        child: DropdownButton<String>(
          isExpanded: true,
          value: currentValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.transparent,
          ),
          style: GeeTextStyles.paragraph3,
          onChanged: onChanged,
          items: priorityLevel.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: heigth - 10,
                    height: heigth - 10,
                    child: priorityImages[priorityLevel.indexOf(value)],
                  ),
                  const SizedBox(width: 10),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
