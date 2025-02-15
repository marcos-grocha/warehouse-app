# Warehouse-APP

**Warehouse** é uma aplicação desenvolvida em **Ruby on Rails** para facilitar o gerenciamento de galpões.

---

## Principais Funcionalidades

- **Gerenciar Galpões**

---

## Tecnologias Utilizadas

- **Ruby on Rails**: Framework principal para desenvolvimento backend.
- **Rspec e Capybara**: Projeto todo criado usando TDD, conta com 190+ testes.
- **SQLite3** ">= 1.4": Banco de dados para desenvolvimento/teste.
- **PWA (Progressive Web App)**: Suporte para service workers e manifest para experiência de aplicativo.

---

## Requisitos do Projeto

- Ruby 3.1.4
- Rails 7.2.1

---

## Como Configurar o Ambiente de Desenvolvimento

### 1. Clonar o Repositório

```bash
git clone https://github.com/marcos-grocha/warehouse-app.git
cd warehouse-app
```

### 2. Instalar Dependências

```bash
bundle install
```

### 3. Configurar o Banco de Dados

```bash
rails db:create db:migrate db:seed
```

### 4. Rodar o Servidor

```bash
rails server
```

---

## Testes
- O projeto conta com mais de X testes, pois foi construindo com desenvolvimento orientado por testes (Test Driven Development).
- Você pode roda-los com o seguinte comando

```bash
rspec
```

## APIs
-  post "/api/v1/warehouses" Para cadastrar novo galpão
-  get "/api/v1/warehouses/" Para listar galpões cadastrados
-  get "/api/v1/warehouses/#{warehouse.id}" Para detalhes de um galpão
---

## Autor
Desenvolvido por [Marcos Guimarães Rocha](https://www.linkedin.com/in/marcos-grocha/).

![image](https://github.com/user-attachments/assets/852db1df-15c9-4fd5-8329-ab09a15e6239)

