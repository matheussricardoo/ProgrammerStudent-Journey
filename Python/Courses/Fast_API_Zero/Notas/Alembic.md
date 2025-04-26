**Alembic** é uma ferramenta de migração de banco de dados para aplicações que utilizam o **SQLAlchemy** como ORM (Object-Relational Mapping). Ele é utilizado para gerenciar alterações no banco de dados ao longo do tempo, permitindo evoluir a estrutura do banco de dados sem perder os dados existentes.

### 📌 **O Que Alembic Faz?**
O principal objetivo do Alembic é permitir que você crie **migrações** do banco de dados de maneira controlada. Uma migração é um conjunto de instruções que descrevem como modificar a estrutura de um banco de dados, como adicionar tabelas, colunas, ou índices.

### 🔹 **Principais Características do Alembic:**

1. **Criação Automática de Migrações:**
   Alembic pode gerar automaticamente os arquivos de migração comparando o estado atual do banco de dados com o modelo de dados definido no código (modelos SQLAlchemy).

2. **Execução de Migrações:**
   Ele permite que você aplique e reverta migrações, ajudando a manter o banco de dados sincronizado com o código. Ou seja, você pode "migrar" de uma versão do banco de dados para outra.

3. **Controle de Versão:**
   Cada migração é registrada com um **ID único** para garantir que as alterações no banco de dados sigam uma sequência cronológica. Isso permite um histórico de todas as mudanças no banco.

4. **Migração Reversível:**
   Ele permite reverter uma migração, ou seja, desfazer as mudanças feitas anteriormente, garantindo que o banco de dados possa ser restaurado para um estado anterior.

### 📌 **Como Usar o Alembic:**

#### 1. **Instalar Alembic:**
   Primeiro, você precisa instalar o Alembic. Se você estiver usando o **Poetry** para gerenciar dependências, basta adicionar o Alembic como uma dependência de desenvolvimento:

   ```bash
   poetry add --dev alembic
   ```

   Ou, se estiver usando o **pip**:

   ```bash
   pip install alembic
   ```

#### 2. **Inicializar o Alembic:**

   Para começar, execute o comando abaixo para criar o diretório de migrações e a configuração do Alembic:

   ```bash
   alembic init migrations
   ```

   Esse comando cria um diretório chamado `migrations` com alguns arquivos, incluindo um arquivo de configuração (`alembic.ini`) e um script de ambiente (`env.py`) que conecta Alembic ao seu banco de dados.

#### 3. **Configurar o Alembic:**

   Abra o arquivo `alembic.ini` e defina a URL de conexão com o banco de dados. O Alembic precisa saber qual banco de dados ele está gerenciando para criar e aplicar as migrações.

   Exemplo de configuração no `alembic.ini`:

   ```ini
   sqlalchemy.url = postgresql://user:password@localhost/mydatabase
   ```

#### 4. **Gerar uma Migração Automática:**

   Quando você modificar seus modelos SQLAlchemy (adicionando novas tabelas, colunas, etc.), o Alembic pode gerar uma migração para refletir essas mudanças no banco de dados. Para gerar a migração, use o comando:

   ```bash
   alembic revision --autogenerate -m "descrição da migração"
   ```

   O `--autogenerate` compara os modelos atuais com o banco de dados e cria um arquivo de migração com as instruções necessárias para atualizar o banco.

#### 5. **Aplicando a Migração:**

   Para aplicar a migração e atualizar o banco de dados, basta rodar o comando:

   ```bash
   alembic upgrade head
   ```

   Isso aplica todas as migrações pendentes até a versão mais recente. Você também pode atualizar para uma versão específica, passando o ID da migração:

   ```bash
   alembic upgrade <id_da_migração>
   ```

#### 6. **Revertendo Migrações:**

   Se você precisar reverter uma migração (por exemplo, se algo deu errado), pode usar o comando:

   ```bash
   alembic downgrade -1
   ```

   Isso desfaz a última migração aplicada. Você também pode reverter para uma versão específica do banco de dados, usando o ID da migração:

   ```bash
   alembic downgrade <id_da_migração>
   ```

---
### 🔹 **Estrutura de Diretórios do Alembic:**

Quando você inicializa o Alembic, ele cria uma estrutura de diretórios padrão:

```
migrations/
├── versions/
│   └── <id_migração>.py
└── env.py
```

- **versions/**: Contém os arquivos de migração gerados.
- **env.py**: Script de ambiente responsável por configurar o banco de dados e as operações de migração.
- **alembic.ini**: Arquivo de configuração do Alembic.

---
### 📌 **Exemplo Prático de Migração com Alembic:**

Imagine que você tem a seguinte tabela de usuários no seu modelo SQLAlchemy:

```python
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
```

Agora, você quer adicionar uma coluna `age` na tabela `users`. Então, você pode editar o modelo para:

```python
class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
    age = Column(Integer)  # Nova coluna
```

Agora, gere a migração com o Alembic:

```bash
alembic revision --autogenerate -m "Add age column to users table"
```

Depois, aplique a migração:

```bash
alembic upgrade head
```

Isso vai adicionar a nova coluna `age` à tabela `users` no banco de dados.

---
### 📌 **Conclusão:**

O **Alembic** é uma poderosa ferramenta para gerenciar migrações de banco de dados em projetos Python com **SQLAlchemy**. Ele facilita a atualização do banco de dados sem perder dados e mantém o controle sobre as mudanças realizadas na estrutura do banco. Além disso, com a geração automática de migrações, a ferramenta torna o processo de alteração e manutenção do banco muito mais simples.

Se você está desenvolvendo uma aplicação com **FastAPI** ou **Flask** e utiliza **SQLAlchemy**, o Alembic é uma escolha excelente para gerenciar suas migrações de banco de dados.