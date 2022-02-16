//Autor: Prof. Fabio Santos (fssilva@uea.edu.br)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CryptoCreatures is ERC721 {
    
    struct Creature{
       string name;
       uint LifeLevel;
       uint attackEnergy;
       uint defenseEnergy;
       address owner;
   }

   Creature[] public creaturesList; 
   address gameOwner;

    constructor () ERC721("CryptoCreatures Token", "CCT") {
        gameOwner = msg.sender;       
    }
    
    modifier onlyOwnerOf(uint _creatureId_1) {
        require(creaturesList[_creatureId_1].owner == msg.sender, "Deve ser o proprietario da criatura para batalhar");
        _;
    }

   function createCreature(string memory _name, address _to) public {
       uint creatureId = creaturesList.length;
       creaturesList.push(Creature(_name, 1, 100, 100, _to));
       _safeMint(_to, creatureId);
    }

    function battle(uint _creatureId_1, uint _creatureId_2) onlyOwnerOf(_creatureId_1) public {

       Creature storage creature_1 =  creaturesList[_creatureId_1];
       Creature storage creature_2 =  creaturesList[_creatureId_2];

       if (creature_1.attackEnergy >= creature_2.defenseEnergy) {
           creature_1.LifeLevel +=1;
           creature_1.attackEnergy +=10;           
       } else {
            creature_2.LifeLevel +=1;
            creature_2.defenseEnergy +=10;  
       }

    }

}