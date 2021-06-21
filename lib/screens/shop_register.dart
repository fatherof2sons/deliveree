import 'dart:convert';
import 'dart:io';

import 'package:delivaree/model/data.dart';
import 'package:delivaree/model/lang_type.dart';
import 'package:delivaree/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShopRegisterPage extends StatefulWidget {
  @override
  _ShopRegisterPageState createState() => _ShopRegisterPageState();
}

class _ShopRegisterPageState extends State<ShopRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // All Input Controllers
  final TextEditingController _shopnameCtrl = TextEditingController();
  final TextEditingController _registerNumCtrl = TextEditingController();
  final TextEditingController _loginNumCtlr = TextEditingController();
  final TextEditingController _viberNumCtlr = TextEditingController();

  String? _selectedValue = "Select Type";
  Color? _iconColor = Colors.grey;
  Color? _iconInput = Colors.grey;

  File? _image;
  final _picker = ImagePicker();
  bool isSignup = true;
  bool isLanguage = true;

  String get _getShopName => _shopnameCtrl.text;
  String get _getRNumber => _registerNumCtrl.text;
  String get _getVNumber => _viberNumCtlr.text;

  /// Get the image from camera and save it to image variable
  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }

  /// Change between signup and signin
  void _twist() {
    setState(() {
      if (isSignup) {
        setState(() {
          isSignup = !isSignup;
        });
      } else {
        setState(() {
          isSignup = true;
        });
      }
    });
  }

  /// Change between english and dhivehi
  void _toggleLang() {
    if (isLanguage) {
      setState(() {
        isLanguage = !isLanguage;
      });
    } else {
      setState(() {
        isLanguage = true;
      });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() && _image != null) {
      List<int>? _imgBytes = _image!.readAsBytesSync();
      String? _readyImg = base64.encode(_imgBytes);

      final _newShop = Shop(
        name: _getShopName,
        photo: _readyImg,
        type: _selectedValue,
        phone: int.tryParse(_getRNumber),
        viber: int.tryParse(_getVNumber),
      );

      print(_newShop.toString());

      Data.shopData.add(_newShop);
      Data.shopData.length;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Processing Data! Please wait")));
    }

    _shopnameCtrl.clear();
    _registerNumCtrl.clear();
    _viberNumCtlr.clear();
    _selectedValue = "Select Type";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusNode _focus = FocusScope.of(context);

        if (!_focus.hasPrimaryFocus) {
          _focus.unfocus();
          if (_iconColor == Colors.deepOrange[900]) {
            setState(() {
              _iconColor = Colors.grey;
            });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isSignup ? "Create Shop" : "Login to Shop",
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: _toggleLang,
              child: Text(
                isLanguage ? "DHI" : "ENG",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Form(
                key: _formKey,
                child: isSignup ? _createPage() : _loginPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createPage() {
    final TextAlign _textAlign = isLanguage ? TextAlign.left : TextAlign.right;
    final _padding = EdgeInsets.all(18.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: _padding,
          // decoration: BoxDecoration(border: Border.all()),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            onTap: () {
              setState(() {
                _iconColor = Colors.deepOrange[900];
              });
            },
            validator: (value) {
              if (value!.isEmpty) return "Please Give A Shop Name";
              return null;
            },
            textAlign: _textAlign,
            controller: _shopnameCtrl,
            decoration: _decoration(
              hintText: isLanguage ? "Shop Name" : "ފިހާރައަށް ކިޔާނެ ނަމެށް",
              icon: Icons.shop,
            ),
          ),
        ),
        _dropDownList(_selectedValue!),
        SizedBox(height: 16.0),
        _imagepicker(isLanguage ? "Add Photo" : "ފޮޓޮއެއް ލުމަށް"),
        Padding(
          padding: _padding,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) return "Please Provide a Valid Mobile Number";
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            textAlign: _textAlign,
            controller: _registerNumCtrl,
            decoration: _decoration(
              hintText: isLanguage
                  ? "Register Number"
                  : "ރެޖިސްޓަރ ކުރާނެ މޯބައިލް ނަންބަރ",
              icon: Icons.app_registration,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) return "Please Provide a Valid Viber Number";
              return null;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            textAlign: _textAlign,
            controller: _viberNumCtlr,
            decoration: _decoration(
              hintText: isLanguage ? "Viber Number" : "ވައިބަރ ނަންބަރ",
              icon: Icons.phone_android_outlined,
            ),
          ),
        ),
        _submitBtn(
          text: isLanguage ? "Create Shop" : "ފިހާރަ ހެދުމަށް",
          onSubmit: _onSubmit,
          createOrLoginText: isLanguage
              ? "Already have a shop? Login instead!"
              : "ރަޖިސްޓަރ ކޮއްފަ ފިހާރައެއް މީގައި އެބައިންތަ؟ އެހެންނަމަ ލޮގިންވޭ",
          onPressed: _twist,
        ),
      ],
    );
  }

  Widget _loginPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextFormField(
            textAlign: isLanguage ? TextAlign.left : TextAlign.right,
            controller: _loginNumCtlr,
            decoration: _decoration(
              hintText: isLanguage
                  ? "Registered Number"
                  : "ރަޖިސްޓަރ ވެފައި އިން ނަންބަރ",
              icon: Icons.login_rounded,
              helperText: isLanguage
                  ? "Number that you gave on your Registeration"
                  : "ރަޖިސްޓަރ ވުމަށް ބޭނުންކުރި ނަންބަރ",
            ),
          ),
        ),
        _submitBtn(
          text: isLanguage ? "Send OTP" : "އޯޓީޕީ ފޮނުވާ",
          createOrLoginText: isLanguage
              ? "Go back to register shop!"
              : "ރަޖިސްޓަރ ކުރާ ބަޔަށް ދިއުމަށް",
          onPressed: _twist,
        ),
      ],
    );
  }

  Widget _submitBtn({
    String? text,
    void Function()? onPressed,
    void Function()? onSubmit,
    String? createOrLoginText,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.0),
        Row(
          children: [
            Card(
              elevation: 3.0,
              shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
              child: Container(
                // margin: const EdgeInsets.only(left: 80.0, top: 30.0),
                decoration: BoxDecoration(
                    color: Colors.deepOrange[900],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
                child: MaterialButton(
                  elevation: 5,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
                  onPressed: onSubmit,
                  child: Text(
                    text!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextButton(
              onPressed: onPressed,
              child: Text(
                createOrLoginText!,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              )),
        ),
      ],
    );
  }

  InputDecoration _decoration({
    String? labelText,
    String? hintText,
    IconData? icon,
    String? helperText,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.deepOrange[900]),
      filled: true,
      fillColor: Colors.black12,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: isLanguage ? 16.0 : 12.0),
      icon: Icon(
        icon,
        color: _iconColor,
      ),
      helperText: helperText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none),
    );
  }

  Widget _dropDownList(String typeValue) {
    return Padding(
      padding: EdgeInsets.only(left: 14.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.merge_type_rounded,
            color: _iconColor,
            size: 30.0,
          ),
          SizedBox(width: 14.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10.0)),
            child: DropdownButton(
              icon: Icon(
                Icons.expand_more_rounded,
              ),
              elevation: 4,
              items: _items(),
              hint: Text(
                typeValue,
                textAlign: isLanguage ? TextAlign.left : TextAlign.right,
                style: TextStyle(fontSize: isLanguage ? 16.0 : 14.0),
              ),
              onChanged: (String? v) {
                setState(() {
                  _selectedValue = v!;
                });
                print(_selectedValue);
              },
              onTap: () {
                setState(() {
                  _iconColor = Colors.blue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Dropdown item List
  List<DropdownMenuItem<String>> _items() {
    final List<List<String>> list = [
      ["Food & Drinks", "ކާބޯ ތަކެތި"],
      ["Grocery Items", "މާރޓް"],
      ["Electronic Items", "ކަރަންޓުގެ ސާމާނު"],
      ["Gaming", "ގޭމު"],
    ];

    return list
        .map((List<String> e) => DropdownMenuItem(
              child: Text(isLanguage ? "${e[0]}" : "${e[1]}"),
              value: isLanguage ? "${e[0]}" : "${e[1]}",
            ))
        .toList();
  }

  Row _imagepicker(String? photo) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 14.0),
          child: Icon(
            Icons.image,
            color: _iconColor,
            size: 28.0,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(10.0)),
          child: GestureDetector(
            onTap: getImage,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Text(
                photo!,
                style: TextStyle(
                    fontSize: isLanguage ? 16.0 : 12.0, color: Colors.black54),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.0),
        _image == null
            ? SizedBox(height: 60.0, width: 60.0, child: Placeholder())
            : Card(
                color: Colors.black87,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Image.file(
                  _image!,
                  height: 60.0,
                  fit: BoxFit.fill,
                ),
              ),
      ],
    );
  }
}
