# SkillVault
# 🧠 SkillVault - Decentralized Skill Certification and Endorsement System

SkillVault is a Solidity-based smart contract that enables trusted issuers to issue verifiable skills to users and allows others to endorse those skills on-chain. This provides a transparent and tamper-proof system for validating an individual's capabilities.

---

## 📜 Features

- ✅ **Skill Issuance:** Approved issuers can assign skills to users.
- 🤝 **Endorsements:** Any user (except the earner) can endorse a skill once.
- 👨‍⚖️ **Admin Control:** The admin manages approved issuers.
- 🔍 **Skill Lookup:** Public methods to fetch skill details and user skill records.

---

## 🚀 Deployment

### ✅ Requirements

- Solidity `^0.8.0`
- Hardhat, Foundry, or Remix IDE
- Ethereum wallet (MetaMask) for deployment/interaction

---

## 📦 Smart Contract Structure

### 🔐 Admin
The deployer becomes the default admin and an approved issuer.

### 🛠️ Structs

```solidity
struct Skill {
    string name;
    address earner;
    address issuer;
    uint timestamp;
    uint endorsements;
}
'''

Contract detail: 0x93d25adbb53e0bce26de2c394a1146b3086968f877855954889a513da94e5f5b![WhatsApp Image 2025-05-26 at 15 44 48_f8dc44a9](https://github.com/user-attachments/assets/73c95494-fc03-4f87-8288-5d65bad760f3)
