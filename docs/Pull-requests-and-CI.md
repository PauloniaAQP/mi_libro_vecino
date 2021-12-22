# Pull request and CI documentation

There are two main branches in this project:
   
- `main`: It is the branch that contains the current version of the application in production. 
   It is recommended to start from this branch only for hotfixes.
- `dev`: It is the branch with functionalities not yet tested by the testing team.
   It is recommended to start from this branch for any type of development or new functionality

All Pull Requests must point to the `dev` branch, except for exceptions (hotfixes). 

### CI Jobs

For these Pull Requests we have the following CI checks and jobs:

- `test_and_coverage`: This jobs runs the tests, the lint analysis and uploads the report of
   coverage to codecov. May fail if lint or tests fails.
- `codecov/patch`: This check is executed by codecov and has to do with coverage
   of the code added in the PR. For example, if the code has 4 lines and only 2 of them
   are tested, a coverage patch of 50% will be achieved. This task may fail if it is not
   reaches a coverage patch of 70%.
- `codecov/project`: This check is executed by codecov and has to do with
   general coverage of the entire project. This task may fail if a coverage project of 70% is not reached.
- `GitGuardian Security Checks`: This check is run by GitGuardian and checks the code 
   added in the PR for possible security issues. It may fail if a security problem is found.

### Enviroments

There is also the `deploy dev instance` job inside the `pr-dev` environment that must be executed
by a mantainer or reviewer of the project after the `test_and_coverage` job has been completed.
This job performs a build and deploys the page in a unique isolated url for each Pull request.
At the end of the deploy, the job will make a comment in the Pull Request with the url link of the page and
how long it will be live. Each page has a life time of 2 days, if is redeployed
with another commit this lifetime is restarted.

If you are a reviewer, you can follow the following steps to deploy the page:

- Go to the page of the Pull request that you want to deploy.
- Go to the bottom of the page and locate the card that says: "This branch is waiting to be deployed".
- Click on `Show enviroments` and choose `deploy_dev_instance`
- You will arrive at the Pull Request job map. Locate the `Review deployments` button and approve the `pr-dev` environment
- With that, the job will be running.
