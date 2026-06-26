import 'package:flutter/material.dart';

class TemperatureScreen extends StatefulWidget {
  final VoidCallback onBack;
  const TemperatureScreen({super.key, required this.onBack,});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final TextEditingController controller = TextEditingController();
  double fahrenheit = 0;
  String error = "";
  double convertToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  void calculate() {
    double? celsius = double.tryParse(controller.text);

    setState(() {
      if (celsius == null) {
        error = "Invalid input. Please enter digits only.";
      } else {
        error = "";
        fahrenheit = convertToFahrenheit(celsius);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final InputDecoration inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Enter a temperature',
    hintStyle: const TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.thermostat_outlined,
              size: 120,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 45),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Temperature in Degrees:"),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: inputDecoration,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => calculate(),
            ),
            const SizedBox(height: 30),
            const Text("Temperature in Fahrenheit:"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text(
                error.isNotEmpty ? error : fahrenheit.toStringAsFixed(1),
                style: TextStyle(
                  color: error.isNotEmpty ? Colors.red : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: widget.onBack, child: Text("Back"),),
          ],
        ),
      ),
    );
  }
}
