<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChiTietGioHang extends Model {
    use HasFactory;
    public $timestamps = false;
    protected $primaryKey = 'id_chi_tiet_gio_hang';
    protected $table = 'chi_tiet_gio_hang';
    protected $fillable = ['id_gio_hang', 'id_san_pham', 'so_luong','ngay_tao'];
}