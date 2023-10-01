# HD Wallet
HD Wallet, atau Hierarchical Deterministic Wallet, adalah salah satu fitur digital wallet modern yang memungkinkannya memiliki banyak address namun tetap mengacu ke satu wallet yang sama.

HD Wallet muncul pertama kali dicetuskan tahun 2012 dalam dokumen [BIP-32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki).

<img src="HD Wallet/Screenshots/Simulator 2.png" width="30%"> <img src="HD Wallet/Screenshots/Console.png" width="65%">

## Proyek Apa Ini?
Proyek ini adalah versi over-simplified bagaimana sebuah HD Wallet dibuat. Saya sebut over-simplified karena walaupun langkah demi langkah dan algoritmanya legit, akan tetapi:

1. Tidak ada blockchain network yang dilibatkan.  
    Dengan demikian belum bisa dibuktikan apakah bisa dilakukan transaksi  pada wallet yang tercipta.
2. Tidak ada fungsi pengecekan balik integritas hashed yang tercipta.  
    Karena tidak ada transaksi yang terjadi, maka fungsi-fungsi tersebut sengaja tidak dibuat.
3. Beberapa fungsi kriptografi tidak dibuat dengan seharusnya.  
    Terutama jika fungsi kriptografi tersebut bisa dibuat versi sederhananya.
4. Beberapa fungsi kriptografi dibuat dengan bantuan external libraries agar lebih succint, sekalipun aslinya bisa ditulis dalam native libraries.

## Proses Pembuatan HD Wallet
**TLDR**; (1) Entropy -\> (2) Seed Phrase -\> (3) Seed -\> (4) Master Private Key and Chain Code -\> (5) child Private Keys and Public Keys -\> (6) Public Address

### Langkah 1: Membangun Entropy
Entropy adalah tentang seberapa random pembuatan initial set of keys. Anggap entropy ini seperti melempar dadu; semakin banyak dadu dan lemparannya crucial bagi keamanan wallet.

Entropy biasanya sepanjang 128, 160, 192, atau 256 bits. Semakin banyak bits, semakin tinggi level entropy, semakin tinggi level security. 

Randomness dari entropy berasal dari suatu metode yang bernama: CSPRNG, atau Cryptographically Secure Pseudo-Random Number Generator. Dalam Swift, fungsi `SecRandomCopyBytes` dapat dipakai untuk keperluan ini.

### Langkah 2: Membangun Seed Phrase
Entropy yang sudah tercipta kemudian diubah kedalam bentuk yang disebut mnemonic seed phrase. Seed phrase ini berupa 12 atau 24 kata acak yang berguna untuk memulihkan (recovering) wallet jika suatu saat kalian tidak bisa mengakses wallet kalian.

Seed phrase ini muncul dari suatu konsensus di komunitas Bitcoin dunia: [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki). Kumpulan kata-kata yang mungkin muncul dalam seed phrase bisa dilihat di [BIP39 English Word List](https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt).

### Langkah 3: Membuat Seed
Seed Phrase yang terbentuk (ditambahkan passphrase jika perlu) kemudian diproses menggunakan fungsi kriptografi berbasis password bernama PBKDF2, yang terdefinisi dalam PKCS5. Proses ini menghasilkan seed sepanjang 512-bit (64 bytes).

Jangan tertukar istilah. Seed tidak sama dengan Seed Phrase.

### Langkah 4: Menciptakan Wallet dan (Master) Private Key
Seed yang tercipta kemudian digunakan untuk menciptakan HD Wallet menggunakan algoritma HMAC-SHA512. 

Dalam HD Wallet ini terdapat Master Private Key dan Chain Code-nya. Keduanya akan digunakan untuk menciptakan banyak pasangan child Private Keys dan Public Keys-nya.

### Langkah 5: Menciptakan (child) Private Key dan Public Key
Kombinasi dari master private key dan chain code, yang diproses dengan algoritma ECDSA akan menghasilkan pasangan child private key dan public key-nya.

### Langkah 6: Menciptakan Wallet’s Public Address
Wallet Address bisa dianalogikan seperti alamat email: Orang lain perlu tahu alamat ini agar bisa mengirimkan asset. Kalian boleh menyebarkan address ini kepada siapapun. Orang lain tidak bisa mengakses wallet kalian melalui address ini. Wallet address = Email address.

/eof
