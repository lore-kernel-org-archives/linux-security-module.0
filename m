From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 30 May 2018 16:34:49 -0400
Subject: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable holds
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
Message-ID: <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/30/2018 10:10 AM, Peter Enderborg wrote:
> Holding the preempt_disable is very bad for low latency tasks
> such as audio and therefore we need to break out the rule-set dependent
> part from this disable. By using a RCU instead of rwlock we
> have an efficient locking and less preemption interference.
> 
> Selinux uses a lot of read_locks. This patch replaces the rwlock
> with RCU that does not hold preempt_disable.
> 
> Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc9git (+measurement)
> I get preempt_disable of about 1.2ms in security_compute_av().
> With the patch I get 960us as the longest security_compute_av()
> without preempt disabeld. There are very much noise in the measurement
> but it is not likely a degrade.
> 
> And the preempt_disable times is also very dependent on the selinux
> rule-set.
> 
> In security_get_user_sids() we have two nested for-loops and the
> inner part calls sittab_context_to_sid() that calls
> sidtab_search_context() that has a for loop() over a while() where
> the loops is dependent on the rules.
> 
> On the test system the average lookup time is 60us and does
> not change with the introduced RCU usage.
> 
> The boolean change becomes a lot more heavy with this patch,
> but it is a very rare usage in compare with read only operations.
> The lock held during a policydb_copy is about 1ms on a XEON.

This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?

> 
> To use RCU the structure of policydb has to be accesses through a pointer.
> We need 5 patches to get there.
>  
> [PATCH V3 1/5 selinux-next] selinux: Make allocation atomic in policydb objects functions.
> This patch change the allocation for policydb objects. They are in its own patch
> to make the complicated part easier to read.
> 
> [PATCH V3 2/5 selinux-next] selinux: Introduce selinux_ruleset struct
> This makes the access for the rule evaluation going though a single pointer.
> 
> [PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use rwlock.
> We need to make sidtabs copys so this patch change the locks to a rwlock
> and create a copy function.
> 
> [PATCH V3 4/5 selinux-next] selinux: seqno separation
> This patch adds separation of the read and write and uses
> the pointer to switch rule set. It uses seqno for error handling
> since there are a possibility to have multiple access.
> 
> [PATCH V3 5/5 selinux-next] selinux: Switch to rcu read locks for avc_compute
> All the preparation is done so this patch do the change of locks to rcu.
> 
> History:
> V1 rwsem
> V2 did not handle all policydb objects, solved with the policydb_copy
>    did not handle sidtab for booleans, I think this one does however
>    shutdown is not used but not removed. 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
