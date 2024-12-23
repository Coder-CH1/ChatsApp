import 'package:chatsapp/resusable_widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart';
import 'package:logging/logging.dart';

class UserRegistration extends StatefulWidget {
  final String phoneNumber;
  const UserRegistration({super.key, required this.phoneNumber});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String initialCountry = '';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final log = Logger('');

  Future<void> _sendOtp() async {
    final phoneNumber = number.phoneNumber;
    log.info('$phoneNumber');
    if(!_form.currentState!.validate()) return;

    try {
       await Supabase.instance.client.auth.signInWithOtp(
        phone: phoneNumber,
      );
       if (!mounted) return;
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Otp sent successfully: check your message')),
       );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'),)
      );
    }
  }

  Future<void> _verifyUserAndSignIn() async {
    if (!_form.currentState!.validate()) return;
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
            if (mounted) return;
            if (!mounted) return;
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } catch (e) {
            log.warning('Error: $e');
          }
        } else {
          log.warning('user authentication failed');
        }
      } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('invalid otp')),
          );
        }
      } catch (e) {
      if (!mounted) return;
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
       backgroundColor: const Color(0xFFFFE81D),
        title: const Text('Chats Box', style: TextStyle(
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
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      children: [
                         const Align(
                           alignment: Alignment.topLeft,
                           child: Padding(
                             padding: EdgeInsets.only(left: 20),
                             child: Text('Connect\nfriends\neasily &\nquickly', style:
                                                   TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Caros',
                                                   ),
                              textAlign: TextAlign.left,
                                                   ),
                           ),
                         ),
                         const Align(
                           alignment: Alignment.topLeft,
                           child: Padding(
                             padding: EdgeInsets.only(left: 20),
                             child: Text('Our chat app is the perfect way to stay\nconnected with friends and family', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                              fontFamily: 'Caros',
                                                     ),
                              textAlign: TextAlign.left,
                                                     ),
                           ),
                         ),
                         const SizedBox(
                          height: 20,
                        ),
                         const Text('Sign in with Phone Number', style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                           textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              this.number = number;
                            },
                            selectorConfig: const SelectorConfig(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: TextButton(
                              onPressed: (){
                                _sendOtp();
                              },
                              child: const Text('Send otp', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: PinCodeTextField(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: displayNameController,
                            decoration: const InputDecoration(
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: TextButton(
                              onPressed: (){
                                _verifyUserAndSignIn();
                              },
                              child:  const Text('Sign in', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))),
                        )
                      ],
                    ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
