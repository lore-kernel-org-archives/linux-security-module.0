From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:05:29 -0400
Subject: [PATCH 15/46] selinux: One check and function call less in
	genfs_read() after error detection
In-Reply-To: <55f62ee9-9e98-f5e0-67eb-fc7aa5cbe8f8@schaufler-ca.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<dbd8e89d-45a1-5785-f2dd-673389ac01a3@users.sourceforge.net>
	<a9983d7d-e1f7-8f85-f696-107cf32160ef@schaufler-ca.com>
	<60ed4f02-4ff8-2ef2-bcc3-ae62bc61cda9@users.sourceforge.net>
	<55f62ee9-9e98-f5e0-67eb-fc7aa5cbe8f8@schaufler-ca.com>
Message-ID: <CAHC9VhTtxZsUyWDga4tZC0hEUO3L8s0jFqy9L=TWqZiHts5=eQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 17, 2017 at 12:53 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 1/17/2017 8:37 AM, SF Markus Elfring wrote:
>>>> @@ -2015,7 +2015,7 @@ static int genfs_read(struct policydb *p, void *fp)
>>>>             newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
>>>>             if (!newgenfs) {
>>>>                     rc = -ENOMEM;
>>>> -                   goto out;
>>>> +                   goto exit;
>>>>             }
>>>>
>>>>             rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
>>>> @@ -2101,7 +2101,7 @@ static int genfs_read(struct policydb *p, void *fp)
>>>>             kfree(newgenfs);
>>>>     }
>>>>     ocontext_destroy(newc, OCON_FSUSE);
>>>> -
>>>> +exit:
>>>>     return rc;
>>> Why not replace the "goto out" with "return rc" rather
>>> than add a target?
>> Would you accept to use the statement "return -ENOMEM;" there instead?
>
> That would be even better.

I *hate* code that does a jump to a label only to then do a
return/exit.  That said, see my earlier comments about not worrying
too much about performance of the error path and in this case I like
the "feel good" nature of the code where ever failure in the loop goes
to "out".

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
