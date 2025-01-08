import 'package:flutter/material.dart';
import 'package:kingofshoes/views/CheckOutScreens.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('My Cart'),
          ],
        ),
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 8.0, // Thiết lập độ cao của bóng
          shadowColor:
              Colors.grey.withOpacity(0.5), // Thiết lập màu sắc của bóng
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal: ', style: TextStyle()),
                  Text("\$1250.00")
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Shopping: '), Text("\$40.90")],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Total Cost: '), Text("\$1690.99")],
              ),
              SizedBox(height: 16.0),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                      text: "Checkout",
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
      backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
              _buildCartItem(
                'Nike Club Max',
                '\$64.95',
                'L',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(String name, String price, String size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.network(
              'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/067ea325-267a-4c9c-8148-d62eeee1e329/W+AIR+FORCE+1+%2707+NEXT+NATURE.png',
              width: 80.0),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                SizedBox(height: 4.0),
                Text(price),
                SizedBox(height: 4.0),
                Text('Size: $size'),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity = _quantity > 1 ? _quantity - 1 : 1;
                  });
                },
                icon: Icon(Icons.remove),
              ),
              Text('$_quantity'),
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
