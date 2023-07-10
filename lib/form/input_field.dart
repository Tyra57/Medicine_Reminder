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
  TextEditingController dosageController = TextEditingController();

  @override
  void dispose() {
    dosageController.dispose();
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
                crossAxisCount: 3, // Number of columns
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
                    child:
                        (widget.title == 'Amount' || widget.title == 'Dosage')
                            ? Stack(
                                children: [
                                  TextFormField(
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
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0,
                                        ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0,
                                        ),
                                      ),
                                    ),
                                    controller: widget.controller,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a value';
                                      }
                                      final numericValue = num.tryParse(value);
                                      if (numericValue == null) {
                                        return 'Please enter a valid number';
                                      }
                                      return null;
                                    },
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: DropdownButton<String>(
                                        value: selectedDosageUnit,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedDosageUnit = newValue!;
                                          });
                                        },
                                        items: dosageUnits
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : TextFormField(
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
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                  ),
                                ),
                                controller: widget.controller,
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
