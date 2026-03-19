## ETL Decisions

### Decision 1 — Standardizing Date Formats
Problem: The raw transaction data contained inconsistent date formats (e.g., `29/08/2023`, `12-12-2023`, `2023-02-05`). This inconsistency made it difficult to join on dates or perform time-based aggregations.
Resolution: All dates were converted into a single standardized format (`YYYY-MM-DD`). This ensured consistency across the warehouse and allowed reliable grouping by month, quarter, and year.

### Decision 2 — Normalizing Category Values
Problem: Product categories were inconsistently labeled, with variations in casing and naming (e.g., `electronics`, `Electronics`, `Groceries`, `Grocery`). This caused duplicate categories and inaccurate reporting.
Resolution: Categories were normalized to a consistent set of values (`Electronics`, `Clothing`, `Grocery`). This eliminated duplicates and ensured accurate aggregation of sales by category.

### Decision 3 — Handling Missing Store City Values
Problem: Some records had missing `store_city` values, even though the `store_name` clearly indicated the location (e.g., `Chennai Anna` without a city).
Resolution: Missing `store_city` values were filled in based on the corresponding `store_name`. For example, `Chennai Anna` was assigned `Chennai`, `Delhi South` was assigned `Delhi`, etc. This ensured complete and accurate store dimension data.
