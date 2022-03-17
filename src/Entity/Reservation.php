<?php

namespace App\Entity;

use App\Repository\ReservationRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ReservationRepository::class)]
class Reservation
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $quantity;

    #[ORM\Column(type: 'datetime')]
    private $creationDate;

    #[ORM\ManyToOne(targetEntity:'App\Entity\Product',inversedBy:'reservations')]
    #[ORM\JoinColumn(nullable:true)]
    private $product;

    #[ORM\ManyToOne(targetEntity:'App\Entity\Order',inversedBy:'reservations')]
    #[ORM\JoinColumn(nullable:true)]
    private $order;

    public function __construct(){
        $this->creationDate = new \DateTime("now");
        //On génère un objet DateTime configuré à l'instant de la génération de notre 
        //instance d'Entity
    }

    public function getReservedPrice(): float{
        //Cette méthode rend le prix total de la Réservation, par rapport au Product lié
        return $this->product->getPrice()*$this->quantity;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getQuantity(): ?int
    {
        return $this->quantity;
    }

    public function setQuantity(int $quantity): self
    {
        $this->quantity = $quantity;

        return $this;
    }

    public function getCreationDate(): ?\DateTimeInterface
    {
        return $this->creationDate;
    }

    public function setCreationDate(\DateTimeInterface $creationDate): self
    {
        $this->creationDate = $creationDate;

        return $this;
    }

    public function getProduct(): ?Product
    {
        return $this->product;
    }

    public function setProduct(?Product $product): self
    {
        $this->product = $product;

        return $this;
    }

    public function getOrder(): ?Order
    {
        return $this->order;
    }

    public function setOrder(?Order $order): self
    {
        $this->order = $order;

        return $this;
    }
}
