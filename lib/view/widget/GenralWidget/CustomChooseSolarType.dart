import 'package:flutter/material.dart';

class CustomChooseSolartype extends StatefulWidget {
  const CustomChooseSolartype({super.key});

  @override
  State<CustomChooseSolartype> createState() => _CustomChooseSolartypeState();
}

class _CustomChooseSolartypeState extends State<CustomChooseSolartype> {
  String? _selectedCellType = 'Monocrystalline';
  final TextEditingController _consumptionController = TextEditingController();

  // قائمة بأنواع الخلايا الشمسية
  final List<String> _solarCellTypes = [
    'Monocrystalline',
    'Polycrystalline',
    'Thin Film',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E4E30), // خلفية الحقل
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCellType,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          dropdownColor: const Color(0xFF2E4E30),
          style: const TextStyle(fontSize: 16),

          onChanged: (String? newValue) {
            setState(() {
              _selectedCellType = newValue;
            });
          },

          items: _solarCellTypes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
