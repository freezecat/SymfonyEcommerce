<?php

namespace App\Entity;

use App\Repository\OrderRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;


#[ORM\Entity(repositoryClass: OrderRepository::class)]
#[ORM\Table(name: '`order`')]
class Order
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $status;

    #[ORM\Column(type: 'datetime')]
    private $creationDate; 

    #[ORM\OneToMany(targetEntity:'App\Entity\Reservation',mappedBy:'order')]
    #[ORM\JoinColumn(nullable:true)]
    private $reservations;

    
    #[ORM\ManyToOne(targetEntity:'App\Entity\User',inversedBy:'orders')]
    #[ORM\JoinColumn(nullable:true)]
    private $user; 

    public function __construct()
    {
        $this->reservations = new ArrayCollection();
        $this->status = "panier"; //Chaque nouvelle commande est automatiquement en mode "panier"
        $this->creationDate = new \DateTime("now");
        //On génère un objet DateTime configuré à l'instant de la génération de notre 
        //instance d'Entity
    }

    public function getTotalPrice(): int{
        //Cette méthode rend le prix total d'une commande , en additionnant
        // la valeur price d'une commande de chaque produit lié à une de ses
        // réservations, multipliée par la $quantity de ces dernières.

        $totalprice =0;
        foreach($this->reservations as $reservation){
           // $totalprice += $reservation->getPrice()*$reservation->getQuantity();
           $totalprice += $reservation->getReservedPrice();
        }
        return $totalprice;
    }
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

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

    /**
     * @return Collection<int, Reservation>
     */
    public function getReservations(): Collection
    {
        return $this->reservations;
    }

    public function addReservation(Reservation $reservation): self
    {
        if (!$this->reservations->contains($reservation)) {
            $this->reservations[] = $reservation;
            $reservation->setOrder($this);
        }

        return $this;
    }

    public function removeReservation(Reservation $reservation): self
    {
        if ($this->reservations->removeElement($reservation)) {
            // set the owning side to null (unless already changed)
            if ($reservation->getOrder() === $this) {
                $reservation->setOrder(null);
            }
        }

        return $this;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
    {
        $this->user = $user;

        return $this;
    }
}
