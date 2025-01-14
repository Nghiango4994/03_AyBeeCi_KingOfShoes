// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:kingofshoes/models/ChiTietHoaDon.dart';
// import 'package:kingofshoes/viewmodels/QuanLyHoaDon.dart';
// import 'package:kingofshoes/views/ChiTietHoaDon.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => OrderViewModel(),
//       child: QuanLyDonHangScreen(),
//     );
//   }
// }

// class QuanLyDonHangScreen extends StatefulWidget {
//   @override
//   _QuanLyDonHangScreenState createState() => _QuanLyDonHangScreenState();
// }

// class _QuanLyDonHangScreenState extends State<QuanLyDonHangScreen> {
//   String trangThaiDuocChon = "Tất cả";

//   final List<String> trangThaiDonHang = [
//     "Tất cả",
//     "Chờ duyệt",
//     "Đang chuẩn bị hàng",
//     "Đang giao hàng",
//     "Đã nhận hàng",
//     "Đã hủy",
//     "Đã trả",
//     "Yêu cầu trả",
//     "Đang chờ đơn vị vận chuyển",
//     "Đã hoàn tất",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<OrderViewModel>().fetchOrders();
//     });
//   }

//   void _duyetDonHang(Order donHang) {
//     context
//         .read<OrderViewModel>()
//         .updateOrder(donHang.id, donHang.copyWith(status: "Đã duyệt"));
//   }

//   void _xemChiTietDonHang(Hoa donHang) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => InvoiceDetailScreen(order: donHang),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final numberFormat = NumberFormat('#,##0');
//     final quanLyDonHangViewModel = context.watch<OrderViewModel>();

//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Quản lý đơn hàng'),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: DropdownButton<String>(
//                 value: trangThaiDuocChon,
//                 onChanged: (value) {
//                   setState(() {
//                     trangThaiDuocChon = value!;
//                   });
//                 },
//                 items: trangThaiDonHang.map((status) {
//                   return DropdownMenuItem<String>(
//                     value: status,
//                     child: Text(status),
//                   );
//                 }).toList(),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: quanLyDonHangViewModel.orders.length,
//                 itemBuilder: (context, index) {
//                   final donHang = quanLyDonHangViewModel.orders[index];

//                   // Lọc trạng thái
//                   if (trangThaiDuocChon != "Tất cả" &&
//                       donHang.status != trangThaiDuocChon) {
//                     return const SizedBox.shrink();
//                   }

//                   return Card(
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Mã đơn hàng: ${donHang.orderCode}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                               const SizedBox(height: 8.0),
//                               Text('Khách hàng: ${donHang.customerName}'),
//                               const SizedBox(height: 8.0),
//                               Text('Ngày đặt: ${donHang.orderDate}'),
//                               const SizedBox(height: 8.0),
//                               Text('Trạng thái: ${donHang.status}'),
//                               const SizedBox(height: 8.0),
//                               Text(
//                                 'Tổng tiền: ${numberFormat.format(donHang.products.fold<double>(0, (total, product) => total + (product.quantity * product.price)))} VND',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           height: 1.0,
//                           color: Colors.grey[300],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () => _duyetDonHang(donHang),
//                                 child: const Text('Duyệt'),
//                               ),
//                               const SizedBox(width: 8.0),
//                               ElevatedButton(
//                                 onPressed: () => _xemChiTietDonHang(donHang),
//                                 child: const Text('Xem chi tiết'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
