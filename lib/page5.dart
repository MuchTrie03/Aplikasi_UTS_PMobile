import 'package:flutter/material.dart';

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  DateTime? birthDate;
  DateTime? currentDate;
  String? ageResult = '';

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.deepPurple, // Warna tombol
            primaryColorDark: Colors.deepPurple, // Warna header saat dipilih
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        if (isBirthDate) {
          birthDate = selectedDate;
        } else {
          currentDate = selectedDate;
        }
      });
    }
  }

  // Fungsi untuk menghitung usia berdasarkan dua tanggal
  void _calculateAge() {
    if (birthDate != null && currentDate != null) {
      final difference = currentDate!.difference(birthDate!);
      final years = (difference.inDays / 365).floor();
      final months = ((difference.inDays % 365) / 30).floor();
      final days = (difference.inDays % 365) % 30;

      setState(() {
        ageResult = 'Usia: $years tahun, $months bulan, $days hari';
      });
    } else {
      setState(() {
        ageResult = 'Silakan pilih tanggal lahir dan tanggal saat ini.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hitung Usia'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Tanggal Lahir
              Text(
                'Pilih Tanggal Lahir:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.cake, color: Colors.deepPurple),
                  title: Text(
                    birthDate == null
                        ? 'Pilih Tanggal Lahir'
                        : '${birthDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => _selectDate(context, true),
                ),
              ),
              SizedBox(height: 20),

              // Tanggal Saat Ini
              Text(
                'Pilih Tanggal Saat Ini:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.today, color: Colors.deepPurple),
                  title: Text(
                    currentDate == null
                        ? 'Pilih Tanggal Saat Ini'
                        : '${currentDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => _selectDate(context, false),
                ),
              ),
              SizedBox(height: 30),

              // Tombol Hitung
              Center(
                child: ElevatedButton(
                  onPressed: _calculateAge,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ), // Warna tombol
                  ),
                  child: Text(
                    'Hitung Usia',
                    style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Hasil Perhitungan Usia
              if (ageResult != null)
                Center(
                  child: Text(
                    ageResult!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
