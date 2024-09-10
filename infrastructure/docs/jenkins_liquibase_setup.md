# Setup Jenkins & Liquitbase

## Command to install jenkins and other services needed

```sh
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install \
    openjdk-11-jdk \
    jenkins \
    awscli \
    git \
    jq
```

After installation liquitbase and mysql drive copy jdbc driver jar file to liquitbase/lib folder

```sh
cp /home/ubuntu/liquibase/mysql-connector-java-8.0.28/mysql-connector-java-8.0.28.jar /home/ubuntu/liquibase/lib/
```

## AWS setup

- create IAM policy `AWSCodeCommitPowerUser`

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
            {
    "Sid": "VisualEditor0",
    "Effect": "Allow",
    "Action": [
    "secretsmanager:GetRandomPassword",
    "secretsmanager:GetResourcePolicy",
    "secretsmanager:GetSecretValue",
    "secretsmanager:DescribeSecret",
    "secretsmanager:ListSecretVersionIds"
                ],
    "Resource": "*"
            }
        ]
  }
  ```

- create roles `JenkinsEC2DevopsRole` and attached the policy `AWSCodeCommitPowerUser`.
- add role to ec2 instancies

## Jenkins setup

Jenkins user credentials
- user: sisorg
- pass: sgPassword23
- email: info-backend@sisorg.com
- token DEV: `113417753689fa475181b9437fcd20cfff`
- token SBX: `11c8cc07aff7da5b6f128906a786f1f46a`

- update private key in jenkins
- update publick key in github
- update slack jenkins webhoook

- Create git credentials, added the private key
- Added git repository credentials.
- If have and error, check: Dashboard > Manage Jenkins > Configure Global Security > Git Host Key Verification Configuration. Then in Host Key Verification Strategy select Accept first connection.

- Install Slack plugin
- Create credential slack-webhook: `atRq7KmkLU9susS9gEVCo30y`

- Add a shell command:

```sh
# This is an example for DEV
export lquser=`aws secretsmanager get-secret-value --secret-id sisorg-rds-mysql-secret-sbx --region us-east-1 --profile sisorg-sbx | jq --raw-output .SecretString | jq -r ."username"`
export lqpassword=`aws secretsmanager get-secret-value --secret-id sisorg-rds-mysql-secret-sbx --region us-east-1 --profile sisorg-sbx  | jq --raw-output .SecretString | jq -r ."password"`
export hostname=`aws secretsmanager get-secret-value --secret-id sisorg-rds-mysql-secret-sbx --region us-east-1  --profile sisorg-sbx | jq --raw-output .SecretString | jq -r ."host"`
export portnumber=`aws secretsmanager get-secret-value --secret-id sisorg-rds-mysql-secret-sbx --region us-east-1 --profile sisorg-sbx | jq --raw-output .SecretString | jq -r ."port"`

bash /home/ubuntu/liquibase/liquibase --url=jdbc:mysql://$MYSQL_HOST:$MYSQL_PORT/$MYSQL_SCHEMA --driver=$MYSQL_DRIVER --username=$MYSQL_USER --password=$MYSQL_PASSWORD --changeLogFile=$CHANGELOG_FILE update
```
