import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'page5.dart';
import 'page6.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1E1E2C),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  final List<Color> buttonColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.purpleAccent,
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1E1E2C),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/img/Profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Much. Trie Harnanto',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '15-2022-083',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.calculate, color: buttonColors[0]),
              title: Text('Kalkulator'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            ListTile(
              leading: Icon(Icons.price_change, color: buttonColors[1]),
              title: Text('Konversi Mata Uang'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2()));
              },
            ),
            ListTile(
              leading: Icon(Icons.thermostat, color: buttonColors[2]),
              title: Text('Konversi Suhu'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page3()));
              },
            ),
            ListTile(
              leading: Icon(Icons.discount, color: buttonColors[3]),
              title: Text('Hitung Diskon'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page4()));
              },
            ),
            ListTile(
              leading: Icon(Icons.cake, color: buttonColors[4]),
              title: Text('Hitung Usia'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page5()));
              },
            ),
            ListTile(
              leading: Icon(Icons.scale, color: buttonColors[5]),
              title: Text('Hitung Massa'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page6()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            DashboardCard(
              title: 'Kalkulator',
              icon: Icons.calculate,
              color: buttonColors[0],
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            DashboardCard(
              title: 'Konversi Mata Uang',
              icon: Icons.price_change,
              color: buttonColors[1],
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2()));
              },
            ),
            DashboardCard(
              title: 'Konversi Suhu',
              icon: Icons.thermostat,
              color: buttonColors[2],
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page3()));
              },
            ),
            DashboardCard(
              title: 'Hitung Diskon',
              icon: Icons.discount,
              color: buttonColors[3],
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page4()));
              },
            ),
            DashboardCard(
              title: 'Hitung Usia',
              icon: Icons.cake,
              color: buttonColors[4],
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page5()));
              },
            ),
            DashboardCard(
              title: 'Hitung Massa',
              icon: Icons.scale,
              color: buttonColors[5],
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page6()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      isPressed = false;
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isPressed ? 0.97 : 1.0),
        decoration: BoxDecoration(
          color: widget.color, // Solid color
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 48,
              color: Colors.black,
            ),
            SizedBox(height: 8),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Black text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
