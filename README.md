# Project Title
# Customer Revenue & Retention Insights
- Leveraging SQL to analyze customer behavior, revenue trends, and product category contributions.


# 1️⃣ Project Overview

# Objective:
Analyze customer shopping behavior, category revenue contribution, and monthly trends to provide actionable insights for business strategy.

# Role/Skills Demonstrated:
- SQL: joins, aggregations, CTEs, date functions
- Business Analytics: AOV, customer segmentation, category contribution, cohort analysis
- Visualization: Excel / Tableau / Power BI
- Storytelling & Data-Driven Insights

# Dataset:
- Olist e-commerce dataset (Kaggle) (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- Tables: orders, order_items, products, customers
- Covers order-level transactions, product categories, prices, freight, and customer info

# 2️⃣ Problem Statement

- How much are customers spending, and how does it differ for new vs repeat customers?
- Which product categories contribute most to revenue?
- How does monthly revenue trend for new vs repeat customers?
- Insights needed for marketing, retention, and inventory strategy.

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

# 4️⃣ Key Insights / Findings

# 1. Average Order Value (AOV)
- Surprisingly, new customers have a slightly higher AOV than repeat customers.
- This happens because repeat customers often place multiple smaller orders, while new customers occasionally place higher-value first orders.
- Business implication:
  - New customer acquisition campaigns may yield high-value initial sales, but retention programs should focus on increasing order frequency among repeat customers.

# 2. Category Contribution
- Top 5 categories contribute ~45% of total revenue.
- Repeat customers dominate premium categories (Electronics, Furniture), but still show smaller average basket size than new customers due to multiple low-value purchases.
- Business implication:
  - Marketing and inventory strategy should prioritize premium categories for repeat customers while encouraging upsell to increase their AOV.

# 3. Monthly Revenue Trend
- Revenue from repeat customers grows steadily, reflecting strong retention.
- Spikes in new customer revenue indicate successful acquisition campaigns.
- Cohort trends help plan marketing and predict future revenue.

# 5️⃣ Visualizations

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
