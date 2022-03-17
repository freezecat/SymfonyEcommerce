<?php

namespace App\Controller;



use App\Entity\Tag;
use App\Entity\Category;
use App\Entity\Product; 
use App\Entity\Order; 
use App\Entity\User; 
use App\Entity\Reservation;
use App\Form\ProductType;
use App\Form\TagType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/client')]
#[Security('is_granted("ROLE_CLIENT")')]
class OrderController extends AbstractController
{
  
    #[Route('/client-backoffice',name:'client_backoffice')]
    public function adminClientBackOffice(ManagerRegistry $managerRegistry): Response{
        //On récupère l'utilisateur:
        $user = $this->getUser();
        //Cette méthode nous affiche la liste de toutes les Commandes/Order
        //de notre base de données ainsi que les Réservations liées

        //Afin de pouvoir récupérer nos commandes, nous avons besoin de l'Entity Manager 
        //ainsi que du Repository de Order. Nous n'avons pas besoin du Repository de Reservation
        //car récupérer un Order signifie récupérer également les Reservations liées.
        $entityManager = $managerRegistry->getManager();
        $orderRepository = $entityManager->getRepository(Order::class);
        //On récupère nos Catégories pour notre header
        $categoryRepository =  $entityManager->getRepository(Category::class); 
        
        $categories = $categoryRepository->findAll();
       // $orders = $orderRepository->findAll(); //findBy(["status"=>"panier"])
       //ici findOneBy car il ne peut y avoir qu'une commande en mode Panier
       // forcément dans admin_client_backfoffice.html.twig il n'y aura pas 
       // de boucle for pour
       
      // $orderPanier = $orderRepository->find($user);

      // $ordersValidees = []; 


    //   $orderPanier = $orderRepository->findOneBy(["status"=>"panier"],["user_id"=>$user->getId()]); 
    //      $ordersValidees = $orderRepository->findBy(["status"=>"validee"],["id"=>"DESC"],["user_id"=>$user->getId()]);

    

     // $orderPanier = $orderRepository->find($user);
        
         $orderPanier = $orderRepository->findOneBy(["status"=>"panier","user"=>$user]); 
         $ordersValidees = $orderRepository->findBy(["status"=>"validee","user"=>$user],["id"=>"DESC"]);

        
        // $orderPanier = $user["order"]->findOneBy(["status"=>"panier"]); 
        // $ordersValidees = $user["order"]->findBy(["status"=>"validee"],["id"=>"DESC"]);

        //Nous transmettons les commandes à Twig:
        return $this->render('order/client_backoffice.html.twig',[
            'categories'=>$categories,
            'orderPanier'=>$orderPanier,
            'ordersValidees'=>$ordersValidees,
            "user"=>$user
        ]);
    }

       //Cette méthode permet de valider une commande/Order en attente (statut panier)
    //dont l'ID est indiqué sur notre URL.
    #[Route("/order/validate/{orderId}",name:"order_validate_client")]
    public function vakudateOrder(int $orderId,ManagerRegistry $managerRegistry,Request $request): Response{
        
        $user =$this->getUser();
        
        $entityManager = $managerRegistry->getManager();
        $orderRepository = $entityManager->getRepository(Order::class);
        //Nour recherchons l'Order en question selon l'ID qui nous a été transmis.
        //Si l'Order n'est pas trouvé OU que son statut n'est pas "panier",nous
        //retournons au tableau de borrd Commandes.
        $order = $orderRepository->find($orderId);
        if(!$order || $order->getStatus() != "panier" || ($order->getUser() != $user))
        {
            return $this->redirectToRoute("client_backoffice");
        }
        if($order->getStatus() == "panier"){
            $order->setStatus("validee"); // ne pas oublier le persist et flush voyons sinon pas de changement dans la bdd!
            $entityManager->persist($order);
            $entityManager->flush();
            $request->getSession()->set('message_title','Validation commande');
            $this->addFlash('info','Votre commande a bien été validée.');
            $request->getSession()->set('status','green');
            return $this->redirectToRoute("client_backoffice");
        }
        //  else  
        // { 
        //     $request->getSession()->set('message_title','Validation commande');
        //     $this->addFlash('info','Cette commande a déjà été validée.');
        //     $request->getSession()->set('status','red');
        // }
        //il n'y a plus d'intérêt puisque la commande est validée et le bouton est supprimée
    }

      //Cette méthode permet de supprimer une réservation d'une commande , si cette
    // dernière est en attente (en mode panier) selon l'ID de l'URL
    #[Route("/reservation/delete/{reservationId}",name:"reservation_delete_client")]
    public function deleteReservation(int $reservationId,ManagerRegistry $managerRegistry,Request $request): Response{
       $user = $this->getUser();
        //Afin de pouvoir récupéerer la Reservation à supprimer , nous avons besoin de
        //l'Entity Manager ainsi que du Repository de Reservation
        $entityManager = $managerRegistry->getManager();
        $reservationRepository = $entityManager->getRepository(Reservation::class);
        $reservation = $reservationRepository->find($reservationId);
        $orderStatus = $reservation->getOrder()->getStatus();

        $orderRepository = $entityManager->getRepository(Order::class);
        

        //on verifie d'abord dans l'ordre si il y a $reservation, puis si 
        //la reservation est lié à une commande $reservation->getOrder() ,
        // !$reservation->getOrder() signifie que la reservation n'est liée à aucune commande
        //et enfin si la commande est en mode panier
        
        if(!$reservation || !$reservation->getOrder() || $orderStatus != "panier" || ($reservation->getOrder()->getUser() != $user))
        { 
            return $this->redirectToRoute("client_backoffice");
        }

          //A présent que nous avons une Reservation d'une commande en mode "panier",
        //nous pouvons procéder à la suppression de la Réservation en question.
        //On commence par rendre au stock du Product lié la quantity requise.
         if($reservation->getProduct()){
             $product = $reservation->getProduct();
             //On ajouter au $stock du Product lié la Quantity de notre Reservation , 
             // avant de persister le Product
             $product->setStock($product->getStock() + $reservation->getQuantity());
             //exemple : avant l'achat d'un produit à stock = 70
             //je prends quantité à 20 , donc stock 50 et quantité 20; => c'est avant la méthode delete!!
             // avant la méthode ici $stock = 20
             //si je flush , c'est-à-dire je supprime la reservation je rajouter 50 à 20; 
             // et je reviens à stock = 70 
             $entityManager->persist($product);
         }

         // Si la Reservation de notre Order est la dernière présente , nous
         //supprimons egalement notre commande 
         $order = $reservation->getOrder();
         $order->removeReservation($reservation); // je retire la réservation de Order
        if($order->getReservations()->isEmpty()){
            $entityManager->remove($order);//On supprime la commande si elle est vide
        }
        
            $entityManager->remove($reservation);
            $entityManager->flush();
            $request->getSession()->set('message_title','Suppression réservation');
            $this->addFlash('info','Votre réservation a bien été supprimée de la commande.');
            $request->getSession()->set('status','green');
        

        // else{
        //     $request->getSession()->set('message_title','Validation commande');
        //     $this->addFlash('info','La commande étant validée vous ne pouvez pas supprimer cette réservation.');
        //     $request->getSession()->set('status','red');
        // } 
        //il n'y a plus d'intérêt puisque la commande est validée et le bouton est supprimée
        return $this->redirectToRoute("client_backoffice");
    }

        //Cette méthode permet de supprimer une commande en attente (statut panier)
        #[Route("/order/delete/{orderId}",name:"order_delete_client")]
        public function deleteOrder(int $orderId,ManagerRegistry $managerRegistry,Request $request): Response{
           
            $user = $this->getUser();

            $entityManager = $managerRegistry->getManager();
            $orderRepository = $entityManager->getRepository(Order::class);
            $order = $orderRepository->find($orderId);
    
            $reservationRepository = $entityManager->getRepository(Reservation::class);
            $reservations = $reservationRepository->findBy(["order"=>$order]);
            
            if(!$order|| !$reservations || $order->getStatus() != "panier")
            { 
                return $this->redirectToRoute("client_backoffice");
            } 
    
            if(!$order || $order->getStatus() == "panier" || ($order->getUser() != $user)){
           
                
                 // OU (une autre façon)
                  foreach($order->getReservations() as $reservation){
                  $product = $reservation->getProduct();
                  
                  $product->setStock($product->getStock() + $reservation->getQuantity());
                  $entityManager->persist($product);
                 $entityManager->remove($reservation);
                 }
                 
                $entityManager->remove($order);
                $entityManager->flush();
                
                $request->getSession()->set('message_title','Suppression commande');
                $this->addFlash('info','Votre commande a bien été supprimée.');
                $request->getSession()->set('status','green');
            }
            return $this->redirectToRoute("client_backoffice");
       
        }
}
