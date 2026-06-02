# Olist E-Commerce SQL Analytics Project

## Overview

This project demonstrates the complete process of building a relational database from raw e-commerce data using Microsoft SQL Server.

Dataset:
- Olist Brazilian E-Commerce Dataset
- Source: Kaggle

Main project stages:
- Creation of staging tables
- CSV data import using BULK INSERT
- Data cleaning and transformation
- Creation of clean tables
- Foreign Key implementation
- Business analysis

---

## Data Preparation

During the import of the `order_reviews` dataset, issues related to emojis and text encoding were identified.

To solve these issues, two Python scripts were developed:

- review text cleaning
- file re-encoding

This allowed successful import into SQL Server.

---

## Data Model

The project follows a two-layer architecture:

Raw CSV Files
↓
Staging Tables
↓
Clean Tables
↓
Business Analytics

### Data Quality Issues

Several inconsistencies were discovered in the original dataset:

- Missing ZIP codes in the geolocation dataset
- Missing product categories in the category translation dataset

Because of these issues, some foreign key relationships could not be enforced without losing records.

---

## Entity Relationship Diagram

![ERD](docs/ERD.png)

---

## Business Analysis

The following analyses were performed:

### Dataset Overview

- Orders: 99,441
- Customers: 99,441
- Sellers: 3,095

### Revenue Analysis

- Total revenue from delivered orders
- Monthly revenue trend

### Product Analysis

- Top 10 categories by revenue
- Average review score by category

### Seller Analysis

- Top 5 sellers by sales revenue

---

## Technologies

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)
- Python
- Pandas
- GitHub