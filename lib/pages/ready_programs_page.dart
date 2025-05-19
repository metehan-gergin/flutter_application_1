import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'active_program_page.dart';

class ReadyProgramsPage extends StatefulWidget {
  const ReadyProgramsPage({super.key});

  @override
  State<ReadyProgramsPage> createState() => _ReadyProgramsPageState();
}

class _ReadyProgramsPageState extends State<ReadyProgramsPage> {
  final Color primaryBlue = const Color(0xFF1565C0);

  bool isLoading = true;
  String? userGoal;
  List<Map<String, String>> programs = [];

  final List<Map<String, String>> gainWeightPrograms = [
    {
      'title': 'Kas Kütlesi Arttırma',
      'duration': '8 Hafta',
      'level': 'Orta',
      'description': 'Yoğun ağırlık antrenmanlarıyla kas yapımını hızlandırır.',
      'goal': 'kilo almak',
    },
    {
      'title': 'Yüksek Kalori Antrenmanı',
      'duration': '6 Hafta',
      'level': 'Başlangıç',
      'description': 'Beslenme destekli ve düşük kardiyo odaklı güç antrenmanı.',
      'goal': 'kilo almak',
    },
  ];

  final List<Map<String, String>> loseWeightPrograms = [
    {
      'title': 'HIIT Kardiyo Programı',
      'duration': '4 Hafta',
      'level': 'Zor',
      'description': 'Yağ yakımını hızlandıran yüksek tempolu kardiyo egzersizleri.',
      'goal': 'kilo vermek',
    },
    {
      'title': 'Yağ Yakıcı Egzersiz Seti',
      'duration': '5 Hafta',
      'level': 'Orta',
      'description': 'Zıplama, koşu ve gövde hareketleri ile kalori harcama odaklı program.',
      'goal': 'kilo vermek',
    },
  ];

  final List<Map<String, String>> stayFitPrograms = [
    {
      'title': 'Full Body Haftalık Rutin',
      'duration': '4 Hafta',
      'level': 'Başlangıç',
      'description': 'Kas tonusunu korumaya ve kondisyonu artırmaya yönelik temel program.',
      'goal': 'formda kalmak',
    },
    {
      'title': 'Esneklik ve Dayanıklılık',
      'duration': '6 Hafta',
      'level': 'Orta',
      'description': 'Yoga, stretching ve vücut ağırlığı ile denge kuran program.',
      'goal': 'formda kalmak',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadUserGoal();
  }

  Future<void> loadUserGoal() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = doc.data();
      if (data != null && data.containsKey('goal')) {
        final goal = data['goal'].toString().toLowerCase();
        List<Map<String, String>> selectedPrograms = [];

        if (goal == 'kilo almak') {
          selectedPrograms = gainWeightPrograms;
        } else if (goal == 'kilo vermek') {
          selectedPrograms = loseWeightPrograms;
        } else if (goal == 'formda kalmak') {
          selectedPrograms = stayFitPrograms;
        }

        setState(() {
          userGoal = goal;
          programs = selectedPrograms;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Firestore hata: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (programs.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hazır Programlar'),
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text(
            'Hedefinize uygun program bulunamadı.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hazır Programlar'),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${program['duration']} • ${program['level']}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    program['description']!,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final uid = FirebaseAuth.instance.currentUser?.uid;
                        if (uid == null) return;

                        await FirebaseFirestore.instance.collection('users').doc(uid).update({
                          'activeProgram': {
                            'title': program['title'],
                            'duration': program['duration'],
                            'level': program['level'],
                            'description': program['description'],
                            'goal': program['goal'],
                          }
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProgramDetailPage(program: program),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Başlat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

