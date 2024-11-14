import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final TextEditingController _controller = TextEditingController();
  String? _fromUnit = 'Celsius';
  String? _toUnit = 'Fahrenheit';
  String _result = '';

  double _convertTemperature(
      double temperature, String fromUnit, String toUnit) {
    if (fromUnit == 'Celsius') {
      if (toUnit == 'Fahrenheit') {
        return (temperature * 9 / 5) + 32;
      } else if (toUnit == 'Kelvin') {
        return temperature + 273.15;
      }
    } else if (fromUnit == 'Fahrenheit') {
      if (toUnit == 'Celsius') {
        return (temperature - 32) * 5 / 9;
      } else if (toUnit == 'Kelvin') {
        return (temperature - 32) * 5 / 9 + 273.15;
      }
    } else if (fromUnit == 'Kelvin') {
      if (toUnit == 'Celsius') {
        return temperature - 273.15;
      } else if (toUnit == 'Fahrenheit') {
        return (temperature - 273.15) * 9 / 5 + 32;
      }
    }
    return temperature;
  }

  void _calculateConversion() {
    if (_controller.text.isNotEmpty) {
      double temp = double.tryParse(_controller.text) ?? 0;
      double result = _convertTemperature(temp, _fromUnit!, _toUnit!);
      setState(() {
        _result = result.toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Konversi Suhu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Suhu',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _fromUnit,
                  items: ['Celsius', 'Fahrenheit', 'Kelvin']
                      .map((unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Dari',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _toUnit,
                  items: ['Celsius', 'Fahrenheit', 'Kelvin']
                      .map((unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Ke',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _calculateConversion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Konversi',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
                if (_result.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Hasil Konversi: $_result $_toUnit',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFE8F5E9),
    );
  }
}
