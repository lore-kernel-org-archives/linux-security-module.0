From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sun, 7 Jan 2018 17:33:48 -0800
Subject: Proposal: CAP_PAYLOAD to reduce Meltdown and Spectre mitigation
	costs
In-Reply-To: <a5398c4e-be02-0de6-5c76-c37320011eef@scylladb.com>
References: <a5398c4e-be02-0de6-5c76-c37320011eef@scylladb.com>
Message-ID: <19dd9dfc-88c5-530c-67eb-3c9822b2be43@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 1/6/2018 11:33 AM, Avi Kivity wrote:
> Meltdown and Spectre mitigations focus on protecting the kernel from a hostile userspace. However, it's not a given that the kernel is the most important target in the system. It is common in server workloads that a single userspace application contains the valuable data on a system, and if it were hostile, the game would already be over, without the need to compromise the kernel.
>
>
> In these workloads, a single application performs most system calls, and so it pays the cost of protection, without benefiting from it directly (since it is the target, rather than the kernel).
>
>
> I propose to create a new capability, CAP_PAYLOAD, that allows the system administrator to designate an application as the main workload in that system. Other processes (like sshd or monitoring daemons) exist to support it, and so it makes sense to protect the rest of the system from their being compromised.

As one of the authors of the POSIX 1003.1e/2c WITHDRAWN DRAFT capability
specification I emphatically NAK this proposal. This is nothing like what
capabilities are for. It doesn't fit the use model and it isn't in any way
related to enforcing system security policy.

> When the kernel switches to user mode of a CAP_PAYLOAD process, it doesn't switch page tables and instead leaves the kernel mapped into the adddress space (still with supervisor protection, of course). This reduces context switch cost, and will also reduce interrupt costs if the interrupt happens while that process executes. Since a CAP_PAYLOAD process is likely to consume the majority of CPU time, the costs associated with Meltdown mitigation are almost completely nullified.

This is a horrible hack. The potential for exploitable edge cases
is enormous. 

> CAP_PAYLOAD has potential to be abused;

Yet another really, really good reason not to implement it.

> every software vendor will be absolutely certain that their application is the reason the universe (let alone that server) exists and they will turn it on, so init systems will have to work to make it doesn't get turned on without administrator opt-in. It's also not perfect, since if there is a payload application compromise, in addition to stealing the application's data ssh keys can be stolen too. But I think it's better than having to choose between significantly reduced performance and security. You get performance for your important application, and protection against the possibility that a remote exploit against a supporting process turns into a remote exploit against that important application.

This is just not a viable use of the capability mechanism.
I am not at liberty to comment on any aspect of the exploits
du'jour, so suggesting alternatives is not something I can
do just now.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
