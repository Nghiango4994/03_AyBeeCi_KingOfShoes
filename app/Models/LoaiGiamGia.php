<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class LoaiGiamGia extends Model{
    protected $table = 'loaigiamgia';
    protected $primaryKey = 'Id';
    public $timestamps = false;
    protected $fillable = ['Id', 'TenLoaiGiamGia'];
}