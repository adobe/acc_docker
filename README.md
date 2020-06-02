# Docker Image for Adobe Campaign Classic
This repository contains Dockerfiles and sample to build your own Docker images for Adobe Campaign Classic.

# Adobe Campaign Classic Standalone
## Architecture
This configuration includes all components on the same computer:
- application process (web),
- delivery process (mta),
- redirection process (tracking),
- workflow process and scheduled tasks (wfserver),
- bounce mail process (inMail),
- statistics process (stat).

Overall communication between the processes is carried out according to the following schema:

![sources](/images/standalone.png)

## Modules
Installed modules are: 
- Delivery
- CRM connectors
- Marketing campaigns (Campaign)
- Content Manager
- Integration with the Adobe Experience Cloud
- Adobe Experience Cloud Shared Audiences Integration
- Access to external data (Federated Data Access)
- AEM integration
- AMP for email
- Campaign Optimization
- Central/local Marketing (Distributed Marketing)
- Coupon management
- Deliverability monitoring (Email Deliverability)
- Offer engine (Interaction)
- Transactional message control (Message Center - Control)
- Mobile channel (SMS)
- Mobile App Channel
- Marketing resources (MRM)
- Marketing Analytics
- Direct Mail channel
- Telephone channel
- Response Manager
- Social networks (Social Marketing)
- Online surveys (Survey Manager)
- Web Analytics connectors 

To activate/deactivate default modules, enter into 'ACC_standalone/acc_install.sh' and edit package list (line 56)

## How to get this docker? 
Go to 'acc_standalone' directory and follow README instructions
