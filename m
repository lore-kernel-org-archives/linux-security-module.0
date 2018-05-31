From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Thu, 31 May 2018 08:42:06 -0400
Subject: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable holds
In-Reply-To: <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
	<8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
	<1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
Message-ID: <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/31/2018 05:04 AM, peter enderborg wrote:
> On 05/30/2018 10:34 PM, Stephen Smalley wrote:
>> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>>> The boolean change becomes a lot more heavy with this patch,
>>> but it is a very rare usage in compare with read only operations.
>>> The lock held during a policydb_copy is about 1ms on a XEON.
>> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
>> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
>> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
> That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
> We do not? use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
> used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
> a multiple writes to sysfs during a boolean settings?? However my concern is/was memory pressure, setting booleans will generate pressure
> with lot of atomic allocation and large vmallocs.

Yes, that is also a concern.  I would prefer to only duplicate the conditional policydb state as in KaiGai's patch.
Keeping temporary setting of booleans lightweight is desirable for other use cases than Android.

I'm also concerned by the implications of switching all of the allocations to atomic.  KaiGai's patch did not take that approach either, and it obviously could make policy reload more prone to transient failures.

 But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
> of copying the policydb.? About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
> is policydb_destroy() of the old copy.
>>



--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
