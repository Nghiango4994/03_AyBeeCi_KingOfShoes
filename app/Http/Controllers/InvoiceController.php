<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HoaDon;
use App\Models\ChiTietHoaDon;
class InvoiceController extends Controller
{
    public function getAll()
    {
        $items =  Hoadon::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }
     public function create(Request $request)
    {
        if (empty($request->HinhThucThanhToan_Id)) {
            return response()->json([
                'success' => false,
                'message' => "Please input hoa don name!"
            ]);
        }

        $hoadon = HoaDon::create([
            'KhachHang_Id'           => $request->KhachHang_Id,
            'HinhThucThanhToan_Id'   => $request->HinhThucThanhToan_Id,
            'ngay_lap'                => $request->ngay_lap,
            'id_Ma_Giam_Gia '       => $request->id_Ma_Giam_Gia ,
            'trang_thai_van_chuyen'           => $request->trang_thai_van_chuyen,
            'trang_thai_thanh_toan'   => $request->trang_thai_thanh_toan,
        ]);

        if (!empty($hoadon)) {
            return response()->json([
                'success' => true,
                'message' => 'Create new hoadon successfully!',
                'data'    => $hoadon
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Have error while creating new hoadon!'
        ]);
    }

public function getHoaDon($HoaDon_Id )
    {
        $hoadon = HoaDon::find($HoaDon_Id);   # Tim kiem theo field id <=> SELECT * FROM tasks WHERE id=$id

        if (empty($hoadon)) {
            return response()->json([
                'success'   => false,
                'message'   => "Not found hoadon with ID: $HoaDon_Id "
            ]);
        }

        return response()->json([
            'success'   => true,
            'data'      => $hoadon
        ]);
    }
    public function delete($HoaDon_Id)
    {
        $hoadon = HoaDon::find($HoaDon_Id);

        if (empty($hoadon)) {
            return response()->json([
                'success' => false,
                'message' => "Not found hoadon with ID: $hoadon"
            ]);
        }

        $hoadon->delete();

        return response()->json([
            'success' => true,
            'message' => "Delete hoadon ID: $hoadon successfully!"
        ]);
    }
}
