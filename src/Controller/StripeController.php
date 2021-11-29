<?php

namespace App\Controller;

use App\Classe\Cart;
use Stripe\Stripe;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class StripeController extends AbstractController
{
    /**
     * @Route("/commande/create-session", name="stripe_create_session")
     */
    public function index(Cart $cart)
    {
        
        $product_for_stripe = [];
        $YOUR_DOMAIN = 'http://localhost:8080';

        foreach ($cart->getFull() as $product) {

            $product_for_stripe[] = [
                'price_data' => [
                    'currency' => 'eur',
                    'unit_amount' => $product['product']->getPrice(),
                    'product_data' => [
                        'name' => $product['product']->getName(),
                        'images' => [$YOUR_DOMAIN."/uploads/".$product['product']->getIllustration()],
                    ],
                ],
                'quantity' => $product['quantity'],
            ];
        }

        Stripe::setApiKey('sk_test_51K0mRoIDAPOc5uODLkh5de8OOSr8l74Yyz4npihWKLkebspv9cz5ktwefuhliWPOyhf3pfsrsthtYOChG5M0Zlxv00PRSSib2k');
                    
        $checkout_session = \Stripe\Checkout\Session::create([
                        
            'line_items' => [
                            
                $product_for_stripe
                // 'price' => $priceStripe,
                // 'quantity' => $product['quantity'],
                    
            ],
            'payment_method_types' => [
                'card',
            ],
            'mode' => 'payment',
            'success_url' => $YOUR_DOMAIN . '/success.html',
            'cancel_url' => $YOUR_DOMAIN . '/cancel.html',

        ]);

        return $this->redirect($checkout_session->url);
    }
}
