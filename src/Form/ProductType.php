<?php

namespace App\Form;

use App\Entity\Product;
use App\Entity\Category;
use App\Entity\Tag;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType; 
use Symfony\Component\Form\Extension\Core\Type\TextareaType;

class ProductType extends AbstractType 
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name',TextType::class,[
                'label'=>'Nom du Produit'
            ])
            ->add('description',TextareaType::class,[
                'label'=>'Description du Produit'
            ])
            ->add('price',NumberType::class,[
                'label'=>'Prix du Produit',
                'scale'=>2, // arrondi 2 chiffres après la virgule
                'attr'=>[ 
                    'min'=>1, //Valeur minimale
                    // on peut ajouter 'class' si on veut styliser
                ]
            ])
            ->add('stock',IntegerType::class,[
                'label'=>'Stock du Produit',
                'attr' => [
                    'min' => 1 //Valeur minimale
                ] 
            ])
            //On veut lier L'Entite Category à Product donc on utilise EntityType au lieu de ChoiceType
            ->add('category',EntityType::class,[
                //EntityType est un champ apparenté à ChoiceType proposant une lisste d'instances 
              //  d'une autre Entity à lier à notre Entity
              'label'=>'categorie', //Désignation du champ
              'class' => Category::class, //Type de l'Entity à lier
              'choice_label' => 'name', //Attribut représentant notre objet visé
              'expanded' => false, // une liste pour false , des boutons radio pour true
              'multiple'=>false  //Plusieurs choix , nécessaire en raison du ManyToMany
              //true pour manyto many mais comme categorie c'est one to many on met à false! sinon problème
            ])
            ->add('tags',EntityType::class,[
                //EntityType est un champ apparenté à ChoiceType proposant une lisste d'instances 
              //  d'une autre Entity à lier à notre Entity
              'label'=>'Tags', //Désignation du champ
              'class' => Tag::class, //Type de l'Entity à lier
              'choice_label' => 'name', //Attribut représentant notre objet visé
              'expanded' => true, // une liste pour false , des boutons radio pour true
              'multiple'=>true //Plusieurs choix , nécessaire en raison du ManyToMany
              //true pour manyto many mais comme categorie c'est one to many on met à false! sinon problème
            ])
            ->add('submit',SubmitType::class,[
                'label'=>'Valider'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Product::class,
        ]);
    }
}
