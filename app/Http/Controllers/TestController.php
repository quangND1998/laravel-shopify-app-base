<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use Illuminate\Contracts\Routing\ResponseFactory;

class TestController extends Controller
{

    public function __construct(private readonly ResponseFactory $responseFactory)
    {
    }
    public function index(Request $request)
    {

        $shop = Auth::user();

        $domain = $shop->getDomain()->toNative();


        $shop = Auth::user();
        $products = $shop->api()->rest('GET', '/admin/api/2021-07/products.json');
        return $products;



        return Inertia::render('Index');
    }
}
