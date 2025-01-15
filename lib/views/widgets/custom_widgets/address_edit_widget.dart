import 'package:flutter/material.dart';
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/viewmodels/Location_ViewModel.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_MiniMap.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class AddressInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSave;

  const AddressInputWidget({
    Key? key,
    required this.controller,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Nhập Địa Chỉ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Nhập địa chỉ của bạn',
          prefixIcon: Icon(Icons.location_on),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onSave(controller.text); // Lưu địa chỉ
            Navigator.of(context).pop(); // Đóng hộp thoại
          },
          child: const Text('Lưu'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng hộp thoại nếu hủy
          },
          child: const Text('Hủy'),
        ),
      ],
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _address = 'Chưa xác định';
  String _paymentMethod = '';
  final TextEditingController _addressController = TextEditingController();

  void _showAddressInputDialog() {
    _addressController.text = _address; // Đặt lại giá trị địa chỉ hiện tại
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddressInputWidget(
          controller: _addressController,
          onSave: (newAddress) {
            setState(() {
              _address = newAddress; // Cập nhật địa chỉ
            });
          },
        );
      },
    );
  }

  void _showPaymentConfirmationDialog() {
    if (_paymentMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn phương thức thanh toán!')),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Xác Nhận Thanh Toán',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
                'Bạn có chắc chắn muốn thanh toán với địa chỉ: $_address?\nPhương thức thanh toán: $_paymentMethod'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý thanh toán ở đây
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thanh toán thành công!')),
                  );
                },
                child: const Text('Xác Nhận'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh Toán',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng tiền hàng: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$1250.00"),
                ],
              ),
              const SizedBox(height: 8.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phí giao hàng: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$40.90"),
                ],
              ),
              const SizedBox(height: 8.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng tiền: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$1690.99"),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text: "Thanh Toán",
                  onClick: _showPaymentConfirmationDialog,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<ThongTin>>(
        future: fetchInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No info available.'));
          } else {
            final info = snapshot.data!.first; // Lấy dữ liệu từ danh sách
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thông tin liên lạc',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 8.0),
                      Text(info.email ?? 'N/A'),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 8.0),
                      Text(info.sdt ?? 'N/A'),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Địa chỉ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  StatefulBuilder(
                    builder: (context, onChanged) {
                      return Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 8.0),
                          Text(_address),
                          const Spacer(),
                          IconButton(
                            onPressed:
                                _showAddressInputDialog, // Hiển thị ô nhập địa chỉ
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomMinimap(), // Giữ Google Maps widget không thay đổi
                  const SizedBox(height: 16.0),
                  const Text('Phương thức thanh toán',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16.0),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'VNPay',
                                groupValue: _paymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMethod = value!;
                                  });
                                },
                              ),
                              Image.asset(
                                'assets/images/vnpay.png',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 8.0),
                              const Text('VNPay'),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Momo',
                                groupValue: _paymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMethod = value!;
                                  });
                                },
                              ),
                              Image.asset(
                                'assets/images/momo.png',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 8.0),
                              const Text('Momo'),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Chọn phương thức thanh toán: $_paymentMethod',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
