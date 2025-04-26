### O que é **ORM**?

**ORM** (Object-Relational Mapping) é um padrão de design que permite mapear objetos de um programa para tabelas de um banco de dados relacional, e vice-versa. Em outras palavras, o ORM permite que você trabalhe com bancos de dados relacionais de forma orientada a objetos, sem a necessidade de escrever SQL manualmente para realizar operações de leitura, inserção, atualização ou exclusão de dados.

Esse conceito visa facilitar a interação com bancos de dados, transformando registros de tabelas em objetos do código (e objetos de código em registros de tabelas), tornando a comunicação com o banco de dados mais intuitiva e mais fácil de manter.

### 📌 **Por que usar ORM?**

- **Abstração de SQL**: O ORM fornece uma camada de abstração que permite que você se concentre na lógica de negócios, em vez de escrever SQL detalhado para interagir com o banco de dados.
- **Código mais legível**: Com o ORM, você trabalha com classes e objetos em vez de usar comandos SQL complicados. Isso torna o código mais fácil de ler e manter.
- **Portabilidade**: Usando ORM, você pode escrever o código de manipulação de banco de dados sem se preocupar com o tipo de banco de dados subjacente (MySQL, PostgreSQL, SQLite, etc.). Trocar de banco de dados geralmente requer poucas ou nenhuma alteração no código.
- **Validação de dados**: Algumas bibliotecas ORM, como o SQLAlchemy, também fazem validações de dados, como checar tipos e garantir que as chaves primárias ou estrangeiras estejam corretamente definidas.

---
### 📌 **Como funciona o ORM?**

Quando você usa um ORM, você define suas tabelas de banco de dados como classes Python. Cada instância de uma classe representa uma linha na tabela, e os atributos dessa classe representam as colunas da tabela.

O ORM mapeia automaticamente os objetos para o banco de dados, para que você possa realizar operações como inserir, atualizar, excluir e consultar dados sem precisar escrever SQL manualmente.

### Exemplo:

#### 1. **Definindo uma Tabela (Classe Python)**:

Em um ORM como o SQLAlchemy, você define uma tabela como uma classe Python, usando classes e atributos para representar as tabelas e as colunas do banco de dados.

```python
from sqlalchemy import Column, Integer, String, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String, unique=True)

# Configuração do banco de dados
engine = create_engine('sqlite:///example.db')
Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)
session = Session()

# Criando um novo usuário
new_user = User(name="John Doe", email="john.doe@example.com")
session.add(new_user)
session.commit()

# Consultando usuários
users = session.query(User).all()
print(users)
```

#### 2. **Operações comuns com ORM:**

- **Inserir dados**:
  Para adicionar novos dados ao banco de dados, você cria uma instância do objeto (classe) e a adiciona à sessão do banco.
  
  ```python
  new_user = User(name="Alice", email="alice@example.com")
  session.add(new_user)
  session.commit()
  ```

- **Consultar dados**:
  Você pode consultar dados de uma tabela usando o método `query` fornecido pelo ORM.
  
  ```python
  users = session.query(User).filter_by(name="Alice").all()
  print(users)
  ```

- **Atualizar dados**:
  Para atualizar um registro, você obtém a instância do objeto, altera os atributos e depois confirma a transação.
  
  ```python
  user = session.query(User).filter_by(id=1).first()
  user.name = "Alice Johnson"
  session.commit()
  ```

- **Excluir dados**:
  Para excluir um objeto, você obtém a instância e a remove da sessão.
  
  ```python
  user = session.query(User).filter_by(id=1).first()
  session.delete(user)
  session.commit()
  ```

---
### 📌 **Vantagens do Uso de ORM**

1. **Abstração**:
   Você não precisa se preocupar com detalhes de SQL, como JOINs, GROUP BY, ou mesmo a estrutura de um banco de dados. O ORM faz a conversão entre objetos e tabelas de forma automática.

2. **Segurança contra Injeção de SQL**:
   Usando ORM, você evita a construção manual de consultas SQL, o que diminui as chances de ser vulnerável a ataques de **injeção de SQL**.

3. **Facilidade de manutenção**:
   Como você não precisa escrever SQL diretamente no código, sua base de código fica mais limpa e fácil de manter.

4. **Menos código repetitivo**:
   O ORM permite criar operações CRUD (Create, Read, Update, Delete) sem precisar escrever SQL repetidamente.

---
### 📌 **Desvantagens do Uso de ORM**

1. **Desempenho**:
   Para consultas muito complexas ou operações que exigem controle total sobre o SQL gerado, o ORM pode gerar consultas mais lentas e menos eficientes do que um SQL escrito manualmente.

2. **Abstração excessiva**:
   Em algumas situações, a abstração pode ser um problema, já que o ORM pode não expor todo o poder do banco de dados (ex: SQL avançado ou otimizações específicas de banco).

3. **Curva de aprendizado**:
   Embora o ORM facilite muitas tarefas, o entendimento completo das suas funcionalidades e melhores práticas pode ter uma curva de aprendizado.

---
### 📌 **Exemplos de ORM em Python**

- **SQLAlchemy**:
  O **SQLAlchemy** é um dos ORMs mais poderosos e populares para Python, que oferece tanto uma abordagem ORM quanto uma linguagem de expressão SQL para controle mais fino.

- **Django ORM**:
  O **Django** (um framework web Python) também oferece um ORM interno. Ele é muito fácil de usar e extremamente popular, especialmente em projetos web.

- **Peewee**:
  **Peewee** é um ORM menor, mais simples, ideal para aplicações menores ou para quem precisa de uma alternativa ao Django ORM.

- **Tortoise ORM**:
  O **Tortoise ORM** é um ORM assíncrono, ideal para usar com frameworks como o **FastAPI**.

---
### 📌 **Conclusão**

**ORM (Object-Relational Mapping)** é uma técnica poderosa para integrar bancos de dados relacionais com aplicativos baseados em objetos. Usando um ORM, você pode interagir com bancos de dados de maneira mais fácil e legível, enquanto o ORM cuida da conversão de dados entre objetos Python e tabelas de banco de dados. Embora tenha algumas limitações e trade-offs, o ORM é uma excelente ferramenta para simplificar o desenvolvimento e manutenção de aplicações que fazem uso de bancos de dados relacionais.