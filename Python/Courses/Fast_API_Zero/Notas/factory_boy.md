O **factory_boy** é uma biblioteca Python usada para criar instâncias de objetos para testes de maneira eficiente e reutilizável. Ele é muito útil para gerar dados falsos (fixtures) em testes unitários e é frequentemente usado com ORMs como SQLAlchemy e Django ORM.

---
## 📌 **Principais benefícios do `factory_boy`**
✅ **Evita repetição de código:** Em vez de criar instâncias manualmente em cada teste, você define uma "fábrica" que gera objetos automaticamente.  
✅ **Facilidade de customização:** Permite criar variações de dados específicos para diferentes cenários de teste.  
✅ **Integração com ORMs:** Suporta Django ORM, SQLAlchemy e até objetos Python normais.  
✅ **Geração dinâmica de valores:** Usa bibliotecas como `Faker` para gerar dados aleatórios realistas.  

---
## 🛠 **Como instalar o `factory_boy`**
Se ainda não tiver instalado, você pode adicioná-lo ao seu projeto com:

```bash
pip install factory_boy
```

---
## 🏗 **Exemplo básico com SQLAlchemy**

Vamos supor que temos um modelo de `User` no SQLAlchemy:

```python
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    username = Column(String, unique=True)
    email = Column(String, unique=True)
```

Agora criamos uma fábrica usando o `factory_boy`:

```python
import factory
from myapp.models import User  # Importando o modelo SQLAlchemy

class UserFactory(factory.alchemy.SQLAlchemyModelFactory):
    class Meta:
        model = User  # Define o modelo que será criado
        sqlalchemy_session = session  # Define a sessão do banco de dados

    id = factory.Sequence(lambda n: n + 1)  # Gera um ID sequencial
    username = factory.Faker("user_name")  # Gera um nome de usuário aleatório
    email = factory.Faker("email")  # Gera um e-mail aleatório
```

Agora podemos usá-la nos testes:

```python
def test_create_user(session):
    user = UserFactory()  # Cria um usuário automaticamente

    session.add(user)
    session.commit()

    assert session.query(User).count() == 1
    assert user.username is not None
    assert user.email is not None
```

---
## 🚀 **Exemplo com Django**
Se você estiver usando Django, a integração é ainda mais simples:

```python
import factory
from django.contrib.auth.models import User

class UserFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = User  # Define o modelo Django

    username = factory.Faker("user_name")
    email = factory.Faker("email")
```

Agora podemos criar um usuário no banco de testes do Django:

```python
def test_create_user(db):
    user = UserFactory()
    assert User.objects.count() == 1
```

---
## 🎯 **Customizando dados**
Você pode definir valores específicos para um teste:

```python
user = UserFactory(username="alice", email="alice@example.com")
```

Ou criar **subfábricas** para relacionamentos:

```python
class TodoFactory(factory.alchemy.SQLAlchemyModelFactory):
    class Meta:
        model = Todo
        sqlalchemy_session = session

    title = factory.Faker("sentence")
    description = factory.Faker("paragraph")
    state = "draft"
    user = factory.SubFactory(UserFactory)  # Relaciona com um usuário
```

---
## 🏁 **Conclusão**
O `factory_boy` é uma ferramenta essencial para testes porque:
- **Gera dados automaticamente**
- **Facilita a criação de objetos complexos**
- **Reduz repetição e melhora a manutenção dos testes**

