import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static MaterialColor appColor = Colors.purple;
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  static const TextStyle smallLight = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Colors.black26,
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.appColor,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    String medicationTitle = "Paracetamol";
    var medicationFrequency = '500mg, a cada 8 horas';
    var medicationNextDose = 'Proximo em 26min';
    var cardIcon = Icons.medication_rounded;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MedicationCard(
              cardIcon: cardIcon,
              medicationTitle: medicationTitle,
              medicationFrequency: medicationFrequency,
              medicationNextDose: medicationNextDose,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MedicationCard extends StatelessWidget {
  const MedicationCard({
    Key? key,
    required this.cardIcon,
    required this.medicationTitle,
    required this.medicationFrequency,
    required this.medicationNextDose,
  }) : super(key: key);

  final IconData cardIcon;
  final String medicationTitle;
  final String medicationFrequency;
  final String medicationNextDose;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: AppColors.appColor.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          width: 300,
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Icon(
                    cardIcon,
                    size: 60,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicationTitle,
                      style: AppTextStyles.heading2,
                    ),
                    Text(
                      medicationFrequency,
                      style: AppTextStyles.body,
                    ),
                    Container(
                      height: 6,
                    ),
                    Text(
                      medicationNextDose,
                      style: AppTextStyles.smallLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
