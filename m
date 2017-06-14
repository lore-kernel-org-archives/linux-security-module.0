From: paul@paul-moore.com (Paul Moore)
Date: Wed, 14 Jun 2017 18:31:28 -0400
Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
In-Reply-To: <2b852eda-e5cc-76f3-3d40-89072e3a56ef@schaufler-ca.com>
References: <3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
	<CAHC9VhS=XF-_stYvFTw37DrJQaHh9G=vmZAbeDObP9DXH7Bi6g@mail.gmail.com>
	<2b852eda-e5cc-76f3-3d40-89072e3a56ef@schaufler-ca.com>
Message-ID: <CAHC9VhSvHfPo6s4L1nG1RxKOwCvZB=UHt_WCPQ7GK5v7ePUAJA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 13, 2017 at 5:24 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/13/2017 8:37 AM, Paul Moore wrote:
>>
>> I'll refrain from commenting on any details in the Smack code, but I
>> thought it might be worth mentioning/asking two things:
>>
>> * I know I've brought this up before and you punted, but since you are
>> reworking the code I figured it is worth mentioning again: I would
>> really recommend leveraging the NetLabel caching mechanism.  All of my
>> measurements are old, but the performance improvement for SELinux was
>> significant; not only do you get to bypass the CIPSO/CALIPSO option
>> parsing, but you get to bypass any of the secattr-to-LSM conversions
>> necessary.
>
> I haven't forgotten about the caching, I'm just having
> trouble working out how to use it. In particular, I think
> (but I'm not completely sure) that having two labels, one
> for incoming and one for outgoing, on each socket makes
> using the caching mechanism difficult.

The NetLabel cache is just a LSM specified blob that gets associated
with the protocol specific packet label.  In SELinux it lets us jump
straight from the CIPSO/CALIPSO option to the secid which is a big
win.  I would imagine you could do something similar with a pointer to
a smack_known struct.

> Smack does not compose or parse packet options
> except when labels are introduced ("imported" in Smack
> terms) to the system. The label/secid/CIPSO triple is
> computed the first time the label is seen and maintained
> as long as the system runs. When a packet comes in the
> CIPSO is looked up in the list. When a packet is to be
> sent the CIPSO is taken from the list entry pointed to
> by the socket (smk_out) label.

Well, call it what you want but I see a linear cost
list_for_each_entry() in smack_from_secattr() that could probably be
bypassed by utilizing the cache.  Not to mention the cost involved in
parsing the category bitmap.

This is what I was talking about when I talked about secattr-to-LSM conversions.

> Does caching work with address selectors? It doesn't look
> like it does, but I can only wrap my brain around so much.

Yep.  We're talking high level so I won't bother with the details, but
the cache works anytime you ask NetLabel to go from the wire-label to
the secattr-label.

>> * It sounds like the main motivation for this change is to help enable
>> LSM stacking for the per-packet access controls.
>
> It's a major motivator, but while I was looking at the existing
> code I became quite dissatisfied with what's there.
>
>> With that in mind
>> would you care to share your current thinking/plans for that?  The
>> proper context (SELinux joke, hardy har har) should help us comment on
>> the ideas/designs in this patch.
>
> In conversations in Toronto last year we agreed that the only thing
> that makes sense is that all security modules need to agree on the
> packet labeling for a packet to be sent.

To be clear, "agree on the packet labeling" means two basic things.

* The global configuration: outbound traffic maps, protocol
definitions (e.g. CIPSO DOIs)

* The per-packet label as seen by the NetLabel kAPI (e.g. struct
netlbl_lsm_secattr)

> There are exactly three ways that this can happen:
>
>         1. Everyone agrees the packet should be unlabeled.

Yep.  Although very uninteresting.

>         2. Everyone agrees to a common labeling

Yep.  See above for what I think that needs to mean.

>         3. Everyone has their own idea on the labeling,
>            and they just happen to match.

...

> I am of the opinion that case #3 is so far fetched that it
> might be ignored. If you agree on the labeling that much I'm
> willing to bet that one of the security modules is redundant.
> Getting the label granularity to match that closely between
> modules would be a major configuration accomplishment. If it
> happens occasionally, great, but SELinux's use of just the
> MLS component and Smack's spelling out the label in category
> bits aren't coming together coincidentally very often. You
> can increase the cases where the two agree with Smack's
> ability to explicitly assign a CIPSO value for a Smack label,
> but I don't see a complete system working that way.

Let's agree to just throw out option #3.  Admins might get lucky and
have it work once in a great while, but it is far from a general
solution and not something I could ever recommend.

> On a local interface you can use Tag 6 to send a secid. If
> you can create a secid that represents a SELinux context
> and Smack label pair (or whatever combination of modules
> you like) you can achieve case #2 locally. This is very good
> news for Smack, because local enforcement is critical.
> And, we need to have a mapped secid solution for SO_PEERSEC
> anyway.

I think eventually we are going to need either a mapping layer for
secids (ungh) or a LSM framework mechanism that allows LSMs to
allocate new secids and have each stacked LSM setup the right state
internally.  I haven't thought enough about the second option to
figure out if it is even feasible, but it saves us the extra layer of
abstraction.

> Which brings us to case #1, unlabeled packets. If the
> system can detect that no one wants a label on a packet
> it can happily be sent. If a packet arrives unlabeled,
> and everyone knows what they want to do in that case,
> there's nothing to worry about. SELinux typically allows
> unlabeled packets to be delivered and sends packets
> unlabeled. Smack sends packets with CIPSO unless the
> sender has the "ambient" label. Smack will also send
> unlabeled packets to "single label" hosts.

If you solve the two "agree on packet labeling" concerns I mentioned
above this just works.

While unlabeled traffic obviously needs to work, it isn't really a
specific use case we need to worry about at the moment.  Solve the
general problem and this should "just work".

> So, if Smack defines 0.0.0.0/32 as single label floor ("_")
> (unlabeled) and 127.0.0.1 as CIPSO,tag6 with appropriate
> Netlabel address selectors you should have a situation
> where you agree on local labeling by case #2 and everyone
> else by case #3 for typical configurations. If you define
> 0.0.0.0/32 with the web ("@") label you get uncontrolled
> network behavior for Smack, as well as SELinux. If you
> want to send CIPSO to the world "0.0.0.0/32 -CIPSO" will
> do that for Smack, and good luck with matching up your
> labeling a'la #1.
>
> If there is a mechanism for mapping the sending labels into
> a single u32 secid we can label locally. If we can agree to
> send packets unlabeled we also have no issue, but there needs
> to be a way to detect that before a packet can be sent. Finally,
> if we're going to insist on sending a labeled packet off box
> there has to be a way to detect the unlikely possibility of
> agreement. All of which seems doable.

Without nitpicking the ideas above, I do agree it all seems doable at
the moment.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
