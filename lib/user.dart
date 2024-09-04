import 'package:chatsapp/resusable_widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String initialCountry = '';
  PhoneNumber number = PhoneNumber(isoCode: '');
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100, left: 20, right: 20),
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
                      height: 50,
                    ),
                    Text('Sign in with Phone Number', style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    IntlPhoneField(
                      //focusNode: focusNode,
                      //dropdownIconPosition: IconPosition.trailing,
                      decoration: const InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'phone number'
                      ),
                      initialCountryCode: '',
                      showCountryFlag: false,
                      languageCode: 'en',
                      autofocus: false,
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ],
                ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: InternationalPhoneNumberInput(
            //     onInputChanged: (PhoneNumber number) {
            //       print(number.phoneNumber);
            //     },
            //     onInputValidated: (bool value) {
            //       print(value);
            //     },
            //     selectorConfig: SelectorConfig(
            //       selectorType: PhoneInputSelectorType.DROPDOWN,
            //       useBottomSheetSafeArea: true,
            //     ),
            //     ignoreBlank: false,
            //     autoValidateMode: AutovalidateMode.disabled,
            //     selectorTextStyle: TextStyle(
            //       color: Colors.black54,
            //     ),
            //     initialValue: number,
            //     //textFieldController: controller,
            //     formatInput: true,
            //     keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            //   ),
            // ),
          SizedBox(
           height: 40,
          ),
          SizedBox(
            height: 48,
            width: 327,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFE81D)
              ),
                onPressed: (){

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
    );
  }
}
