// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "E1001",
    category: "Electronics",
    name: "Samsung 65-inch 4K Smart TV",
    brand: "Samsung",
    price: 25000,
    specifications: {
      resolution: "3840x2160",
      voltage: "220V",
      warranty_years: 2,
      ports: ["HDMI", "USB", "Ethernet"]
    },
    features: ["Smart TV", "HDR10+", "Voice Control"]
  },
  {
    _id: "C2001",
    category: "Clothing",
    name: "Men's Leather Jacket",
    brand: "Levi's",
    price: 4500,
    attributes: {
      size: ["M", "L", "XL"],
      color: "Black",
      material: "Genuine Leather"
    },
    care_instructions: ["Dry Clean Only", "Do Not Iron"],
    availability: {
      online: true,
      stores: ["Mall A", "Mall B"]
    }
  },
  {
    _id: "G3001",
    category: "Groceries",
    name: "Organic Almond Milk",
    brand: "Alpro",
    price: 350,
    nutrition: {
      calories: 60,
      protein_g: 2,
      fat_g: 3,
      carbs_g: 8
    },
    expiry_date: "2024-12-15",
    ingredients: ["Water", "Almonds", "Sea Salt"],
    storage: "Keep refrigerated"
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({ category: "Electronics", price: { $gt: 20000 } });

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: ISODate("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "C2001" },
  { $set: { discount_percent: 15 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
/*
Reason: Indexing the 'category' field improves query performance when filtering
products by category (e.g., Electronics, Clothing, Groceries). Since category-based
queries are frequent in e-commerce, this index reduces scan time and speeds up retrieval.
*/
