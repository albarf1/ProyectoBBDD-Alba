 PadelTech – Proxecto Final de Bases de Datos Relacionales
Proxecto de deseño e implementación dunha base de datos relacional para un centro deportivo intelixente especializado en pádel. Este sistema permite xestionar usuarios, reservas, partidos, métricas de xogo, logros, pagos e máis funcionalidades clave nun entorno tecnolóxico avanzado.

🎯 Obxectivo
Deseñar e implementar un modelo relacional axeitado para PadelTech , seguindo tódalas fases do ciclo de vida dunha base de datos relacional:

Recollida de requisitos co ClienteBOT
Deseño conceptual (ER)
Deseño lóxico e normalización ata 3FN
Deseño físico adaptado a MySQL
Carga inicial de datos
Funcións, procedementos e disparadores (triggers)
Consultas SQL representativas
Pruebas e simulacións funcionais
Documentación completa
Control de versións en GitHub
Este proxecto foi desenvolvido como parte da materia Bases de Datos no Ciclo Formativo DAM/DAW.

✅ Requisitos
Para executar este proxecto na túa máquina local, necesitas:

🔧 MySQL 8.0+
💻 MySQL Workbench (opcional)
📁 Git
🌍 Sistema operativo: Windows, Linux ou macOS
📑 Tabla de Contenidos
Requisitos
Fases do Proxecto
1. Recollida de Requisitos
2. Deseño Conceptual
3. Deseño Lóxico e Normalización
4. Deseño Físico
5. Carga Inicial de Datos
6. Funcións e Procedementos Almacenados
7. Disparadores (Triggers)
8. Consultas Representativas
9. Casos de Prueba e Simulacións
10. Resultados e Verificación
🗂️ Estrutura do Repositorio
🛠️ Instalación e Uso
🤝 Contribucións
📄 Licenza
🔄 Fases do Proxecto
1. Recollida de Requisitos
Interacción co bot ClienteBOT para obter os requisitos do negocio:

Xestión de usuarios e membrecías
Reservas de pistas e validación horaria
Partidos e rexistro de participación
Análise de rendemento mediante métricas
Gamificación con logros desbloqueables
Monitorización de sensores nas pistas
Rexistro de pagos e métodos de pago
📦 Entregable : docs/conversation_clienteBOT.md

2. Deseño Conceptual
Modelo Entidade–Relación das entidades principais e as súas relacións, con cardinalidades e claves primarias.

🖼️ Diagrama visual : docs/diagramas/modeloConceptual.png
📘 Explicación : docs/modelo_conceptual.md

3. Deseño Lóxico e Normalización
Transformación do modelo conceptual nun esquema relacional axeitado, aplicando o proceso de normalización ata a terceira forma normal (3FN) .

📘 Documentación : docs/modelo_relacional.md
📦 Script SQL : sql/padeltech.sql

4. Deseño Físico
Adaptación do modelo ao motor MySQL , incluíndo axustes de tipos de dato, índices e disparadores.

🔧 Script principal:
mysql -u root -p < sql/padeltech.sql
5. Carga Inicial de Datos
Inserción de datos iniciais realistas, como usuarios reais do curso, partidos ficticios, métricas de xogo, logros desbloqueados e pagos iniciais.

🧾 Escenarios probados:

Usuarios ficticios pero co email @iessanmamede.com
Varios partidos e rexistros de participación
Logros desbloqueados segundo o progreso
Validación de horarios e integridade referencial
📦 Script SQL : sql/datos.sql

6. Funcións e Procedementos Almacenados
Conxunto de funcións e procedementos almacenados para encapsular lóxica de negocio dende a propia base de datos.

🧾 Exemplos:

realizar_pago(usuario_id, metodo_id, monto)
calcular_nivel_jugador(usuario_id)
actualizar_estadisticas_usuario(usuario_id)
ver_uso_pistas()
📦 Script SQL : sql/funcionesyprocedimientos.sql

7. Disparadores (Triggers)
Automatización de accións importantes, como:

Validación de horarios antes de inserción de reservas
Desbloqueo automático de logros tras rexistrar métricas altas
Actualización de estatísticas cando se insertan novas métricas
Creación automática de rexistros en preferencias
📦 Script SQL : sql/triggers.sql

8. Consultas Representativas
Conxunto de consultas avanzadas que simulan escenarios reais do sistema:

🧾 Escenarios comúns:

Mostrar todos os usuarios cunha membrecía específica
Ver estadísticas persoais de cada usuario
Consultar logros desbloqueados por usuario
Comprobar uso mensual de pistas
Historial financeiro por usuario
Análise de progreso individual
📦 Script SQL : sql/consultas.sql

9. Casos de Prueba e Simulacións
Simulación de situacións reais para validar o correcto funcionamento do sistema:

🧪 Escenarios probados:

Rexistro dun novo usuario
Inserción de métricas e actualización de nivel
Validación de horario ocupado en pista
Consulta de rendemento individual
Desbloqueo de logros segundo o progreso
Pagos e vinculación a membrecías
📦 Script SQL : sql/casosPrueba.sql

10. Resultados e Verificación
Confirmación de que o sistema funciona correctamente:

Modelo relacional ben deseñado e normalizado
Integridade referencial entre táboas
Disparadores (triggers) actúan correctamente
Probas e resultados esperados cumpridos
📘 Entregable : docs/resultados_verificacion.md

🗂️ Estrutura do Repositorio
padeltch/
│
├── docs/                      # Documentación técnica e explicativa
│   ├── conversation_clienteBOT.md      # Conversa co ClienteBOT
│   ├── modelo_conceptual.md          # Modelo ER explicado
│   ├── modelo_relacional.md          # Táboas e proceso de normalización
│   ├── pruebas_simulaciones.md       # Escenarios probados e resultados
│   ├── resultados_verificacion.md    # Validación do sistema
│   └── diagramas/
│       ├── modeloConceptual.png      # Diagrama ER visual
│       └── modeloRelacional.png     # Diagrama relacional

├── sql/                         # Scripts SQL do proxecto
│   ├── padeltech.sql            # Script principal de BD
│   ├── datos.sql                # Inserción inicial de datos
│   ├── casosPrueba.sql           # Simulacións funcionais
│   ├── consultas.sql             # SELECTs avanzados
│   ├── funcionesyprocedimientos.sql  # PL/SQL: funcións e procedementos
│   └── triggers.sql              # Disparadores automatizados

├── README.md                    # Este arquivo
├── .gitignore                   # Para Git
└── plantilla_memoria_BBDD.docx  # Plantilla para a memoria do proxecto

🛠️ Instalación e Uso
1. Clonar o repositorio

git clone https://github.com/tunome/padeltch.git 
cd padeltch

2. Crear a base de datos en MySQL

mysql -u root -p < sql/padeltech.sql

3. Cargar datos iniciais

mysql -u root -p padeltch < sql/datos.sql

4. Engadir disparadores

mysql -u root -p padeltch < sql/triggers.sql

5. Engadir funcións e procedementos

mysql -u root -p padeltch < sql/funcionesyprocedimientos.sql

6. Executar consultas representativas

mysql -u root -p padeltch < sql/consultas.sql

7. Realizar probas e simulacións

mysql -u root -p padeltch < sql/casosPrueba.sql
