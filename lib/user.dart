import 'package:chatsapp/resusable_widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'home.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String initialCountry = '';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  moveToChatPage(BuildContext context) {
    if (_form.currentState!.validate()) {
      setState(() {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const Home()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       backgroundColor: Color(0xFFFFE81D),
        title: Text('Chats Box', style: TextStyle(
          fontFamily: 'Caros',
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: CustomColor.multiColors,
        ),
        child: Form(
          key: _form,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Connect\nfriends\neasily &\nquickly', style:
                      TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Caros',
                      ),
                        textAlign: TextAlign.left,
                      ),
                      Text('Our chat app is the perfect way to stay\nconnected with friens and family', style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontFamily: 'Caros',
                      ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text('Sign in with Phone Number', style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          this.number = number;
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        initialValue: number,
                        textFieldController: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        formatInput: false,
                        inputDecoration: const InputDecoration(
                            hintText: 'phone number',
                          hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                           return 'Phone number cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      PinCodeTextField(
                        controller: pinCodeController,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(4),
                          fieldHeight: 52,
                          fieldWidth: 51,
                          activeFillColor: Colors.transparent,
                          activeColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          errorBorderColor: Colors.red,
                          borderWidth: 0.2,
                        ),
                        backgroundColor: Colors.transparent,
                        appContext: context,
                        length: 6,
                        autoFocus: true,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        cursorColor: Colors.grey, onChanged: (String value) {  },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
              ),
            SizedBox(
             height: 20,
            ),
            SizedBox(
              height: 48,
              width: 327,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFE81D)
                ),
                  onPressed: (){
                   moveToChatPage(context);
                    //_signInWithPhoneNumber();
                  },
                  child: Text('Sign in', style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ))),
            )
            ],
          ),
        ),
      ),
    );
  }
}
