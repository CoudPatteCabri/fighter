<?php

namespace App\DataFixtures;

use App\Entity\Champion;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class ChampionFixturesCreole extends Fixture
{
    public function load(ObjectManager $manager): void
    {

        $champion = new Champion();
        $champion->setName("test")
            ->setPv(3000)
            ->setPower("500");
        $manager->persist($champion);

        $manager->flush();
    }
}
