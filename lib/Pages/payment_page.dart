import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart'; // Import Provider
import 'package:slide_to_act/slide_to_act.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentOption;
  final List<String> paymentOptions = ['Credit Card', 'PayPay', 'Google Pay'];

  @override
  Widget build(BuildContext context) {
    // Retrieve the CartModel using Provider
    var cart = Provider.of<CartModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFF86D19B),
      appBar: AppBar(
        backgroundColor: Color(0xFF86D19B),
        title: Text(
          'Payment Method',
          style: TextStyle(
            color: Color(0xff043611),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Payment options
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paymentOptions.map((option) {
              return ListTile(
                title: Text(option),
                leading: Radio(
                  activeColor: Color(0xff11b039),
                  value: option,
                  groupValue: selectedPaymentOption,
                  onChanged: (value) {
                    // Update the selected payment option
                    setState(() {
                      selectedPaymentOption = value as String?;
                    });
                    // Do something with the selected option if needed
                  },
                ),
              );
            }).toList(),
          ),

          // Display total amount
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Text(
              'Total Amount: ${cart.calculateTotal()} 円',
              style: TextStyle(fontSize: 24),
            ),
          ),

          // Slide to Proceed to Payment
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SlideAction(
                borderRadius: 16,
                elevation: 1,
                outerColor: Color(0xff11b039).withOpacity(0.8),

                text: 'Slide to Pay',
                onSubmit: () {
                  // Handle the payment logic here
                  if (selectedPaymentOption != null) {
                    print('Selected Payment Option: $selectedPaymentOption');
                    // Proceed with the payment logic
                  } else {
                    // Show an error or prompt the user to select a payment option
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
