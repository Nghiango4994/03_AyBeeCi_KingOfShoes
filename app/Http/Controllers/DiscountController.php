<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Magiamgia;

class DiscountController extends Controller
{
    // Lấy tất cả mã giảm giá
    public function getAll()
    {
        $items = Magiamgia::all();

        return response()->json([
            'success' => true,
            'data'    => $items
        ]);
    }

    // Xác thực mã giảm giá
    public function getDiscount($code)
    {
        $discount = Magiamgia::where('id', $code)->first();

        if ($discount) {
            return response()->json([
                'success' => true,
                'message' => 'Discount code valid',
                'discount' => $discount
            ], 200);
        }

        return response()->json([
            'success' => false,
            'message' => 'Invalid discount code'
        ], 404);
    }

    // Tạo mã giảm giá mới
    public function create(Request $request)
    {
        $request->validate([
            'ChuoiGiamGia' => 'required|string|max:255',
            'GiaTriGiam'   => 'required|numeric',
            'NgayHetHan'  => 'required|date',
            'LoaiGiamGiaId' => 'required|integer',
            'SoLuong' => 'required|integer'
        ]);

        $magiamgia = Magiamgia::create($request->all());

        return response()->json([
            'success' => true,
            'message' => 'Discount code created successfully!',
            'data'    => $magiamgia
        ], 201);
    }

    // Cập nhật mã giảm giá
    public function update(Request $request, $id)
    {
        $discount = Magiamgia::find($id);

        if (!$discount) {
            return response()->json([
                'success' => false,
                'message' => "Not found discount code with ID: $id"
            ], 404);
        }

        $request->validate([
            'ChuoiGiamGia' => 'sometimes|required|string|max:255',
            'GiaTriGiam'   => 'sometimes|required|numeric',
            'NgayGiamGia'  => 'sometimes|required|date',
            'LoaiGiamGiaId' => 'sometimes|required|integer'
        ]);

        $discount->update($request->all());

        return response()->json([
            'success' => true,
            'message' => 'Discount code updated successfully!',
            'data'    => $discount
        ]);
    }

    // Xóa mã giảm giá
    public function delete($id)
    {
        $discount = Magiamgia::find($id);

        if (!$discount) {
            return response()->json([
                'success' => false,
                'message' => "Not found discount code with ID: $id"
            ], 404);
        }

        $discount->delete();

        return response()->json([
            'success' => true,
            'message' => "Discount code ID: $id deleted successfully!"
        ]);
    }
}
