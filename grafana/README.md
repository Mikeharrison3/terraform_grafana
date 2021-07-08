
## Goals
    Creating an hosting Grafana in AWS behind a network load balancer. 

## Layout


## Future improvments/security concerns
    1. Grafana should be configured to utilize an external database (cluster) to make the most out of load balancing. 

    2. Load balancer needs to be setup as an application balancer. Will need to obtain a domain and a certificate for this. This will allow TLS connections. TLS allows the connection between the client and the load balancer to be encrypted. 

    
    4. Do not allow direct access to port 3000 without going through the load balancer. 

## Running the example
    1. Configure your access keys by running AWS configure and following the prompts. Importing your access keys from the portal.

    2. Run terraform init

    3. Run terraform plan

    4. Run terraform apply

    After terraform apply is ran, the terminal will output two IP's. 
    
    The loadbalancer IP can be accessed by port 80 ex: http://[Output IP]. 

    server_public_ip access can be access by port 3000 ex: http://[OUTPUT IP]:3000


### Remember to destroy your environment to prevent charges. 
    1. terraform destroy
