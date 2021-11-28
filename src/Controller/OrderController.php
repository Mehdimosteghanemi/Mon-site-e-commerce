<?php

namespace App\Controller;

use App\Classe\Cart;
use App\Entity\Order;
use App\Entity\OrderDetails;
use App\Form\OrderType;
use DateTime;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Stripe\Checkout\Session;
use Stripe\Stripe;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class OrderController extends AbstractController
{
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    /**
     * @Route("/commande", name="order")
     */
    public function index(Cart $cart, Request $request): Response
    {   

        if (!$this->getUser()->getAddresses()->getValues())
        {
            return $this->redirectToRoute('account_address_add');
        }

        $form = $this->createForm(OrderType::class, null, [
            'user' => $this->getUser()
        ]);

        return $this->render('order/index.html.twig', [
            'form' => $form->createView(),
            'cart' => $cart->getFull()
        ]);
    }

    /**
     * @Route("/commande/recapitulatif", name="order_recap", methods={"POST"})
     */
    public function add(Cart $cart, Request $request): Response
    {   
        
        $form = $this->createForm(OrderType::class, null, [
            'user' => $this->getUser()
        ]);
        
        $form->handleRequest($request);
        
        if ($form->isSubmitted() && $form->isValid()) {
            
            $date = new DateTimeImmutable();
            $carriers = $form->get('carriers')->getData();
            $delivery = $form->get('addresses')->getData();
            $delivery_content = $delivery->getFirstname().' '.$delivery->getLastname();
            
            if ($delivery->getCompany())
            {
                $delivery_content .= '<br/>'.$delivery->getCompany();
            }
            
            $delivery_content .= '<br/>'.$delivery->getAddress();
            $delivery_content .= '<br/>'.$delivery->getPostal().' '.$delivery->getCity();
            $delivery_content .= '<br/>'.$delivery->getCountry();
            
            
            // Save order Order()
            $order = new Order();
            $order->setUser($this->getUser());
            $order->setCreatedAt($date);
            $order->setCarrierName($carriers->getName());
            $order->setCarrierPrice($carriers->getPrice());
            $order->setDelivery($delivery_content);
            $order->setIsPaid(0);
            
            $this->entityManager->persist($order);
            
            
            
            Stripe::setApiKey('sk_test_51K0mRoIDAPOc5uODLkh5de8OOSr8l74Yyz4npihWKLkebspv9cz5ktwefuhliWPOyhf3pfsrsthtYOChG5M0Zlxv00PRSSib2k');
            $YOUR_DOMAIN = 'http://localhost:8080/';
            $productStripe = [];
            $priceStripe = [];

            
            // Save my products OrderDetails()
            foreach ($cart->getFull() as $product)
            {
                
                $orderDetails = new OrderDetails();
                $orderDetails->setMyOrder($order);
                $orderDetails->setProduct($product['product']->getName());
                $orderDetails->setQuantity($product['quantity']);
                $orderDetails->setPrice($product['product']->getPrice());
                $orderDetails->setTotal($product['product']->getPrice() * $product['quantity']);
                
                $this->entityManager->persist($orderDetails);
                
                $productStripe[] = \Stripe\Product::create([
                    'name' => $product['product']->getName()
                ]);

                
                $priceStripe[] = \Stripe\Price::create([
                    'product' => $productStripe,
                    'unit_amount' => $product['product']->getPrice(),
                    'currency' => 'eur',
                ]);
                
            }
            
            dd($productStripe, $priceStripe);
            // $this->entityManager->flush();
            
            
            $checkout_session = \Stripe\Checkout\Session::create([
                
                'line_items' => [[
                    
                    'price' => $priceStripe,
                    'quantity' => $product['quantity'],
                    
                    ]],
                    
                    'mode' => 'payment',
                    'success_url' => $YOUR_DOMAIN . '/success.html',
                    'cancel_url' => $YOUR_DOMAIN . '/cancel.html',

            ]);

            // \dump($checkout_session->url);
            \dd($checkout_session);

            return $this->render('order/add.html.twig', [
                'cart' => $cart->getFull(),
                'carrier' => $carriers,
                'delivery' => $delivery_content
            ]);
        }

        return $this->redirectToRoute('cart');

        
    }
}


