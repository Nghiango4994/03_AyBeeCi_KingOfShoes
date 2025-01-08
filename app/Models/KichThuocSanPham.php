<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KichThuocSanPham extends Model {
    use HasFactory;
    public $timestamps = false;
    protected $table = 'kich_thuoc_san_pham';
    protected $fillable = ['ten_kich_thuoc'];
}
