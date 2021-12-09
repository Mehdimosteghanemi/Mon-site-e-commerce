<?php

namespace App\Controller;

use App\Classe\Mail;
use App\Form\ContactType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ContactController extends AbstractController
{
    /**
     * @Route("/nous-contacter", name="contact")
     */
    public function index(Request $request): Response
    {

        $form = $this->createForm(ContactType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid())
        {
            $this->addFlash('notice', 'Merci de nous avoir contacté, notre équipe va vous répondre dans les meilleurs délais.');

            $mail = new Mail();
            $formData = $form->getData();

            $content = "Bonjour <br/>Vous avez reçu un message de <strong>".$formData['prenom']." ".$formData['nom']."</strong></br>Adresse email : <strong>".$formData['email']."</strong> </br>Message : ".$formData['content']."</br></br>";

            $mail->send('mapetiteboutique@yopmail.com', '', 'Message émis du formulaire de contact', $content);
        }

        return $this->render('contact/index.html.twig', [
            'form' => $form->createView()
        ]);
    }
}

