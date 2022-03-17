<?php

namespace App\Controller;

use App\Entity\Tag;
use App\Entity\Category;
use App\Entity\Product; 
use App\Entity\Order; 
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

#[Route('/admin')]
#[Security('is_granted("ROLE_ADMIN")')] //il n'y a que les admins qui peuvent accéder à ces pages
class AdminController extends AbstractController
{
  

    #[Route('/products', name: 'admin_backoffice')]
    public function adminBackoffice(ManagerRegistry $managerRegistry): Response
    {
        $entityManager = $managerRegistry->getManager();
        $productRepository = $entityManager->getRepository(Product::class);
        //On récupère les catégories pour notre header
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();

        $products = $productRepository->findAll();

        $tagRepository = $entityManager->getRepository(Tag::class);
        $tags = $tagRepository->findAll();

        $selectedCategory = [
            "name" => "Back office administrateur",
            "description"=>"Page administrateur. Ici vous pouvez consultez la liste des produits,créer un produit ,modifier ou supprimer un produit."
        ];

        return $this->render('admin/backoffice_admin.html.twig',[
            "categories"=>$categories,
            "products"=>$products,
            "selectedCategory"=>$selectedCategory,
            "tags"=>$tags
        ]);
    }

    #[Route('/client-backoffice',name:'client_backoffice_admin')]
    public function adminClientBackOffice(ManagerRegistry $managerRegistry): Response{
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

    //    $orderPanier = $orderRepository->findOneBy(["status"=>"panier"],["user_id"=>$user->getId()]); 
    //      $ordersValidees = $orderRepository->findBy(["status"=>"validee"],["id"=>"DESC"],["user_id"=>$user->getId()]);
  
       //$orderPanier = $orderRepository->find($user);
        $orderPanier = $orderRepository->findOneBy(["status"=>"panier"]); 
 
        //ici on a tous les panier validées car on a pas filtrer avec les users
        $ordersValidees = $orderRepository->findBy(["status"=>"validee"],["id"=>"DESC"]);

        //Nous transmettons les commandes à Twig:
        return $this->render('admin/admin_client_backoffice.html.twig',[
            'categories'=>$categories,
            'orderPanier'=>$orderPanier,
            'ordersValidees'=>$ordersValidees
        ]);
    }

    //Cette méthode permet de valider une commande/Order en attente (statut panier)
    //dont l'ID est indiqué sur notre URL.
    #[Route("/order/validate/{orderId}",name:"order_validate")]
    public function vakudateOrder(int $orderId,ManagerRegistry $managerRegistry,Request $request): Response{
        $entityManager = $managerRegistry->getManager();
        $orderRepository = $entityManager->getRepository(Order::class);
        //Nour recherchons l'Order en question selon l'ID qui nous a été transmis.
        //Si l'Order n'est pas trouvé OU que son statut n'est pas "panier",nous
        //retournons au tableau de borrd Commandes.
        $order = $orderRepository->find($orderId);
        if(!$order || $order->getStatus() != "panier")
        {
            return $this->redirectToRoute("client_backoffice_admin");
        }
        if($order->getStatus() == "panier"){
            $order->setStatus("validee"); // ne pas oublier le persist et flush voyons sinon pas de changement dans la bdd!
            $entityManager->persist($order);
            $entityManager->flush();
            $request->getSession()->set('message_title','Validation commande');
            $this->addFlash('info','Votre commande a bien été validée.');
            $request->getSession()->set('status','green');
            return $this->redirectToRoute("client_backoffice_admin");
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
    #[Route("/reservation/delete/{reservationId}",name:"reservation_delete")]
    public function deleteReservation(int $reservationId,ManagerRegistry $managerRegistry,Request $request): Response{
        //Afin de pouvoir récupéerer la Reservation à supprimer , nous avons besoin de
        //l'Entity Manager ainsi que du Repository de Reservation
        $entityManager = $managerRegistry->getManager();
        $reservationRepository = $entityManager->getRepository(Reservation::class);
        $reservation = $reservationRepository->find($reservationId);
        $orderStatus = $reservation->getOrder()->getStatus();

        //on verifie d'abord dans l'ordre si il y a $reservation, puis si 
        //la reservation est lié à une commande $reservation->getOrder() ,
        // !$reservation->getOrder() signifie que la reservation n'est liée à aucune commande
        //et enfin si la commande est en mode panier
        
        if(!$reservation || !$reservation->getOrder() || $orderStatus != "panier")
        { 
            return $this->redirectToRoute("client_backoffice_admin");
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
        return $this->redirectToRoute("client_backoffice_admin");
    }
 
    //Cette méthode permet de supprimer une commande en attente (statut panier)
    #[Route("/order/delete/{orderId}",name:"order_delete")]
    public function deleteOrder(int $orderId,ManagerRegistry $managerRegistry,Request $request): Response{
        $entityManager = $managerRegistry->getManager();
        $orderRepository = $entityManager->getRepository(Order::class);
        $order = $orderRepository->find($orderId);

        $reservationRepository = $entityManager->getRepository(Reservation::class);
        $reservations = $reservationRepository->findBy(["order"=>$order]);
        
        if(!$order|| !$reservations || $order->getStatus() != "panier")
        { 
            return $this->redirectToRoute("client_backoffice_admin");
        } 

        if($order->getStatus() == "panier"){
            //ATTENTION à l'ordre de suppression!! 
            // on supprime d'abord les reservations , puis une fois les reservations vide 
            // on pourra supprimer order
            // sinon erreur à cause des contraintes de clés. //clé étrangere bdd restrict!
            // foreach($reservations as $reservation){
            //     if($reservation->getProduct()){
            //         $product = $reservation->getProduct();
            //         //On ajouter au $stock du Product lié la Quantity de notre Reservation , 
            //         // avant de persister le Product
            //         $product->setStock($product->getStock() + $reservation->getQuantity());
            //         //exemple : avant l'achat d'un produit à stock = 70
            //         //je prends quantité à 20 , donc stock 50 et quantité 20; => c'est avant la méthode delete!!
            //         // avant la méthode ici $stock = 20
            //         //si je flush , c'est-à-dire je supprime la reservation je rajouter 50 à 20; 
            //         // et je reviens à stock = 70 
            //         $entityManager->persist($product);
            //     }
            // $entityManager->remove($reservation);
            // }
            
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
        return $this->redirectToRoute("client_backoffice_admin");
   
    }

    //Cette méthode dirige l'utilisateur vers un formulaire de création de Product et
    //transfère le Product dans la base de données une fois celui-ci renseigné 
    
    #[Route('/create_product', name: 'create_product')]
    public function createProduct(Request $request,ManagerRegistry $managerRegistry): Response
    { 
      
        //Nous avons besoin de dialoguer avec la base de données, donc nous faisons appel à
        //l'Entity Manager
        $entityManager = $managerRegistry->getManager();
 
        //Nous créons une instance d'Entity Product que nous lions à notre formulaire
        $product = new Product; //pour chaque création on fait une instance de Product;
        $productForm = $this->createForm(ProductType::class,$product);

        $productRepository = $entityManager->getRepository(Product::class);
        $products = $productRepository->findAll();

        
        $productRepository = $entityManager->getRepository(Product::class);
        $products = $productRepository->findAll();
 
             //On récupère les catégories pour notre header
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();
        //Nous appliquons les valeurs de notre Request, et si le formulaire est valide, 
        //nous l'envoyons vers notre base de donnée
        $productForm->handleRequest($request);
        if($request->isMethod('post') && $productForm->isValid()){
            if($product->getPrice() >= 1){  
                $request->getSession()->set('message_title','Achat');
                $this->addFlash('info','Le produit a bien été crée.');
                $request->getSession()->set('status','green');
            $entityManager->persist($product);  
            $entityManager->flush(); 
            return $this->redirectToRoute('admin_backoffice');
            }
            else{
                $request->getSession()->set('message_title','Achat');
                $this->addFlash('info','Veuillez indiquer un prix supérieur à 1€.');
                $request->getSession()->set('status','red');
              
            }
            return $this->redirectToRoute('admin_backoffice');
            
        }
        //Si le formulaire n'est pas rempli,nous le présentons à l'utilisateur

        return $this->render('admin/dataform.html.twig',[
            'categories'=>$categories,
            'dataform'=>$productForm->createView(),
            'formName'=>'Création de produit'
        ]); 
    }  
 
    //Cette méthode a pour bojectif de proposer à l'utilisateur un formulaire dédié à la
    //modification d'un Product ré  cupéré de notre base de données via son ID, que 
    //nous renseignons dans l'URL
    #[Route('/update_product/{produitId}', name: 'update_product')]
    public function updateProduct(int $produitId,Request $request,ManagerRegistry $managerRegistry): Response
    {
        //Afin de pouvoir commnuniquer avec notre base de données et récupérer
        //des éléments à partir de cette dernière , nous allons avoir besoin de 
        //l'Entity Manager et du Repository pertinent.
        $entityManager = $managerRegistry->getManager();
        $productRepository = $entityManager->getRepository(Product::class);
       
        //On récupère les catégories pour notre header
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();
        
        //Nous recherchons le Product désiré via une recherche avec l'ID noté dans l'URL,
        //si la recherche n'aboutit pas , nous revenons au backoffice administrateur
        $product = $productRepository->find($produitId); 
        //ici il s'agit de modifier donc on ne fait pas d'instance mais à la place on recherche le produit dont 
        //l'id vaut produitId

        if(!$product){
            
                $request->getSession()->set('message_title','Modification du produit');
                $this->addFlash('info','Le produit indiqué n\'existe pas.');
                $request->getSession()->set('status','red');
                return $this->redirectToRoute('admin_backoffice');
            
        }
       
        $productForm = $this->createForm(ProductType::class,$product);
        $productForm->handleRequest($request);
        if($request->isMethod('post') && $productForm->isValid()){
            if($product->getPrice() >= 1){
                $request->getSession()->set('message_title','Achat');
                $this->addFlash('info','Le produit a bien été modifié.');
                $request->getSession()->set('status','green');
            $entityManager->persist($product);
            $entityManager->flush();
            }
            else{
                $request->getSession()->set('message_title','Achat');
                $this->addFlash('info','Veuillez indiquer un prix supérieur à 1€.');
                $request->getSession()->set('status','red');
                
            }
           
    
            return $this->redirectToRoute('admin_backoffice');
        }
         
        return $this->render('admin/dataform.html.twig',[
            'dataform'=>$productForm->createView(),
            'formName'=>'Modification du produit',
            'produitId'=>$produitId,
            'categories'=>$categories
        ]);

      
    }



    //ATTENTION!: si le produit en question à 1 ou plusieurs tag , on ne peut pas le supprimer (à cause de la table product_tag dans bdd);
    //il faut modifier et décocher tous les tags avant de supprimer le produit.
    #[Route('/delete_product/{produitId}', name: 'delete_product')]
    public function deleteProduct(int $produitId,Request $request,ManagerRegistry $managerRegistry): Response
    {
        $entityManager = $managerRegistry->getManager();
        $productRepository = $entityManager->getRepository(Product::class);
        $product = $productRepository->find($produitId); 
        //ici il s'agit de modifier donc on ne fait pas d'instance mais à la place on recherche le produit dont 
        //l'id vaut produitId
    
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();

        if(!$product){
            $request->getSession()->set('message_title','Modification du produit');
                $this->addFlash('info','Le produit indiqué n\'existe pas.');
                $request->getSession()->set('status','red');
                return $this->redirectToRoute('admin_backoffice');
        }
       
        $productForm = $this->createForm(ProductType::class,$product);
        $productForm->handleRequest($request);
        if($request->isMethod('post') && $productForm->isValid()){
            $request->getSession()->set('message_title','Achat');
            $this->addFlash('info','Le produit a bien été supprimé.');
            $request->getSession()->set('status','green');
            $entityManager->remove($product);
            $entityManager->flush();
             
           
    
            return $this->redirectToRoute('admin_backoffice');
        }
         
        return $this->render('admin/dataform.html.twig',[
            'dataform'=>$productForm->createView(), 
            'produitId'=>$produitId,
            'formName'=>'Suppression de produit',
            'categories'=>$categories
        ]); 

    }

    #[Route('/tag/create', name: 'tag_create')]
    public function createTags(Request $request,ManagerRegistry $managerRegistry): Response
    {
        //Ceete méthode permet à l'utilisateur de cr    éer jusqu'à 5 Tags via un formulaire
        //Afin de pouvoir communiquer avec notre base de données, nous avons besoin de l'Entity Manager
        //ainsi que du Repository de Tag
        $entityManager = $managerRegistry->getManager();
        $tagRepository = $entityManager->getRepository(Tag::class);
        //Nous utilisons le Form Builder pour créer notre propre formulaire champ par champ
        // on a pas utiliser la console pour avoir tagForm
        //on utilise createFormBuilder au lieu de createForm ,
        //car on a besoin de ce formulaire que dans /tag/create/ seulement , pas de besoin d'externaliser le formulaire
        //contrairement au CRUD 
        $tagsForm = $this->createFormBuilder()
        ->add('tag1',TextType::class,[
            'label'=>'Tag #1', 
            'required'=>false, //remplir le champ n'est pas nécessaire
             'attr' => [
                 'class'=>"w3-imput w3-border w3-round w3-light-grey"
             ]
        ])
        ->add('tag2',TextType::class,[
            'label'=>'Tag #2', 
            'required'=>false, //remplir le champ n'est pas nécessaire
             'attr' => [
                 'class'=>"w3-imput w3-border w3-round w3-light-grey"
             ]
        ])
        ->add('tag3',TextType::class,[
            'label'=>'Tag #3', 
            'required'=>false, //remplir le champ n'est pas nécessaire
             'attr' => [
                 'class'=>"w3-imput w3-border w3-round w3-light-grey"
             ] 
        ])
        ->add('tag4',TextType::class,[
            'label'=>'Tag #4', 
            'required'=>false, //remplir le champ n'est pas nécessaire
             'attr' => [
                 'class'=>"w3-imput w3-border w3-round w3-light-grey"
             ]
        ])
        ->add('tag5',TextType::class,[
            'label'=>'Tag #5', 
            'required'=>false, //remplir le champ n'est pas nécessaire
             'attr' => [
                 'class'=>"w3-imput w3-border w3-round w3-light-grey"
             ]
             ])
        ->add('submit',SubmitType::class,[
            'label'=>'valider',
            'attr'=>[
                'class'=>'w3-button w3-black w3-margin-bottom',
                'style'=>'margin-top:10px'
            ]
        ])
        ->getForm();

        //Nous appliquons l'objet Request sur notre formulaire
        $tagsForm->handleRequest($request);
        //Sil le formulaire est validé.
        if($request->isMethod('post') && $tagsForm->isValid()){
            //On récupère les valeurs de notre formulaire
            //La méthode getData() rrend un tableau associatif qui possède les valeurs de chaque
            //champ de notre formulaire et ainsi les valeurs de nos cinq tags
            $data= $tagsForm->getData();
            for($i=1; $i< 6;$i++){
                if(!empty($data['tag'.$i])){ // verifie si le champ tag1 , tag2 ... sont remplis
                    //s'ils sont remplis on ajoute leur tag dans la bdd
                    $tagName = $data['tag'.$i]; //On récupère la valeur du Champ
                    //On instancie un nouveau Tag à faire persister
                    $tag = new Tag;
                    $tag->setName($tagName);
                    $request->getSession()->set('message_title','Achat');
                    $this->addFlash('info','Le tag a bien été crée.');
                    $request->getSession()->set('status','green');
                    $entityManager->persist($tag);
                }
            }
            $entityManager->flush(); //On applique toutes les demandes de persistance
            //On retourne ensuite au backoffice
            return $this->redirectToRoute('admin_backoffice');

        }
        //Si le formulaire n'est pas valider , nous le présentons à l'utilisateur
        return $this->render("admin/dataform.html.twig",[
            'formName'=>'Creation de Tags',
            'dataform'=>$tagsForm->createView()
        ]);
     }

    //1 ere méthode avec createFormBuilder (sans le php/bin console make:form et createForm) : elle marche!!
    //  #[Route('/tag/update/{tagId}', name: 'tag_update')]
    //  public function updateTag(int $tagId, Request $request,ManagerRegistry $managerRegistry): Response
    //  {
    //     $entityManager = $managerRegistry->getManager();
    //     $tagRepository = $entityManager->getRepository(Tag::class);
    //     $tag = $tagRepository->find($tagId);
    //     $tagsForm = $this->createFormBuilder()
    //     ->add('tag',TextType::class,[
    //         'label'=>'Tag', 
    //         'required'=>false, //remplir le champ n'est pas nécessaire
    //          'attr' => [
    //              'class'=>"w3-imput w3-border w3-round w3-light-grey",
    //              'value'=>$tag->getName()
    //          ],
             
    //     ])
    //     ->add('submit',SubmitType::class,[
    //         'label'=>'valider',
    //         'attr'=>[
    //             'class'=>'w3-button w3-black w3-margin-bottom',
    //             'style'=>'margin-top:10px'
    //         ]
    //     ])
    //     ->getForm();
        
    //     $tagsForm->handleRequest($request);
    //     if($request->isMethod('post') && $tagsForm->isValid()){
    //         $data= $tagsForm->getData();
    //         if(!empty($data['tag'])){
    //         $tag->setName($data['tag']);
    //         $entityManager->persist($tag);
    //         }
    //         $entityManager->flush();
    //         return $this->redirectToRoute('admin_backoffice');
    //     }
    //     return $this->render("admin/dataform.html.twig",[
    //         'formName'=>'Modification de Tags',
    //         'dataform'=>$tagsForm->createView(),
    //         "tagId"=>$tagId,
    //         "name"=>$tag->getName()
            
    //     ]); 


    //  }

    //  #[Route('/tag/delete/{tagId}', name: 'tag_delete')]
    //  public function deleTag(int $tagId, Request $request,ManagerRegistry $managerRegistry): Response
    //  {
    //     $entityManager = $managerRegistry->getManager();
    //     $tagRepository = $entityManager->getRepository(Tag::class);
    //     $tag = $tagRepository->find($tagId);
    //     $tagsForm = $this->createFormBuilder()
    //     ->add('tag',TextType::class,[
    //         'label'=>'Tag', 
    //         'required'=>false, //remplir le champ n'est pas nécessaire
    //          'attr' => [
    //              'class'=>"w3-imput w3-border w3-round w3-light-grey",
    //              'value'=>$tag->getName()
    //          ],
             
    //     ])
    //     ->add('submit',SubmitType::class,[
    //         'label'=>'valider',
    //         'attr'=>[
    //             'class'=>'w3-button w3-black w3-margin-bottom',
    //             'style'=>'margin-top:10px'
    //         ]
    //     ])
    //     ->getForm();
        
    //     $tagsForm->handleRequest($request);
    //     if($request->isMethod('post') && $tagsForm->isValid()){
    //         $data= $tagsForm->getData();
    //         if(!empty($data['tag'])){
    //        // $tag->setName($data['tag']);
    //         $entityManager->remove($tag);
    //         }
    //         $entityManager->flush();
    //         return $this->redirectToRoute('admin_backoffice');
    //     }
    //     return $this->render("admin/dataform.html.twig",[
    //         'formName'=>'Modification de Tags',
    //         'dataform'=>$tagsForm->createView(),
    //         "tagId"=>$tagId,
    //         "name"=>$tag->getName()
            
    //     ]); 
    //  } 

   
     #[Route('/tag/update/{tagId}', name: 'tag_update')]
     public function updateTag(int $tagId, Request $request,ManagerRegistry $managerRegistry): Response
     {
        $entityManager = $managerRegistry->getManager();
        $tagRepository = $entityManager->getRepository(Tag::class);
       
        //On récupère les catégories pour notre header
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();
        
        //Nous recherchons le Product désiré via une recherche avec l'ID noté dans l'URL,
        //si la recherche n'aboutit pas , nous revenons au backoffice administrateur
        $tag = $tagRepository->find($tagId); 
        //ici il s'agit de modifier donc on ne fait pas d'instance mais à la place on recherche le produit dont 
        //l'id vaut produitId

        if(!$tag){
            $request->getSession()->set('message_title','Modification du produit');
            $this->addFlash('info','Le tag indiqué n\'existe pas.');
            $request->getSession()->set('status','red');
            return $this->redirectToRoute('admin_backoffice');
        }
       
        $tagForm = $this->createForm(TagType::class,$tag);
        $tagForm->handleRequest($request);
        if($request->isMethod('post') && $tagForm->isValid()){
            $request->getSession()->set('message_title','Achat');
            $this->addFlash('info','Le tag a bien été modifié.');
            $request->getSession()->set('status','green');
            $entityManager->persist($tag);
            $entityManager->flush();
            
            
           
    
            return $this->redirectToRoute('admin_backoffice');
        }
         
        return $this->render('admin/dataform.html.twig',[
            'dataform'=>$tagForm->createView(),
            'formName'=>'Modification du produit',
            'tagId'=>$tagId,
            'categories'=>$categories 
        ]);
    } 

    
    #[Route('/tag/delete/{tagId}', name: 'tag_delete')]
    public function deleteTag(int $tagId, Request $request,ManagerRegistry $managerRegistry): Response
    {
       $entityManager = $managerRegistry->getManager();
       $tagRepository = $entityManager->getRepository(Tag::class);
      
       //On récupère les catégories pour notre header
       $categoryRepository = $entityManager->getRepository(Category::class);
       $categories = $categoryRepository->findAll();
       
       //Nous recherchons le Product désiré via une recherche avec l'ID noté dans l'URL,
       //si la recherche n'aboutit pas , nous revenons au backoffice administrateur
       $tag = $tagRepository->find($tagId); 
       //ici il s'agit de modifier donc on ne fait pas d'instance mais à la place on recherche le produit dont 
       //l'id vaut produitId
 
       if(!$tag){
        $request->getSession()->set('message_title','Modification du produit');
        $this->addFlash('info','Le tag indiqué n\'existe pas.');
        $request->getSession()->set('status','red');
        return $this->redirectToRoute('admin_backoffice');
       }
      
       $tagForm = $this->createForm(TagType::class,$tag);
       $tagForm->handleRequest($request);
       if($request->isMethod('post') && $tagForm->isValid()){
        $request->getSession()->set('message_title','Achat');
        $this->addFlash('info','Le tag a bien été supprimé.');
        $request->getSession()->set('status','green');
           $entityManager->remove($tag);
           $entityManager->flush();
           
           
          
   
           return $this->redirectToRoute('admin_backoffice');
       }
        
       return $this->render('admin/dataform.html.twig',[
           'dataform'=>$tagForm->createView(),
           'formName'=>'Modification du produit',
           'tagId'=>$tagId,
           'categories'=>$categories
       ]);
   }

   #[Route('/categories/generate', name: 'category_generate')]
   public function generateCategories(ManagerRegistry $managerRegistry){
    //Cette méthode a pour objectif de générer automatiquement une série de catégories
    //(Chaise, Bureau, Lit , Canapé, Armoire et Autre) pour notre application,
    //après avoir vidé la table MySQL au préalable.

    //Afin de pouvoir communiquer avec notre base de données et notre table Category,
    //nous allons avoir besoin de l'Entity Manager ainsi que du Repository de Category

    $entityManager = $managerRegistry->getManager();
    $categoryRepository = $entityManager->getRepository(Category::class);
    //Nous commençons par vider notre table: nous récupérons tous les éléments avant de 
    //les supprimer un par un
    $categories = $categoryRepository->findAll(); //On récupère toutes les catégories

    $productRepository = $entityManager->getRepository(Product::class);

   

    $tagRepository = $entityManager->getRepository(Tag::class);

    $tags = $tagRepository->findAll();
    
    foreach($categories as $category){ // foreach( $categorie->getProduct() as $product , setCat à null ...
       //Nous parcourons le tableau ici afin de pouvoir effectuer une requête de retrait sur
       // chaque catégorie
       //Afin d'éviter les violations de clef étrangère, nous devons être sûr qu'une 
       //catégorie n'est liée à aucun produit avant de procéder à leur suppression
       
       foreach($category->getProducts() as $product){
           $category->removeProduct($product); //Après cette boucle foreach, 
           //le catalogue de Products lité à notre Catégory sera vide 
           //dans Product les catégorie à "null"
       }
       $entityManager->remove($category);
      
    }
  
    $categoryNames = ["Chaise","Bureau","Lit","Canape","Armoire","Autre"];
    $description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     Aliquam fringilla semper ligula vestibulum mattis.
     Ut in aliquam sapien, in fermentum turpis. Morbi vel mollis est.
      Nulla nec consequat nisi. Pellentesque auctor posuere enim in egestas. 
      Donec suscipit augue eget pulvinar convallis.";

      $categories = [];
      foreach($categoryNames as $categoryName){
          //Création et persistance de chaque category
          $category = new Category;
          $category->setName($categoryName);
          $category->setDescription($description);
          $entityManager->persist($category);
          $categories += [$category->getName() => $category]; 
          //["chaise"=>["name":"chaise","description":"..."],"bureau"=>[...],etc...]
      }
      //Nous récupérons la liste de tous nos Products afin de pouvoir les attacher à nos
      //nouvelles Categories
      $products = $productRepository->findAll();
      foreach($products as $product){
        //Nous parcourons la liste de nos Products; nous vérifions les noms, et nous les
        //attachons en conséquence à nos nouvelles catégories
        $productName = strtolower($product->getName());//strtolower en minuscule pour 
        //éviter les soucies de casse

        //switch(true) nous permet de vérifier l'exactitude (un rendu de la valeur "true)
        // de chacune des propositions ici. Si un de nos Products contient un extrait
        //mentionné (chaise, bureau, etc), le Product est automatiquement lié à la 
        //Category correspondante

        //On a accès au nom de la liste des produits et on associe à chaque nom
        // sa catégorie correspondante si le produit à un nom chaise , on lui 
        //attribut une catégorie chaise
        switch(true){ 

            case str_contains($productName,"chaise"): // si dans $product->getName il y a le mot chaise alors catégorie chaise
            $product->setCategory($categories["Chaise"]); //lie la catégorie chaise (voir ligne 721)
            break;
            case str_contains($productName,"bureau");
            $product->setCategory($categories["Bureau"]);
            break;
            case str_contains($productName,"lit");
            $product->setCategory($categories["Lit"]);
            break;
            case str_contains($productName,"canape");
            $product->setCategory($categories["Canape"]);
            break;
            case str_contains($productName,"canapé");
            $product->setCategory($categories["Canape"]);
            break;
            case str_contains($productName,"armoire");
            $product->setCategory($categories["Armoire"]);
            break;
            default:
            $product->setCategory($categories["Autre"]);
            break;
        }
      }

      $entityManager->flush();

    
   $selectedCategory = [
    "name" => "Back office administrateur",
    "description"=>"Page administrateur. Ici vous pouvez consultez la liste des produits,créer un produit ,modifier ou supprimer un produit."
];



    return $this->render("admin/backoffice_admin.html.twig",[
        "selectedCategory"=>$selectedCategory,
        "products"=>$products,
        "tags"=>$tags
    ]);
   }


}
