<?php

namespace App\Controller;

use App\Entity\Tag;
use App\Entity\Product;
use App\Entity\Category;
use App\Entity\Order;
use App\Entity\Reservation;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class IndexController extends AbstractController
{
    #[Route('/', name: 'app_index')]
    public function index(ManagerRegistry $managerRegistry): Response 
    {
        //Nous récupérons notre Utilisateur
        $user = $this->getUser();

        $products = [];
        //on ajoute au tableau $products 15 élements ['name'=>uniqid()]
        //pour le terminal : php bin/console make:entity , mettre tjrs le nom de l'entité en Majuscule
        //string et text: string estt limitée à 255 et pas text
        // for($i=0;$i<4;$i++){
        //     array_push($products,['name'=>uniqid()]);
        // }
       
        
        $entityManager = $managerRegistry->getManager();
        $productRepository = $entityManager->getRepository(Product::class);
        //On récupère tous les éléments Product
        $products = $productRepository->findAll();
      

        $categoryRepository = $entityManager->getRepository(Category::class);
        //On récupère tous les éléments Product
        $categories = $categoryRepository->findAll();

        //On crée une 'selectedCategory" sous la form d'un tableau associatif
        $selectedCategory = [
            "name" => "Symfony eCommerce",
            "description"=>"Bienvenue sur la page d'accueil de notre magasin de mobilier ."
        ];
         return $this->render('index/index.html.twig', [
            'products'=>$products,
            'categories'=>$categories,
            'selectedCategory'=>$selectedCategory,
            'controller_name' => 'IndexController',
            'user'=>$user
        ]);
    }

    // #[Route('/category/{categoryId}', name: 'index_category')]
    // public function indexCategory($categoryId,ManagerRegistry $managerRegistry): Response 
    // {
    //     $entityManager = $managerRegistry->getManager();
   
    //     $categoryRepository = $entityManager->getRepository(Category::class);

    //     $category = $categoryRepository->findOneBy(["id"=>$categoryId]);
    //     //on affiche que les produits dont le categoryId est identique dans la bdd
    //    // $products = $productRepository->findBy(["id"=>$categoryId]);
    //     $products = $category->getProducts(); //voir category.php (entity)
    //     return $this->render('index/index.html.twig',[
    //         'category'=>$category,
    //          'products'=>$products,
    //         'controller_name'=>'IndexController'
    //     ]); 
    // }
    //correction

    #[Route('/category/{categoryName}', name: 'index_category')]
    //$categoryName="" delivre un warning que je charge la page la 1re fois localhost:8000
    public function indexCategory(string $categoryName/*=''*/,ManagerRegistry $managerRegistry): Response 
    {
        //Cette méthode renvoie uniquement de la Catégorie récupérée via les 
        //renseignements placés dans notre URL 
        //Nous avons besoins de l'Entity Manager et du Repository pertinent
        $entityManager = $managerRegistry->getManager(); 
   
        $categoryRepository = $entityManager->getRepository(Category::class);

        //Liste des categories
        $categories = $categoryRepository->findAll();
        //Nous récupérons la Catégory qui nous intéresse. Si elle n'est pas trouvée, 
        //nous retournons tout simplement à l'index
       // $category = $categoryRepository->find($categoryId);
       $category = $categoryRepository->findOneBy(['name'=>$categoryName]);
       //Si la recherche n'abouti pas, la valeur de Category équivaut à null, et la 
       //condition suivante !$category est validée.
       if(!$category){ 
           return $this->redirectToRoute("app_index");
       }
       //Nous allons transformer la Collection $products en Array classique PHP 
       //afin d'utiliser la méthode array_reverse et obtenir les éléments
       //les plus récents en premier
        $products = $category->getProducts()->toArray(); //voir category.php (entity)
        $products = array_reverse($products);
        return $this->render('index/index.html.twig',[
            'categories'=>$categories, 
             'products'=>$products,
            'controller_name'=>'IndexController',
            "selectedCategory" => $category
        ]);
    }  

    #[Route('tag/{tagId}', name: "index_tag")]
    public function indexTag(int $tagId,ManagerRegistry $managerRegistry): Response{
        //Cette méthode publie le catalogue des Products liés à un Tag en particulier , dont l'Id
        //est renseigné via notre URL
        //Afin de pouvoir récupérer le Tag conerné et les éléments qui y sont liés, nous avons<
        //besoin de l'Entity Manager et du Repository pertinent
        $entityManager = $managerRegistry->getManager();
        $tagRepository = $entityManager->getRepository(Tag::class);
        //Liste des catégories;
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();
        //Nous recherchons notre Tag via son ID via la méthode find() du Repository.Si la recherche
        // est infructueuse , nous retournons à l'index
        $tag = $tagRepository->find($tagId);
        //En condition supplémentaire, nous indiquons que si aucun Product n'est lié au tag 
        //(si le tableau de Product du Tag est vide), nous retournons à l'index.Etant donné qu'il
        //s'agit de la seconde condition préalable à la vérification de la non-nullité de $tag,
        //cela signifie que cette condition est directement ignorée si $tag vaut null, 
        //ce qui nous préserve du risque d'une erreur , !$tag en premier !
        // sinon on ne peut pas vérif le second.
        if(!$tag || empty($tag->getProducts())){
            return $this->redirectToRoute('app_index');
        }
        //Une fois que notre tag est retrouvé , nous récupérons les Products qui lui sont liés
        $products = $tag->getProducts();
        //Nous transmettons les Produits , le Tag (sous le nom "selectedCategory") et nos 
        //Categories à index.html.twig
        return $this->render('index/index.html.twig',[
            'categories'=>$categories, // pour le header.html.twig
            'selectedCategory' => $tag,
            'products'=>$products,
            'tagId'=>$tagId
        ]);
    }

    //Cette méthode affiche les informations relaties à une instance d'Entity de type
    //Product dont l'ID correspond à la valeur du paramètres de route indiquée dans
    //notre URL .
    //Nous récupérons l'Entity Manager et le Repository pertinent afin de pouvoir 
    //dialoguer avec notre base de données.
    #[Route('/product/display/{productId}', name: 'display_product')]
    public function displayProduct(int $productId,Request $request,ManagerRegistry $managerRegistry): Response 
    {
        //on communique avec la bdd pour récupérer le produit dont l'id vaut $productId
        $user = $this->getUser();
        $entityManager = $managerRegistry->getManager();
        $productRepository = $entityManager->getRepository(Product::class);

        //creation formulaire d'achat productForm
        $productForm = $this->createFormBuilder()
        ->add('quantite',IntegerType::class,[
            'label'=>'quantite', 
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

        
            //On récupère la liste des catégories pour notre header
            $categoryRepository = $entityManager->getRepository(Category::class);

            //Liste des categories
            $categories = $categoryRepository->findAll();
        //Nous utilisons la méthode find() du Répository afin de pouvoir retrouver le Product
        //qui nous intéresse. Si le résultat est null, nous retournons à notre page d'index.
        
        $product = $productRepository->findOneBy(["id"=>$productId]); // ou find($productId])
        
        if(!$product){
            return $this->redirectToRoute("app_index");
        }
        $category = $product->getCategory()->getName();

        //Nous appliquons l'objet Request sur notre formulaire
        $productForm->handleRequest($request);
        // si le formulaire est validé:

            if($request->isMethod('post') && $productForm->isValid() && $user){ // ou $request->isSubmitted() au lieu de method post
                $data = $productForm->getData();
                if($product->getStock()>0){
                   //Nous créons une instance de Réservation
                   $reservation = new Reservation; 
                   $reservation->setProduct($product);
                   //Nous verifions s'il existe une instance de Order avec un status "panier".
                   //Si oui, nous ajoutons notre Reservation à cette Commande/Order.Si non,
                   //nous la créons 
                   $orderRepository = $entityManager->getRepository(Order::class);
                   $activeOrder = $orderRepository->findOneBy(["status"=>"panier","user"=>$user]);
                 
                if(!$activeOrder){ // il ne peut y avoir qu'UN SEUL activeOrder dont le statut est "panier"
                       $activeOrder = new Order;
                       $activeOrder->setUser($user);
                   }
                    //reservation en question
                    $activeOrder->setUser($user);
                    $reservation->setOrder($activeOrder);
                   //Une fois après avoir récupéré (ou crée) notre Order, nous le lions à
                   //notre Reservation en question
                    $stock = $product->getStock();

                   
                   
                      
                    if($stock >= $data["quantite"]){
                      $product->setStock($stock-$data["quantite"]);

                      $reservation->setQuantity($data["quantite"]);
                      //j'introduis la nouvelle valeur dans la bdd avec persist puis flush
                      //informe l'utilisateur de son achat par un message + session
                      $request->getSession()->set('message_title','Achat');
                      $this->addFlash('info','Votre achat à bien été effectué.');
                      $request->getSession()->set('status','green');
            
            
                    }
                    else{
                        $product->setStock(0);
                        //on ne peut donner le nombre de produit en stock , car pas assez de produit
                        $reservation->setQuantity($stock);
                        $request->getSession()->set('message_title','Achat');
                        $this->addFlash('info','Il n\'y a pas assez de produits en stock,vous voulez commander '.$data["quantite"]." produits mais il n'en reste que ".$stock.".Vous recevrez donc ".$stock." produits.");
                        $request->getSession()->set('status','red');
                        
                    
                    }
                     
                    $entityManager->persist($product); 
                    $entityManager->persist($reservation);  
                    $entityManager->persist($activeOrder);
                    $entityManager->flush(); 
                    
                    //Rafraichissement de la page
                    return $this->redirectToRoute("display_product",[
                        'productId'=>$product->getId()
                    ]);

                   
                  } 
                  else{
                    $request->getSession()->set('message_title','Achat');
                    $this->addFlash('info','Le produit est en rupture de stock.');
                    $request->getSession()->set('status','yellow');
                  }
            }

            /**
             * ^categoryRepository = $entityM ...
             * $categories = $cat
             */


       // $tags = $product->getTags() ;
        //$product->getCategory() //fait "appelle" à Entity/category.php puis pour récupérer le nom 
        //on utilise la méthode getName() de category.php donc $product->getCategory()->getName();
        //Si nous avons récupéré notre product avec succès de notre base de données,
        //nous pouvons l'afficher via notre page Twig.

        return $this->render("index/product.html.twig",[
             "productId"=>$productId,
             "product"=>$product,
             "category"=>$category,
             "categories"=>$categories,
             "dataform" =>$productForm->createView(),
             "user" => $user
            // "tags"=>$tags
             
         ]);
    }
    
   // Correction:
    #[Route('/productcorrection/{productId}', name: 'display_productcorrection')]
    public function displayProductCorrection(int $productId,ManagerRegistry $managerRegistry): Response 
    {
      
        $entityManager = $managerRegistry->getManager();
        $productRepository = $entityManager->getRepository(Product::class);
        $categoryRepository = $entityManager->getRepository(Category::class);
        $categories = $categoryRepository->findAll();
        //Nous utilisons la méthode find() du Répository afin de pouvoir retrouver le Product
        //qui nous intéresse. Si le résultat est null, nous retournons à notre page d'index.
        
        $product = $productRepository->findOneBy(["id"=>$productId]); // ou find($productId])
        if(!$product){
            return $this->redirectToRoute("app_index");
        }
      
        //Si nous avons récupéré notre product avec succès de notre base de données,
        //nous pouvons l'afficher via notre page Twig.
        return $this->render("index/display_product.html.twig",[
             "product"=>$product,
            
             "categories"=>$categories
              
         ]);
    }

    
   //Cette méthode décrémente notre Product désigné via l'ID renseignée dans notre 
   //base de donnée de 1.
   
// MODIFICATION : TOUT CE PASSE DANS DISPLAY PRODUCT
//  #[Route('/product/buy/{productId}', name: 'buy_product')]
//    public function buyProduct(int $productId,Request $request,ManagerRegistry $managerRegistry): Response
//    {
//        //Afin de pouvoir daloguer avec notre base de données et récupérere le Product
//    //dont nous désirons décrémenterr le stock, nous avons besoin de L'Entity Manager 
//    //ainsi que du Repository pertinent:
//       $entityManager = $managerRegistry->getManager();
//       $productRepository = $entityManager->getRepository(Product::class);
//       //Nous récupérons le Product dont l'ID est spécifié dans l'URL. Si ce Product n'est 
//       //pas trouvé , nous retournons à l'index
//       $product = $productRepository->find($productId);
//       if(!$product){
//           return $this->redirectToRoute('app_index');
//       }
//       $category = $product->getCategory()->getName();
//       if($product->getStock()>0){
//         $stock = $product->getStock();
//           $product->setStock($stock-1);
//           //j'introduis la nouvelle valeur dans la bdd avec persist puis flush
//           //informe l'utilisateur de son achat par un message + session
//           $request->getSession()->set('message_title','Achat');
//           $this->addFlash('info','Votre achat à bien été effectué.');
//           $request->getSession()->set('status','green');


//           $entityManager->persist($product);  
//           $entityManager->flush(); 

//       }
//       else{
//         $request->getSession()->set('message_title','Achat');
//         $this->addFlash('info','Le produit est en rupture de stock.');
//         $request->getSession()->set('status','yellow');
//       }
   
//       return $this->redirectToRoute("display_product",[
//           "product"=>$product,
//           "productId"=>$productId,
//           "category"=>$category
//       ]);


//    }
}
