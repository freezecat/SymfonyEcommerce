<?php

namespace App\Controller;

use App\Entity\User;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class SecurityController extends AbstractController 
{

    #[Route(path: '/admin/register', name: 'register_admin')]
    public function registerAdmin(Request $request, ManagerRegistry $managerRegistry,
    UserPasswordHasherInterface $passHasher): Response{
        //Cette méthode nous permet de créer une nouvelle Entity User via l'usage
        //d'un formulaire interne à notre méthode , et avec les privilèges désirés.

        //Pour enregistrer un nouvel utilisateur , ous avons besoin de l'Entity manager
        $entityManager = $managerRegistry->getManager();
        //Nous créons notre formulaire interne:
            $userForm = $this->createFormBuilder()
            ->add('username',TextType::class,[
                'label'=>'Nom de l\'utilisateur'
            ])
            ->add('password',RepeatedType::class, [ // permet de répéter 2 fois le mdp , afin d'avoir la confirmation du mdp
                'type'=>PasswordType::class,
                'required'=>true,
                'first_options' => [
                    'label'=>'Mot de passe',
                    'attr'=>[
                        'class' => 'w3-input w3-border w3-round w3-light-grey'
                    ]
                ],
                'second_options'=> [
                    'label'=>'Confirmation du mot de passe',
                    'attr'=>[
                        'class' => 'w3-input w3-border w3-round w3-light-grey'
                    ]
                ]
            ])
            ->add('role',ChoiceType::class,[
                'label'=>'Privilèges',
                'choices'=>[
                    'Role:Client' => 'ROLE_CLIENT',
                    'Role:Admin'=>'ROLE_ADMIN'
                ],
                'expanded'=>true,
                'multiple' => false,
                'attr'=>[
                    'class' => 'w3-input w3-border w3-round w3-light-grey'
                ]
            ])
            ->add('submit',SubmitType::class,[
                'label'=>'Valider',
                'attr'=>[
                    'class' => 'w3-input w3-border w3-round w3-light-grey'
                ]
            ])
            ->getForm();
            //Nous traitons les données reçus au sein de notre formulaire
            $userForm->handleRequest($request);
            if($request->isMethod('post') && $userForm->isValid()){
                //On récupère les informations de notre formulaire
                $data = $userForm->getData();
                //Nous créeons notre entité User selon les informations enregistrées
                $user = new User;
                $user->setRoles(['ROLE_USER',$data['role']]);
                $user->setUsername($data['username']);
                $user->setPassword($passHasher->hashPassword($user,$data['password']));
                $entityManager->persist($user);
                $entityManager->flush();
                //Après la création de l'Utilisateur , nous retournons à l'index
                return $this->redirectToRoute('app_index');
            }
            //Si notre formulaire n'est pas validé, nous le présentons à l'utilisateur
            return $this->render('index/dataform.html.twig',[
                "formName"=>"Inscription Utilisateur (Admin)",
                "dataform"=>$userForm->createView()
            ]);
    }       

    #[Route(path: '/login', name: 'app_login')]
    public function login(AuthenticationUtils $authenticationUtils): Response 
    {
        // if ($this->getUser()) {
        //     return $this->redirectToRoute('target_path');
        // }

        // get the login error if there is one
        $error = $authenticationUtils->getLastAuthenticationError();
        // last username entered by the user
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('security/login.html.twig', ['last_username' => $lastUsername, 'error' => $error]);
    }

    #[Route(path: '/logout', name: 'app_logout')]
    public function logout(): void
    {
        throw new \LogicException('This method can be blank - it will be intercepted by the logout key on your firewall.');
    }
}
