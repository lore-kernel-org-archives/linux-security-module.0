From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Wed, 16 May 2018 16:28:43 -0400
Subject: [RFC PATCH v4 3/5] ima: differentiate auditing policy rules from
	"audit" actions
In-Reply-To: <1526391655.3937.151.camel@linux.vnet.ibm.com>
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
	<20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
	<1526391655.3937.151.camel@linux.vnet.ibm.com>
Message-ID: <2496f165-67f7-304d-08a0-ea8eedd3c3d4@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/15/2018 09:40 AM, Mimi Zohar wrote:
> Hi Stefan,
>
> On Fri, 2018-05-11 at 10:42 -0400, Stefan Berger wrote:
>> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>>
>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>> the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
>> to reflect the IMA policy rules.
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> We do need to separate out auditing the IMA policy rules from the
> "IMA-audit" messages. ?Based on the IMA policy rule aspect of the
> discussions [1], ?I would really appreciate if you could work with
> Richard and Steve on the new IMA policy rule audit format.
Is your patch below still valid for splitting it up into 'two distinct 
audit record types' ?

>
> This change can be upstreamed independently of either the IMA
> namespacing or the audit containerid patch sets. ?The sooner we make
> this change and upstream it, the better.
>
> [1]?https://www.redhat.com/archives/linux-audit/2018-March/msg00092.html
>
> thanks,
>
> Mimi
>
>> ---
>>   include/uapi/linux/audit.h          | 3 ++-
>>   security/integrity/ima/ima_policy.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 4e61a9e05132..8966e7ff1c4c 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -146,7 +146,8 @@
>>   #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
>>   #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
>>   #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
>> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
>> +#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
>>
>>   #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 915f5572c6ff..3a1412db02a3 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -619,7 +619,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>   	bool uid_token;
>>   	int result = 0;
>>
>> -	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
>> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
>>
>>   	entry->uid = INVALID_UID;
>>   	entry->fowner = INVALID_UID;


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
