<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Session;

class PhuongThucThanhToan extends Model {
    use HasFactory;
      // Tắt timestamps
    public $timestamps = false;
    protected $table = 'phuong_thuc_thanh_toan';
    protected $fillable = ['id', 'ten_phuong_thuc'];
}
