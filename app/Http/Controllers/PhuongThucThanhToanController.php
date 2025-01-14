<?php

namespace App\Http\Controllers;

use App\Models\PhuongThucThanhToan;
use Illuminate\Http\Request;

class PhuongThucThanhToanController extends Controller{
    public function index(){
        $phuongThucThanhToans = PhuongThucThanhToan::all();
        return response()->json($phuongThucThanhToans);
    }
    public function store(Request $request){
        $phuongThucThanhToan = PhuongThucThanhToan::create($request->all());
        return response()->json($phuongThucThanhToan, 201);
    }
    public function show($id){
        return PhuongThucThanhToan::findOrFail($id);
    }
    public function update(Request $request, $id){
        $phuongThucThanhToan = PhuongThucThanhToan::findOrFail($id);
        $phuongThucThanhToan->update($request->all());
        return response()->json($phuongThucThanhToan, 200);
    }
    public function destroy($id){
        PhuongThucThanhToan::destroy($id);
        return response()->json(null, 204);
    }
}