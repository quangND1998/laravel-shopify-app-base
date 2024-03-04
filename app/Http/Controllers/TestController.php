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

        // $shopApi = $shop->api()->rest('GET', '/admin/api/2024-01/products.json?ids=632910392,921728736');
        $shop = $request->user();
        $productResource = [
            "title" => "Good Product",
            "body_html" => "<strong>Good snowboard!</strong>"
        ];

        $request = $shop->api()->rest(
            'POST',
            '/admin/api/products.json',
            [
                'product' => $productResource
            ]
        );
        dd($request);
        return $this->responseFactory->json($request['body']['product']);


        return Inertia::render('Index');
    }
}
