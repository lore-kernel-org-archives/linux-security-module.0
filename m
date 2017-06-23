From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 23 Jun 2017 09:53:43 -0700
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <20170623163030.GA18820@mail.hallyn.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
	<20170623160026.GA18257@mail.hallyn.com>
	<aa62373e-7cd6-39dd-2e38-2b6d6dbe18a8@schaufler-ca.com>
	<20170623163030.GA18820@mail.hallyn.com>
Message-ID: <ef37880d-6baa-12a6-eab1-bcd0a4e94d53@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/23/2017 9:30 AM, Serge E. Hallyn wrote:
> Quoting Casey Schaufler (casey at schaufler-ca.com):
>> On 6/23/2017 9:00 AM, Serge E. Hallyn wrote:
>>> Quoting Amir Goldstein (amir73il at gmail.com):
>>>> On Thu, Jun 22, 2017 at 9:59 PM, Stefan Berger
>>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>>> This series of patches primary goal is to enable file capabilities
>>>>> in user namespaces without affecting the file capabilities that are
>>>>> effective on the host. This is to prevent that any unprivileged user
>>>>> on the host maps his own uid to root in a private namespace, writes
>>>>> the xattr, and executes the file with privilege on the host.
>>>>>
>>>>> We achieve this goal by writing extended attributes with a different
>>>>> name when a user namespace is used. If for example the root user
>>>>> in a user namespace writes the security.capability xattr, the name
>>>>> of the xattr that is actually written is encoded as
>>>>> security.capability at uid=1000 for root mapped to uid 1000 on the host.
>>>>> When listing the xattrs on the host, the existing security.capability
>>>>> as well as the security.capability at uid=1000 will be shown. Inside the
>>>>> namespace only 'security.capability', with the value of
>>>>> security.capability at uid=1000, is visible.
>>>>>
>>>> Am I the only one who thinks that suffix is perhaps not the best grammar
>>>> to use for this namespace?
>>> You're the only one to have mentioned it so far.
>>>
>>>> xattrs are clearly namespaced by prefix, so it seems right to me to keep
>>>> it that way - define a new special xattr namespace "ns" and only if that
>>>> prefix exists, the @uid suffix will be parsed.
>>>> This could be either  ns.security.capability at uid=1000 or
>>>> ns at uid=1000.security.capability. The latter seems more correct to me,
>>>> because then we will be able to namespace any xattr without having to
>>>> protect from "unprivileged xattr injection", i.e.:
>>>> setfattr -n "user.whatever.foo at uid=0"
>>> I like it for simplifying the parser code.  One concern I have is that,
>>> since ns.* is currently not gated, one could write ns.* on an older
>>> kernel and then exploit it on a newer one.
>> security.ns.capability at uid=1000, then?
> That loses the advantage of simpler parsing though.  (Really it's not much
> of a simplification anyway.)  So I'm not sure what advantage remains.
>
>> Or maybe just security.ns.capability, taking James' comment into account.
> That last one may be suitable as an option, useful for his particular
> (somewhat barbaric :) use case, but it's not ok for the general solution.

security.ns at uid=100.capability

It makes the namespace part explicit and separate from
the rest of the attribute name. It also generalizes for
other attributes.

security.ns at uid=1000 at smack=WestOfOne.SMACK64

> If uid 1000 was delegated the subuids 100000-199999, it should be able
> to write a file capability for use by his subuids, but that file capability
> must not apply to other subuids.
>
> -serge
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
