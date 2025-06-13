# 💰 Gestão Financeira Pessoal Mobile

> Aplicativo desenvolvido em Flutter como Trabalho de Conclusão de Curso (TCC), com o objetivo de oferecer uma ferramenta eficiente para organização e acompanhamento de receitas e despesas de forma prática e acessível.

---

## 📱 Sobre o Projeto

Este aplicativo tem como finalidade proporcionar aos usuários uma maneira simples de:

- Registrar e categorizar suas entradas e saídas financeiras;
- Visualizar os dados por meio de gráficos interativos;
- Acompanhar o saldo mensal atualizado em tempo real;
- Organizar suas finanças pessoais diretamente do smartphone.

---

## 👨‍💻 Desenvolvedores

Este projeto foi desenvolvido como TCC pelos alunos:

- **Luis Honorato** – Flutter Developer
- **Ivan Felipe** – PO e SCRUM Master

Curso: **Sistemas de Informação**  
Instituição: **Faculdade Sapiens**

---

## 🎯 Objetivos do Projeto

- Aplicar conhecimentos práticos em Flutter e arquitetura de software;
- Implementar um sistema reativo com gerenciamento de estado usando `Bloc`;
- Utilizar banco de dados local com `Drift`;
- Adotar boas práticas de design e usabilidade;
- Proporcionar uma experiência fluida para o usuário final.

---

## 🧱 Tecnologias e Ferramentas

| Categoria             | Ferramenta / Tecnologia        |
|----------------------|--------------------------------|
| **Framework**        | Flutter                        |
| **Linguagem**        | Dart                           |
| **Gerenciador de estado** | Bloc                    |
| **Banco de dados local** | Drift (SQLite ORM)       |
| **Gráficos**         | fl_chart                       |
| **Formatação de data** | intl                         |
| **Design System**    | Customizado (`AppColors`, fontes e gradientes definidos) |
| **Armazenamento Offline** | Suporte completo sem internet |

---

## 📊 Funcionalidades

- ✅ Cadastro de entradas (receitas) e saídas (despesas);
- ✅ Categorias dinâmicas conforme o tipo da movimentação;
- ✅ Visualização do saldo mensal;
- ✅ Gráfico de barras com comparação mensal;
- ✅ Gráfico de pizza com distribuição por categoria;
- ✅ Interface limpa, responsiva e de fácil navegação;
- ✅ Persistência local dos dados.

---

## 🧠 Arquitetura do Projeto

- **Camada de Dados:** `Drift`, DAOs, repositórios
- **Camada de Domínio:** `UseCases`, interfaces de repositório
- **Camada de Apresentação:** `Bloc`, `Widgets`, `Pages`
- **Design System:** Gradientes, fontes e cores centralizadas em `AppColors`

Organização baseada em **Clean Architecture**, promovendo desacoplamento e manutenibilidade.

---

## 🚀 Como Executar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/gestao-financeira-tcc.git
   cd gestao-financeira-tcc```

2. Instale as dependências:
   ```bash
   flutter pub get```
   
3.Execute o projeto

## 📂 Estrutura de Pasta
lib/
├── core/                    # Temas, constantes e helpers
├── features/
│   └── finance/
│       ├── data/            # DAOs, database e repository
│       ├── domain/          # Models, Enums, Interfaces
│       ├── presentation/    # BLoC, Pages, Widgets
├── main.dart                # Inicialização

## 📅 Cronograma e Metodologia
- Metodologia utilizada: Ágil com entregas iterativas

- Divisão por etapas:

    - Levantamento de requisitos e design da solução

    - Implementação incremental das funcionalidades

    - Testes e ajustes com base em feedback

    - Documentação e finalização
