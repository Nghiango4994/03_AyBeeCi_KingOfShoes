<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Session;

class SanPham extends Model {
    use HasFactory;
      // Tắt timestamps
    public $timestamps = false;
    protected $table = 'san_pham';
    protected $fillable = ['ten', 'loai_id', 'mau_id', 'kich_thuoc_id', 'gia', 'so_luong', 'mo_ta','ma_giam_gia','GiaSauGiam','nhacungcap_id','id_anh','trang_thai_sp'];
}
