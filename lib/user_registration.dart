import 'package:chatsapp/resusable_widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart';

class UserRegistration extends StatefulWidget {
  final String phoneNumber;
  const UserRegistration({super.key, required this.phoneNumber});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String initialCountry = '';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final GlobalKey<FormState> _firstForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondForm = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  Future<void> _sendOtp() async {
    final phoneNumber = number.phoneNumber;
    print('$phoneNumber');
    if(!_firstForm.currentState!.validate()) return;

    try {
      final response = await Supabase.instance.client.auth.signInWithOtp(
        phone: phoneNumber,
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'),)
      );
    }
  }

  Future<void> _verifyUserAndSignIn() async {
    if (!_secondForm.currentState!.validate()) return;
    try {
      final response = await Supabase.instance.client.auth.verifyOTP(
          phone:  number.phoneNumber,
          token:  pinCodeController.text,
          type: OtpType.sms);

        if (response.session != null) {
        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          final profileResponse = await Supabase.instance.client
              .from('profiles')
              .upsert({
            'user_id': user.id,
            'created_at': user.createdAt,
            'phone_number': number.phoneNumber,
            'display_name': displayNameController.text.isNotEmpty ? displayNameController.text : 'User'
          });
          if (profileResponse != null) {
            throw profileResponse.error;
          }
          try {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } catch (e) {
            print('Error: $e');
          }
        } else {
          throw Exception('user authentication failed');
        }
      } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('invalid otp')),
          );
        }
      } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}'),)
      );
      }
    }

  @override
  void dispose() {
    phoneNumberController.dispose();
    pinCodeController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
       backgroundColor: Color(0xFFFFE81D),
        title: Text('Chats Box', style: TextStyle(
          fontFamily: 'Caros',
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: CustomColor.multiColors,
        ),
        child: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Form(
                key: _firstForm,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 150, left: 10, right: 20),
                      child: Column(
                          children: [
                             Text('Connect\nfriends\neasily &\nquickly', style:
                            TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Caros',
                            ),
                              textAlign: TextAlign.left,
                            ),
                             Text('Our chat app is the perfect way to stay\nconnected with friends and family', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              fontFamily: 'Caros',
                            ),
                              textAlign: TextAlign.left,
                            ),
                             SizedBox(
                              height: 20,
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
                              inputDecoration: InputDecoration(
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
                              height: 10,
                            ),
                          ],
                        ),
                    ),
                  TextButton(
                      onPressed: (){
                        _sendOtp();
                      },
                      child: Text('Send otp', style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ))),
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
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: displayNameController,
                        decoration: InputDecoration(
                          hintText: 'Display name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        validator: (val)  {
                          if (val == null || val.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          _verifyUserAndSignIn();
                        },
                        child:  Text('Sign in', style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
