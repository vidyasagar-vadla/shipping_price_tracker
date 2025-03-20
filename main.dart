import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courier Price Calculator',
      home: PriceCalculator(),
    );
  }
}

class PriceCalculator extends StatefulWidget {
  @override
  _PriceCalculatorState createState() => _PriceCalculatorState();
}

class _PriceCalculatorState extends State<PriceCalculator> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  String? selectedCourier;
  String result = '';

  final List<String> couriers = ['Bluedart', 'Delhivery', 'DTDC'];

  // Focus nodes
  final FocusNode pickupFocusNode = FocusNode();
  final FocusNode deliveryFocusNode = FocusNode();

  Future<void> calculatePrice() async {
    final pickup = pickupController.text;
    final delivery = deliveryController.text;

    if (pickup.isEmpty || delivery.isEmpty || selectedCourier == null) {
      setState(() {
        result = 'Please fill all fields and select a courier.';
      });
      return;
    }

    try {
      final response = await http.get(
          Uri.parse('http://192.168.62.249:5000/city_distances'));
      if (response.statusCode == 200) {
        final distances = json.decode(response.body);
        final distanceKey = '${pickup}-$delivery';
        if (distances[distanceKey] != null) {
          final distance = distances[distanceKey];
          final courierRates = await http.get(
              Uri.parse('http://192.168.62.249:5000/couriers'));
          if (courierRates.statusCode == 200) {
            final rates = json.decode(courierRates.body)[selectedCourier];
            final basePrice = rates['base_price'];
            final perKmRate = rates['per_km_rate'];
            final totalPrice = basePrice + (distance * perKmRate);

            setState(() {
              result = 'Estimated Price: ${totalPrice.toStringAsFixed(2)} Rs';
            });
          } else {
            setState(() {
              result = 'Error fetching courier rates.';
            });
          }
        } else {
          setState(() {
            result = 'Distance not available for the selected route.';
          });
        }
      } else {
        setState(() {
          result = 'Error fetching distances.';
        });
      }
    } catch (e) {
      setState(() {
        result = 'An error occurred: $e';
      });
    }
  }

  @override
  void dispose() {
    pickupController.dispose();
    deliveryController.dispose();
    pickupFocusNode.dispose();
    deliveryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courier Price Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              focusNode: pickupFocusNode,
              decoration: InputDecoration(labelText: 'Pickup Address'),
            ),
            TextField(
              controller: deliveryController,
              focusNode: deliveryFocusNode,
              decoration: InputDecoration(labelText: 'Delivery Address'),
            ),
            DropdownButton<String>(
              hint: Text('Select Courier'),
              value: selectedCourier,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCourier = newValue;
                });
              },
              items: couriers.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculatePrice,
              child: Text('Calculate Price'),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}