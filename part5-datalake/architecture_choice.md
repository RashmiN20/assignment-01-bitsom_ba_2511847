## Architecture Recommendation

For a fast‑growing food delivery startup collecting GPS logs, customer reviews, payment transactions, and menu images, the most effective choice is a **Data Lakehouse architecture**. Key reasons include:

- **Multi‑format support**  
  - Can store structured payment tables, semi‑structured JSON reviews, raw GPS logs, and binary image files in one environment.  
  - Avoids the rigidity of a warehouse, which is limited to structured data only.  

- **Unified analytics and machine learning**  
  - SQL queries can analyze payment transactions and customer behavior.  
  - Machine learning models can process GPS data for delivery optimization and images for menu recognition.  
  - A lakehouse supports both workloads without duplicating infrastructure.  

- **Scalability and cost efficiency**  
  - Rapid growth means surging volumes of location and image data.  
  - Lakehouses leverage inexpensive cloud object storage while still offering warehouse‑like query performance.  
  - This ensures scalability without excessive cost.  

- **Governance and reliability**  
  - Unlike a pure data lake, lakehouses enforce ACID transactions and schema evolution.  
  - This guarantees consistency for financial reporting and compliance while allowing flexible exploration of unstructured data.  

**In summary:** A Data Lakehouse provides unified storage, analytical flexibility, and scalability. It balances the needs of structured financial data with unstructured reviews and images, making it the most future‑proof architecture for a dynamic food delivery startup.