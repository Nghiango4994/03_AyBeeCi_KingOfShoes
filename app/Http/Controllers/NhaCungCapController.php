<?php

namespace App\Http\Controllers;

use App\Models\NhaCungCap;
use Illuminate\Http\Request;

class NhaCungCapController extends Controller
{
    public function index()
    {
        return NhaCungCap::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'ten_nha_cung_cap' => 'required|string|max:100',
            'dia_chi' => 'nullable|string|max:255',
            'sdt' => 'nullable|string|max:15'
        ]);
        return NhaCungCap::create($request->all());
    }

    public function show($id)
    {
        return NhaCungCap::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $nhaCungCap = NhaCungCap::findOrFail($id);
        $request->validate([
            'ten_nha_cung_cap' => 'required|string|max:100',
            'dia_chi' => 'nullable|string|max:255',
            'sdt' => 'nullable|string|max:15'
        ]);
        $nhaCungCap->update($request->all());
        return $nhaCungCap;
    }

    public function destroy($id)
    {
        NhaCungCap::findOrFail($id)->delete();
        return response()->json(['message' => 'Deleted successfully']);
    }
}