<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrangThai extends Model
{
    use HasFactory;

    protected $table = 'trang_thai';
    protected $fillable = ['ten_trang_thai'];
    public $timestamps = false;
}