Date: May 1 2014

# My experience with Azure

TLDR; Azure deleted my company's data without warning and wouldn't fix it. 

Let me start by saying that despite everything, I was *extremely* enthusiastic about Azure &mdash; until my last experience. Also, I'm mostly focused on *git push* style deployment (Azure Web Sites). 

#### Forced off BizSpark plan by rounding errors

I was a late adopter of Azure (February 2013), after the new portal was released. 

Roughly a week after switching to Azure, a rounding error killed all of my websites and databases. Despite having only empty databases, the system had decided I was using 1.000001 database units, .000001 in excess of my quota. There were no notifications; we found out about the outage the hard way - subscription shutdown. Despite being truly under the free quota, I just switched to pay-as-you-go billing and ate the cost. I couldn't get any help from Azure billing or support on the BizSpark subscription.

This is when I discovered that you cannot move services between subscriptions. If Microsoft messes up a subscription, you have to re-create *everything* &mdash; while your web presence is down.

#### Azure Web site deploy failure rate is *high*

My next hurdle was when I exceeded the 1GB quota for disk space with cache files. Azure web site storage being ephemeral and all, I'd expect it to just recycle and redeploy. Oops, no, everything just shuts down. There's also no way to resolve the issue (start, stop, redeploy doesn't help) I ended up having to move from Shared to Reserved to 'clean' the instance. 

I've had about 20% of my deployments fail due to a DLL still being in-use. There doesn't seem to be any handling of file locking; the deploy didn't auto-roll-back either. Start, stop, redeploy, nothing could solve it. I had to downgrade to shared, then back to reserved so I can get the website back up on another instance.

#### Confidence - moving critical services to Azure

With that behind me, and impressed by the decent performance I was seeing, I gradually moved all my apps and sites to Azure, including web applications and customer databases.

#### Then this appeared in my inbox, timestamped 7:29am.

![Your Subscripton Has Been Cancelled](/attachments/cancellation.png)

I checked, and **all of my azure sites were down**. I logged into the portal, and discovered that **all of my databases, backups, instances, and websites had been terminated and deleted**. There was *nothing* left. In fact, everything had been deleted at midnight, **8 hours prior** to the first (and only) notification of the action taken.

Now, the cancellation wasn't random, but it also wasn't completely my fault. Every year, Xbox Live bills me ~$120 MSFT for 2 gold subscriptions that I've never used (I always buy prepaid cards). It's a ghost that can't be killed; no record of it except the credit card charge.

A couple weeks prior to this event, a charge for $121.14 MSFT appeared on my card. I logged into my azure account and verified that my most recent statement was $38, and I had no pending invoices or e-mail receipts. After triple-checking it *couldn't* be Azure, I opened a dispute on the charge, certain it was from XBOX. 

A few days after the cancellation, the matching Azure invoice appeared in my account. 

### Handling of the situation

I immediately contacted Azure support and explained the situation. They insisted that while invoices are generated some time before they're available for viewing, credit cards are not charged until *afterwards*. Perhaps this is how it's supposed to work, but it's not the order of events that happened to me - my azure charge was initiated before I had any warning. I wasn't expecting $98 of CPU usage either, which made the charge even more difficult to identify. I *did* re-authorize the charge with the credit card company as soon as I got the invoice.

The first representative did not offer to help resolve the situation or restore service to the subscription, but suggested I open yet another support ticket to migrate the services to a new subscription. 

Due to the extensive delay, I redeployed to AppHarbor and restored service to my sites.

I continued inquiring into how to 'fix' the situation. I've included the transcript below.

### Communication transcript

>   Hello Nathanael,
>    Upon reviewing we see that all the data has been deleted as the subscription was disabled. Hence, data transfer is not possible. Kindly let me know if you have any questions.
>      
>    Thanks and Regards,
>    Aarish

>   Deletion of my data is violation of the Azure Usage agreement per 4c and 4e "Customer Data return and deletion". http://www.windowsazure.com/en-us/support/legal/subscription-agreement/
>    You may extract and/or delete Customer Data at any time. When a Subscription expires or terminates, we will retain any Customer Data you have not deleted for at least 90 days so that you may extract it, except for free trials, where we may delete Customer Data immediately without any retention period. You remain responsible for all storage and other applicable charges during this retention period. Following the expiration of this retention period, we will delete all Customer Data, including any cached or back-up copies, within 30 days of the end of the retention period. You agree that we have no additional obligation to continue to hold, export or return Customer Data and that we have no liability whatsoever for deletion of Customer Data pursuant to these terms.
>        - Nathanael 

>   Hello Nathanael,
>       
>   Kindly be informed by design when a subscription is cancelled or disabled, all deployments are deleted leaving only the SQL database and Storage account which will be available for 90 days from the date of cancellation. Upon reviewing the usage, we see that SQL database usage stopped on 9th July and the subscription was disabled on 10th July. Let me know if you have any questions.
>   
>   Thanks and Regards,
>   Aarish


>    However, you're saying that the SQL and Storage accounts were deleted.
>    
>    -Nathaanel


> Hello Nathanael,
> 
> Thank you for your response. The SQL database was deleted from the management portal before the subscription was disabled from our backend. Also, there were no storage account usage for this subscription. Hence, no data was retained. Let me know if you have any questions.
> 
> Thanks and Regards,
> Aarish

At which point I took a day off to cool down. I *certainly* didn't log in and delete my own data *on the same day* my subscription was terminated. I can only assume that the audit logs for subscription cancellation were simply confusing. 

>    Hello Nathanael,
>    
>    I haven’t heard from you, and hope this means I have completely addressed your concern. If you do have any further questions, please reply and let me know – I will be happy to assist you further. If not kindly let me know if I have your permission to archive this case.
>    
>    Thanks and Regards,
>    Aarish

>   Hello Nathanael,
>   
>   I still haven’t heard back from you, but would like to confirm that the issue is fully addressed before I archive this case. Please let me know if you have any additional questions or concerns.
>   
>   Thanks and Regards,
>   Aarish

Apparently waiting a couple of days wasn't enough for me to resume the conversation with a polite tone, which I feel bad about.

>   Surely you're joking? What have you possibly resolved?
>   - Nathanael


>    Hello Nathanael,
>    
>    Kindly be informed that as there were no SQL database and storage account at the time when your subscription was disabled. No data was retained. Hence, we are not able to transfer as per your request. Let me know if you have any questions.
>    
>    I apologize for the inconvenience.
>    
>    Thanks and Regards,
>    Aarish

>    I'm pretty sure that DB still had data at the time the subscription was cancelled. Also, why can't you at least transfer the Website configurations to the new subscription?
>    
>    -Nathanael

Several days into the conversaion, Aarish finally offers to re-enable the subscription (but explains that it's a useless effort).

>   Hello Nathanael,
>   Kindly be informed that there are certain prerequisites to perform data transfer. Some are listed below;
>   
>   1: Source and destination subscription has to be active.
>   2: Destination subscription should be empty.
>   3: Service administrator of both the source and destination subscription should be common ( at least until the transfer is complete).
>        
>   I have enabled the source subscription from backend. Kindly login to the portal to check if the website is available. Kindly let me know if we can schedule a call to discuss further.
>     
>    Thanks and Regards,
>    Aarish


>    So, you're saying that since I already have 1 server using the new subscription, I can't move anything to it? This kind of limitation needs to be communicated much more clearly to customers.
>    - Nathanael

>    Hello Nathanael,
>      
>    You are correct. If the destination subscription has any services running, we cannot move services from another subscription. Also be informed that the source subscription was enabled from the backend, kindly verify the same and let me know if you have any questions.
>        
>    Thanks and Regards,
>        Aarish


### Results

Many users of [ImageResizer](http://imageresizing.net) have asked for a SaaS version of the software. I wish I could provide it to them, but I **cannot** entrust my users to a host that capriciousouly deletes customer data. It's also not cost-effective run Windows on AWS, which means an ImageResizer SaaS is not happening.

Azure has potential, but Microsoft has never been good at billing customers accurately or resolving related issues. I've been using AWS and Heroku for years without experiencing a single billing-related service disruption &mdash; despite having credit cards expire multiple times. 

Don't assume I have perfect faith in AWS, Heroku, or even AppHarbor. The only decent way to mitiage risk is plan for multi-cloud support. If you can redeploy to another provider, you can avoid bad situations. Unfortunately, AppHarbor is the closest thing Azure has to competition.

## What Azure needs to improve on

* Use a different merchant description for Azure charges.
* Consider rounding fractional amounts down instead of up. Floating point math is hard, we know.
* Notifiy customers before (not after!) deleting their stuff. 
* Perhaps, if there is a billing issue, give customers a time window to resolve it.
* Add a "Reset" button to websites that recycles the VM and ephemeral storage, so when code fails, users can rescue bad situations.
* Be transactional about website deployments. If you couldn't deploy *all* the files, roll back.
* Handle locked files.
* Provide invoices via e-mail.
* Don't be arbitrary and annoying about subscriptions. Let them be repaired.
* Try less hard to cancel customer accounts. 
* **Empower customers to resolve subscription problems without involving support**.


### We love you AppHarbor, stick around! 

And last, but most importantly &mdash; Azure needs viable competitors. With linux, we can pick and choose cloud providers at will, but investing in a Windows-based cloud application ties us firmly to Microsoft (and their strengths and weaknesses). If Windows is to be a viable platform in the future, it's cloud story *must* be multi-vendor &mdash; in a way that it isn't now. 

Microsoft has invested in their competitors before - and this is a great time to do it again. Azure can't survive alone.











