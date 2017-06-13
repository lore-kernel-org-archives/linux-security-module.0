From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 13 Jun 2017 14:24:52 -0700
Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
In-Reply-To: <CAHC9VhS=XF-_stYvFTw37DrJQaHh9G=vmZAbeDObP9DXH7Bi6g@mail.gmail.com>
References: <3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
	<CAHC9VhS=XF-_stYvFTw37DrJQaHh9G=vmZAbeDObP9DXH7Bi6g@mail.gmail.com>
Message-ID: <2b852eda-e5cc-76f3-3d40-89072e3a56ef@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/13/2017 8:37 AM, Paul Moore wrote:
> On Thu, Jun 8, 2017 at 10:41 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
>>
>> I want to make some changes to Smack's way of looking at
>> networks and network labeling. The existing default is that
>> Smack thinks everyone is a CIPSO host and that any packet
>> without a label should get the ambient label. This was the
>> right choice in 1997 when MLS hosts only talked to each other,
>> and might have made some sense in 2007 when Smack got started,
>> but is clearly not going to work well in 2017. I also have
>> found that the way Smack uses Netlabel is painfully at odds
>> with the way SELinux does, and that could prevent my long
>> term goal of complete module stacking from coming about.
>>
>> The proposed New World Order shouldn't break anybody who
>> isn't using a network that is dedicated to nothing but
>> CIPSO hosts, and that's easy to configure, too. It should
>> make working side-by-side with SELinux reasonably simple.
>>
>> Today, the ambient label (floor by default) is defined as
>> an unlabeled Netlabel domain, and the default domain is a
>> cipsov4, doi:3. When a network address is configured to be
>> single-label the Netlabel configuration does not look right
>> to me, I'm not sure it did anything useful.
>>
>> The change simplifies (put the 'S' in "Smack") the Netlabel
>> configuration and makes everything clearer. To maintain
>> compatibility, 0.0.0.0/0 is given cipsov4,doi:3 and looks
>> on the net as it does today. The loopback address 127.0.0.1/32
>> gets cipsov4,doi:2 and doi:2 is defined to use tag:6, which
>> is the local-only but always correct tag.
>>
>> Because the new configuration uses addresses, it's easy
>> to map it to something reasonable for SELinux. Change
>> 0.0.0.0/0 to an unlabeled domain are you should be happy.
>>
>> # echo 0.0.0.0/0 System > /sys/fs/smackfs/netlabel
>>
>> I'm not 100% done with this patch, but I have to leave it
>> alone for a few days, so it seemed like a good point to
>> get other eyes on it.
> I'll refrain from commenting on any details in the Smack code, but I
> thought it might be worth mentioning/asking two things:
>
> * I know I've brought this up before and you punted, but since you are
> reworking the code I figured it is worth mentioning again: I would
> really recommend leveraging the NetLabel caching mechanism.  All of my
> measurements are old, but the performance improvement for SELinux was
> significant; not only do you get to bypass the CIPSO/CALIPSO option
> parsing, but you get to bypass any of the secattr-to-LSM conversions
> necessary.

I haven't forgotten about the caching, I'm just having
trouble working out how to use it. In particular, I think
(but I'm not completely sure) that having two labels, one
for incoming and one for outgoing, on each socket makes
using the caching mechanism difficult.

Smack does not compose or parse packet options
except when labels are introduced ("imported" in Smack
terms) to the system. The label/secid/CIPSO triple is
computed the first time the label is seen and maintained
as long as the system runs. When a packet comes in the
CIPSO is looked up in the list. When a packet is to be
sent the CIPSO is taken from the list entry pointed to
by the socket (smk_out) label.

Does caching work with address selectors? It doesn't look
like it does, but I can only wrap my brain around so much.

> * It sounds like the main motivation for this change is to help enable
> LSM stacking for the per-packet access controls.  

It's a major motivator, but while I was looking at the existing
code I became quite dissatisfied with what's there.

> With that in mind
> would you care to share your current thinking/plans for that?  The
> proper context (SELinux joke, hardy har har) should help us comment on
> the ideas/designs in this patch.

In conversations in Toronto last year we agreed that the only thing
that makes sense is that all security modules need to agree on the
packet labeling for a packet to be sent. There are exactly three ways
that this can happen:

	1. Everyone agrees the packet should be unlabeled.
	2. Everyone agrees to a common labeling
	3. Everyone has their own idea on the labeling,
	   and they just happen to match.

I am of the opinion that case #3 is so far fetched that it
might be ignored. If you agree on the labeling that much I'm
willing to bet that one of the security modules is redundant.
Getting the label granularity to match that closely between
modules would be a major configuration accomplishment. If it
happens occasionally, great, but SELinux's use of just the
MLS component and Smack's spelling out the label in category
bits aren't coming together coincidentally very often. You
can increase the cases where the two agree with Smack's
ability to explicitly assign a CIPSO value for a Smack label,
but I don't see a complete system working that way.

On a local interface you can use Tag 6 to send a secid. If
you can create a secid that represents a SELinux context
and Smack label pair (or whatever combination of modules
you like) you can achieve case #2 locally. This is very good
news for Smack, because local enforcement is critical.
And, we need to have a mapped secid solution for SO_PEERSEC
anyway.

Which brings us to case #1, unlabeled packets. If the
system can detect that no one wants a label on a packet
it can happily be sent. If a packet arrives unlabeled,
and everyone knows what they want to do in that case,
there's nothing to worry about. SELinux typically allows
unlabeled packets to be delivered and sends packets
unlabeled. Smack sends packets with CIPSO unless the
sender has the "ambient" label. Smack will also send
unlabeled packets to "single label" hosts.

So, if Smack defines 0.0.0.0/32 as single label floor ("_")
(unlabeled) and 127.0.0.1 as CIPSO,tag6 with appropriate
Netlabel address selectors you should have a situation
where you agree on local labeling by case #2 and everyone
else by case #3 for typical configurations. If you define
0.0.0.0/32 with the web ("@") label you get uncontrolled
network behavior for Smack, as well as SELinux. If you
want to send CIPSO to the world "0.0.0.0/32 -CIPSO" will
do that for Smack, and good luck with matching up your
labeling a'la #1.

If there is a mechanism for mapping the sending labels into
a single u32 secid we can label locally. If we can agree to
send packets unlabeled we also have no issue, but there needs
to be a way to detect that before a packet can be sent. Finally,
if we're going to insist on sending a labeled packet off box
there has to be a way to detect the unlikely possibility of
agreement. All of which seems doable.


>> Oh, and I cleaned up those IPv6 ifdefs that made everyone
>> cringe so.
> Regardless of everything else, this makes me happy.  I have to think
> this should make your life a bit easier too. :)

That falls out of having to require netfilter in order to get packets
labeled properly with address selectors. I think I'll be able to retire
the IPv6 port labeling mechanism after I put in a little more work on
netfilter/secmark.  

>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  security/smack/Kconfig           |  10 +-
>>  security/smack/Makefile          |   3 +-
>>  security/smack/smack.h           |  24 ++--
>>  security/smack/smack_access.c    |   6 +-
>>  security/smack/smack_lsm.c       | 265 ++++++++++++++++++++++-----------------
>>  security/smack/smack_netfilter.c |   4 +-
>>  security/smack/smackfs.c         | 208 +++++++++++++++++++-----------
>>  7 files changed, 308 insertions(+), 212 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
