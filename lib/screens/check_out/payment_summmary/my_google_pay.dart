import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final total;
  MyGooglePay({this.total});
  @override
  State<MyGooglePay> createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  var paymentItems = [];

// In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) {
    print(paymentResult);
    // Send the resulting Google Pay token to your server or PSP
  }

  @override
  Widget build(BuildContext context) {
    return GooglePayButton(
        paymentConfigurationAsset: 'sample_payment_configuration.json',
        paymentItems: [
          PaymentItem(
            label: 'Total',
            amount: '${widget.total}',
            status: PaymentItemStatus.final_price,
          )
        ],
        type: GooglePayButtonType.pay,
        onPaymentResult: onGooglePayResult,
       );
  }
}
