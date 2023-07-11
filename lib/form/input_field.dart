import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// THIS PAGE IS DONE BY WANI AND FUNCTIONING AS THE MAIN DECORATION FOR TEXTFIELD MEDICATION FORM

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool isImageField;
  final TextInputType inputType;
  

  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.isImageField = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? selectedImage;
  final List<String> dosageUnits = ['mg', 'ml', 'g', 'oz', 'mcg'];
  String selectedDosageUnit = 'mg';
  final TextEditingController _dosageController = TextEditingController();

  @override
  void dispose() {
    _dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (widget.isImageField)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildImageField('assets/tablets.png', 'Tablets'),
                  _buildImageField('assets/dropper.png', 'Drops'),
                  _buildImageField('assets/cream.png', 'Cream'),
                  _buildImageField('assets/pills.png', 'Capsule'),
                  _buildImageField('assets/suppository.png', 'Suppository'),
                  _buildImageField('assets/syrup.png', 'Syrup'),
                ],
              ),
            ),
          if (!widget.isImageField)
            Container(
              height: 52,
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.only(left: 14.0, bottom: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      cursorColor: Colors.red[400],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                      ),
                      controller: widget.controller,
                      inputFormatters: [
                       if (widget.title == 'Amount' ||
                            widget.title == 'Dosage')
                           FilteringTextInputFormatter.allow(
                              RegExp(r'^[\d.,]+$')),
                      ],
                      keyboardType: widget.title == 'Amount' ||  widget.title == 'Dosage'
                          ? TextInputType.number
                          : TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageField(String imagePath, String labelText) {
    final isSelected = selectedImage == imagePath;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = isSelected ? null : imagePath;
        });
      },
      child: Material(
        color: isSelected ? const Color(0xFFEF5350) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFFEF5350) : Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                ),
              ),
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
