
AIRFLOW README & Answers to Questions presented by the Project Team

DevOps Admin: Erich EJ Best 
email:        erich.ej.best@gmail.com
phone:        201-218-9860


Approach and Choices Explained

•	I chose to use the airflow https://airflow.apache.org/installation.html and utilize available installation choices.

Choices you had to make due to time pressure

•	Currently working 12 hours or so at my current job there was limited time and days where no time was available.  Most of the time looking at this project was multi-tasking.

•	Chose to deliver the project using a combination of a scripted solution using the tools of AWS CLI, Terraform and User_Data to get a single execution automated solution.

Known deviations from best practice or real production setup

•	Adherence to an Enterprise Security Solution would be a best practice and is not part of this model.

•	A DNS solution should be used and would need to be part of the solution (DNS worked in my testing lab).

•	In a production setup would have a more robust Pipeline including orchestration and tracking DevOps solutions

Description of the setup, why you chose the technologies used in your stack

•	Terraform is the main technology used in the stack and would have expanded this for organizational framework, tracking and transparencies using other tools in the stack.

•	Based on the lack of available time constraint; getting the application deployed in raw automation, was a solution that was possible.

Anything else you think would be good to know

•	If there were a chance for more time, would have preferred to submit a Jenkins solution using a Shift Left DevOps Solution with a Jenkinsfile in GitHub and Pipeline to deploy.  Still would be using the script; perhaps slightly adjusted and all the Python dependences using a Chef Cookbook/Recipe.   Please let me know if this option is possible?
