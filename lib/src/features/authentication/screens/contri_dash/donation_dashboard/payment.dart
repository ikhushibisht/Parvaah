import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:parvaah_helping_hand/src/constants/colors.dart';
import 'package:parvaah_helping_hand/src/constants/image_string.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_NIGLhPLHQxcHqq',
      'amount': amount,
      'name': 'Parvaah',
      'prefill': {
        'contact': '8090783441',
        'email': 'khushibisht2319@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    showSnackbar('Payment successful');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print(response.message!);
    showSnackbar('Payment failed');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName!);
    showSnackbar('External wallet: ${response.walletName}');
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tDashboardBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              tWelcomeScreen,
              height: 200,
              width: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Every contribution, big or small, helps build a brighter future",
              style: TextStyle(
                  color: tPrimaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.black,
                autofocus: false,
                style: const TextStyle(color: tPrimaryColor),
                decoration: const InputDecoration(
                  labelText: "Enter amount",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: tPrimaryColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: amtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount to be paid';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (amtController.text.toString().isNotEmpty) {
                  setState(() {
                    int amount = int.parse(amtController.text.toString());
                    openCheckout(amount);
                  });
                }
              },
              icon: Icon(Icons.lock),
              label: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Proceed to donate',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: tPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}