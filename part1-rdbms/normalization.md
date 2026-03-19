## Anomaly Analysis

- **INSERT ANOMALY:**

  **Definition:** Cannot insert new entity data without unrelated order data.  

  **Example:** Sales reps are only stored in `orders_flat.csv` tied to orders (as well as products).  

  **Rows/Columns Reference:**  
  - ORD1114 | SR01 | Deepak Joshi | deepak@corp.com | "Mumbai HQ, Nariman Point, Mumbai - 400021"  
  - ORD1027 | SR02 | Anita Desai | anita@corp.com | "Delhi Office, Connaught Place, New Delhi - 110001"  
  - ORD1037 | SR03 | Ravi Kumar | ravi@corp.com | "South Zone, MG Road, Bangalore - 560001"  

  If you want to add a new rep (e.g., "Medha Raj"), you cannot insert her details (sales_rep_id, sales_rep_name, sales_rep_email, office_address) without creating a fake order_id. Same goes with **product** as well.

---

- **UPDATE ANOMALY:**

  **Definition:** Redundant data requires multiple updates, risking inconsistency.  

  **Example:** Deepak Joshi’s office address is repeated across rows, and even appears in two different formats: `"Nariman Pt"` vs `"Nariman Point"`.  

  **Rows/Columns Reference:**  
  - ORD1114 | SR01 | Deepak Joshi | "Mumbai HQ, Nariman Point, Mumbai - 400021"  
  - ORD1091 | SR01 | Deepak Joshi | "Mumbai HQ, Nariman Pt, Mumbai - 400021"  
  - ORD1158 | SR01 | Deepak Joshi | "Mumbai HQ, Nariman Point, Mumbai - 400021"  

  If the office address changes, every row containing this value must be updated. Missing one row leads to inconsistent office addresses for the same rep.

---

- **DELETE ANOMALY:**

  **Definition:** Deleting an order removes important non‑order data.  

  **Example:** Removing orders can erase sales rep details.  

  **Rows/Columns Reference:**  
  - ORD1075 | C005 | Vikram Singh | SR03 | Ravi Kumar | ravi@corp.com | "South Zone, MG Road, Bangalore - 560001"  
  - ORD1037 | C002 | Priya Sharma | SR03 | Ravi Kumar | ravi@corp.com | "South Zone, MG Road, Bangalore - 560001"  
  - ORD1155 | C007 | Arjun Nair | SR01 | Deepak Joshi | deepak@corp.com | "Mumbai HQ, Nariman Point, Mumbai - 400021"  

  If **all orders for SR03 were deleted**, then Ravi Kumar’s office details (sales_rep_id, sales_rep_name, office_address) would be lost. This demonstrates how delete anomalies can remove critical non‑order information.

---

## Normalization Justification  

I strongly refute the claim that keeping everything in one flat table is simpler. While it may appear straightforward at first, this design quickly undermines data integrity, consistency, and logical management.  

1. **Data Integrity and Consistency**  
   In the flat table, sales representative Deepak Joshi’s office address is repeated across multiple rows — and even appears inconsistently as `"Nariman Pt"` versus `"Nariman Point"`. If his office relocates, every row must be updated. Missing even one update creates inconsistent records, an update anomaly. Normalization resolves this by storing rep details once in `tbl_salesReps`, ensuring updates are consistent and reliable.  

2. **Storage Efficiency and Redundancy**  
   Flat tables duplicate information unnecessarily, wasting storage and complicating maintenance. For example, Ravi Kumar’s details are repeated across orders. Normalization eliminates this redundancy by separating entities into dedicated tables (`tbl_customers`, `tbl_products`), reducing duplication and improving efficiency.  

3. **Logical Data Management and Anomaly Prevention**  
   Flat structures suffer from insert and delete anomalies. Adding a new rep like Meera Kapoor requires inserting a fake order row, while deleting all orders for Ravi Kumar (SR03) could erase his information entirely. Normalization prevents these issues by allowing reps, customers, and products to be managed independently. This logical separation ensures queries remain accurate and maintenance is far easier.  

In short, normalization is not over‑engineering — it is a necessary discipline. By enforcing integrity, reducing redundancy, and preventing anomalies, normalization ensures the database remains consistent, scalable, and trustworthy over time.  