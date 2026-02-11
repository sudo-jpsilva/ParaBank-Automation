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

- [x] **Registo de novo utilizador**
	- Usar faker para gerar dados (FirstName, LastName, Username, Password...).
	- Criar utilizador via UI.
	- Validar mensagem de boas‑vindas após registo.

- [x] **Login com utilizador recém‑criado**
	- Reutilizar username/password criados (suite variables).
	- Validar mensagem de boas‑vindas e/ou que o painel da conta é apresentado.

- [x] **Tentativa de login inválido**
	- Username correto + password errada.
	- Username inexistente.
	- Validar mensagem de erro: "The username and password could not be verified." e permanência na página de login.

---

### 3. Gestão de contas (E2E – End‑to‑End)

- [x] **Abertura de nova conta**
	- Estar autenticado com utilizador válido.
	- Abrir nova conta a partir de uma conta existente.
	- Capturar o ID da nova conta apresentado no ecrã.
	- Validar que a nova conta aparece na lista de contas.

- [ ] **Transferência de fundos**
	Y - Transferir, por exemplo, $100 da Conta A para a Conta B. 
	N - Validar que o saldo da Conta A diminui e o da Conta B aumenta corretamente.
	N - Tratar casos de saldo insuficiente (teste negativo opcional).

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

### 5. Testes de API 

- [x] **Login via API para obter CUSTOMER_ID**
	- Chamar `GET /services/bank/login/{username}/{password}?_type=json`.
	- Extrair `id` da resposta JSON e guardar em `${CUSTOMER_ID}` (keyword `Login With API to Get User ID`).
	- Reutilizar `${CUSTOMER_ID}` nos restantes testes de API.

- [x] **GET accounts de cliente válido**
	- `GET /services/bank/customers/${CUSTOMER_ID}/accounts`.
	- Validar status `200` e que a lista tem pelo menos uma conta.
	- Verificar que cada conta tem `id`, `type`, `balance`.

- [x] **GET accounts com customer id inválido (negativo)**
	- Usar `${invalid_id}=00000`.
	- `GET /services/bank/customers/${invalid_id}/accounts    expected_status=anything`.
	- Validar status `400` e mensagem "Could not find customer #0".

- [x] **GET customer INFO com CUSTOMER_ID válido**
	- `GET /services/bank/customers/${CUSTOMER_ID}?_type=json`.
	- Validar `200` e campos `firstName`, `lastName`, `address`, `phoneNumber`, `ssn` não vazios.

- [x] **GET customer com id inválido (negativo)**
	- Usar `${invalid_id}`.
	- Esperar `400` com mensagem adequada (documentar comportamento real).

- [x] **Update customer via API**
	- Chamar endpoint de update.
	- Validar que o `GET customer` reflete os novos dados.


### 6. Empacotar como tutorial

- [ ] Documentar, no README ou em docs separados:
	- Setup de ambiente (Python, uv, Browser/rfbrowser init).
	- Estrutura de pastas (tests, resources, libraries).
	- Exemplo de POM com uma página (login ou registo).
	- Uso da faker library para dados dinâmicos.
	- Execução das suites `smoke_suite.robot` e `negative_suite.robot`.


