import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../global/global_instances.dart';
import '../../global/global_vars.dart';
import '../widgets/custom_text_field.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
{
  XFile? imageFile;
  ImagePicker pickerImage = ImagePicker();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();
<<<<<<< HEAD
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
=======
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a



  pickImageFromGallery() async
  {
    imageFile = await pickerImage.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 11,),

          InkWell(
            onTap: ()
            {
              pickImageFromGallery();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageFile == null ? null : FileImage(File(imageFile!.path)),
              child: imageFile == null
                  ? Icon(
                    Icons.add_photo_alternate,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: Colors.grey,
                  )
                  : null,
            ),
          ),

          const SizedBox(height: 11,),

          Form(
            key: formKey,
            child: Column(
              children: [

                CustomTextField(
                  textEditingController: nameTextEditingController,
                  iconData: Icons.person,
                  hintString: "Name",
                  isObscure: false,
                  enabled: true,
                ),

                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintString: "Email",
                  isObscure: false,
                  enabled: true,
                ),

                CustomTextField(
<<<<<<< HEAD
                  textEditingController: phoneTextEditingController,
                  iconData: Icons.phone,
                  hintString: "Phone",
                  isObscure: false,
                  enabled: true,
                ),

                CustomTextField(
=======
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintString: "Password",
                  isObscure: true,
                  enabled: true,
                ),

                CustomTextField(
                  textEditingController: confirmPasswordTextEditingController,
                  iconData: Icons.lock,
                  hintString: "Confirm Password",
                  isObscure: true,
                  enabled: true,
                ),

<<<<<<< HEAD
                CustomTextField(
                  textEditingController: locationTextEditingController,
                  iconData: Icons.my_location,
                  hintString: "My Current Address",
                  isObscure: false,
                  enabled: true,
                ),

                Container(
                  width: 398,
                  height: 39,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () async
                    {
                      String address = await commonViewModel.getCurrentLocation();

                      setState(() {
                        locationTextEditingController.text = address;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    label: const Text(
                      "Get my Current Location",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                ),

=======
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
                const SizedBox(height: 32,),

                ElevatedButton(
                  onPressed: () async
                  {
                    await authViewModel.validateSignUpForm(
                        imageFile,
                        passwordTextEditingController.text.trim(),
                        confirmPasswordTextEditingController.text.trim(),
                        nameTextEditingController.text.trim(),
                        emailTextEditingController.text.trim(),
<<<<<<< HEAD
                        phoneTextEditingController.text.trim(),
                        fullAddress,
=======
>>>>>>> b3ba5fc02ce374bdec3b643c678759d45161765a
                        context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 32,),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
