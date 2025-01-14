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
        \Log::info($request->all());

        if (empty($request->id_khach_hang)) {
            return response()->json([
                'success' => false,
                'message' => "Please input customer ID!"
            ]);
        }
    
        // Lấy giá trị từ request
        $kich_thuoc = $request->kich_thuoc;
        $id_khach_hang = $request->id_khach_hang; // Lấy id_khach_hang từ request
        $so_luong = $request->so_luong ?? 1; // Lấy so_luong từ request, mặc định là 1 nếu không có
        $id_bien_the_san_pham = $request->id_bien_the_san_pham; // Lấy id_bien_the_san_pham từ request
    
        // Kiểm tra xem id_bien_the_san_pham có được cung cấp không
        if (empty($id_bien_the_san_pham)) {
            return response()->json([
                'success' => false,
                'message' => "Please input product variant ID!"
            ]);
        }
    
        // Tạo mới giỏ hàng
        $gioHang = GioHang::create([
            'id_khach_hang' => $id_khach_hang,
            'so_luong' => $so_luong,
            'ngay_tao' => now(), // Hoặc giá trị ngày bạn muốn
            'id_bien_the_san_pham' => $id_bien_the_san_pham, // Thêm trường này
            'kich_thuoc' => $kich_thuoc
        ]);
    
        // Kiểm tra kết quả tạo giỏ hàng
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


     public function tang(Request $request)
    {
        $idGioHang = $request->input('idGioHang');
        $idBienThe = $request->input('idBienThe');
        $cartItem = GioHang::where('id_gio_hang', $idGioHang)
                        ->where('id_bien_the_san_pham', $idBienThe)
                        ->first();
        if ($cartItem) {
             $cartItem->so_luong += 1;
            $cartItem->save();
            return response()->json(['success' => true, 'data' => $cartItem], 200);
        } else {
            return response()->json(['success' => false, 'message' => 'Item not found'], 404);
        }
    }

     public function giam(Request $request)
    {
        $idGioHang = $request->input('idGioHang');
        $idBienThe = $request->input('idBienThe');
        $cartItem = GioHang::where('id_gio_hang', $idGioHang)
                        ->where('id_bien_the_san_pham', $idBienThe)
                        ->first();
        if ($cartItem) {
           if($cartItem->so_luong <= 1){
                $cartItem->so_luong = 1;
            }else{
                 $cartItem->so_luong -= 1;
            }
            $cartItem->save();
            return response()->json(['success' => true, 'data' => $cartItem], 200);
        } else {
            return response()->json(['success' => false, 'message' => 'Item not found'], 404);
        }
    }
}

