<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ChiTietGioHang;

class DetailCartController extends Controller
{
    public function getAll()
    {
        $items = ChiTietGioHang::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }

    public function create(Request $request)
    {
        if (empty($request->id_gio_hang)) {
            return response()->json([
                'success' => false,
                'message' => "Please input id_gio_hang!"
            ]);
        }

        $chitietgiohang= ChiTietGioHang::create([
            'id_gio_hang' => $request->id_gio_hang,
             'id_san_pham' => $request->id_san_pham,
              'so_luong' => $request->so_luong,
               'ngay_tao' => $request->ngay_tao,
        ]);

        if (!empty($chitietgiohang)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new chitietgiohang successfully!',
                'data'    => $chitietgiohang
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new chitietgiohang!'
        ]);
    }

    public function getDetailCart($id)
    {
        $chitietgiohang = ChiTietGioHang::find($id);

        if (empty($chitietgiohang)) {
            return response()->json([
                'success' => false,
                'message' => "Not found chitietgiohang with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $chitietgiohang
        ]);
    }
   public function update(Request $request, $id)
    {
        $chitietgiohang = ChiTietGioHang::find($id);

        if (empty($chitietgiohang)) {
            return response()->json([
                'success' => false,
                'message' => "Not found product with ID: $id"
            ]);
        }

        $chitietgiohang->id_gio_hang           = $request->id_gio_hang;
        $chitietgiohang->id_san_pham       = $request->id_san_pham;
        $chitietgiohang->so_luong        = $request->so_luong;
        $chitietgiohang->ngay_tao = $request->ngay_tao;
        $chitietgiohang->save();

        return response()->json([
            'success' => true,
            'message' => "Update chitietgiohang ID: $id successfully!",
            'data'    => $chitietgiohang
        ]);
    }


    // Xóa giỏ hàng
    public function delete($id_chi_tiet_gio_hang)
    {
        $chitietgiohang = ChiTietGioHang::find($id_chi_tiet_gio_hang);

        if (empty($chitietgiohang)) {
            return response()->json([
                'success' => false,
                'message' => "Not found chitietgiohang with ID: $id_chi_tiet_gio_hang"
            ]);
        }

        $chitietgiohang->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete chitietgiohang ID: $id_chi_tiet_gio_hang successfully!"
        ]);
    }
}
