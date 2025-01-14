<?php

namespace App\Http\Controllers;

use App\Models\TrangThaiThanhToan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TrangThaiThanhToanController extends Controller
{
    public function index()
    {
        $trangThaiThanhToan = TrangThaiThanhToan::all();
        return response()->json($trangThaiThanhToan);
    }

    public function store(Request $request)
    {
        $request->validate([
            'ten_trang_thai' => 'required|string|max:100'
        ]);
        
        $trangThaiThanhToan = TrangThaiThanhToan::create($request->all());
        return response()->json($trangThaiThanhToan, 201); // Trả về mã 201 khi tạo thành công
    }

    public function update(Request $request, $id)
    {
        $trangThai = TrangThaiThanhToan::findOrFail($id);

        $request->validate([
            'ten_trang_thai' => 'required|string|max:100'
        ]);

        $trangThai->update($request->all());
        return response()->json($trangThai);
    }

    public function destroy($id)
    {
        TrangThaiThanhToan::destroy($id);
        return response()->json(null, 204); // Trả về mã 204 khi xóa thành công
    }

    public function search($id)
    {
        $trangThaiThanhToan = DB::table('trang_thai_thanh_toan')->where('id', $id)->first(); // Sử dụng first() thay vì get() để lấy một bản ghi duy nhất
        return response()->json($trangThaiThanhToan);
    }
}
