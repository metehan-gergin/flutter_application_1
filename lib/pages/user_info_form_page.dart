import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoFormPage extends StatefulWidget {
  const UserInfoFormPage({super.key});

  @override
  State<UserInfoFormPage> createState() => _UserInfoFormPageState();
}

class _UserInfoFormPageState extends State<UserInfoFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _gender;
  int? _age;
  double? _height;
  double? _weight;
  String? _goal;

  final List<String> genders = ['Erkek', 'Kadın'];
  final List<String> goals = ['Zayıflamak', 'Kilo Almak', 'Formda Kalmak'];

  Future<void> _saveUserInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': _name,
          'gender': _gender,
          'age': _age,
          'height': _height,
          'weight': _weight,
          'goal': _goal,
        });

        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilgilerini Gir', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildDropdownField(
                label: 'Cinsiyet',
                value: _gender,
                items: genders,
                onChanged: (value) => setState(() => _gender = value),
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'İsminiz',
                keyboardType: TextInputType.name,
                onSaved: (val) => _name = val,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'Yaşınız',
                keyboardType: TextInputType.number,
                onSaved: (val) => _age = int.tryParse(val ?? ''),
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'Boy (cm)',
                keyboardType: TextInputType.number,
                onSaved: (val) => _height = double.tryParse(val ?? ''),
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                label: 'Kilo (kg)',
                keyboardType: TextInputType.number,
                onSaved: (val) => _weight = double.tryParse(val ?? ''),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                label: 'Hedefiniz',
                value: _goal,
                items: goals,
                onChanged: (value) => setState(() => _goal = value),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveUserInfo,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Devam Et', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextInputType keyboardType,
    required void Function(String?) onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'Bu alan zorunludur' : null,
      onSaved: onSaved,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Bu alan zorunludur' : null,
    );
  }
}
