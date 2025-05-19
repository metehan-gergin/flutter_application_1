import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF1565C0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ayarlar Sayfası",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Ayarlar sayfasındaki içerikler
            ListTile(
              title: const Text('Hesap Bilgileri'),
              onTap: () {
                // Hesap Bilgileri sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Text('Bildirimler'),
              onTap: () {
                // Bildirimler sayfasına yönlendirme
              },
            ),
            ListTile(
              title: const Text('Gizlilik Politikası'),
              onTap: () {
                // Gizlilik Politikası sayfasına yönlendirme
              },
            ),
            // Diğer ayar seçeneklerini burada ekleyebilirsiniz
          ],
        ),
      ),
    );
  }
}
