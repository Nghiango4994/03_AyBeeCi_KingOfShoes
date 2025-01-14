<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class KichThuocSanPham extends Model
{
    use HasFactory;
    protected $primaryKey = 'id';
    public $timestamps = false;
    protected $table = 'kich_thuoc_san_pham';
    protected $fillable = ['id', 'ten_kich_thuoc'];
}