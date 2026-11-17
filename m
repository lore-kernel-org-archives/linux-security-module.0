Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794937054;
	b=FjqB3JVzZvjzY3Op735GEz6z3OBkvJU4ekWhHfjQxEVzaG5xBcnXIgRXMk3hP/83vuOH
	 EF8OnKN584w+K17WAqDY2TjuyFVKyEAhdCC46PKMD3oOlhUv/8aoLB2FL6a91hdoUvrTa
	 caEuUSyPpT1uKr7saGuuWIR5WOi16uYFCvac3OHgNGDvtXW7aypMSJXiLrAWxELcDNH4u
	 /5ZsjUk7M7DU+qDqclpAjHc18462iCc2rGlPxGMYtH0kCRj1BbbFFqSiwoebLh8Qz4/uZ
	 9Vkbx0GrQzv+cvLeHqlqGdWQj7ZE159jES1TMefGfufGq+auMS8vUUDApFiRZfOXEiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uIwpU1G0S/NqSFaGi3+jp2QeKv8+tYQDPWGubJQpaow=;
	b=SW+CCbAtdYngUNgciI0B211MaTP+2wtyFwgeNGRJl5K/eFI1G8eIdLze7uSSN88dmZiV
	 xDnYrjPP/rPTEIkoNmT7ko0Z9SEBd5SmfEdAp9PKmmh7nmHsV/HRHtZ6rsRS85a1kDUyh
	 CIEudrLyZ6Qu6kN4fSFlpkADVCSsJ3x4+y2r1vxtNKBk4djzy/UXmDmpuf+MDtijuUQ7C
	 qo4KXGcYiODxYPLGOUPxPFpWyGTNWgrYsipwNpLFSgBpPrbNX0zezgpeVakk0TGUzvaXA
	 sxgbmdY5TkocOdTSXd06S5JlZgTxdEVEwosHaqg0h0Ob6OF2GCb94kx+nDDbYtPp0Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q65pbW00;
	arc=fail smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03038606A339
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 17:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03038606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q65pbW00
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso15641e87.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 09:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937052; cv=none;
        d=google.com; s=arc-20260327;
        b=rA7GtVjbDCI5wL7jgZRkbrsj+pPbs9f6cNn8q3ibP31SgijfD5w4aY5qpMBvAbis6C
         fdvs8qjsoFq7mHafcaAN2O98WDqDKtArdg1JlbOOyF34i5J3a+weNqba3IgGm0S4K5Qk
         4fR3MS0CbOuXgNRNOim+3VxIPFg6nlEmWaHZP5a5KbVB1Deld5DPZhsS2moIyI+8L5o/
         iGCNY7yVy0oHJBFdgJ/qLAUmr1DbCyL2kr10DP9a5xwrUMkSu8+wyVEFc81JGYhEUaTU
         vzGhLWkBx7suwzFOA3d+UbgFjzMKAsPNNKkNEmHFWQM92qwFzbXGWHHTbX8RQcMKrIVL
         ZZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uIwpU1G0S/NqSFaGi3+jp2QeKv8+tYQDPWGubJQpaow=;
        fh=GSTX92z3gk3cAiNKkG8JpRwujUu3yC34Vpm1wNgreGY=;
        b=HKBWXNoheyYWOzGaU2lK4EGL7a3mcODw3/U/17LQADBDl+UR4A7T6m3YyvEiY4vQ6C
         EP1eYf5ClwbifAKQ+oGFoODiFvg4/qwXk7jn3nHIW0REbN/Fb5lzcEUmK/TAf6CzP7/Q
         lbACh8hgRrQh55z3qmQJgSzm9qvD7fta+uTlGDdOGjwo4gwDaQz81BR7LsVJSc4KDEk0
         5DueRTQ0ZO+FwRacVCud6tGJloe1+nUHJBWAxcmMlm0pP7eelJdFgl7alwo10LIF1HSu
         BIeBzf7CHPhaCOu8oN8WMJvh2MJRTz6hySM4vAqkwj/KrOWp/DW1ijfUUATQJ43zPtB/
         568g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794937052; x=1795541852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uIwpU1G0S/NqSFaGi3+jp2QeKv8+tYQDPWGubJQpaow=;
        b=Q65pbW00pHc4gs6KcBvnyKXSyUuTE4JfrmIT6BLnsFPSBfFMXAqtD61+KCEATl4Uhe
         n1QoXCH9dZOtNmk7yDN7n+6kAjyfy8retEs+PZ6tfSfdQGIq9FUnZOktOKjwHqdFA0U/
         pU31o5bmeIj0QOEtlAvK+w2pCq3zPPO59ZQ8IX/g2NKs8AnP1pj6ieY5w4Z5OpyXvMt0
         qmrbgQus2dFV9Uy9SklULFVeaEYqFINed7N4faw6lHIE7N3emkZr72FzTVpCWSyv0FUJ
         lk7F07Ec5pi4GTUqmENNvo3BxxqG9rVt0mPu9/XYetGXV9iu0+sfFhdOAtGmR6e0rmBn
         mviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937052; x=1795541852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIwpU1G0S/NqSFaGi3+jp2QeKv8+tYQDPWGubJQpaow=;
        b=MBYTcyHMji1ngB+StDxBOdXOV4fNMQTjQGdZ8iAPMbRnCWxpgcLSDSoR5vThKKvBNb
         iro+Zp/SNlKxDRrTMwWtKXZxRbPCB3JSSEJFMgvpuDK8mttRbDnS/cBEsnQ6F2Z3zdkG
         T3Vhtd7YxoIlPwUFsFRHk7wKPXzFBGJ0OzC6foPk6lWwSw3E+A6AtlVSaDzDnHAC1SMm
         A1Z6W71Xl3bPaFqOYvp4ThIZeBnfZEN1PqlzKSAPQzHSvvdWjg1SnZQmatebhp2oWw+j
         dALZzSjIMl87RBw6BSG1W5OOjeKjhkEhqsp4Xt5l+SO8rI7PO+YbF1D2wTXijq+IJ+VM
         UP2A==
X-Forwarded-Encrypted: i=1; AL+hErGP3aXZQhFNwdaQCBhcaFOdbfX4vPRdZz73nXfzpjI6FXxKnFDXunV5+ls4ec+BVbH7VsfFzRl98t6gI56hm5QaPxZz9js=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Pr2+ZtdOLCA0OJoyRj2f17+l7T/lGlqHw8XU5pkOtE/zFCRtL
	fqN3zPcIfCMSx2Dmj37Z0QE7zekJZQE03ZCk55T4JLImqynW6lABe6QYflPLnBqgwoF0SqMSFPQ
	g6IrLYEsszRZVTR/CchqMT+J3OJahwwC1zdnEM3L1
X-Gm-Gg: AYBFou2+Hg9S7Nn6YqF/3x+j8d3cY1SBL5k67ilgQv0BiWrt9IqQePR2+GAhyf0iwwA
	26CNITWr3QEpiz8EUl263t8foQe4WZ6oCZc73IoaoiWKJcDEmIFih45Liyw7Ku5oQFA8zWv2aHb
	xioaINQhhrdrxO3EyUky8mihoj+FxznczshlW4oOpvLDoQk2vkpkAxLsmTl+gGwT4uGip9dKxj7
	Uc8rYgYBvIhIqyVChNj5j4900hKNBWkNnRLHxBIbEWsL6uzrPwrTsY/FwNNbLbak0ri5IDLVEkC
	YbAONWD+zm+/fNJ7goSsmZtjraiS4OfUTxW/ygsMrGXyixxaHtg+09/EmuZ7SMw378Y86nct3nh
	74KQuLtHlFE/Wak4ZwoehFlU6O3tF4QA0yw==
X-Received: by 2002:a05:6512:33d5:b0:5bf:a4e4:c329 with SMTP id
 2adb3069b0e04-5c170a15b84mr5575263e87.64.1794937052080; Tue, 17 Nov 2026
 09:37:32 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <20261106-befreien-addieren-eislauf-e09212803534@brauner> <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
 <avM41a80aig2de-R@google.com> <20261111-behagen-faktisch-entgegen-e2e714373895@brauner>
 <CALCETrUjW=kXxyggDUvEN+Pxc-pE98eVbdW8XBU8JzfqXj_voA@mail.gmail.com> <20261117-rational-ohnehin-unbeugsam-e5c04759a156@brauner>
In-Reply-To: <20261117-rational-ohnehin-unbeugsam-e5c04759a156@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 09:37:19 -0800
X-Gm-Features: Aa3M54pEPEuG6xXoA_VcNPLpRvUBxQYv2Rvc07pMupzDgfrZ2jXEXOCCMAfHfMk
Message-ID: <CALCETrWhuOnBy0N0KznmczD4S2XEK0fbr0C=1KFQqTnoTJbQbg@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: Christian Brauner <brauner@kernel.org>
Cc: "Hallgrimur H. Gunnarsson" <halg@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 9:10=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Nov 16, 2026 at 09:15:18AM -0800, Andy Lutomirski wrote:
> > On Wed, Nov 11, 2026 at 7:20 AM Christian Brauner <brauner@kernel.org> =
wrote:
> > > * a task that setns()es in later gets
> > >   ns->cap_bset & (cred->cap_userns | cred->cap_permitted)
> >
> > I'm not sure this is ideal.  If a task has cap_userns & CAP_NET_ADMIN,
> > then there is no attack surface issue with allowing it to enter a
> > namespace and be NET_ADMIN there even if the namespace itself has
> > CAP_NET_ADMIN cleared from cap_bset.  But any exemption here would
> > need to be a new API so that it isn't used by accident.
> >
> > I'm mostly saying this because container managers might want to
> > restrict cap_userns within their containers but still have it
> > themselves for management.  But maybe there isn't any need to enter
> > the userns for this purpose.
>
> I don't think there is. A manager that holds the capabilities itself can
> just do most things from the outside. I think it's nice that once you're
> inside a namespace you're bound by its capabiltiy set. Otherwise the set
> isn't a property of the namespace anymore. If someone comes up with a
> real need to enter we can add an explicit opt-in later?

Fair enough.  Also you've written infinitely more nontrivial container
managers than I have (I've written container managers, too, but
they're all special-purpose things that don't do much in the way of
actual managing).

>
> > > * Root in a container has caps as well so for containers the exemptio=
n
> > >   would be wrong.
> > >
> > >   So here we need a a lockable SECURE_NO_USERNS_CAP_RAISE bit thingy.
> > >   This turns off the exemption and prevents raising the mask.
> > >
> > >   Docker lowers the mask, sets and locks the bit, and
> > >   unshare(CLONE_NEWUSER) in the container doesn't hand out CAP_NET_AD=
MIN
> > >   anymore.
> >
> > Can you clarify this part a bit?  I'm not seeing why Docker should be
> > special.  Shouldn't the inside of a Docker container work as much like
> > a normal non-container system as possible?  What's the use case?
>
> I picked Docker because you brought it up, and your goal of allowing
> user namespaces even in Docker is kinda the use case. Docker can only
> drop the CLONE_NEWUSER block from its seccomp profile if nested user
> namespaces can't get more caps than root/Docker wants to give them.
>
> But the bit isn't at all Docker specific. Any privileged task that wants =
the
> mask to apply to itself would benefit. With just the exemption this would=
n't be
> possible:
>
> (1) A runtime that holds full capabilities gives a
>     user namespace it creates all bits.
>     It can just set the bit before creating it.
>
> (2) In a container without a user namespace container root has host-level
>     capabilities. Any user namespace it creates gets them through this
>     exemption thing. So it can also add them back to its mask. And the ma=
sk is
>     inherited. So every process it starts can then create user namespaces=
 with
>     them.
>
>     by raising the bit we stop both. The locked bit keeps container root =
which
>     also has CAP_SETPCAP from clearing it.
>

I'm still not 100% sure I'm following this.  By "exemption" are you
talking about the cred->cap_premitted term here?

ns->cap_bset =3D parent->cap_bset &
                       (cred->cap_userns | cred->cap_permitted);

(As as aside, as formulated, the parent->cap_bset term should be
irrelevant, no?  cred always refers to a task in parent, and this
whole thing is defined so that cap_userns and cap_permitted are always
subsets of parent's cap_bset, right?)

I think I agree that there needs to be a way to turn the cap_permitted
thing on and off (and I'm also not sure whether cap_permitted is
better than cap_effective), but I'm not convinced that an inheritable
and lockable bit is necessary or wise.

How about changing the rule to:

child->cap_bset =3D parent->cap_bset & soft_cap_userns &
(cred->cap_userns | cred->cap_permitted)

a) (ugly but easier) A non-inheritable prctl-controlled mask
soft_cap_userns, changing the rule to parent->cap_bset &
soft_cap_userns & (cred->cap_userns | cred->cap_permitted).
soft_cap_userns would be reset to all ones on on fork and exec to
avoid creating new inheritable security-relevant state.

b) A whole new create-a-namespace API where the caller chooses
soft_cap_userns at the time they create the namespace.

> On the host none of that matters as the mask is root's own policy there.

I'm still not seeing how there's a difference between host vs
init-userns-container vs separate-userns-container.  After all, in
*any* of these contexts, the configuration *of the host or inside the
container* might want to restrict cap_userns for unprivileged users or
for everyone, which it can do with whatever API we add to do this.
And some container manager might run with CAP_NET_ADMIN in such a
context, and it might want to create its own container that has
CAP_NET_ADMIN removed from cap_bset.   But I might just be being dense
here or I might be misunderstanding you.



There is one thing that continues to bother me about all of this.  In
a sane world where privilege elevation on exec was simply not a thing
(no_new_privs =3D true always, nosuid always, no file caps, etc), then
cap_bset is kind of irrelevant, right?  A task either does or does not
have NET_ADMIN, and it either does or does not have the ability to
create *a task in a new userns, including itself, with NET_ADMIN*.
Since our API is based on creating/entering a userns as opposed to
spawning tasks into a userns, the rule should be, upon entering a
userns:

    cap_permitted =3D cap_userns

or something to that effect.  Or maybe:

    cap_permitted =3D ns_enter_requested_caps & cap_userns

and cap_effective and ambient get clamped to cap_permitted.

Unfortunately we don't live in this world, and I'm not convinced that
can credibly even approximate it, because people really like their
setuid programs working inside a userns.  It still bugs me that we're
designing permission systems designed to work in the POSIX model that
I think we all kind of agree is fundamentally rather messed up.

>
> > In any event, the ptrace access checks also need to be updated.  If
> > we're adding cap_userns, then one should not be able to
> > PTRACE_MODE_ATTACH a task with higher cap_userns.
>
> Yeah, I mentioned that in my reply earlier.
