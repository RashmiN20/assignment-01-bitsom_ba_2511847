## Storage Systems

**Goal 1 — Readmission risk prediction:**  
Historical treatment data is stored in a data lake (S3/GCS) with a lakehouse layer (Delta/Hudi/Iceberg) for ACID guarantees and reproducible ML pipelines. A feature store (Feast) manages versioned features for training and inference, ensuring consistency between model development and deployment.

**Goal 2 — Doctor plain‑English queries:**  
Clinical notes are embedded using a sentence transformer and stored in a vector database (pgvector, Pinecone, or Weaviate). Doctor queries are converted into embeddings at runtime and matched via cosine similarity, enabling semantic search across patient histories even when terminology differs (e.g., “cardiac event” vs. “myocardial infarction”).

**Goal 3 — Monthly management reports:**  
Curated datasets are replicated into a columnar data warehouse (Snowflake, BigQuery, or Redshift). Warehouses support fast aggregations, concurrency, and cost‑efficient storage for denormalized tables. Precomputed aggregates back dashboards and SLA‑driven reports for hospital management.

**Goal 4 — Real‑time ICU vitals:**  
Streaming ingestion (Kafka) feeds a time‑series database (TimescaleDB or InfluxDB). This supports high‑throughput, low‑latency writes, retention policies, downsampling, and fast range queries for monitoring and alerting, ensuring ICU staff have timely visibility into patient vitals.

**Governance:**  
Across all systems, schema versioning, lineage tracking, encryption, and fine‑grained access controls ensure compliance with audit and privacy requirements.

---

## OLTP vs OLAP Boundary

The OLTP boundary ends at the relational database and streaming/CDC layer. Immediate consistency operations — orders, charting, medication events — remain in OLTP. Data is replicated downstream into analytical systems via CDC or streaming. OLAP begins in the lake, warehouse, and vector DB, where transformations, aggregations, and ML training occur. This separation preserves transactional integrity while enabling scalable analytics, semantic search, and reproducible ML pipelines. Doctors and ICU staff rely on OLTP for live care, while management and AI layers consume OLAP outputs for insights.

---

## Trade‑offs

The main trade‑off is **consistency versus scalability**. A single OLTP store simplifies correctness and auditing but cannot support high‑concurrency analytics or semantic search. Replicating data into specialized stores (warehouse, vector DB, time‑series DB, feature store) improves performance but introduces duplication, latency, and risk of divergence.  

**Mitigation:** Robust CDC/streaming pipelines with idempotent or exactly‑once semantics reduce drift. Schema contracts and versioning enforce consistency. A feature store guarantees aligned snapshots between training and inference. Automated reconciliation and drift detection jobs monitor divergence, while clear ownership and SLAs ensure issues are corrected quickly without compromising clinical safety.
