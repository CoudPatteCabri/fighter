<?php
// src/EventListener/UserCreationListener.php
namespace App\EventListener;

use App\Entity\Champion;
use App\Entity\User;
use App\Entity\UserChampion;
use Doctrine\Persistence\ManagerRegistry;

class UserCreationListener
{
    private $registry;

    public function __construct(ManagerRegistry $registry)
    {
        $this->registry = $registry;
    }

    public function postPersist(User $user)
    {
        // Obtenir l'EntityManager
        $entityManager = $this->registry->getManager();

        // Sélectionner un champion pour l'utilisateur (vous pouvez implémenter votre propre logique de sélection ici)
        $champion = $entityManager->getRepository(Champion::class)->findOneBy([]);

        // Créer une nouvelle relation user_champion et l'associer à l'utilisateur et au champion sélectionné
        $userChampion = new UserChampion();
        $userChampion->setUser($user);
        $userChampion->setChampion($champion);

        // Enregistrer la relation dans la base de données
        $entityManager->persist($userChampion);
        $entityManager->flush();
    }
}
