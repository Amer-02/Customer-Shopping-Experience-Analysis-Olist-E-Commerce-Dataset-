# Project Title
# Customer Shopping Experience Analysis — E-Commerce Case Study
- Leveraging SQL to analyze customer behavior, revenue trends, and product category contributions.


# 1️⃣ Project Overview

# Objective:
Analyze customer shopping behavior, revenue patterns, and category contributions to optimize business decisions for an e-commerce platform (Amazon-style).

# Role/Skills Demonstrated:
- SQL (data extraction, joins, aggregations, CTEs)
- Business analysis (AOV, repeat vs new customers, category contribution)
- Data visualization (Excel/Tableau/Power BI)
- Portfolio-ready storytelling

# Dataset:
- Publicly available Olist e-commerce dataset (Kaggle) (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- 4 tables: orders, order_items, products, customers
- Covers order-level transactions, product categories, prices, freight, and customer info

# 2️⃣ Problem Statement

- How much are customers spending, and how does it vary by new vs repeat customers?
- Which product categories contribute most to revenue?
- How does monthly revenue trend for new and repeat customers?
- Insights needed to prioritize marketing, retention, and category strategies.

# 3️⃣ Approach & SQL Workflow

# Step A: Average Order Value (AOV) Analysis
- Calculate overall AOV and AOV by category (GMV vs total spend including freight).
- Highlight differences between new and repeat customers using customer_unique_id.

# Step B: Customer Segmentation (New vs Repeat)
- Identify repeat customers via number of orders per customer_unique_id.
- Tag each order as New vs Repeat for downstream analysis.

# Step C: Category Contribution Analysis
- Aggregate revenue by product_category_name and customer_type.
- Calculate contribution % within customer type.
- Highlights top revenue-generating categories and customer behavior patterns.

# Step D: Monthly Revenue / Cohort Analysis
- Assign cohort month as first purchase month per customer_unique_id.
- Track monthly revenue for New vs Repeat customers.
- Provides insights on customer retention, revenue growth, and seasonal trends.

# Step E: Data Export & Visualization
- Export SQL results to CSV.
- Build stacked bar charts, line charts, and monthly trend dashboards in Tableau/Power BI/Excel.

#4️⃣ Key Insights / Findings

# 1. Average Order Value (AOV)
Repeat customers have higher AOV than new customers → retention drives higher revenue.
Certain categories (Electronics, Furniture) drive higher-value baskets.

# 2. Category Contribution
Top 5 categories contribute ~70% of total revenue.
Repeat customers favor premium categories, new customers favor low-ticket categories.
Insights can guide promotion strategy and inventory planning.

# 3. Monthly Revenue Trend
Revenue from repeat customers grows steadily → strong retention.
Spikes in new customer revenue indicate successful acquisition campaigns.
Cohort trends help plan marketing and predict future revenue.

# 5️⃣ Visualizations (Portfolio Highlights)

- Stacked Bar Chart: Revenue contribution by category and customer type.
- Line Chart: Monthly revenue trends for New vs Repeat customers.
- Optional: Bar chart for AOV by category (still better to do for insights)

# 6️⃣ Business Impact

- Retention Strategy: Focus on categories and customer segments driving repeat revenue.
- Marketing Spend Optimization: Allocate budget to high-contributing categories and campaigns.
- Inventory & Operations Planning: Prioritize stock and logistics for categories favored by repeat customers.
- Decision-Ready Insights: Mirrors real Amazon BA reporting style — actionable and metrics-driven.

# 7️⃣ Tools Used
- SQL / MySQL: Data extraction, joins, aggregations, CTEs, date functions
- Excel / Tableau / Power BI: Visualizations, dashboards, storyboarding
- Dataset: Olist public e-commerce dataset (transactions, customers, products) (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
