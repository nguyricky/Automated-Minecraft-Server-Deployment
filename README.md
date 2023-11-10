
# AutomatedMC

A comprehensive infrastructure-as-code approach enables the seamless deployment of a Minecraft server with complete automation. Terraform is employed for provisioning and deployment of the server instance, while the server automation is achieved through a refined shell script, ensuring a fully automated setup.

## Prerequisites

To begin with the setup, please make sure you have the necessary installations in place. 

* AWS CLI
* Terraform

In case you haven't installed them yet, you can find them at:

* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Additionally, there are a few other prerequisites that require pre-configuration. These being:

* An SSH Key
* AWS Credentials

### Creating an SSH key

To generate an SSH key, follow these steps:


    1. Open your terminal and navigate to the root directory.
    2. Once in the root directory, use the command:

            cd .ssh

       To navigate to the .ssh directory.
    3. After navigating to that directory create an ssh key using the command:
    
            ssh-keygen

    4. Once the key is create it should be named:

            id_rsa.pub
    
    5. Next go into the file and copy all its contents and save them in a safe place.

Once you have completed all the preceding steps successfully, you are ready to proceed to the next stage.

### AWS Credentials

To successfully deploy your Minecraft server using this setup, it is essential to configure your AWS credentials. The AWS credentials file, commonly known as .aws/credentials, holds these credentials. The location of this file may vary depending on your system.

To find your AWS Credentials, follow these steps:

    1. Navigate to your AWS Learner Lab page.
    2. Start the AWS Lab.
    3. Click on the button labeled 'AWS Details'.
    4. Where is says 'AWS CLI' press the show button.
    5. Copy all of those credentials.
    6. Then navigate to your .aws/credentials file using the terminal.
    7. Paste all of those credentials into the file.

Once you have finished that you have finished all the prerequisites required to run the Minecraft Setup!

## Setup

Let's begin using Terraform and creating the Minecraft server.

To fully set up the automated server, follow these steps:

    1. Clone the GitHub Repository locally.
    2. Navigate to the Terraform main file:

       main.tf 
    
    3. Inside the file main.tf you are going to find a function:

       resource "aws_key_pair" "deployer" {
       key_name   = "mc_key"
       public_key = ""
       }

       To utilize this function, you will need to input the SSH key generated in the previous step. To do so, place your SSH key inside the quotation marks within the "public_key" field.
    4. Once finished save the file.
    5. Next, execute the following command: 
        
       terraform init

    6. Then once finished, execute the following command:

       terraform apply

    7. Once the Terraform deployment process reaches completion, you should observe the message "Apply complete", followed by:

       Outputs:
       instance_id = "{ID}"
       instance_ipv4 = "{IP}"

    8. Copy the value displayed in the output labeled as "instance_ipv4".

Congratulations on completing the Terraform setup! You are now ready to move on to the next step, which involves deploying the Minecraft Server on your EC2 Instance using a shell script.

To proceed with the deployment, please follow the instructions outlined below.

    1. Navigate to the shell script setup file:

       setup.sh 
    
    2. Inside the file setup.sh you are going to find an ssh command:

       ssh -i ~/.ssh/id_rsa ubuntu@{IP}<< 'EOF'

       With this command, you will want to replace {IP} with the IP that you saved from running 'terraform apply'.

    3. Next, go back into the terminal and run the command:

       chmod +x setup.sh
    
    4. Then lastly, run the script with the command:

        ./setup.sh

Once finished the Minecraft server may take approximately 3-5 minutes to become fully operational. However, the actual time required for deployment may vary.

## Collaborators

<a href="https://github.com/nguyricky/keebtype/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=nguyricky/keebtype" />
</a>

## Support

Feel free to [donate](https://ko-fi.com/rickynguyen), and know that every contribution goes a long way in supporting my continued development!
