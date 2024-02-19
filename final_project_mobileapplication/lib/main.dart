import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CalculateScreen(),
        '/info': (context) => InfoScreen(),
      },
    );
  }
}

class CalculateScreen extends StatelessWidget {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Color.fromARGB(255, 16, 7, 141)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('I12.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 227, 229, 231)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 51, 222, 231)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color.fromARGB(255, 245, 241, 241)),
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 227, 229, 231)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 62, 212, 232)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  double height = double.tryParse(heightController.text) ?? 0;
                  double weight = double.tryParse(weightController.text) ?? 0;
                  double bmi = calculateBMI(height, weight);
                  Navigator.pushNamed(context, '/info', arguments: bmi);
                },
                child: Text('Calculate BMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateBMI(double height, double weight) {
    return (weight / ((height / 100) * (height / 100)));
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double bmi = ModalRoute.of(context)!.settings.arguments as double;
    String result = getBMIResult(bmi);
    String imagePath = getCategoryImagePath(result);

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Category'),
        backgroundColor: Color.fromARGB(255, 239, 236, 236),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your BMI: ${bmi.toStringAsFixed(3)}',
                style: TextStyle(
                    fontSize: 30.0, color: Color.fromARGB(255, 248, 246, 246)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 20.0),
              Text(
                'Category:'
                '$result',
                style: TextStyle(
                    fontSize: 25.0, color: Color.fromARGB(255, 249, 249, 250)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  String getBMIResult(double bmi) {
    if (bmi < 16) {
      return 'Severe undernourishment';
    } else if (bmi >= 16 && bmi <= 16.9) {
      return 'Medium undernourishment';
    } else if (bmi >= 17 && bmi <= 18.4) {
      return 'Slight undernourishment';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal nutrition state';
    } else if (bmi >= 25 && bmi <= 29.9) {
      return 'Overweight';
    } else if (bmi >= 30 && bmi <= 39.9) {
      return 'Obesity';
    } else if (bmi >= 40) {
      return 'Pathological Obesity';
    } else {
      return 'error';
    }
  }

  String getCategoryImagePath(String category) {
    switch (category) {
      case 'Severe undernourishment':
        return 'I1.jpg';
      case 'Medium undernourishment':
        return 'I2.jpg';
      case 'Slight undernourishment':
        return 'I3.jpg';
      case 'Normal nutrition state':
        return 'I4.jpg';
      case 'Overweight':
        return 'I5.jpg';
      case 'Obesity':
        return 'I7.jpg';
      case 'Pathological Obesity':
        return 'I9.jpg';
      default:
        return 'assets/default_image.png';
    }
  }
}
