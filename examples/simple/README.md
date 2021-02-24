
Deploy
Execute the following in a Cloud Shell terminal:
```bash
terraform init
terraform apply -var project_id=foo 
export PROXY_NAME=$(gcloud compute instances list --format="value(name)" --filter=forward)
export PROXY_ZONE=$(gcloud compute instances list --format="value(zone)" --filter=forward)

gcloud compute ssh $PROXY_NAME \
     --zone $PROXY_ZONE \
     --tunnel-through-iap \
     -- -L 3128:localhost:3128
     
# new terminal
curl --proxy localhost:3128 http://whatismyip.akamai.com/
```