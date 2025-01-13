# Marketing-Campaign-Analysis
This project focuses on analyzing Maven’s data to evaluate customer purchasing behaviors, assess the impact of past marketing campaigns, and identify actionable insights.

# Introduction
Maven Market is a retail company serving 2,240 customers over a two-year period (2012–2014). Specializing in a wide range of products, including wine, meat, sweets, fish, and gold products, Maven caters to diverse customer preferences through multiple sales channels such as physical stores, catalogs, and websites.
To support its retail operations, Maven’s dedicated marketing department designs and executes targeted campaigns aimed at boosting sales, enhancing customer engagement, and optimizing the performance of its sales channels. However, recent campaigns have underperformed, raising concerns about their effectiveness and the overall return on investment.
This project focuses on analyzing Maven’s data to evaluate customer purchasing behaviors, assess the impact of past marketing campaigns, and identify actionable insights. By leveraging these findings, Maven can refine its marketing strategies, improve campaign performance, and strengthen its position as a leading retail company in a competitive market.

# Challenges and Business Question
The following business questions have been outlined to help Maven Marketing evaluate the outcomes of their past marketing campaigns. My objective is to provide data-driven answers to these questions and deliver actionable insights that can drive business growth for Maven Marketing:
1.What was the trend in purchase from 2012-2014?
2.What factors significantly influence the number of web purchases?
3.Which marketing campaign has been the most successful?
4.What are the key characteristics of the average customer?
5.Which products are performing the best?
6.Which sales channels are underperforming?

# PROJECT GOAL
Maven Market's recent marketing campaigns have not achieved the desired results, prompting the need for a thorough data analysis to identify areas for improvement and propose actionable solutions.
The goal of this project is to perform a comprehensive marketing analysis to uncover insights into:
1. Customer segmentation and purchase behavior: helping to better understand the target audience.
2. Product performance: to identify high-performing and underperforming items.
3. Campaign and channel performance: enabling optimization and effective budget allocation.

#About the Data
The dataset is a CSV file that contains one table, consisting of 2,240 rows and 28 columns. It is a single table which contains information on 2,240 customers of Maven Market, covering customer profiles, purchasing habits, and sales channel usage (store, website, and catalog). It includes details on customer spending, recency of purchases, and demographic factors such as number of children, marital status, country, education level, and year of birth. Additionally, the data tracks discount purchases, customer complaints, and the outcomes of five marketing campaigns, providing valuable insights into customer engagement and preferences across various product categories, including wine, meat, fruits, fish, sweets, and gold items.
Here is a link to the [dataset](https://www.kaggle.com/datasets/shahidkhan01174/maven-marketing-campaign)

# Methodology
## Data Cleaning and Exploration – SQL Server and Power Query
To prepare the dataset for analysis, I utilized both Power Query and SQL Server. While Power Query offered a more straightforward approach to cleaning the data, I also included the SQL codes to demonstrate my proficiency with SQL. The codes can be found in the SQL files.

#Data Cleaning, Exploration and Analysis With Power Query
·  ##Change Data Type:
In the Power Query Editor, I  selected the columns I wanted to convert to the INT data type. The columns include:  NumWebVisits,Campaigns 1-5 columns, columns for channel of purchase(catalog, store,website),discount column and product columns (meat,wine,fish,gold, sweets,fruits. The expenditure column was converted to currency. With the columns selected, I clicked on the Transform tab in the ribbon, clicked Data Type and choose Whole Number (which corresponds to INTEGER).  Using this method, I also changed the enrollment date and birth-year columns to the date type.

##Make the data consistent
In the marital status column, there were inconsistent data such as “Yolo” and “Absurd”. I replaced this values with Null. I replaced “Alone” with “Single” and “Together” with “Married”. By selecting the Marital Status column and clicking the transform tab, and then the “replace values” tab to replace the inconsistent data. 

##Renaming Columns
It was important to rename some columns to simple names. To rename a column in Power Query, I right-clicked the column header, selected "Rename," typed the new name, and pressed Enter. I followed the same procedure for each column I wanted to rename. This method ensured that all selected columns were appropriately renamed.The are the columns renamed and their new names:
expenditure column- Customer income
NumDealsPurchases-Discount,
MntWines -Wine
MntFruits - Fruits
MntMeatProducts - Meat 
MntFishProducts - Fish
MntSweetProducts - Sweets
MntGoldProducts - Gold
 AcceptedCmp1 -'Campaign 1
AcceptedCmp2  - Campaign 2
AcceptedCmp3 - Campaign 3
AcceptedCmp4  - Campaign 4
AcceptedCmp5 -  Campaign 5

##Adding Custom Columns
To create a new table, I went to the Modeling tab in Power BI, Clicked "New Table' and pasted the Dax formulas.Then I opened the data view tab to check if the new table, ProductRevenue, has been created correctly with two columns: Product and Revenue.
I repeated this procedure for the Campaign and Channel columns.

ProductRevenue = 
UNION(
    ROW("Product", "Fruits", "Revenue", SUM(Maven[Fruits])),
    ROW("Product", "Wines", "Revenue", SUM(Maven[Wines])),
    ROW("Product", "Meat", "Revenue", SUM(Maven[Meat])),
    ROW("Product", "Sweets", "Revenue", SUM(Maven[Sweets])),
    ROW("Product", "Fish", "Revenue", SUM(Maven[Fish])),
    ROW("Product", "Gold", "Revenue", SUM(Maven[Gold]))
)

CampaignContribution = 
UNION(
    ROW("Campaign", "Campaign 1", "Contribution", SUM(Maven[Campagn 1])),
    ROW("Campaign", "Campaign 2", "Contribution", SUM(Maven[Campagn 2])),
    ROW("Campaign", "Campaign 3", "Contribution", SUM(Maven[Campagn 3])),
    ROW("Campaign", "Campaign 4", "Contribution", SUM(Maven[Campagn 4])),
    ROW("Campaign", "Campaign 5", "Contribution", SUM(Maven[Campagn 5]))
)

ChannelPurchases = UNION( 
ROW("Channel", "Store Purchases", "Contribution", SUM(Maven[Store Purchases])), ROW("Channel", "Website Purchases", "Contribution", SUM(Maven[Website Purchases])),
ROW("Channel", "Catalog Purchases", "Contribution", SUM(Maven[Catalog Purchases])) )
        
# Data Visualization in Power BI
The dashboard can be accessed with this [link](https://app.powerbi.com/groups/me/reports/f753dbc3-d2b0-4bab-85be-c65b3bce5d7c?ctid=df8679cd-a80e-45d8-99ac-c83ed7ff95a0&pbi_source=linkShare&bookmarkGuid=48b7e2da-7693-41d7-923a-6e0be29d189f)




# Insights and Answers to Business Questions

1. What was the trend in purchase from 2012-2014?

Overall Trend:
During the three years, months with significant discounts consistently showed an increase in purchases compared to the average monthly purchases within the same year. This indicates that discounts were a key driver of higher purchase volumes.

2012 - August (High-Discount Month)
-Purchases: 1,659
-Average Monthly Purchases (Other Months): 1,042
-Impact of Discounts: A significant rise in purchases was observed during August, highlighting the strong influence of discounts on consumer behavior.

2013 - March (High-Discount Month)
-Purchases: 1,370
-Average Monthly Purchases (Other Months): 1,251.36
-Impact of Discounts: A moderate increase in purchases occurred, reflecting a smaller yet notable impact of discounts in driving sales.

2014 - May (High-Discount Month)
-Purchases: 1,262
-Average Monthly Purchases (Other Months): 963.4
-Impact of Discounts: A noticeable increase in purchases during May emphasized the positive role of discounts in encouraging buying behavior.

Category-Specific Trends:
-Wine Purchases: Over the past two years, wine remained the top-purchased item, with notable preference from Spanish and Saudi Arabian customers.
-Fish purchases grew steadily from 5.97% to 6.83%, indicating a rising demand.
-Meat purchases experienced a more substantial increase, moving from 26.5% to 29.11%, particularly driven by sales from stores.

2. What factors significantly influence the number of web purchases?
 - Demographics
Customers in Spain with graduate or PhD-level education showed a significant rise in web purchases, increasing from 250 to 264 over two years.This indicates a consistent upward trend.
Similarly, Saudi Arabian customers with comparable educational and marital statuses also contributed to the rise in web purchases. Their numbers increased from 70 to 91 during the same timeframe, showcasing significant growth in this segment.
-Impact of Discounts
There is a clear correlation between the rise in website visits and an increase in both website purchases and discount purchases. This shows that promotional offers and discounts play a pivotal role in driving customer engagement and conversion rates.
-Product Preferences
Among all product categories, wine emerged as the most purchased item through the website over the past two years.Following wine, meat and fish also showed strong sales performance, demonstrating their appeal to Maven’s customer base.

3. Which marketing campaign has been the most successful?
Campaign 4 with a total of 167 offers accepted was the most effective. An increase in discount purchases correlated with the acceptance of Campain 4 offers.

4. What are the key characteristics of the average customer?
The average customer has an income of approximately $51,600, are married, hold a PhD, were born in the 1970s, and have no kids. They are primarily based in Spain. Over a two-year span, the average income of customers rose from $50,740 in 2012 to $52,450 in 2014. In terms of purchasing behavior, these customers tend to buy wine, fish, and meat both online and in-store.

5. Which products are performing the best?
The top-performing product category is wines, which generated the highest revenue of $680,816, accounting for a significant portion of the total product revenue of $1 million.

6. Which sales channels are underperforming?
The catalog was the weakest-performing purchase channel, with just 5,963 purchases. In comparison, the website had 9,150 purchases, and in-store purchases led with 12,970.

# Recommendations
1.Marketing efforts, including advertisements and email campaigns, should focus more on customers in Spain, as the majority of Maven's customer base is located there
2.Customer complaints must be promptly addressed and resolved, regardless of the discounts or offers they have received throughout the year.
3.High-demand products, such as wine, fish, and meat, should be consistently available across all sales channels to meet customer expectations.
4.Implement loyalty programs and special discounts to reward frequent customers who make purchases through the website or physical store.
5.Ensure product descriptions are detailed, highlighting key benefits, unique features, and pricing on the catalog. In addition, promote catalog across all purchasing channels and add catalog-specific discounts, coupon codes, or limited-time offers to improve purchases.


