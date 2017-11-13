# Aula prática

Desenvolva uma aplicação que realize as operações de CRUD para a entidade `Album`. A funcionalidade precisa estar disponível com UI (interface para o usuário).
As demais informações podem ser inseridas via `script sql`.

```java
class Album{
    private Estilo estilo; //Rock, Pop, Sertanejo
    private Banda banda;
    private LocalDate anoDeLancamento;
}
class Banda{
    private String nome;
    private String localDeOrigem;
    private List<String> integrates;
}
enum Estilo{
    Rock,
    Pop,
    Sertanejo;
}
```

## Recuperando do banco

Usando a enumeração `Estilo` podemos recuperá-la do banco da seguinte forma:

```java
result.getString("estilo")
result.getInt("estilo")
Estilo rock = Estilo.valueOf("Rock")
```
