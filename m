From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 23 Jun 2017 16:51:35 -0700
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <da083027-fcd4-bc08-2d88-93034ba1cacc@linux.vnet.ibm.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
	<20170623160026.GA18257@mail.hallyn.com>
	<aa62373e-7cd6-39dd-2e38-2b6d6dbe18a8@schaufler-ca.com>
	<3404c486-c848-3283-50f7-2283cb631e8e@linux.vnet.ibm.com>
	<20170623183520.GC21137@mail.hallyn.com>
	<da083027-fcd4-bc08-2d88-93034ba1cacc@linux.vnet.ibm.com>
Message-ID: <59197179-8ef9-6be6-315f-41c10a8d7d06@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/23/2017 4:09 PM, Stefan Berger wrote:
> On 06/23/2017 02:35 PM, Serge E. Hallyn wrote:
>> Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
>>> On 06/23/2017 12:16 PM, Casey Schaufler wrote:
>>>> On 6/23/2017 9:00 AM, Serge E. Hallyn wrote:
>>>>> Quoting Amir Goldstein (amir73il at gmail.com):
>>>>>> On Thu, Jun 22, 2017 at 9:59 PM, Stefan Berger
>>>>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>>>>> This series of patches primary goal is to enable file capabilities
>>>>>>> in user namespaces without affecting the file capabilities that are
>>>>>>> effective on the host. This is to prevent that any unprivileged user
>>>>>>> on the host maps his own uid to root in a private namespace, writes
>>>>>>> the xattr, and executes the file with privilege on the host.
>>>>>>>
>>>>>>> We achieve this goal by writing extended attributes with a different
>>>>>>> name when a user namespace is used. If for example the root user
>>>>>>> in a user namespace writes the security.capability xattr, the name
>>>>>>> of the xattr that is actually written is encoded as
>>>>>>> security.capability at uid=1000 for root mapped to uid 1000 on the host.
>>>>>>> When listing the xattrs on the host, the existing security.capability
>>>>>>> as well as the security.capability at uid=1000 will be shown. Inside the
>>>>>>> namespace only 'security.capability', with the value of
>>>>>>> security.capability at uid=1000, is visible.
>>>>>>>
>>>>>> Am I the only one who thinks that suffix is perhaps not the best grammar
>>>>>> to use for this namespace?
>>>>> You're the only one to have mentioned it so far.
>>>>>
>>>>>> xattrs are clearly namespaced by prefix, so it seems right to me to keep
>>>>>> it that way - define a new special xattr namespace "ns" and only if that
>>>>>> prefix exists, the @uid suffix will be parsed.
>>>>>> This could be either  ns.security.capability at uid=1000 or
>>>>>> ns at uid=1000.security.capability. The latter seems more correct to me,
>>>>>> because then we will be able to namespace any xattr without having to
>>>>>> protect from "unprivileged xattr injection", i.e.:
>>>>>> setfattr -n "user.whatever.foo at uid=0"
>>>>> I like it for simplifying the parser code.  One concern I have is that,
>>>>> since ns.* is currently not gated, one could write ns.* on an older
>>>>> kernel and then exploit it on a newer one.
>>>> security.ns.capability at uid=1000, then?
>>> Imo, '.ns' is redundant and 'encoded' in the '@'.
>> So how about
>>     security. at uid=1000@@capability ?
> Ouch.
>> Maybe it's not worth it.
>
> So the .ns is there to be able to possibly extend it in another dimension in the future, like have '.foo' there at some point?

Traditionally we have <kind-of-attribute>.<name-of-attribute>
If you want to preserve the kind and name you have to introduce
a third component if you want to have it treated differently
under curtain (e.g. namespaced) conditions. You want to maintain
the kind, because that's already treated specially. You want to
maintain the name because that's what the feature code keys on.
The kind is expected to be first, and the name last, so your new
data needs to be in the middle. You need to identify what you
expect the new bit to be used for because if you're clever enough
to create a reason to add to the attribute name, someone else is,
too. Thus

	security.ns at uid=1000@@.capability
	security.endian at end=big@@.capability

It's better to add fields than to change how a field is
formatted and interpreted.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
