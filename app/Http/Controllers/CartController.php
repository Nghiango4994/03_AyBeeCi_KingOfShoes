<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\GioHang;
use App\Models\ChiTietGioHang;
class CartController extends Controller
{
    // Lấy tất cả giỏ hàng
    public function getAll()
    {
        $items =  GioHang::with('chi_tiet_gio_hang')->get();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }

    // Tạo giỏ hàng mới
    public function create(Request $request)
    {
        if (empty($request->id_gio_hang)) {
            return response()->json([
                'success' => false,
                'message' => "Please input customer ID!"
            ]);
        }

        $gioHang = GioHang::create([
            'id_khach_hang' => $request->id_khach_hang,
            'id_khach_hang'    => $request->id_khach_hang,
            'id_sanpham' => $request->id_sanpham,
            'SoLuong' => $request->SoLuong,
            'tong_don_gia' => $request->tong_don_gia,  

        ]);

        if (!empty($gioHang)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new cart successfully!',
                'data'    => $gioHang
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new cart!'
        ]);
    }

    // Lấy giỏ hàng theo ID
    public function getCart($id)
    {
        $gioHang = GioHang::find($id);

        if (empty($gioHang)) {
            return response()->json([
                'success' => false,
                'message' => "Not found cart with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $gioHang
        ]);
    }

    // Xóa giỏ hàng
    public function delete($id)
    {
        $gioHang = GioHang::find($id);

        if (empty($gioHang)) {
            return response()->json([
                'success' => false,
                'message' => "Not found cart with ID: $id"
            ]);
        }

        $gioHang->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete cart ID: $id successfully!"
        ]);
    }
}
