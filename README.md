#Passos com o `docker-compose`

## Criar as imagens e Executar os serviços

`docker-compose up -d --build`

*`-d`: configura uma execução em background (_Detached mode_)* 
*`--build`: forçar a criação de novas imagens antes da execução dos containers*  

## Encerrar os serviços

`docker-compose down --rmi`

*`---rmi <type>`: remove as imagens, podemos configurar com `all` ou `local`;


#Passos sem o `docker-compose`

## Listar as imagens

`docker image ls`

## Listar os containers

`docker container ls`

## Parar o container

`docker stop <container_id | container_name>`



## Criar o arquivo `Dockerfile` do banco PostgreSQL
```
FROM postgres
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD 12345
ENV POSTGRES_DB pos-cliente
COPY create.sql /docker-entrypoint-initdb.d/
COPY insert.sql /docker-entrypoint-initdb.d/
```
## Criar uma imagem do banco PostgreSQL
`docker build -t ricardojob/banco ./postgres`:  
*`-t`: qual a tag que vamos atribuir a essa imagem*  
*`./postgres`: caminho relativo (ou absoluto) para o arquivo Dockerfile*  


## Criar o arquivo `Dockerfile` da aplicação
```
FROM tomcat
COPY target/app.war ${CATALINA_HOME}/webapps/app.war
```

## Criar uma imagem da aplicação

`docker build -t ricardojob/app .`:  
*`-t`: qual a tag que vamos atribuir a essa imagem*  
*`.`: caminho relativo (ou absoluto) para o arquivo Dockerfile*  

## Executar o container  
`docker run -p 5433:5432 -d --name banco ricardojob/banco` e 
`docker run -p 8081:8080 -d --name app --link banco:host-banco ricardojob/app`:   
*`-p`: o bind entre a porta do host local com a porta do container*  
*`-d`: o container seja executar em background*  
*`--link`: o bind entre os containers, para pertimir que o container da aplicação tenha acesso ao container do banco*  
*`--name`: o nome do container*  




## Executar comandos no container  
Para executarmos comandos necessitamos de executar o comando `docker exec -it <container_id | container_name> <command>`. 
Por exemplo, para termos acesso ao container do banco que configuramos podemos fazer:

`docker exec -it banco /bin/bash`:  
*`-it`: para termos acesso iterativo ao TTY*  
*`banco`: o nome do container que desejamos seja executar determinado comando*  
*`/bin/bash`: o comando que vamos executar no container*  

Após esses passos, teremos acesso ao terminal do container. Podemos acessar o _database_ que definimos no arquivo `Dockerfile` que configura o banco de dados, neste exemplo `pos-cliente`.

`psql -U postgres pos-cliente`:  
*`-U`: usuário configurado*  
*`pos-cliente`: o _database_ que desejamos acessar* 

Alguns comando úteis no `psql`:  
*`\dt`: lista as tabelas do _database_*    
*`select * from cliente;`: seleciona todos os clientes*  
*`INSERT INTO cliente(nome, cpf) VALUES ('Kiko','123.132.121-31');`: insere um novo cliente*    
*`\q`: sair do _database_*  