*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

#Aqui importo a palavra reservada que criei "quase que um componente meu"
Resource       ../resources/base.robot
Library        FakerLibrary


*** Variables ***

${name}                Cleyton Silva
${email}               cleyton2@hotmail.com
${password}            123456


*** Test Cases ***
Deve poder cadastrar um novo usuario

    #Fiz instalação do pymongo com pip install pymongo, servirá para conectar a BD mongo e deletar itens
	#criei a folder libs, dentro dela criei o database.py e lá fiz o meu uso de bd

    #Massa de testes dinamica caso eu queira usar dados da lib faker
    # ${name}            FakerLibrary.Name
	# ${email}           FakerLibrary.Free Email
    # ${password}        Set Variable     pwd123

	#Usar dados fixos local, ou seja, so serve estas variaveis para este cenario
	# ${name}        Set Variable        Cleyton Silva
    # ${email}       Set Variable        cleyton2@hotmail.com
    # ${password}    Set Variable        123456


    #removo o usuario acima (caso ja esteja criado na BD) e só depois é que irei iniciar  a sessão
    remove user from database          ${email}



    Start Session

	#mas preciso ir para a pagina de login e StartSession so vai ate a home, por isto, uso o Go To
	Go To            http://localhost:3000/signup

    #Checkpoints - Validação
	# Aqui estou dizendo que vamos procurar pelo h1 com uso de xpath, que devera estar visivel e que tem ate 5 segundos para achar
	Wait For Elements State    xpath=//h1        visible        5
	# Verificando se o texto esta mesmo presente com usso de css selector
    Get Text                   css=h1        equal          Faça seu cadastro



	Fill Text    id=name            ${name}
    Fill Text    id=email           ${email}
	Fill Text    id=password        ${password}

	Click        id=buttonSignup


    #Validação se aparece no final do cadastro a informação de usuario cadastrado com sucesso
	Wait For Elements State    css=.notice p        visible             5
	Get Text                   css=.notice p        equal               Boas vindas ao Mark85, o seu gerenciador de tarefas.


    sleep            5



Não deve permitir o cadastro com email duplicado
    #esta tags, é igual a @smoke do cypress, criação de tag especifica
	#Para rodar um teste com a tag especifica o comando seria: robot -d ./logs -i nomedatag tests/signup.robot
    [Tags]    dup
    Start Session

    Go To            http://localhost:3000/signup

	Wait For Elements State    xpath=//h1        visible        5
    Get Text                   css=h1        equal          Faça seu cadastro


	Fill Text    id=name            ${name}
    Fill Text    id=email           ${email}
	Fill Text    id=password        ${password}

	Click        id=buttonSignup


    Wait For Elements State    css=.notice p        visible             5
	Get Text                   css=.notice p        equal               Oops! Já existe uma conta com o e-mail informado.
