From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 29 May 2018 16:12:51 -0700
Subject: [PATCH 1/2] security: Move LSM registration arguments to struct
	lsm_info
In-Reply-To: <alpine.LRH.2.21.1805300853590.14712@namei.org>
References: <20180517070052.GA22158@ircssh-2.c.rugged-nimbus-611.internal>
	<alpine.LRH.2.21.1805300853590.14712@namei.org>
Message-ID: <adf91142-ebb0-b20f-6e18-ae6c5b9a7774@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/29/2018 3:54 PM, James Morris wrote:
> On Thu, 17 May 2018, Sargun Dhillon wrote:
>
>>  struct security_hook_list {
>> -	struct hlist_node		list;
>> -	struct hlist_head		*head;
>> -	union security_list_options	hook;
>> -	char				*lsm;
>> +	struct hlist_node			list;
>> +	struct hlist_head			*head;
>> +	const union security_list_options	hook;
>> +	struct lsm_info				*info;
> Kees asked if this field should be const in response to your 01 May 
> posting.  Please address this.
>
> Also, I'd love to see more folk review & ack these patches.

Unless there is serious interest in loadable security
module support there isn't a lot of value to be gained
with this patch set. I am officially agnostic on the topic.
I know that there has been significant resistance to the
facility in the past. I will put more effort into review
if [un]loadable modules have a future.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
