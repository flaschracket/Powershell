# Powershell
powershell script to test powershell in network

# Windows Update with Powershell
## Locally
there are several ways to update windows locally, *Windows_Update_2* is a script which work without installing any extra module.

## from Remote
it is not so easy to do windows update from remote client. obwohl the connectiono is established successfully, there will be "Access Denied" error. 
the reason is not about Windows or Connection. It happens because Windows.Update Service does not allow any download from remote. therefore list of updates are appeared in result but error happens for doing the update job.
there are several ways to solve this. The way helped me was to establish a permanent connection between two hosts and then run the script(which is located in Target) from remote.
Run-Windows_update_Remotely is a script which can be run from remote client to do the job.
