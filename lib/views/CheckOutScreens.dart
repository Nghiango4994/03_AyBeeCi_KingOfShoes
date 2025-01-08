import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_MiniMap.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 8.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSummaryRow('Subtotal: ', "\$1250.00"),
              SizedBox(height: 8.0),
              _buildSummaryRow('Shopping: ', "\$40.90"),
              SizedBox(height: 8.0),
              _buildSummaryRow('Total Cost: ', "\$1690.99"),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text: "Checkout",
                  onClick: () {
                    // Implement checkout logic here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactInformation(),
              SizedBox(height: 16.0),
              _buildAddress(),
              SizedBox(height: 16.0),
              CustomMinimap(),
              _buildPaymentMethod(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle()),
        Text(value),
      ],
    );
  }

  Widget _buildContactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Information',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        _buildContactRow(Icons.email, 'rumenhussen@gmail.com'),
        SizedBox(height: 8.0),
        _buildContactRow(Icons.phone, '+88-692-764-269'),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8.0),
        Text(text),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Text('Newahall st 36, London, 12908 - UK'),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Row(
          children: [
            Icon(Icons.credit_card),
            SizedBox(width: 8.0),
            Text('Paypal Card'),
            Spacer(),
            Text('0696 4629'),
          ],
        ),
      ],
    );
  }
}
