<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrangThaiVanChuyen extends Model
{
    use HasFactory;

    protected $table = 'trang_thai_van_chuyen';
    protected $fillable = ['id','ten_trang_thai'];
    public $timestamps = false;
}