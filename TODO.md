## Plano de trabalho / Esqueleto do tutorial

Este TODO serve para guiar o desenvolvimento e depois estruturar o tutorial de aprendizagem baseado neste repositório (bank automation com Parabank).

---

### 1. Fundamentos e boas práticas

- [ ] **Page Object Model (POM)**
	- Nunca usar seletores (xpath/css/ids) diretamente nos ficheiros de teste.
	- Criar resources de página (ex.: `resources/pages/login_page.resource`, `resources/pages/accounts_page.resource`) com keywords e variáveis de seletores.

- [ ] **Hooks (Setup/Teardown)**
	- Usar `Suite Setup` / `Suite Teardown` e `Test Setup` / `Test Teardown` para garantir estado limpo.
	- Exemplo: criar utilizador de teste no `Suite Setup` e limpar sessões no `Suite Teardown`.

- [ ] **Verificações assertivas robustas**
	- Não testar só se um botão é clicável.
	- Validar o efeito: texto de boas‑vindas, mudança de página, saldos atualizados, mensagens de erro específicas, etc.

---

### 2. Testes de registo e autenticação (funcionais e negativos)

- [ ] **Registo de novo utilizador**
	- Usar faker para gerar dados (FirstName, LastName, Username, Password...).
	- Criar utilizador via UI.
	- Validar mensagem de boas‑vindas após registo.

- [ ] **Login com utilizador recém‑criado**
	- Reutilizar username/password criados (suite variables).
	- Validar mensagem de boas‑vindas e/ou que o painel da conta é apresentado.

- [ ] **Tentativa de login inválido**
	- Username correto + password errada.
	- Username inexistente.
	- Validar mensagem de erro: "The username and password could not be verified." e permanência na página de login.

---

### 3. Gestão de contas (E2E – End‑to‑End)

- [ ] **Abertura de nova conta**
	- Estar autenticado com utilizador válido.
	- Abrir nova conta a partir de uma conta existente.
	- Capturar o ID da nova conta apresentado no ecrã.
	- Validar que a nova conta aparece na lista de contas.

- [ ] **Transferência de fundos**
	- Transferir, por exemplo, $100 da Conta A para a Conta B.
	- Validar que o saldo da Conta A diminui e o da Conta B aumenta corretamente.
	- Tratar casos de saldo insuficiente (teste negativo opcional).

---

### 4. Testes de lógica de empréstimo (Boundary/Decision Testing)

- [ ] **Pedido de empréstimo aprovado**
	- Pedir valor baixo com entrada (down payment) alta.
	- Validar mensagem de aprovação e criação do empréstimo/conta associada (se aplicável).

- [ ] **Pedido de empréstimo recusado**
	- Pedir valor muito alto (ex.: 1 milhão) com entrada mínima (ex.: 1$).
	- Validar mensagem de recusa e que nenhum empréstimo é criado.
	- Usar estes cenários para explicar Boundary Value Analysis / Decision Testing.

---

### 5. Empacotar como tutorial

- [ ] Documentar, no README ou em docs separados:
	- Setup de ambiente (Python, uv, Browser/rfbrowser init).
	- Estrutura de pastas (tests, resources, libraries).
	- Exemplo de POM com uma página (login ou registo).
	- Uso da faker library para dados dinâmicos.
	- Execução das suites `smoke_suite.robot` e `negative_suite.robot`.


