# StockFlow
StockFlow | AI-Enhanced Retail Inventory Management &amp; Automated Procurement System built on Salesforce.
StockFlow is an enterprise-grade inventory optimization solution built on the Salesforce Lightning Platform. It solves the critical retail challenge of "stock-out" and "over-ordering" by automating the entire procurement lifecycle—from real-time stock monitoring to automated Purchase Order (PO) generation.

🚀 Key Features
Automated Reordering Engine: An Apex-based logic handler that monitors stock levels and automatically generates Purchase Orders when inventory hits a predefined "Safety Level."

Real-time Inventory LWC: A high-performance Lightning Web Component dashboard featuring conditional formatting (Red/Yellow/Green) to visualize stock health across multiple warehouses.

Asynchronous Integration: Uses Queueable Apex and REST Callouts to fetch real-time shipment status from external logistics providers.

Supplier Notification Flow: A headless Salesforce Flow that triggers automated PDF quote requests and emails to suppliers via SendGrid/SMTP.

Custom Logging Framework: A production-ready error-handling system that captures Apex exceptions into a custom Log__c object.

🛠️ Technical Stack
Backend: Apex (Triggers, Classes, Scheduled/Queueable Apex)

Frontend: Lightning Web Components (LWC), SLDS (Salesforce Lightning Design System), JavaScript (ES6+)

Declarative: Salesforce Flows, Approval Processes, Dynamic Forms

Integration: REST API, JSON, Named Credentials

Security: Permission Sets, Sharing Rules, OWD Settings

📊 Data Architecture
The project follows a modular schema to ensure data integrity:

Products & Warehouses: Relational mapping of assets to locations.

Inventory (Junction): Tracks the intersection of stock and location with Master-Detail relationships.

Purchase Orders: Tracks procurement lifecycle from 'Draft' to 'Received'.
