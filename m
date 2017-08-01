From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Tue, 1 Aug 2017 13:25:31 -0400
Subject: [RFC PATCH 3/5] ima: mamespace audit status flags
In-Reply-To: <20170801171702.f2szj5huzbt7fdfl@docker>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-4-mkayaalp@linux.vnet.ibm.com>
	<20170801171702.f2szj5huzbt7fdfl@docker>
Message-ID: <2848EE0A-2DB8-420B-A611-60967EB90F5C@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Aug 1, 2017, at 1:17 PM, Tycho Andersen <tycho@docker.com> wrote:
> 
> Hi Mehmet,
> 
> On Thu, Jul 20, 2017 at 06:50:31PM -0400, Mehmet Kayaalp wrote:
>> --- a/security/integrity/ima/ima_ns.c
>> +++ b/security/integrity/ima/ima_ns.c
>> @@ -301,3 +301,24 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
>> 
>> 	return status;
>> }
>> +
>> +#define IMA_NS_STATUS_ACTIONS	IMA_AUDIT
>> +#define IMA_NS_STATUS_FLAGS	IMA_AUDITED
>> +
> 
> Seems like these are defined in ima.h above in the patch, and
> re-defined here?

Yes, it should be in the ima.h only.

>> +unsigned long iint_flags(struct integrity_iint_cache *iint,
>> +			 struct ns_status *status)
>> +{
>> +	if (!status)
>> +		return iint->flags;
>> +
>> +	return iint->flags & (status->flags & IMA_NS_STATUS_FLAGS);
> 
> Just to confirm, is there any situation where:
> 
>    iint->flags & IMA_NS_STATUS_FLAGS != status->flags & IMA_NS_STATUS_FLAGS
> 
> ? i.e. can this line just be:
> 
>    return status->flags & IMA_NS_STATUS_FLAGS;
> 

As Guilherme had pointed out, the first & should be |.

Mehmet
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
