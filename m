From: paul@paul-moore.com (Paul Moore)
Date: Thu, 22 Jun 2017 18:24:48 -0400
Subject: The secmark "one user" policy
In-Reply-To: <2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
Message-ID: <CAHC9VhRzrFgyD_-N-+h4U78NAJ5xu9x0Ggm0NdKsdUDsTmrCfA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 11:23 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 6/21/2017 12:13 AM, James Morris wrote:
>> On Tue, 20 Jun 2017, Casey Schaufler wrote:
>>
>>> I'm looking at the secmark code and am looking in
>>> particular at the places where it explicitly says
>>> that it is intended for one security module at a
>>> time. For extreme stacking I can either enforce this
>>> restriction by configuration or remove it by clever
>>> uses of secid mappings. Either can be made "transparent"
>>> to existing user-space. Paul has expressed distaste for
>>> using configuration as a shortcut for dealing with this
>>> kind of problem, and I generally agree with him. On the
>>> other hand, the code is quite clear that it is designed
>>> for one and only one kind of secid at a time. I don't
>>> want to put a lot of effort into patches that are
>>> unacceptable to the author.

We've talked about these problems quite a bit the past few years,
although I believe most of those discussions have occurred in hallways
and bars, and with a random collection of bored, uninterested, or
frightened contributors.  Let me try to summarize my thoughts a bit
below ...

>> How would you see this working, ideally?
>
> Ideally there would be a separate secmark for each security
> module that wants to use the mechanism. Mechanism would be
> provided* so that user-space can identify which security
> module it is referring to when interacting with the kernel.
> My understanding is that we're unlikely to get an expanded
> secmark, so I have concentrated elsewhere.

I think "unlikely" is putting it kindly when it comes to an expanded secmark.

However, expanding the secmark isn't really the solution we need, or
want for that matter.  The core of the problem is that we don't have a
security pointer/blob in the skb, and unfortunately, just like an
expanded secmark, it isn't going to happen ... at least not in the
traditional sense.

> A "clever" secid mapping takes the secids from all the
> security modules and gently manipulates them until they
> fit into a single u32. This might be an index into a list
> of secid sets ...

As we've talked about before, I believe the only real general solution
to this problem is to use the secmark as an index into some
list/array/???/datastore that acts like a traditional LSM security
blob.  The blob could contain whatever the LSM requires: a secmark, a
peer label, and/or whatever else comes up later down the line.  While
painful, I'm hopeful that we could do this in a way which wouldn't
completely tank performance, and I expect that reference counting
could be used to help limit memory pressure in most of the current use
cases.  This would likely require a few more hooks (I think, it has
been about a year since I looked into this last), but based on my last
go-round with DaveM the additional hooks weren't a major source of
concern for him.

This approach would also have the advantage of finally allowing us to
handle traffic forwarding in a proper manner.  It's a big mess at the
moment and depending on how your network labeling is configured it
may, or may not, work.  As software based switches grow in importance
for cloud based solutions, having proper LSM per-packet forwarding
controls becomes more important (IMHO).

> ... but if you have two modules using secids
> you can give each half of the secmark and accommodate
> many configurations, including Fedora. Again, you need
> mechanism* for user-space. This option would require changes
> to the xt_SECMARK implementation, which goes out of it's
> way to ensure all secmarks come from the same security
> module. One option is to add a SECMARK_MODE_COMPOUND, but
> that isn't any more helpful then removing the restriction.

I don't mean to make light of this as an issue, but I think we have
larger problems to deal with first (see above).  I think once we solve
those we should be able to deal with this in a reasonable manner.

> As for configuration options, SELinux only uses secmarks
> when user-space introduces them. If netfilter doesn't have
> any security rules that add secmarks, none are used. Smack
> can be configured to set secmarks on all packets, with the
> potential for change by user-space, but can also be set up
> without any use of secmarks. There doesn't need to be any
> significant change to xt_SECMARK if it is important to
> maintain the "one user" model. Requiring that the user-space
> use of netfilter be sane for the multiple security module
> case (e.g. don't use SELinux firewall if Smack has the
> secmark) seems somewhat reasonable.

Ugh, no.  Please, no.  The configuration route is tempting because it
is easy, but just think of the users, the poor confused admins.
Seriously, think of them, because they are just going to configure the
LSMs the way they do now and some of them are going to have a
configuration the either 1) doesn't work and they will (rightly)
complain or 2) blows up in their face with a kernel panic, a
relabeling bug, or something else equally nasty.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
