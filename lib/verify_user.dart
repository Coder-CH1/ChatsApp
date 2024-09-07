import 'package:chatsapp/resusable_widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'home.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({Key? key}) : super(key: key);

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
        backgroundColor: Color(0xFF00F0FF),
        title: Text('Verify User', style: TextStyle(
          fontFamily: 'Caros',
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: CustomColor.multiColors2,
        ),
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
            child: Column(
              children: [
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
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureTextPassword,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        //labelText: 'Password',
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        errorStyle: TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextPassword ? Icons.visibility : Icons.visibility_off, color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextPassword = !_obscureTextPassword;
                            });
                          },
                        )
                    ),
                    validator: (val) {
                      if(val == null || val.isEmpty) {
                        return 'Password cannot be empty';
                      } else if(val.length<6) {
                        return 'Password length must be at least 6';
                      }
                      return null;
                    }
                ),
                TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureTextConfirmPassword,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        //labelText: 'Confirm Password',
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        errorStyle: TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextConfirmPassword ? Icons.visibility : Icons.visibility_off, color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                            });
                          },
                        )
                    ),
                    validator: (val){
                      if(val == null || val.isEmpty) {
                        return 'Password cannot be empty';
                      } else if(val != passwordController.text) {
                        return 'Password does not Match';
                      }
                      return null;
                    }
                ),
                SizedBox(
                  height: 80,
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
      ),
    );
  }
}
