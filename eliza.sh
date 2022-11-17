#!/bin/bash
# eliza.sh
#   script simulando o funcionamento do sistema ELIZA, de Joseph Weizenbaum
#
# Versão:
#   0.1 MVP
#
# Autores:
#   Lucas Mendonça Emery Cade

### TODO:
# Ordenar a frase em um arquivo para usar "BLAHs"
# Definir o caso de . ou ,
# 

### Erros atuais:
# Problema do -gt não funcionar quando a linha em keywords.txt tem um '\n'
#



echo "Boa tarde!"

# Dividir a entrada em palavras separadas por espaço, criar a keystack
while IFS=' ' read -p "> " entrada; do    
    highest_weight=0

    rm -f keystack.txt
    touch keystack.txt

    # Interromper o programa se sair ou exit
    [[ "$entrada" == "sair" || "$entrada" == "exit" ]] && break

    for i in ${entrada[@]}; do        
        # Procurar cada palavra no arquivo de keywords
        kw=$(grep -i $i keywords.txt)
        #echo "KW: $kw"
        
        # Caso essa keyword exista
        if ! [ -z "$kw" ]; then
            
            declare -i weight
            weight=$(awk -F ';' '{print int($2)}' <<< $kw)
            
            #echo "Weight: $weight"
            #echo "Highest: $highest_weight"

            # Verificar se o peso é maior que a keyword mais relevante atualmente
            if [ $weight -gt $highest_weight ]; then
                
                # Mudar a keyword mais relevante atualmente
                highest_weight=$weight
                #echo "New highest: $highest_weight"

                keywordest=$(echo "$kw" | cut -d';' -f1)
                #echo "Keywordest: $keywordest"

                # Colocar a keyword no topo da stack
                echo -e "$kw\n$(cat keystack.txt)" > keystack.txt
            else 
                # Se o peso for menor
                # Colocar a keyword no fundo da stack
                #echo "Peso menor"
                echo -e "$kw" >> keystack.txt
            fi
        fi
    done

    # Caso nenhuma keyword seja encontrada
    if [ $highest_weight -eq 0 ]; then

        # Usar uma keyword genérica aleatória para puxar assunto
        randint=$(( $RANDOM % 3 + 1 ))
        keywordest="void$randint"
        #echo "Random keywordest: $keywordest"
    fi

    # Buscar uma resposta da keyword no arquivo de respostas
    resp=$(grep -i "$keywordest;" responses.txt | cut -d ";" -f2-)
    
    cont=$(echo -n "$resp" | grep -c '^')
    
    echo "$resp"
        
    #if [ $cont -gt 1 ]; then
    #    randint=$(( $RANDOM % $cont + 1 ))
    #    echo "Rand: $randint"
    #    newresp=$(echo $resp | sed -n ${randint}p)
    #fi
    
    #echo "$newresp"
done