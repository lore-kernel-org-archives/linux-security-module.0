From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:15:43 -0400
Subject: [PATCH 21/46] selinux: Two function calls less in range_read()
	after error detection
In-Reply-To: <e3fcbcbb-a1fb-ef39-268f-2e79532739b1@schaufler-ca.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<1e37fe86-2e83-c1f0-f43b-69ed2fb5c7aa@users.sourceforge.net>
	<e3fcbcbb-a1fb-ef39-268f-2e79532739b1@schaufler-ca.com>
Message-ID: <CAHC9VhQdMhC0a9+736=r1JHihLh2eC=rVZLXx7v3=52Pf2xrVQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 17, 2017 at 11:35 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 1/15/2017 7:21 AM, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 14 Jan 2017 20:20:15 +0100
>>
>> Adjust a jump target to avoid two calls of the function "kfree" at the end
>> after a memory allocation failed for the local variable "rt".
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  security/selinux/ss/policydb.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>> index 4cd96ce51322..0d2f64558c0a 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -1857,7 +1857,7 @@ static int range_read(struct policydb *p, void *fp)
>>               rt = kzalloc(sizeof(*rt), GFP_KERNEL);
>>               if (!rt) {
>>                       rc = -ENOMEM;
>> -                     goto out;
>> +                     goto exit;
>
> Why not "return rc;"?
> goto to a return is wrong.

Agree with Casey, but also see my previous comments about the
convenience of using a single error handling goto for loops like this.

>>               }
>>
>>               rc = next_entry(buf, fp, (sizeof(u32) * 2));
>> @@ -1909,6 +1909,7 @@ static int range_read(struct policydb *p, void *fp)
>>  out:
>>       kfree(rt);
>>       kfree(r);
>> +exit:
>>       return rc;
>>  }
>>
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
