From: paul@paul-moore.com (Paul Moore)
Date: Fri, 23 Jun 2017 16:47:16 -0400
Subject: The secmark "one user" policy
In-Reply-To: <ace458f9-e5a2-1811-4c1c-449d50c4f4cf@schaufler-ca.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<CAHC9VhRzrFgyD_-N-+h4U78NAJ5xu9x0Ggm0NdKsdUDsTmrCfA@mail.gmail.com>
	<ace458f9-e5a2-1811-4c1c-449d50c4f4cf@schaufler-ca.com>
Message-ID: <CAHC9VhSQZhUhxsDJf4a9OSRys0QsToHH9HNMfunivEGdQDvrRA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 22, 2017 at 7:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/22/2017 3:24 PM, Paul Moore wrote:
>> On Wed, Jun 21, 2017 at 11:23 AM, Casey Schaufler
>> <casey@schaufler-ca.com> wrote:
>>> On 6/21/2017 12:13 AM, James Morris wrote:
>>>> On Tue, 20 Jun 2017, Casey Schaufler wrote:

...

>>>> How would you see this working, ideally?
>>> Ideally there would be a separate secmark for each security
>>> module that wants to use the mechanism. Mechanism would be
>>> provided* so that user-space can identify which security
>>> module it is referring to when interacting with the kernel.
>>> My understanding is that we're unlikely to get an expanded
>>> secmark, so I have concentrated elsewhere.
>>
>> I think "unlikely" is putting it kindly when it comes to an expanded secmark.
>>
>> However, expanding the secmark isn't really the solution we need, or
>> want for that matter.  The core of the problem is that we don't have a
>> security pointer/blob in the skb, and unfortunately, just like an
>> expanded secmark, it isn't going to happen ... at least not in the
>> traditional sense.
>
> I had been thinking in terms of a blob that contains the
> various secids provided by the modules, but a blob that contains
> more/other information has possibilities. Hmm.

You *might* be able to get away with a blob that contains just secids
and is entirely managed at the LSM shim layer, but that is a big
missed opportunity as it doesn't really fix any of the problems we
have now that are caused by a lack of a skb security blob.  The jump
from a blob of secids to a set of LSM specific blobs is a very small
one and solves a lot of problems.  The hard bit is the
secmark-as-a-blob-index, once you've got that working, it shouldn't
matter quite as much what you are indexing.

>>> A "clever" secid mapping takes the secids from all the
>>> security modules and gently manipulates them until they
>>> fit into a single u32. This might be an index into a list
>>> of secid sets ...
>>
>> As we've talked about before, I believe the only real general solution
>> to this problem is to use the secmark as an index into some
>> list/array/???/datastore that acts like a traditional LSM security
>> blob.  The blob could contain whatever the LSM requires: a secmark, a
>> peer label, and/or whatever else comes up later down the line.  While
>> painful, I'm hopeful that we could do this in a way which wouldn't
>> completely tank performance, and I expect that reference counting
>> could be used to help limit memory pressure in most of the current use
>> cases.  This would likely require a few more hooks (I think, it has
>> been about a year since I looked into this last), but based on my last
>> go-round with DaveM the additional hooks weren't a major source of
>> concern for him.
>
> The specific concern I have here is that the code in xt_SECMARK wants
> you to declare a specific security module when using secmarks.

I understand, and perhaps I'm not thinking about it correctly, but I
just don't think it is as large a problem as you believe.  If it truly
is impossible to overcome, we can always create a SECMARK_STACKED
target or something.  I'm reasonably confident this is not the hard
part of this work.

>> This approach would also have the advantage of finally allowing us to
>> handle traffic forwarding in a proper manner.  It's a big mess at the
>> moment and depending on how your network labeling is configured it
>> may, or may not, work.  As software based switches grow in importance
>> for cloud based solutions, having proper LSM per-packet forwarding
>> controls becomes more important (IMHO).
>
> I confess to having spent no time on the traffic forwarding
> implementation. I didn't know there was an issue, but now that
> I do it will influence my choices.

Fun exercise: trace a packet through the forwarding path and watch as
it is either encapsulated or descapsulated by IPsec, similar problems
exist for IP tunnels/conversions (e.g. IPv6 <-> IPv4).

In order to solve this we need a security blob tied to the skb, we
can't rely on IP headers (CIPSO, CALIPSO) or xfrm state (labeled
IPsec).

>>> As for configuration options, SELinux only uses secmarks
>>> when user-space introduces them. If netfilter doesn't have
>>> any security rules that add secmarks, none are used. Smack
>>> can be configured to set secmarks on all packets, with the
>>> potential for change by user-space, but can also be set up
>>> without any use of secmarks. There doesn't need to be any
>>> significant change to xt_SECMARK if it is important to
>>> maintain the "one user" model. Requiring that the user-space
>>> use of netfilter be sane for the multiple security module
>>> case (e.g. don't use SELinux firewall if Smack has the
>>> secmark) seems somewhat reasonable.
>>
>> Ugh, no.  Please, no.  The configuration route is tempting because it
>> is easy, but just think of the users, the poor confused admins.
>> Seriously, think of them, because they are just going to configure the
>> LSMs the way they do now and some of them are going to have a
>> configuration the either 1) doesn't work and they will (rightly)
>> complain or 2) blows up in their face with a kernel panic, a
>> relabeling bug, or something else equally nasty.
>
> Regardless of what we do there will be configurations
> that just won't be possible to make work. A Tizen Smack
> configuration and a DoD SELinux MLS internal network
> setup would be pretty well guaranteed to result in no
> packets being delivered in either direction. You've worked
> on putting distributions together, so you know that at
> some point there have to be limits on just how general
> any "solution" can be.

The difference is that in this Smack-SELinux/MLS case it fails due to
security policy incompatibilities, not due to limitations in the LSM
or the LSM stacking layer.  I want to make sure that the LSM stacking
layer isn't the source of the problem.

NOTE: I'm intentionally avoiding the arguments regarding stacking
specific LSMs, e.g. Smack with SELinux, because I fear this brings us
back around to the old religious arguments.  I would encourage others
to do the same.  These debates were not constructive in the past, and
I don't believe they will be constructive now.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
