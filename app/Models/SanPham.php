<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Session;
use App\Models\BienTheSanPham;
use App\Models\NhaCungCap;
class SanPham extends Model {
    use HasFactory;
      // Tắt timestamps
    public $timestamps = false;
    protected $table = 'san_pham';
    protected $fillable = ['ten', 'id', 'mo_ta', 'nhacungcap_id', 'loai_san_pham'];
    public function bienThe() {
      return $this->hasMany(BienTheSanPham::class, 'san_pham_id', 'id');
  }
}


