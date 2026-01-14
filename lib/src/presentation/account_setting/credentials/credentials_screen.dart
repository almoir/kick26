import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({super.key});

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 72,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ConstColors.baseColorDark5)),
            child: Center(child: GoldGradient(child: const Icon(Icons.chevron_left, size: 28))),
          ),
        ),
        title: Text(
          "Credentials",
          style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(12), child: Image.asset('assets/images/credentials.png')),
      ),
    );
  }
}
