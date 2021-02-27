using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Behaviour_BadPingouin : MonoBehaviour
{
    string state;
    // Start is called before the first frame update
    void Start()
    {
        state = "waiting";
    }

    // Update is called once per frame
    void Update()
    {
        switch(state){
            case "walking":
                TowardPlayer();
                break;
            case "light":
                LightAttack();
                break;
            case "attack":
                Attack();
                break;
            case "spe":
                SpeAttack();
                break;
            case "taunt":
                Taunt();
                break;
            
        }
    }
    void LightAttack(){

    }
    void Attack(){

    }
    void SpeAttack(){
        
    }
    void TowardPlayer(){
    }
    void Taunt(){

    }
}
