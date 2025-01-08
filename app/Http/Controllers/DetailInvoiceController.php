<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ChiTietHoaDon;

class DetailInvoiceController extends Controller
{
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
        if (empty($request->HoaDonNhap_Id)) {
            return response()->json([
                'success' => false,
                'message' => "Please input HoaDonNhap_Id!"
            ]);
        }

        $chitiethoadon= ChiTietHoaDon::create([
            'HoaDon_Id' => $request->HoaDonNhap_Id,
             'SanPham_Id' => $request->SanPham_Id,
              'SoLuong' => $request->SoLuong,
               'DonGia' => $request->DonGia,
               'GiamGia' => $request->GiamGia,
               'id_khach_hang' => $request->id_khach_hang,
        ]);

        if (!empty($chitiethoadon)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new chitiethoadon successfully!',
                'data'    => $chitiethoadon
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new chitiethoadon!'
        ]);
    }

    public function getDetailOrder($id)
    {
        $chitiethoadon = ChiTietHoaDon::find($id);

        if (empty($chitiethoadon)) {
            return response()->json([
                'success' => false,
                'message' => "Not found chitiethoadon with ID: $id"
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => $chitiethoadon
        ]);
    }
   public function update(Request $request, $id)
    {
        $chitiethoadon = ChiTietHoaDon::find($id);

        if (empty($chitiethoadon)) {
            return response()->json([
                'success' => false,
                'message' => "Not found product with ID: $id"
            ]);
        }

        $chitiethoadon->HoaDonNhap_Id           = $request->HoaDonNhap_Id;
        $chitiethoadon->SanPham_Id       = $request->SanPham_Id;
        $chitiethoadon->SoLuong        = $request->SoLuong;
        $chitiethoadon->DonGia = $request->DonGia;
        $chitiethoadon->GiamGia           = $request->GiamGia;
        $chitiethoadon->id_khach_hang       = $request->id_khach_hang;
        $chitiethoadon->save();

        return response()->json([
            'success' => true,
            'message' => "Update chitiethoadon ID: $id successfully!",
            'data'    => $chitiethoadon
        ]);
    }


    // Xóa giỏ hàng
    public function delete($id_chi_tiet_gio_hang)
    {
        $chitiethoadon = ChiTietHoaDon::find($id_chi_tiet_gio_hang);

        if (empty($chitiethoadon)) {
            return response()->json([
                'success' => false,
                'message' => "Not found chitiethoadon with ID: $id_chi_tiet_gio_hang"
            ]);
        }

        $chitiethoadon->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete chitiethoadon ID: $id_chi_tiet_gio_hang successfully!"
        ]);
    }
}
