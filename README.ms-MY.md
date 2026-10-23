<div align="left">

[English](README.md) | **Bahasa Melayu**

# GET SHIT DONE untuk OpenCode. (Berasaskan TÂCHES v1.38.5 - 2026-04-25)

**Sistem meta-prompting, kejuruteraan konteks dan pembangunan berpandukan spesifikasi yang ringan tetapi berkuasa untuk Claude Code oleh TÂCHES. (Diadaptasikan untuk OpenCode oleh rokicool dan para penggiat)**

[Repositori GitHub Asal TÂCHES](https://github.com/glittercowboy/get-shit-done)

[![npm version](https://img.shields.io/npm/v/gsd-opencode?style=for-the-badge&logo=npm&logoColor=white&color=CB3837)](https://www.npmjs.com/package/gsd-opencode)
[![npm downloads](https://img.shields.io/npm/dm/gsd-opencode?style=for-the-badge&logo=npm&logoColor=white&color=CB3837)](https://www.npmjs.com/package/gsd-opencode)
[![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/rokicool/gsd-opencode?style=for-the-badge&logo=github&color=181717)](https://github.com/rokicool/gsd-opencode)

---

## Pemasangan

```bash
# Belum ada Node.js? Pasang nvm dahulu (npm/npx perlukan Node.js):
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm install --lts
source ~/.bashrc

npx gsd-opencode@latest

# atau
npm install gsd-opencode -g && gsd-opencode install

# atau
bunx gsd-opencode@latest
```

## ⚠️ Selepas memasang: jalankan [`gsd-fix.sh`](./gsd-fix.sh) — wajib untuk OpenCode 2.x

Memasang atau mengemas kini melalui `npx gsd-opencode@latest` (atau npm, bun dan lain-lain) mempunyai dua masalah yang diketahui pada OpenCode 2.x — **[GSD_FIX.md](./GSD_FIX.md)** menerangkannya dengan terperinci:

1. **Setiap arahan `/gsd-*` seolah-olah tiada.** Pemasang meletakkan 88 fail arahan ke dalam folder bersarang `commands/gsd/`, yang mana OpenCode 2.0 daftarkan sebagai arahan dengan ruang nama `/gsd/gsd-*` dan bukannya nama mendatar `/gsd-*` — walaupun `gsd-opencode check` melaporkan setiap fail intact.
2. **`gsd-sdk` ditinggalkan sebagai pautan simbolik tergantung ke cache npx yang sementara.** npx boleh mengumpul sampah `~/.npm/_npx/…` pada bila-bila masa, memutuskan secara senyap panggilan `gsd-sdk query …` yang dipercayai oleh setiap arahan dan ejen GSD.

Kedua-duanya dibetulkan oleh skrip [`gsd-fix.sh`](./gsd-fix.sh) yang bersifat idempoten. Jalankan sekali selepas setiap pemasangan **atau** kemas kini:

```bash
bash gsd-fix.sh

# atau terus dari repo ini, tanpa perlu klon:
curl -fsSL https://raw.githubusercontent.com/C-Fu/gsd-opencode-fu/main/gsd-fix.sh -o gsd-fix.sh && bash gsd-fix.sh

# atau kalau pakai opencode v1.x.x:
curl -fsSL https://raw.githubusercontent.com/C-Fu/gsd-opencode-fu/main/gsd_pre_v2_fix.sh -o gsd_pre_v2_fix.sh && bash
```

Skrip ini meratakan `commands/gsd/` → `commands/`, menetapkan `gsd-sdk` kepada pemasangan global npm yang sebenar, dan mengesahkan OpenCode telah mendaftarkan arahan `/gsd-*`. Lihat **[GSD_FIX.md](./GSD_FIX.md)** untuk gejala, latar belakang dan langkah pembaikan manual.

---

# Berita terkini

2026-05-16 — Saya mencuba get-shit-done-cc asal untuk OpenCode dan ia nampak kukuh. (Masih berpendapat `/gsd-oc-set-profile` kami jauh lebih baik, walau bagaimanapun.) Mulai sekarang, saya akan memperlahankan kadar peningkatan gsd-opencode dan mengesyorkan semua orang mula menggunakan get-shit-done yang asal.

Terima kasih atas semua sokongan, idea hebat, dan atas kebijaksanaan menangkap semua bug sepanjang jalan.

-- **Roman** (2026-05-16)

# Penjelasan

Get-Shit-Done (GSDv1) asal mula menyokong OpenCode kira-kira 3 bulan yang lalu. Itu bagus, tetapi memandangkan saya mula bekerja pada projek ini lebih awal, saya menjumpai banyak kekasaran dalam GSD asal untuk OpenCode. Jadi saya memutuskan untuk terus mengusahakan port ini.

Walaupun ia 'direct port' dengan adaptasi kod yang mudah, kami menambah beberapa ciri khusus.

Terima kasih kepada [@dpearson2699](https://github.com/dpearson2699) atas versi awal dan idea sistem Profil. Saya mengubah suainya kemudian dan percaya sistem kami (`/gsd-oc-set-profile`) jauh lebih sesuai dan mudah digunakan berbanding yang asal, yang berdasarkan konsep 'Tiga peringkat model' Claude Code.

Saya belum mahu menyerah pada projek ini, tetapi secara jujur, semakin kurang masuk akal.

-- **Roman** (2026-04-13)


[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/zRJ0UWHBjCY/0.jpg)](https://www.youtube.com/watch?v=zRJ0UWHBjCY)

---

<br>

```bash
$ npx gsd-opencode

atau

$ npx gsd-opencode@latest

```

**Berfungsi pada Mac, Windows dan Linux.**

<br>

![GSD Install](assets/terminal.svg)

<br>

*"Jika anda tahu dengan jelas apa yang anda mahu, ini AKAN membina untuk anda. Tiada cakap kosong."*

*"Saya telah mencuba SpecKit, OpenSpec dan Taskmaster — ini menghasilkan keputusan terbaik buat saya."*

*"Ketara sekali tambahan paling berkuasa pada Claude Code saya. Tiada lebih-kejuruteraan. Secara harfiah terus siapkan kerja."*

<br>

**Dipercayai oleh jurutera di Amazon, Google, Shopify dan Webflow.**

[Mengapa Saya Membina Ini](#mengapa-saya-membina-ini) · [Pengurus Pengedaran](#pengurus-pengedaran-khusus-gsd-opencode) · [Cara Ia Berfungsi](#cara-ia-berfungsi) · [Arahan](#arahan) · [Mengapa Ia Berfungsi](#mengapa-ia-berfungsi)

</div>

---



## Mengapa Saya Membina Ini 

Saya seorang pembangun solo. Saya tidak menulis kod — Claude Code yang menulis.

Alat pembangunan berpandukan spesifikasi lain wujud; BMAD, Speckit... Tetapi semuanya seolah-olah menjadikan perkara jauh lebih rumit daripada yang sepatutnya (sprint ceremonies, story points, taklimat pihak berkepentingan, retrospektif, aliran kerja Jira) atau kurang kefahaman gambaran besar tentang apa yang anda bina. Saya bukan syarikat perisian 50 orang. Saya tidak mahu berlakon sebagai syarikat besar. Saya hanya seorang insan kreatif yang cuba membina perkara hebat yang berfungsi.

Jadi saya bina GSD. Kerumitan berada dalam sistem, bukan dalam aliran kerja anda. Di sebalik tabir: kejuruteraan konteks, pemformatan prompt XML, orkestrasi subejen, pengurusan keadaan. Yang anda nampak: beberapa arahan yang terus berfungsi.

Sistem ini memberikan Claude Code segalanya yang diperlukan untuk melakukan kerja *dan* mengesahkannya. Saya percayakan aliran kerja ini. Ia memang melakukan kerja dengan baik.

Itulah dia. Tiada teater korporat. Hanya sistem yang amat berkesan untuk membina perkara menarik secara konsisten menggunakan Claude Code.

— **TÂCHES**


## Daripada penterjemah...

Saya sungguh menyukai kedua-dua GSD dan OpenCode. Saya rasa tidak adil jika GSD hanya tersedia untuk Claude Code. 

— **Roman**

## Versi 1.38.0 

Versi dinaikkan untuk mengikut GSDv1 asal [v1.38.5](https://github.com/gsd-build/get-shit-done/releases/tag/v1.38.5)

## Versi 1.35.0

Versi dinaikkan untuk mengikut GSDv1 asal [v1.35.0](https://github.com/gsd-build/get-shit-done/releases/tag/v1.35.0)

## Versi 1.33.2

Menambah sokongan untuk menterjemah panggilan tugas latar `Agent()` kepada sintaks pendek `@gsd-<agent>` yang serasi dengan OpenCode. Peraturan terjemahan baharu ke-21 dalam `assets/configs/remove-task.json` mengekstrak nama ejen secara dinamik daripada corak `skill="gsd-<agent>"` dan menukarnya ke format OpenCode. Kemas kini ini membetulkan dua panggilan `Agent()` dalam aliran kerja `autonomous.md` untuk penghantaran fasa rancang dan laksana, memastikan keserasian OpenCode sepenuhnya.

## Versi 1.33.0

Sekali lagi kami mengikut GSDv1 asal [v1.33.0](https://github.com/gsd-build/get-shit-done/releases/tag/v1.33.0) (2026-04-04).

Dan di pihak tempatan terdapat banyak perubahan. Dan yang paling penting - saya membuang panggilan `task()`, kerana ia tidak disokong oleh OpenCode, dan menggantikannya dengan panggilan terus kepada ejen.

## Versi 1.30.0

Kami terus mengikut GSDv1 asal v1.30.0 (2026-03-30)

Terdapat penyelesaian yang kontroversi yang saya gunakan untuk menyokong sintaks "skill(skill='command-name')". Selain itu, segalanya dijangka berfungsi sepenuhnya.

## Versi 1.22.1

Saya memutuskan untuk menambah properti 'mode: subagent' kepada semua ejen kustom. Sepatutnya ia tidak menjejaskan sebarang fungsi GSD. Namun, sepatutnya ia membuang ejen-ejen yang tidak perlu daripada senarai yang tersedia melalui Tab.

Silakan rungut jika saya terlepas sesuatu.

## Versi 1.22.0 - Kami mengikut asal v1.22.4 (2026-03-03)

Seperti biasa, semua perubahan yang dibuat TACHES boleh dijumpai dalam [CHANGELOG.md asal v1.20.5 -> v1.22.4](https://github.com/gsd-build/get-shit-done/blob/main/CHANGELOG.md)

Tema utama perubahan ini - GSD asal menggunakan sintaks yang betul untuk melaksanakan ejen. Jadi, tiada lagi perhentian yang tidak dijangka ATAU Gsd-Planner yang kekal aktif selepas perancangan selesai.

Di pihak gsd-opencode pula, terdapat beberapa pembetulan dan banyak perubahan backend.

## Versi 1.20.3 - Sistem profil model gsd-opencode baharu

  Saya terpaksa berhenti menyokong sistem profil model GSD asal. Claude Code menggunakan tiga model berbeza: Opus, Sonnet dan Haiku. Dalam OpenCode, kami dirahmatikan dengan berpuluh-puluh penyedia dan ratusan model. Sistem profil model GSD tidak sesuai untuk kami.
  
  Jadi, saya terpaksa mereka semula dan menamakannya 'simple|smart|genius' buat masa ini. Saya harap ia akan menyelesaikan masalah perhentian yang tidak dijangka.

- `/gsd-settings` - *Tidak lagi membuat sebarang perubahan pada peruntukan model-ejen*. Ia bertanya tentang profil model - tetapi tidak berbuat apa-apa. Anda perlu melaksanakan `/gsd-set-profile` sendiri.
- `/gsd-check-profile` - Menyemak fail konfigurasi gsd-opencode dan memaklumkan tentang isu (jika ada).
- `/gsd-set-profile` - Antara muka utama anda untuk mengawal model apa yang digunakan pada peringkat mana. Cubalah! Tidak, betul-betul, **Cubalah!**

## Versi 1.20.0 - Kami mengikut asal v1.20.5

Seperti biasa, semua perubahan yang dibuat TACHES boleh dijumpai dalam [CHANGELOG.md asal v1.9.4 -> v1.20.5](https://github.com/glittercowboy/get-shit-done/blob/main/CHANGELOG.md)

Bagi pihak kami pula. Kami ada banyak perubahan kecil dan satu perubahan besar kepada Pengurusan Profil. Daripada mereplikasi pendekatan TACHES/Claude Code, kami menggunakan yang relevan dengan OpenCode.

GSD-OpenCode menyokong tiga Profil:

 - Simple (membolehkan mentakrif satu model untuk bekerja bagi semua jenis ejen kustom gsd)
 - Smart  (membolehkan mentakrif dua model berbeza untuk bekerja dengan ejen kustom gsd: satu untuk  )
 - Genius (ok, ok. Bukan genius sebenarnya, tetapi membolehkan mentakrif tiga model berbeza untuk bekerja dengan ejen kustom)

## Versi 1.9.0 - Kami mengikut asal v1.9.4

Semua perubahan yang dibuat TACHES boleh dijumpai dalam [CHANGELOG.md asal v1.6.4 -> v1.9.4](https://github.com/glittercowboy/get-shit-done/blob/main/CHANGELOG.md).

### Pengurusan Profil Model

OpenCode kini menyokong pengurusan profil model sepenuhnya melalui:
- `/gsd-settings` — Menu tetapan interaktif untuk profil, override peringkat dan togol aliran kerja
- `/gsd-set-profile <profile>` — Tukar pantas antara profil quality/balanced/budget
- `/gsd-set-model <profile>` — Konfigur model yang digunakan oleh setiap profil

Arahan-arahan ini mengurus `.planning/config.json` dan menjana `opencode.json` dengan pemetaan ejen-ke-model. Nota: Quit dan mulakan semula OpenCode selepas menukar profil agar perubahan berkuat kuasa.

## Versi 1.6.0 - Kami mula menggunakan git submodule

Jika anda klon repo ini, jangan lupa melaksanakan arahan berikut selepas klon:

```
$ git submodule update --init --recursive 
```

Ia akan mengemas kini/mengisi folder ./original/get-shit-done daripada repo TÂCHES. 

Berikut ialah artikel padat yang menarik tentang git submodule: [Working with submodules](https://github.blog/open-source/git/working-with-submodules/). 
Terima kasih kepada @borisnaydis kerana menunjukkannya.

## Versi 1.5.0 - Perubahan Pecah: Kemas Kini Konvensyen Penamaan Arahan

**⚠️ Penting: Perubahan Pecah dalam Sintaks Arahan**

Kami membuat kemas kini untuk menyelaraskan konvensyen penamaan arahan GSD dengan format `kebab-case` standard OpenCode. Malangnya, ini memperkenalkan perubahan pecah kepada sintaks arahan yang boleh dilihat yang telah lama biasa digunakan oleh pengguna.

### Apa yang Berubah

**Penamaan Arahan:** Semua arahan GSD dikemas kini daripada awalan `/gsd:` kepada format `/gsd-`.

### Mengapa Perubahan Ini?

Konvensyen penamaan `gsd-kebab-case` mengikut format arahan standard OpenCode. Penjajaran ini memastikan konsistensi merentas ekosistem dan meningkatkan keserasian.
**Nota:** Kami memahami ini adalah perubahan pecah yang tidak menyenangkan kepada sintaks arahan yang boleh dilihat. Jika/apabila ia menjadi mungkin pada masa depan, kami mungkin mempertimbangkan untuk mengembalikan sintaks `/gsd:` asal sambil mengekalkan keserasian ke belakang.

### Panduan Migrasi

Bagi pengguna yang menaik taraf ke versi 1.5.0, hanya gantikan titik bertindih (`:`) dalam semua arahan GSD dengan sengkang (`-`):

- Lama: `/gsd:plan-phase 1`
- Baharu: `/gsd-plan-phase 1`

Semua fungsi kekal sama—hanya awalan arahan telah berubah.

---

Vibecoding mempunyai reputasi yang buruk. Anda nyatakan apa yang anda mahu, AI menjana kod, dan anda mendapat hasil tidak konsisten yang runtuh apabila berkembang.

GSD membaiki itu. Ia ialah lapisan kejuruteraan konteks yang menjadikan OpenCode boleh dipercayai. Nyatakan idea anda, biar sistem mengekstrak segalanya yang perlu diketahui, dan biar OpenCode meneruskan kerja.

---

## Untuk Siapa Ini

Mereka yang mahu menyatakan apa yang mereka mahu dan membinanya dengan betul — tanpa berpura-pura menjalankan organisasi kejuruteraan 50 orang.

---

## Bermula

```bash
npx gsd-opencode

# ATAU

npm install gsd-opencode -g
gsd-opencode install

```

Itu sahaja. Sahkan dengan `/gsd-help`.

### Sentiasa Dikemas Kini

GSD berkembang dengan pantas. Semak kemas kini secara berkala:

```
/gsd-whats-new
```

Kemas kini dengan:

```bash
npx gsd-opencode@latest

# ATAU

npm install gsd-opencode@latest -g
gsd-opencode install

```

<details>
<summary><strong>Pemasangan Bukan Interaktif (Docker, CI, Skrip)</strong></summary>

```bash
npx gsd-opencode --global   # Pasang ke ~/.config/opencode/
npx gsd-opencode --local    # Pasang ke .opencode/
```

Guna `--global` (`-g`) atau `--local` (`-l`) untuk melangkau prompt interaktif.

</details>

<details>
<summary><strong>Nyahpasang GSD-OpenCode</strong></summary>

```bash
# Nyahpasang (auto-kesan pemasangan global atau tempatan)
gsd-opencode uninstall

# Nyahpasang secara global
gsd-opencode uninstall --global
gsd-opencode uninstall -g

# Nyahpasang secara tempatan
gsd-opencode uninstall --local
gsd-opencode uninstall -l

# Pratonton apa yang akan dibuang (dry run)
gsd-opencode uninstall --dry-run
```

Lihat [DISTRIBUTION-MANAGER.md](./DISTRIBUTION-MANAGER.md) untuk opsyen nyahpasang terperinci termasuk kawalan sandaran dan ciri keselamatan.

</details>

<details>
<summary><strong>Pemasangan Pembangunan</strong></summary>

Klon repositori dan jalankan pemasang secara tempatan:

```bash
git clone https://github.com/rokicool/gsd-opencode.git
cd gsd-opencode
git submodule update --init --recursive 
node bin/install.js --local
```

Memasang ke `.opencode/` untuk menguji pengubahsuaian sebelum menyumbang.

</details>


<details>
<summary><strong>Alternatif: Kebenaran Granular</strong></summary>

Jika anda tidak mahu menggunakan bendera tersebut, tambah ini ke `.opencode/settings.json` projek anda:

```json
{
  $schema: https://opencode.ai/config.json,
  permission: {
    bash: allow,
    read: allow,
    edit: allow,
    grep: allow,
    glob: allow,
    list: allow
  }
}
```

</details>

---

## Pengurus Pengedaran (khusus gsd-opencode)

GSD-OpenCode menyertakan pengurus pakej yang komprehensif untuk memasang, menyelenggara dan mengemas kini sistem GSD. Setelah dipasang melalui npm, anda mempunyai akses kepada CLI penuh untuk mengurus pemasangan GSD anda.

### Rujukan Pantas

| Arahan | Penerangan |
|---------|-------------|
| `gsd-opencode install` | Pasang GSD (interaktif) |
| `gsd-opencode install --global` / `-g` | Pasang secara global (~/.config/opencode/) |
| `gsd-opencode install --local` / `-l` | Pasang secara tempatan (./.opencode/) |
| `gsd-opencode list` | Tunjuk status pemasangan |
| `gsd-opencode check` | Sahkan kesihatan pemasangan |
| `gsd-opencode repair` | Baiki pemasangan yang rosak |
| `gsd-opencode update` | Kemas kini ke versi terkini |
| `gsd-opencode uninstall` | Buang pemasangan |

Untuk dokumentasi terperinci tentang semua arahan, opsyen, penyelesaian masalah dan penggunaan lanjutan, lihat [DISTRIBUTION-MANAGER.md](./DISTRIBUTION-MANAGER.md).

---

## Cara Ia Berfungsi

> **Dah ada kod?** Jalankan `/gsd-map-codebase` dahulu. Ia melancarkan ejen selari untuk menganalisis stack, arkitektur, konvensyen dan kebimbangan anda. Kemudian `/gsd-new-project` mengenali pangkalan kod anda — soalan tertumpu pada apa yang anda tambah, dan perancangan secara automatik memuatkan corak anda.

### 1. Memulakan Projek

```
/gsd-new-project
```

Satu arahan, satu aliran. Sistem ini:

1. **Soalan** — Bertanya sehingga ia memahami idea anda sepenuhnya (matlamat, kekangan, pilihan teknologi, kes tepi)
2. **Penyelidikan** — Melancarkan ejen selari untuk menyiasat domain (pilihan tetapi disyorkan)
3. **Keperluan** — Mengekstrak apa yang v1, v2 dan di luar skop
4. **Peta Jalan** — Mewujudkan fasa yang dipetakan kepada keperluan

Anda meluluskan peta jalan. Kini anda sedia untuk membina.

**Menjana:** `PROJECT.md`, `REQUIREMENTS.md`, `ROADMAP.md`, `STATE.md`, `.planning/research/`

---

### 2. Perbincang Fasa

```
/gsd-discuss-phase 1
```

**Di sinilah anda membentuk pelaksanaan.**

Peta jalan anda mempunyai satu-dua ayat bagi setiap fasa. Itu tidak mencukupi untuk membina sesuatu sebagaimana yang anda *bayangkan*. Langkah ini merakam pilihan anda sebelum apa-apa diselidik atau dirancang.

Sistem menganalisis fasa dan mengenal pasti perkara kabur berdasarkan apa yang dibina:

- **Ciri visual** → Susun atur, kepadatan, interaksi, keadaan kosong
- **API/CLI** → Format respons, flag, pengendalian ralat, tahap keterangan
- **Sistem kandungan** → Struktur, nada, kedalaman, aliran
- **Tugasan pengorganisasian** → Kriteria pengumpulan, penamaan, pendua, pengecualian

Bagi setiap area yang anda pilih, ia bertanya sehingga anda berpuas hati. Output — `CONTEXT.md` — terus disalurkan ke dua langkah berikut:

1. **Penyelidik membacanya** — Tahu corak apa yang perlu disiasat ("pengguna mahu susun atur kad" → siasat pustaka komponen kad)
2. **Perancang membacanya** — Tahu keputusan apa yang dikunci ("infinite scroll diputuskan" → rancangan menyertakan pengendalian skrol)

Semua dalam anda di sini, semakin banyak sistem membina apa yang anda benar-benar mahu. Langkauinya dan anda dapat nilai lalai yang munasabah. Gunakannya dan anda dapat *visi anda sendiri*.

**Menjana:** `{phase}-CONTEXT.md`

---

### 3. Rancang Fasa

```
/gsd-plan-phase 1
```

Sistem ini:

1. **Menyelidik** — Menyiasat cara melaksanakan fasa ini, dipandu oleh keputusan CONTEXT.md anda
2. **Merancang** — Mewujudkan 2-3 rancangan tugas atomik dengan struktur XML
3. **Mengesahkan** — Menyemak rancangan terhadap keperluan, berulang sehingga lulus

Setiap rancangan cukup kecil untuk dilaksanakan dalam tetingkap konteks yang segar. Tiada degradasi, tiada "Saya akan lebih ringkas sekarang."

**Menjana:** `{phase}-RESEARCH.md`, `{phase}-{N}-PLAN.md`

---

### 4. Laksanakan Fasa

```
/gsd-execute-phase 1
```

Sistem ini:

1. **Menjalankan rancangan dalam gelombang** — Selari jika boleh, berjujukan jika bersandar
2. **Konteks segar bagi setiap rancangan** — 200k token semata-mata untuk pelaksanaan, sifar sampah terkumpul
3. **Commit bagi setiap tugas** — Setiap tugas mendapat commit atomiknya sendiri
4. **Mengesahkan terhadap matlamat** — Menyemak pangkalan kod menyampaikan apa yang dijanjikan fasa

Tinggalkan seketika, dan kembali kepada kerja yang telah siap dengan sejarah git yang bersih.

**Cara Pelaksanaan Gelombang Berfungsi:**

Rancangan dikumpulkan ke dalam "gelombang" berdasarkan kebergantungan. Dalam setiap gelombang, rancangan berjalan selari. Gelombang berjalan berjujukan.

```
┌─────────────────────────────────────────────────────────────────────┐
│  PHASE EXECUTION                                                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  WAVE 1 (parallel)          WAVE 2 (parallel)          WAVE 3       │
│  ┌─────────┐ ┌─────────┐    ┌─────────┐ ┌─────────┐    ┌─────────┐  │
│  │ Plan 01 │ │ Plan 02 │ →  │ Plan 03 │ │ Plan 04 │ →  │ Plan 05 │  │
│  │         │ │         │    │         │ │         │    │         │  │
│  │ User    │ │ Product │    │ Orders  │ │ Cart    │    │ Checkout│  │
│  │ Model   │ │ Model   │    │ API     │ │ API     │    │ UI      │  │
│  └─────────┘ └─────────┘    └─────────┘ └─────────┘    └─────────┘  │
│       │           │              ↑           ↑              ↑       │
│       └───────────┴──────────────┴───────────┘              │       │
│              Dependencies: Plan 03 needs Plan 01            │       │
│                          Plan 04 needs Plan 02              │       │
│                          Plan 05 needs Plans 03 + 04        │       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Mengapa gelombang penting:**
- Rancangan bebas → Gelombang sama → Berjalan selari
- Rancangan bersandar → Gelombang kemudian → Menunggu kebergantungan
- Konflik fail → Rancangan berjujukan atau rancangan sama

Itulah sebabnya "hirisan menegak" (Plan 01: ciri pengguna hujung-ke-hujung) lebih mudah dilarikan selari daripada "lapisan mendatar" (Plan 01: semua model, Plan 02: semua API).

**Menjana:** `{phase_num}-{N}-SUMMARY.md`, `{phase_num}-VERIFICATION.md`

---

### 5. Sahkan Kerja

```
/gsd-verify-work 1
```

**Di sinilah anda mengesahkan ia benar-benar berfungsi.**

Pengesahan automatik menyemak bahawa kod wujud dan ujian lulus. Tetapi adakah ciri itu *berfungsi* sebagaimana yang anda jangkakan? Ini peluang anda untuk menggunakannya.

Sistem ini:

1. **Mengekstrak deliverable boleh diuji** — Apa yang anda patut boleh lakukan sekarang
2. **Membimbing anda satu demi satu** — "Bolehkah anda log masuk dengan e-mel?" Ya/tidak, atau nyatakan apa yang salah
3. **Mendiagnosis kegagalan secara automatik** — Melancarkan ejen debug untuk mencari punca asas
4. **Mewujudkan rancangan pembetulan yang disahkan** — Sedia untuk dilaksanakan semula serta-merta

Jika semuanya lulus, anda teruskan. Jika ada yang rosak, anda tidak debug secara manual — anda hanya menjalankan `/gsd-execute-phase` semula dengan rancangan pembetulan yang dijana untuk anda.

**Menjana:** `{phase}-UAT.md`, rancangan pembetulan jika isu dijumpai

---

### 6. Ulang → Lengkap → Milestone Seterusnya

```
/gsd-discuss-phase 2
/gsd-plan-phase 2
/gsd-execute-phase 2
/gsd-verify-work 2
...
/gsd-complete-milestone
/gsd-new-milestone
```

Ulang **perbincang → rancang → laksana → sahkan** sehingga milestone lengkap.

Setiap fasa mendapat input anda (perbincang), penyelidikan yang sewajarnya (rancang), pelaksanaan yang bersih (laksana) dan pengesahan manusia (sahkan). Konteks kekal segar. Kualiti kekal tinggi.

Apabila semua fasa selesai, `/gsd-complete-milestone` mengarkibkan milestone dan menandakan release.

Kemudian `/gsd-new-milestone` memulakan versi seterusnya — aliran sama seperti `new-project` tetapi untuk pangkalan kod sedia ada anda. Anda menyatakan apa yang mahu dibina seterusnya, sistem menyelidik domain, anda menetapkan skop keperluan, dan ia mewujudkan peta jalan baharu. Setiap milestone ialah kitaran bersih: define → build → ship.

---

### Mod Pantas

```
/gsd-quick
```

**Untuk tugas ad-hoc yang tidak memerlukan perancangan penuh.**

Mod pantas memberikan anda jaminan GSD (commit atomik, penjejakan keadaan) dengan laluan yang lebih pantas:

- **Ejen sama** — Perancang + pelaksana, kualiti sama
- **Melangkau langkah pilihan** — Tiada penyelidikan, tiada penyemak rancangan, tiada verifier
- **Penjejakan berasingan** — Berada dalam `.planning/quick/`, bukan fasa

Guna untuk: pembetulan bug, ciri kecil, perubahan konfigurasi, tugas sekali jalan.

```
/gsd-quick
> Apa yang anda mahu lakukan? "Tambah togol mod gelap pada tetapan"
```

**Menjana:** `.planning/quick/001-add-dark-mode-toggle/PLAN.md`, `SUMMARY.md`

---

## Mengapa Ia Berfungsi

### Kejuruteraan Konteks

OpenCode amat berkuasa *jika* anda memberikannya konteks yang diperlukan. Kebanyakan orang tidak.

GSD mengendalikannya untuk anda:

| Fail | Apa yang dilakukannya |
|------|--------------|
| `PROJECT.md` | Visi projek, sentiasa dimuatkan |
| `research/` | Pengetahuan ekosistem (stack, ciri, arkitektur, perangkap) |
| `REQUIREMENTS.md` | Keperluan v1/v2 berskop dengan kebolehjejakan fasa |
| `ROADMAP.md` | Ke mana anda menuju, apa yang sudah siap |
| `STATE.md` | Keputusan, sekatan, kedudukan — ingatan merentas sesi |
| `PLAN.md` | Tugas atomik dengan struktur XML, langkah pengesahan |
| `SUMMARY.md` | Apa yang berlaku, apa yang berubah, dikomit ke sejarah |
| `todos/` | Idea dan tugas yang dirakam untuk kerja kemudian |

Had saiz berdasarkan tempat kualiti OpenCode mula merosot. Kekal di bawahnya, anda dapat kecemerlangan yang konsisten.

### Pemformatan Prompt XML

Setiap rancangan ialah XML berstruktur yang dioptimumkan untuk OpenCode:

```xml
<task type="auto">
  <name>Create login endpoint</name>
  <files>src/app/api/auth/login/route.ts</files>
  <action>
    Use jose for JWT (not jsonwebtoken - CommonJS issues).
    Validate credentials against users table.
    Return httpOnly cookie on success.
  </action>
  <verify>curl -X POST localhost:3000/api/auth/login returns 200 + Set-Cookie</verify>
  <done>Valid credentials return cookie, invalid return 401</done>
</task>
```

Arahan yang tepat. Tiada meneka. Pengesahan terbina dalam.

### Orkestrasi Berbilang Ejen

Setiap peringkat menggunakan corak yang sama: orkestrator yang nipis melancarkan ejen khusus, mengumpul hasil, dan menghala ke langkah seterusnya.

| Peringkat | Kerja orkestrator | Kerja ejen |
|-------|------------------|-----------|
| Penyelidikan | Menyelaras, membentangkan penemuan | 4 penyelidik selari menyiasat stack, ciri, arkitektur, perangkap |
| Perancangan | Mengesahkan, mengurus iterasi | Perancang mewujud rancangan, penyemak mengesahkan, gelung sehingga lulus |
| Pelaksanaan | Mengumpulkan ke dalam gelombang, menjejak kemajuan | Pelaksana melaksanakan secara selari, setiap satu dengan 200k konteks segar |
| Pengesahan | Membentangkan hasil, menghala seterusnya | Verifier menyemak pangkalan kod terhadap matlamat, debugger mendiagnosis kegagalan |

Orkestrator tidak pernah melakukan kerja berat. Ia melancarkan ejen, menunggu, mengintegrasikan hasil.

**Hasilnya:** Anda boleh menjalankan keseluruhan fasa — penyelidikan mendalam, berbilang rancangan dicipta dan disahkan, ribuan baris kod ditulis merentas pelaksana selari, pengesahan automatik terhadap matlamat — dan tetingkap konteks utama anda kekal pada 30-40%. Kerja berlaku dalam konteks subejen yang segar. Sesi anda kekal pantas dan responsif.

### Commit Git Atomik

Setiap tugas mendapat commit sendiri serta-merta selepas selesai:

```bash
abc123f docs(08-02): complete user registration plan
def456g feat(08-02): add email confirmation flow
hij789k feat(08-02): implement password hashing
lmn012o feat(08-02): create registration endpoint
```

> [!NOTE]
> **Faedah:** Git bisect menjumpai tugas yang gagal dengan tepat. Setiap tugas boleh dikembalikan secara bebas. Sejarah yang jelas untuk OpenCode dalam sesi masa depan. Pemerhatian lebih baik dalam aliran kerja automasi AI.

Setiap commit adalah tepat, boleh dijejak dan bermakna.

### Modular secara Reka Bentuk

- Tambah fasa pada milestone semasa
- Sisipkan kerja genting antara fasa
- Lengkapkan milestone dan mula segar semula
- Laraskan rancangan tanpa membina semula segalanya

Anda tidak pernah terkunci. Sistem ini menyesuaikan diri.

---

## Arahan

### Aliran Kerja Teras

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-new-project` | Permulaan penuh: soalan → penyelidikan → keperluan → peta jalan |
| `/gsd-discuss-phase [N]` | Merakam keputusan pelaksanaan sebelum perancangan |
| `/gsd-plan-phase [N]` | Penyelidikan + rancangan + pengesahan bagi satu fasa |
| `/gsd-execute-phase <N>` | Laksanakan semua rancangan dalam gelombang selari, sahkan apabila siap |
| `/gsd-verify-work [N]` | Ujian penerimaan pengguna manual ¹ |
| `/gsd-audit-milestone` | Sahkan milestone mencapai definisi selesainya |
| `/gsd-complete-milestone` | Arkib milestone, tanda release |
| `/gsd-new-milestone [name]` | Mulakan versi seterusnya: soalan → penyelidikan → keperluan → peta jalan |

### Navigasi

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-progress` | Di mana saya? Apa seterusnya? |
| `/gsd-help` | Tunjuk semua arahan dan panduan penggunaan |
| `/gsd-update` | Kemas kini GSD dengan pratonton changelog |
| `/gsd-join-discord` | Sertai komuniti Discord GSD |

### Brownfield

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-map-codebase` | Analisis pangkalan kod sedia ada sebelum new-project |

### Pengurusan Fasa

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-add-phase` | Tambah fasa pada peta jalan |
| `/gsd-insert-phase [N]` | Sisipkan kerja genting antara fasa |
| `/gsd-remove-phase [N]` | Buang fasa masa depan, nombor semula |
| `/gsd-list-phase-assumptions [N]` | Lihat pendekatan yang dimaksudkan OpenCode sebelum perancangan |
| `/gsd-plan-milestone-gaps` | Wujudkan fasa untuk menutup jurang daripada audit |

### Sesi

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-pause-work` | Wujudkan serahan (handoff) apabila berhenti di tengah fasa |
| `/gsd-resume-work` | Pulihkan daripada sesi terakhir |

### Utiliti

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-settings` | Tetapan interaktif: profil, override peringkat, togol aliran kerja |
| `/gsd-set-profile <profile>` | Tukar profil model (quality/balanced/budget) |
| `/gsd-set-model [profile]` | Konfigur model untuk peringkat sesebuah profil |
| `/gsd-add-todo [desc]` | Rakam idea untuk kemudian |
| `/gsd-check-todos` | Senaraikan todo tertunggak |
| `/gsd-debug [desc]` | Debug sistematik dengan keadaan berterusan |
| `/gsd-quick` | Laksanakan tugas ad-hoc dengan jaminan GSD |

<sup>¹ Disumbangkan oleh pengguna reddit OracleGreyBeard</sup>

---

## Konfigurasi

GSD menyimpan tetapan projek dalam `.planning/config.json`. Konfigurasikan semasa `/gsd-new-project` atau kemas kini kemudian dengan `/gsd-settings`.

### Tetapan Teras

| Tetapan | Opsyen | Lalai | Apa yang dikawal |
|---------|---------|---------|------------------|
| `mode` | `yolo`, `interactive` | `interactive` | Auto-luluskan vs sahkan pada setiap langkah |
| `depth` | `quick`, `standard`, `comprehensive` | `standard` | Ketelitian perancangan (fasa × rancangan) |

### Profil Model (khusus gsd-opencode)

| Profil | Perancangan | Pelaksanaan | Pengesahan | 
|---------|---------|---------|------------------|
| Simple  | Model pertama | Model pertama | Model pertama |
| Smart   | Model pertama | Model pertama | Model kedua |
| Genius  | Model pertama | Model kedua | Model ketiga |

#### Cara Ia Berfungsi

GSD menggunakan sistem **peruntukan model berasaskan peringkat**. Selain mengkonfigur setiap ejen satu persatu, anda menetapkan model kepada tiga peringkat:

| Peringkat | Ejen | Tujuan |
|-------|--------|---------|
| **Perancangan** | gsd-planner, gsd-plan-checker, gsd-phase-researcher, gsd-roadmapper, gsd-project-researcher, gsd-research-synthesizer, gsd-codebase-mapper | Keputusan arkitektur, penyelidikan, reka bentuk tugas |
| **Pelaksanaan** | gsd-executor, gsd-debugger | Pelaksanaan kod mengikut rancangan yang jelas |
| **Pengesahan** | gsd-verifier, gsd-integration-checker | Menyemak deliverable terhadap matlamat |

#### Fail Konfigurasi

Dua fail mengurus peruntukan model:

| Fail | Tujuan |
|------|---------|
| `.planning/oc-config.json` | **Sumber kebenaran** — menyimpan profil |
| `opencode.json` | **Konfigurasi terbitan** — pemetaan ejen-ke-model dibaca oleh OpenCode |

Apabila anda menukar profil atau model, GSD mengemas kini kedua-dua fail. OpenCode membaca `opencode.json` semasa permulaan.

#### Pratetap 

**Pratetap** mentakrifkan model asas bagi setiap profil:

```json
{
  "profiles": {
    "presets": {
      "genius": {
        "planning": "bailian-coding-plan/qwen3.5-plus",
        "execution": "bailian-coding-plan/kimi-k2.5",
        "verification": "bailian-coding-plan/MiniMax-M2.5"
      }
    }
  },
  "current_oc_profile": "genius"
}
```

#### Persediaan Kali Pertama

Pada penggunaan pertama (atau semasa menjalankan `/gsd-set-profile` → Reset presets), **Panduan Persediaan Pratetap** akan berjalan:

1. Menyoal `opencode models` untuk mengesan model yang tersedia
2. Meminta anda memilih model bagi setiap profil/peringkat (9 pilihan keseluruhan)
3. Menyimpan konfigurasi ke `.planning/oc-config.json`
4. Menjana `opencode.json` dengan pemetaan ejen

Ini memastikan pratetap anda menggunakan model yang benar-benar tersedia dalam pemasangan OpenCode anda.

#### Arahan

| Arahan | Apa yang dilakukannya |
|---------|--------------|
| `/gsd-set-profile` | Menu interaktif penuh: tukar profil, tetap/kosongkan override, reset pratetap, togol ejen aliran kerja |
| `/gsd-set-profile <profile>` | Tukar pantas antara profil simple/smart/genius |


**Contoh:**

```bash
# Tukar ke profil simple
/gsd-set-profile simple

# Konfigur model profil balanced secara interaktif
/gsd-set-profile balanced

# Buka menu tetapan penuh
/gsd-settings
```

#### Falsafah Profil

Semasa mengkonfigur pratetap anda:

- **simple** — Guna model paling berkeupayaan anda untuk semua peringkat. Terbaik untuk kerja arkitektur kritikal.
- **smart** — Model kuat untuk perancangan (keputusan penting), peringkat pertengahan untuk pelaksanaan/pengesahan (ikut arahan).
- **genius** — Model kuat untuk perancangan (keputusan penting), peringkat pertengahan untuk pelaksanaan/pengesahan (ikut arahan), model ringan untuk penyelidikan/pengesahan. Terbaik untuk kerja volum tinggi.

#### Penting: Perlu Mulakan Semula

OpenCode memuatkan `opencode.json` semasa permulaan dan **tidak melakukan hot-reload** peruntukan model. Selepas menukar profil atau model:

1. Tutup OpenCode sepenuhnya
2. Mulakan semula OpenCode

Peruntukan model baharu anda kemudian akan aktif.

### Ejen Aliran Kerja

Ejen-ejen ini melancarkan ejen tambahan semasa perancangan/pelaksanaan. Ia meningkatkan kualiti tetapi menambah token dan masa.

| Tetapan | Lalai | Apa yang dilakukannya |
|---------|---------|--------------|
| `workflow.research` | `true` | Menyelidik domain sebelum merancang setiap fasa |
| `workflow.plan_check` | `true` | Mengesahkan rancangan mencapai matlamat fasa sebelum pelaksanaan |
| `workflow.verifier` | `true` | Mengesahkan keperluan mesti ada disampaikan selepas pelaksanaan |

Guna `/gsd-settings` untuk menogolnya, atau override bagi setiap panggilan:
- `/gsd-plan-phase --skip-research`
- `/gsd-plan-phase --skip-verify`

### Pelaksanaan

| Tetapan | Lalai | Apa yang dikawal |
|---------|---------|------------------|
| `parallelization.enabled` | `true` | Jalankan rancangan bebas secara serentak |
| `planning.commit_docs` | `true` | Jejak `.planning/` dalam git |

---

## Penyelesaian Masalah

**Arahan tidak dijumpai selepas pemasangan?**
- Lihat bahagian [Penyelesaian Masalah Sistem Pengedaran](#troubleshooting-installation-issues) untuk bantuan terperinci
- Sahkan pemasangan: `gsd-opencode list`
- Mulakan semula OpenCode untuk memuatkan semula arahan slash

**Kebenaran ditolak semasa pemasangan?**
- Lihat [Penyelesaian Masalah Isu Pemasangan](#troubleshooting-installation-issues) untuk penyelesaian

**Mahu kemas kini ke versi terkini?**
```bash
# Guna arahan kemas kini terbina dalam
gsd-opencode update

# Atau pasang semula melalui npm
npx gsd-opencode@latest
```

**Guna Docker atau persekitaran terkontena?**

Lihat bahagian [Penggunaan Docker/Container](#dockercontainer-usage) untuk arahan terperinci.

Jika bacaan fail gagal dengan laluan tilde (`~/.config/opencode/...`), tetapkan `OPENCODE_CONFIG_DIR` sebelum memasang:
```bash
OPENCODE_CONFIG_DIR=/home/youruser/.config/opencode npx gsd-opencode --global
```
Ini memastikan laluan mutlak digunakan dan bukannya `~` yang mungkin tidak mengembang dengan betul dalam kontena.

---


## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=rokicool/gsd-opencode&type=date&legend=top-left)](https://www.star-history.com/#rokicool/gsd-opencode&type=date&legend=top-left)

## Lesen

Lesen MIT. Lihat [LICENSE](LICENSE) untuk butiran.

---

<div align="center">

**OpenCode penuh potensi. GSD menjadikannya boleh dipercayai.**

</div>
