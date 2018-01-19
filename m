From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 19 Jan 2018 09:34:36 -0800
Subject: [PATCH] general protection fault in sock_has_perm
In-Reply-To: <1516382386.2560.11.camel@tycho.nsa.gov>
References: <20180118215853.228182-1-salyzyn@android.com>
	<1516382386.2560.11.camel@tycho.nsa.gov>
Message-ID: <fe1be13d-3242-8f60-aa53-71e2548b7858@android.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/19/2018 09:19 AM, Stephen Smalley wrote:
> On Thu, 2018-01-18 at 13:58 -0800, Mark Salyzyn wrote:
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> . . .
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 8644d864e3c1..95d7c8143373 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4342,7 +4342,7 @@ static int sock_has_perm(struct sock *sk, u32
>> perms)
>>   	struct common_audit_data ad;
>>   	struct lsm_network_audit net = {0,};
>>   
>> -	if (sksec->sid == SECINITSID_KERNEL)
>> +	if (!sksec || sksec->sid == SECINITSID_KERNEL)
>>   		return 0;
> The patch description says "null check the sk_security, and if the
> case, reject the permissions."  The patch code instead has it return
> 0/success, i.e. permission granted.  Which one is correct?
<oops> -EACCESS would be advised, yes. THANKS.

<please remove my mistake from my permanent record ;-} >
> If we
> return -EACCES, then we might break userspace; if we return 0, we might
> be allowing an operation that should have been denied.  Both seem like
> losing propositions.
if the sk_security is NULL, it is in-effect a form of UAF, so kernel 
_and_ user space is already 'sick'. I think it is a significantly larger 
losing proposition to panic the kernel? Reporting -EACCESS (as was 
proper) is a error propagation way to let user space deal with the 
erroneous condition.

>
> Could we instead have selinux_sk_free_security() defer freeing of the
> sock security blob to a call_rcu(), like we did for
> inode_free_security, or change the caller of it to not free it until
> the sock is truly freed?

AFAIK the upper issue is the premature closing on an RCU protected 
object, and the _right_ answer is that its call should have been 
properly deferred to a synchronization or grace period. Having 
sk_free_security be deferred by the grace period runs the risk that it 
is in a race with the proper deletion of a languishing read object in an 
RCU. It is a bug in the upper layers. My proposal in this KISS stability 
patch is to make security deal with those bugs gracefully until all 
those issues are fixed (in ToT).

-- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
