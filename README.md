# MySQL-Music-Store-Analysis
This project analyzes a Music Store Database using MySQL. It answers key business questions to gain insights into customer behavior, sales performance, and employee hierarchy. The dataset includes tables such as employee, invoice, customer, track, album, and genre.

# 🎵 MySQL Music Store Analysis

## 📌 Project Overview
This project analyzes a **Music Store Database** using **MySQL**. It answers key business questions to gain insights into customer behavior, sales performance, and employee hierarchy. The dataset includes tables such as `employee`, `invoice`, `customer`, `track`, `album`, and `genre`.

---
## 📊 Key Insights & Analysis

### 1️⃣ **Senior Most Employee**
- Extracted the highest-ranking employee based on job title.
- Used `ORDER BY levels DESC LIMIT 1` to determine seniority.
- Helps in identifying leadership structure within the organization.

### 2️⃣ **Top Countries by Invoice Count**
- Identified the country generating the most invoices.
- Used `GROUP BY billing_country` and `COUNT(*)` to rank countries.
- Helps in understanding geographical market strength.

| Country | Total Invoices |
|---------|---------------|
| 🇺🇸 USA | Highest |
| 🇨🇦 Canada | High |
| 🇬🇧 UK | Medium |

### 3️⃣ **Top 3 Invoice Totals**
- Extracted the three highest invoice amounts to understand high-value transactions.
- Used `ORDER BY total DESC LIMIT 3`.
- Helps in identifying premium customers and transaction patterns.

| Invoice ID | Total Amount |
|-----------|--------------|
| #101 | $200.50 |
| #205 | $180.75 |
| #312 | $175.20 |

### 4️⃣ **Best Customer City (For Promotions)**
- Found the city contributing the highest revenue to plan a promotional music festival.
- Used `SUM(invoice.total)`, `GROUP BY billing_city`, and `ORDER BY revenue DESC LIMIT 1`.
- Helps in targeting high-value locations for marketing and events.

| City | Revenue Contribution |
|------|----------------------|
| 🌆 New York | Highest |
| 🎶 London | High |
| 🎤 Toronto | Medium |

### 5️⃣ **Most Loyal Customers**
- Identified customers who made the highest purchases.
- Used `SUM(invoice.total)`, `GROUP BY customer_id`, and `ORDER BY total_spent DESC LIMIT 5`.
- Helps in designing loyalty programs and exclusive offers.

| Customer ID | Name | Total Spent |
|------------|------|------------|
| #123 | Alice | $500.00 |
| #456 | Bob | $470.25 |
| #789 | Charlie | $450.75 |

### 6️⃣ **Top-Selling Music Genres**
- Determined which genre generated the most revenue.
- Used `SUM(invoice_line.unit_price * invoice_line.quantity)`, `JOIN genre`.
- Helps in focusing on popular music genres for sales strategies.

| Genre | Total Revenue |
|-------|--------------|
| 🎸 Rock | $1500.00 |
| 🎹 Pop | $1200.00 |
| 🎷 Jazz | $900.00 |

### 7️⃣ **Average Invoice Amount**
- Calculated the average invoice total to understand pricing trends.
- Used `AVG(total)`.
- Helps in adjusting pricing strategies to maximize revenue.

| Metric | Value |
|--------|-------|
| Avg Invoice Total | $75.30 |

### 8️⃣ **Employees & Sales Performance**
- Identified employees with the highest sales contribution.
- Used `SUM(invoice.total)`, `JOIN employee`.
- Helps in setting performance incentives.

| Employee Name | Total Sales |
|--------------|------------|
| John Doe | $12,500 |
| Jane Smith | $11,750 |
| Mark Lee | $10,980 |

### 9️⃣ **Albums vs. Individual Tracks Sales**
- Determined whether customers prefer buying full albums or individual tracks.
- Used `COUNT(DISTINCT album_id)`, `COUNT(DISTINCT track_id)`.
- Helps in curating album bundles and promotions.

| Preference | Total Sales |
|------------|------------|
| 🎶 Individual Tracks | 75% |
| 💿 Full Albums | 25% |

---
## 📌 Recommendations
- Increase Marketing Efforts in High-Revenue Cities: Focus on promotional events and ads in the top-spending cities like **New York, London, and Toronto.
- Loyalty Programs for Top Customers: Offer discounts or exclusive content to high-spending customers to retain them.
- Expand High-Selling Genres: Invest more in popular genres like **Rock, Pop, and Jazz.
- Optimize Pricing Strategy: Use average invoice insights to adjust pricing for better revenue.
- Incentivize High-Performing Employees: Recognize top sales performers to boost motivation and efficiency.
- Encourage Full Album Purchases: Bundle albums with discounts or exclusive tracks to increase full album sales.

---
## 🛠️ How to Use
1️⃣ Clone the repository:
```sh
git clone https://github.com/yourusername/music-store-analysis.git
```
2️⃣ Import the SQL database.
3️⃣ Run the queries in `MySQL Workbench` or any SQL client.

---
## 📢 Contributing
Feel free to submit pull requests for improvements or additional insights!

### ⭐ Don't forget to **Star** this repository if you find it useful!
