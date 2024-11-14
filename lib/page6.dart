import 'package:flutter/material.dart';

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  TextEditingController massController = TextEditingController();
  String selectedInputUnit = 'Kilogram'; // Default pilihan unit input
  String selectedOutputUnit = 'Kilogram'; // Default pilihan unit output
  String result = '';

  // Daftar satuan massa
  List<String> units = ['Kilogram', 'Gram', 'Ons', 'Pound'];

  // Fungsi untuk konversi massa
  void _convertMass() {
    double mass = double.tryParse(massController.text) ?? 0;

    if (mass == 0) {
      setState(() {
        result = 'Mohon masukkan nilai massa yang valid!';
      });
      return;
    }

    double convertedValue = 0;

    // Konversi input ke kilogram
    switch (selectedInputUnit) {
      case 'Kilogram':
        convertedValue = mass; // Tidak perlu konversi
        break;
      case 'Gram':
        convertedValue = mass / 1000; // Gram ke Kilogram
        break;
      case 'Ons':
        convertedValue = mass / 35.274; // Ons ke Kilogram
        break;
      case 'Pound':
        convertedValue = mass / 2.20462; // Pound ke Kilogram
        break;
      default:
        setState(() {
          result = 'Unit input tidak dikenali!';
        });
        return;
    }

    // Konversi kilogram ke unit output yang dipilih
    double finalResult = 0;
    switch (selectedOutputUnit) {
      case 'Kilogram':
        finalResult = convertedValue; // Sudah dalam kilogram
        break;
      case 'Gram':
        finalResult = convertedValue * 1000; // Kilogram ke Gram
        break;
      case 'Ons':
        finalResult = convertedValue * 35.274; // Kilogram ke Ons
        break;
      case 'Pound':
        finalResult = convertedValue * 2.20462; // Kilogram ke Pound
        break;
      default:
        setState(() {
          result = 'Unit output tidak dikenali!';
        });
        return;
    }

    setState(() {
      result = 'Hasil konversi: $finalResult $selectedOutputUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hitung Massa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Input Massa
              Text(
                'Masukkan Nilai Massa:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: massController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Massa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Dropdown untuk memilih satuan input massa
              Text(
                'Pilih Satuan Massa Input:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedInputUnit,
                icon: Icon(Icons.arrow_downward),
                isExpanded: true,
                elevation: 16,
                style: TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedInputUnit = newValue!;
                  });
                },
                items: units.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Dropdown untuk memilih satuan output massa
              Text(
                'Pilih Satuan Massa Output:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedOutputUnit,
                icon: Icon(Icons.arrow_downward),
                isExpanded: true,
                elevation: 16,
                style: TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOutputUnit = newValue!;
                  });
                },
                items: units.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Tombol Hitung
              Center(
                child: ElevatedButton(
                  onPressed: _convertMass,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Hitung Konversi',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Hasil Konversi
              if (result.isNotEmpty)
                Center(
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
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
