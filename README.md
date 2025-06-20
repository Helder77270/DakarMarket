
## 🔧 Utilisation (Tests, Compilation, Audit)

### 📦 Installation des dépendances

```bash
forge install
```

### 🧪 Tests

```bash
forge test
```

Options utiles :

- Exécution verbeuse :
  ```bash
  forge test -vvvv
  ```

- Tests avec un fork (ex: mainnet/testnet) :
  ```bash
  forge test --fork-url <YOUR_RPC_URL>
  ```

### 🛠️ Compilation

```bash
forge build
```

Nettoyer les fichiers générés :

```bash
forge clean
```

### 📊 Couverture de tests (audit interne)

```bash
forge coverage --report debug
```

Générer un rapport HTML (si `lcov` est installé) :

```bash
forge coverage --report lcov
genhtml lcov.info -o coverage-report
```

### 🔍 Analyse statique et vérification

- Vérifier le format du code :
  ```bash
  forge fmt --check
  ```

- Créer un snapshot des tests (pour comparaison future) :
  ```bash
  forge snapshot
  ```

- Vérifier un contrat sur Etherscan (avec une clé API) :
  ```bash
  forge verify-contract --chain-id <CHAIN_ID> <CONTRACT_ADDRESS> <CONTRACT_PATH>:<CONTRACT_NAME> --etherscan-api-key <API_KEY>
  ```
