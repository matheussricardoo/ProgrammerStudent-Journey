## **📌 O que é DRY?**

**DRY** (Don't Repeat Yourself) significa **"Não se repita"** e é um princípio fundamental da programação e do desenvolvimento de software.

Ele incentiva a **reutilização de código**, evitando **duplicação desnecessária** e tornando o código mais **limpo, eficiente e fácil de manter**.

---
## **📌 Por que usar DRY?**

✅ **Facilita a manutenção** → Se precisar mudar algo, altera em um único lugar.  
✅ **Evita erros** → Reduz a chance de inconsistências no código.  
✅ **Melhora a legibilidade** → Código mais organizado e compreensível.  
✅ **Aumenta a produtividade** → Menos repetição significa menos trabalho.

---
## **📌 Exemplo SEM DRY (Código Repetitivo)**

```python
print("Olá, João! Bem-vindo ao sistema.")
print("Olá, Maria! Bem-vinda ao sistema.")
print("Olá, Pedro! Bem-vindo ao sistema.")
```

O código repete a mesma lógica várias vezes, tornando-se difícil de modificar.

---
## **📌 Exemplo COM DRY (Código Reutilizável)**

```python
def saudar_usuario(nome):
    print(f"Olá, {nome}! Bem-vindo ao sistema.")

saudar_usuario("João")
saudar_usuario("Maria")
saudar_usuario("Pedro")
```

🔹 Agora, se quisermos mudar a saudação, basta alterar apenas a função.

---
## **📌 Aplicação do DRY em um CRUD com FastAPI**

### **SEM DRY (Código Repetitivo)**

```python
@app.get("/users/{user_id}")
def get_user(user_id: int, db: Session = Depends(get_db)):
    return db.query(User).filter(User.id == user_id).first()

@app.get("/products/{product_id}")
def get_product(product_id: int, db: Session = Depends(get_db)):
    return db.query(Product).filter(Product.id == product_id).first()
```

🔺 Aqui há código repetitivo para buscar **usuários** e **produtos**.

---
### **COM DRY (Código Reutilizável)**

```python
def get_item(model, item_id: int, db: Session):
    return db.query(model).filter(model.id == item_id).first()

@app.get("/users/{user_id}")
def get_user(user_id: int, db: Session = Depends(get_db)):
    return get_item(User, user_id, db)

@app.get("/products/{product_id}")
def get_product(product_id: int, db: Session = Depends(get_db)):
    return get_item(Product, product_id, db)
```

🔹 Agora temos **uma única função reutilizável** para buscar qualquer modelo no banco.

---
## **📌 DRY na Prática**

1️⃣ **Use funções e classes para evitar repetição.**  
2️⃣ **Reutilize componentes no Frontend e Backend.**  
3️⃣ **Use herança e polimorfismo em POO.**  
4️⃣ **Utilize templates em frameworks como Django e Jinja.**  
5️⃣ **Refatore sempre que perceber código duplicado.**

---
## **📌 Conclusão**

O **princípio DRY** ajuda a tornar seu código mais **eficiente, modular e fácil de manter**.  
Sempre que perceber **código duplicado**, pense em formas de refatorá-lo para seguir o conceito de **DRY**. 🚀