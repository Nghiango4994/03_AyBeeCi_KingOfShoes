<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\GioHang;
use App\Models\ChiTietGioHang;
use App\Models\SanPham;
use App\Models\AnhSanPham;
class CartController extends Controller
{
    // Lấy tất cả giỏ hàng
    public function getAll()
    {
        // Lấy tất cả giỏ hàng 
        $items = GioHang::with(['bienthesanpham'])->get();

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
   // $gioHang = GioHang::with(['chiTietGioHang.sanPham.anh'])->where('id_gio_hang', $id)->first(); 
    $gioHang = GioHang::with(['bienthesanpham','bienthesanpham.mau','bienthesanpham.anh','bienthesanpham.kichthuoc','bienthesanpham.trangthai','bienthesanpham.magiamgia'])->where('id_khach_hang', $id)->get();

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


     public function thaydoisoluong(Request $request)
    {
        $idGioHang = $request->input('idGioHang');
        $idBienThe = $request->input('idBienThe');
        $so_luong = $request->input('so_luong');
        // Logic để tăng số lượng sản phẩm trong giỏ hàng
        // Ví dụ: Tìm sản phẩm trong giỏ hàng và tăng số lượng
        $cartItem = GioHang::where('id_gio_hang', $idGioHang)
                        ->where('id_bien_the_san_pham', $idBienThe)
                        ->first();
        if ($cartItem) {
           if($cartItem->so_luong <= 1 ||$so_luong <= 1 ){
                $cartItem->so_luong = 1;
            }else{
                $cartItem->so_luong = $so_luong;
            }
            $cartItem->save();
            return response()->json(['success' => true, 'data' => $cartItem], 200);
        } else {
            return response()->json(['success' => false, 'message' => 'Item not found'], 404);
        }
    }
}

