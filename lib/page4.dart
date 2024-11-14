import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  String _result = '';

  // Fungsi untuk menghitung harga setelah diskon
  double _calculateDiscount(double price, double discount) {
    return price - (price * (discount / 100));
  }

  // Fungsi untuk melakukan perhitungan dan menampilkan hasil
  void _calculate() {
    double price = double.tryParse(_priceController.text) ?? 0;
    double discount = double.tryParse(_discountController.text) ?? 0;

    if (price > 0 && discount >= 0 && discount <= 100) {
      double finalPrice = _calculateDiscount(price, discount);
      setState(() {
        _result = 'Harga setelah diskon: Rp ${finalPrice.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _result = 'Masukkan harga dan diskon yang valid!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hitung Diskon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Input Harga
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Harga Barang',
                    hintText: 'Contoh: 500000',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    prefixIcon: Icon(Icons.money, color: Colors.green),
                  ),
                ),
                SizedBox(height: 20),

                // Input Diskon
                TextField(
                  controller: _discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Diskon (%)',
                    hintText: 'Contoh: 20',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    prefixIcon: Icon(Icons.percent, color: Colors.red),
                  ),
                ),
                SizedBox(height: 20),

                // Tombol Hitung
                ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 119, 179, 222), // Blue color for button
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                  ),
                  child: Text(
                    'Hitung',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),

                // Hasil Diskon
                if (_result.isNotEmpty)
                  Text(
                    _result,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFF5F5F5), // Light grey background
    );
  }
}
