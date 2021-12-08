<?php

namespace App\Controller;

use App\Classe\Mail;
use App\Entity\ResetPassword;
use App\Entity\User;
use App\Form\ResetPasswordType;
use DateTime;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Flex\Flex;

class ResetPasswordController extends AbstractController
{
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }


    /**
     * @Route("/mot-de-passe-oublie", name="reset_password")
     */
    public function index(Request $request): Response
    {
        if ($this->getUser()) {
            return $this->redirectToRoute('home');
        }

        if ($request->get('email')) {
            $user = $this->entityManager->getRepository(User::class)->findOneByEmail($request->get('email'));
            
            if ($user) {
                // 1 : Enregistrer en bdd la demande de reset_password avec un user, toke et createdAt.
                $reset_password = new ResetPassword();
                $reset_password->setUser($user);
                $reset_password->setToken(uniqid());
                $reset_password->setCreatedAt(new DateTimeImmutable());
                $this->entityManager->persist($reset_password);
                $this->entityManager->flush();

                // 2 : Envoyer un email à l'utilisateur avec un lien lui permettant de mettre à jour son mot de passe.
                $url = $this->generateUrl(
                    'update_password',
                    [
                        'token' => $reset_password->getToken()    
                    ],
                    UrlGeneratorInterface::ABSOLUTE_URL
                );

                $content = "Bonjour ".$user->getFirstname()."<br/>Vous avez demandé à réinitialiser votre mot de passe sur le site Ma petite boutique.<br/><br/>";
                $content .= "Merci de bien vouloir cliquer sur le lien suivant pour <a href='".$url."'>mettre à jour votre mot de passe</a>.";

                $mail = new Mail();
                $mail->send($user->getEmail(), $user->getFirstname().' '.$user->getLastname(), 'Réinitialiser votre mot de passe sur Ma petite boutique', $content);

                $this->addFlash('notice', 'Vous allez recevoir dans quelques instants un e-mail avec la procédure pour réinitialiser votre mot de passe.');

            } else {

                $this->addFlash('notice', 'Cette adresse e-mail est inconnue.');
            }
        }

        return $this->render('reset_password/index.html.twig');
    }

    /**
     * @Route("/modifier-mon-mot-de-passe/{token}", name="update_password")
     */
    public function update($token, Request $request, UserPasswordHasherInterface $hasher): Response
    {
       $reset_password = $this->entityManager->getRepository(ResetPassword::class)->findOneByToken($token);

       if (!$reset_password) {
           return $this->redirectToRoute('reset_password');
       }

       // Vérifier si le createrdAt = now - 3h

       $now = new DateTime();
       if ($now > $reset_password->getCreatedAt()->modify('+ 3 hour')) {
           
            $this->addFlash('notice', 'Votre demande de changement de mot de passe a expiré. Merci de la renouveller.');
            return $this->redirectToRoute('reset_password');
       }
       
       // rendre une vue avec mot de passe et confirmez votre mot de passe.
       $form = $this->createForm(ResetPasswordType::class);
       $form->handleRequest($request);

       if ($form->isSubmitted() && $form->isValid()) {

        $new_pwd = $form->get('new_password')->getData();

            // encodage des mots de passe
            $password = $hasher->hashPassword($reset_password->getUser(), $new_pwd);
            $reset_password->getUser()->setPassword($password);

            // flush en base de données
            $this->entityManager->flush();

            // redirection de l'utilisateur vers la page de connexion
            $this->addFlash('notice', 'Votre mot de passe a bien été mis à jour.');
            return $this->redirectToRoute('app_login');
       }

       return $this->render('reset_password/update.html.twig', [
           'form' => $form->createView()
       ]);
    }
}