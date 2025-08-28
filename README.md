# 🧬 Proyecto de Análisis de Secuencias de ARN

Este proyecto automatiza el análisis de secuencias de ARN mediante un **pipeline** que incluye:

- Procesamiento de datos
- Alineamiento
- Predicción de estructura secundaria
- Análisis estructural
- Visualización
- Análisis de clustering y machine learning

---

## 🔬 Aplicación

Este pipeline está diseñado para analizar un conjunto de **78 secuencias de tipo tRNA-Sec**, obtenidas de **extracciones marinas metagenómicas** y descargadas desde el siguiente enlace:  
[https://rnacentral.org/search?q=RNA%20AND%20so_rna_type_name:%22Selenocysteinyl_tRNA%22%20AND%20length:%5B90%20TO%2090%5D%20AND%20TAXONOMY:%222994539%22](https://rnacentral.org/search?q=RNA%20AND%20so_rna_type_name:%22Selenocysteinyl_tRNA%22%20AND%20length:%5B90%20TO%2090%5D%20AND%20TAXONOMY:%222994539%22).

Además, se emplearon como **seed alignments** los archivos disponibles en **Rfam** para esta familia de secuencias (**RF01852**), descargados desde el siguiente enlace:  
[https://rfam.org/family/RF01852#tabview=tab2](https://rfam.org/family/RF01852#tabview=tab2).

## Estos datos sirvieron como base para realizar todos los análisis posteriores.

## 📁 Estructura del Proyecto

```
text
├── 1-Data/                 # Datos de entrada (secuencias FASTA)
├── 2-Alignments/           # Resultados de alineamiento de secuencias
├── 3-Folding/              # Predicciones de estructura secundaria
├── 4-Structure/            # Análisis estructural de archivos PDB
├── 5-Results/              # Resultados finales y visualizaciones
├── analysis1.sh            # Script 1: Procesamiento y alineamiento
├── analysis2.sh            # Script 2: Predicción de plegamiento
├── analysis3.sh            # Script 3: Análisis estructural
├── analysis4.sh            # Script 4: Generación de logos de secuencia
└── analysis5.ipynb         # Notebook Jupyter: clustering y Random Forest
```

---

## 🚀 Pipeline de Análisis

### **1. Procesamiento Inicial y Alineamiento** (`analysis1.sh`)

- Calcula estadísticas de archivos FASTA usando **seqkit**
- Realiza alineamiento múltiple con **MAFFT**
- Procesa secuencias: reemplaza **U por T** y formatea en una línea
- Genera secuencias sin gaps y las recorta a **80 nucleótidos**

### **2. Predicción de Estructura Secundaria** (`analysis2.sh`)

- Ejecuta **RNAalifold** sobre secuencias alineadas y genera un gráfico en formato vectorial
- Ejecuta **RNAfold** sobre secuencias no alineadas
- Elimina valores de **MFE** (energía libre mínima) de los resultados

### **3. Análisis Estructural** (`analysis3.sh`)

- Procesa archivos **PDB** usando **MC-Annotate**
- Calcula estadísticas de pares de bases:
  - Pares totales
  - Pares Watson-Crick
  - Pares Wobble (G-U)
  - Pares no canónicos
  - Apilamientos adyacentes y no adyacentes
- Genera un archivo **CSV** con los resultados

### **4. Visualización** (`analysis4.sh`)

- Genera **logos de secuencia** con **WebLogo**:
  - Para secuencias alineadas
  - Para secuencias no alineadas recortadas
- También se generaron los gráficos de logos de secuencia, el heatmap de entropía y el árbol filogenético a partir de la versión web de MetaLogo.

### **5. Análisis de Machine Learning** (`analysis5.ipynb`)

- Realiza un **análisis de clustering jerárquico** sobre las secuencias
- Entrena y valida un **modelo de Random Forest**
- Los resultados están disponibles en la carpeta **5-Results/**

---

## 🛠️ Requisitos

### **Dependencias**

- [seqkit](https://bioinf.shenwei.me/seqkit/)
- [MAFFT](https://mafft.cbrc.jp/alignment/software/)
- [ViennaRNA](https://www.tbi.univie.ac.at/RNA/)
- [MC-Annotate](http://www-lbit.iro.umontreal.ca/mc-annotate/)
- [Python](https://www.python.org/) + librerías: weblogo, metalogo, pandas, numpy, scikit-learn, matplotlib y scipy

### **Instalación**

```bash
# Instalar dependencias en sistemas basados en Debian/Ubuntu
sudo apt install seqkit mafft vienna-rna weblogo

# MC-Annotate requiere instalación manual:
# Descargar desde: http://www-lbit.iro.umontreal.ca/mc-annotate/

# Librerías Python para el notebook
pip install weblogo metalogo pandas numpy scikit-learn matplotlib scipy
```

---

## 📋 Uso

-Verificar que la carpeta 1-Data exista con los archivos FASTA correspondientes.
-Ejecutar los scripts en orden:

```bash
# Dar permisos de ejecución
chmod +x analysis*.sh

# Ejecutar pipeline completo
./analysis1.sh
./analysis2.sh
./analysis3.sh
./analysis4.sh

# Para ejecutar el análisis de machine learning
jupyter notebook analysis5.ipynb
```

---

## 📊 Resultados

Los resultados se guardan en las carpetas correspondientes:

- **6-Results/analysis_results.csv** → CSV con estadísticas estructurales
- **6-Results/** → Logos de secuencia en formato PNG
- **6-Results/** → Resultados del clustering y modelo Random Forest
- **2-Alignments/** → Secuencias alineadas y procesadas
- **3-Folding/** → Predicciones de estructura secundaria
