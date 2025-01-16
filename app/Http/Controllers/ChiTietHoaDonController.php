<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ChiTietHoaDon;

class ChiTietHoaDonController extends Controller
{
    // Lấy tất cả chi tiết hóa đơn
    public function getAll()
    {
        $items = ChiTietHoaDon::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }
            
    public function create(Request $request) 
    {
        $data = $request->only(['HoaDon_Id', 'BienThe_Id', 'SoLuong']);

        if (empty($data['HoaDon_Id'])) {
            return response()->json([
                'success' => false,
                'message' => "Please input HoaDon_Id!"
            ]);
        }

        $chiTietHoaDon = ChiTietHoaDon::create($data);

        if ($chiTietHoaDon) {
            return response()->json([
                'success' => true,
                'message' => 'Create new ChiTietHoaDon successfully!',
                'data'    => $chiTietHoaDon
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new ChiTietHoaDon!'
        ]);
    }

    // Lấy chi tiết hóa đơn theo ID
   public function getChiTietHoaDon($code)
    {
         // $gioHang = GioHang::with(['chiTietGioHang.sanPham.anh'])->where('id_gio_hang', $id)->first(); 
        // Lấy chi tiết hóa đơn từ cơ sở dữ liệu theo HoaDon_Id
        $chiTietHoaDon = ChiTietHoaDon::with(['bienthesanpham'])->where('HoaDon_Id', $code)->get();

        // Kiểm tra nếu có dữ liệu
        if ($chiTietHoaDon->isEmpty()) {
            return response()->json(['message' => 'Không tìm thấy chi tiết hóa đơn'], 404);
        }

        // Trả về chi tiết hóa đơn dưới dạng JSON
        return response()->json($chiTietHoaDon, 200);
    }
    // Xóa chi tiết hóa đơn
    public function delete($id)
    {
        $chiTietHoaDon = ChiTietHoaDon::find($id);

        if (empty($chiTietHoaDon)) {
            return response()->json([
                'success' => false,
                'message' => "Not found ChiTietHoaDon with ID: $id"
            ]);
        }

        $chiTietHoaDon->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete ChiTietHoaDon ID: $id successfully!"
        ]);
    }
}
