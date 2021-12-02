<?php

namespace App\Controller;

use App\Classe\Mail;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    /**
     * @Route("/", name="home")
     */
    public function index(SessionInterface $session): Response
    {

       $mail = new Mail();
       $mail->send('mapetiteboutique@yopmail.com', 'med med', 'Mon premier mail', 'Et voici ton premier mail de la part de Symfony!');
       
        return $this->render('home/index.html.twig');
    }
}
