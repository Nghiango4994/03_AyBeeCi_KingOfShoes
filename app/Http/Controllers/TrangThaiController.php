<?php
namespace App\Http\Controllers;

use App\Models\TrangThai;
use Illuminate\Http\Request;

class TrangThaiController extends Controller
{
    public function index()
    {
        return TrangThai::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'ten_trang_thai' => 'required|string|max:100'
        ]);
        return TrangThai::create($request->all());
    }

    public function show($id)
    {
        return TrangThai::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $trangThai = TrangThai::findOrFail($id);
        $request->validate([
            'ten_trang_thai' => 'required|string|max:100'
        ]);
        $trangThai->update($request->all());
        return $trangThai;
    }

    public function destroy($id)
    {
        TrangThai::findOrFail($id)->delete();
        return response(null, 204);
    }
}