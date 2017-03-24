From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 24 Mar 2017 11:09:02 +0100
Subject: selinux: Move some assignments for the variable "rc" in
	policydb_read()
In-Reply-To: <CAHC9VhSfvsoWCD1DHFPYhnmWx_cmmapo6vjboS8e=6OZ8ca9gA@mail.gmail.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<7fdcfc8f-affa-fcf8-adaf-dc8fd9e1b472@users.sourceforge.net>
	<CAHC9VhSfvsoWCD1DHFPYhnmWx_cmmapo6vjboS8e=6OZ8ca9gA@mail.gmail.com>
Message-ID: <eb71602a-3bb8-a643-5926-9d23aa2798ba@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

>> One local variable was set to an error code in some cases before
>> a concrete error situation was detected. Thus move the corresponding
>> assignments into if branches to indicate a software failure there.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  security/selinux/ss/policydb.c | 59 +++++++++++++++++++++++++-----------------
>>  1 file changed, 35 insertions(+), 24 deletions(-)
> 
> More code churn with no real advantage.

There are different opinions about the mentioned implementation details.


> I agree with the style you are using,

Thanks for such feedback.


> and would support changing it if you are in the function fixing bugs
> or doing other substantial changes in that code,

Is this expectation a contradiction for a desired patch granularity?


> but I can't justify it as a standalone change, sorry.

This update suggestion seems to be not attractive enough for you at the moment
as another change step of my patch series.
Would you like to check if there are other effects worthwhile besides the proposed
coding style adjustment here?

Regards,
Markus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
