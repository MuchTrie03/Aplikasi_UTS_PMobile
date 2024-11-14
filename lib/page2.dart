import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String? _selectedCurrencyFrom = 'USD';
  String? _selectedCurrencyTo = 'IDR';
  TextEditingController _amountController = TextEditingController();
  final List<String> _currencies = ['USD', 'EUR', 'JPY', 'IDR'];
  double _result = 0.0;
  bool _hasConverted = false;

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      _result = amount *
          _getConversionRate(_selectedCurrencyFrom, _selectedCurrencyTo);
      _hasConverted = true;
    });
  }

  double _getConversionRate(String? fromCurrency, String? toCurrency) {
    // Nilai tukar dummy antar mata uang (sesuaikan untuk simulasi yang realistis)
    Map<String, Map<String, double>> exchangeRates = {
      'USD': {'IDR': 15700.0, 'EUR': 0.85, 'JPY': 110.0, 'USD': 1.0},
      'EUR': {'IDR': 16500.0, 'USD': 1.18, 'JPY': 130.0, 'EUR': 1.0},
      'JPY': {'IDR': 120.0, 'USD': 0.0091, 'EUR': 0.0077, 'JPY': 1.0},
      'IDR': {'USD': 0.0000636, 'EUR': 0.0000606, 'JPY': 0.0083, 'IDR': 1.0},
    };

    return exchangeRates[fromCurrency]?[toCurrency] ?? 1.0;
  }

  void _onCurrencyChangedFrom(String? value) {
    setState(() {
      _selectedCurrencyFrom = value;
      _hasConverted = false;
    });
  }

  void _onCurrencyChangedTo(String? value) {
    setState(() {
      _selectedCurrencyTo = value;
      _hasConverted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: '\$ ',
                      labelText: 'Jumlah',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCurrencyFrom,
                        items: _currencies.map((String currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: _onCurrencyChangedFrom,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.swap_horiz, color: Colors.grey),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCurrencyTo,
                        items: _currencies.map((String currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: _onCurrencyChangedTo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _convertCurrency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Konversi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_hasConverted)
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Hasil Konversi',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${_result.toStringAsFixed(2)} $_selectedCurrencyTo',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
