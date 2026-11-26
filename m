Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703545;
	b=AuYWniHWlRLrmXK7L4kAyhOpo2EgOYysIKgY1l8Xwo4CrvQQITlbBEaWeMVEYOylNAzw
	 3Vqlh7ev9Zs8WDUVzsaT5jnbEPAz1P7gtOcnxJ9UHbyRw9Z+VAc3S7qVPtekyTMUrpayy
	 Ka6rwDBLpZMA7L58yeW2G2mNkPMVyiZqVLYGdU9cu9AYhz44J7aNk51UgcyJebMiNLUOA
	 k8deoM9kdsdQ5tBzjjsO3Y/0bMwwPn4kvYaaHIBC7w5nO3fNpGz9rVG3YzOg6Wj+Pq1G0
	 cr8QXZTcQFa/UmVEY/53sLnc027WN2xs3Yhfrk8y/fdfVKtSosPctYA8JTKZQxTRy7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703545;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
	b=A5bjDf2YgJ0NaQFSlh/USgrlqXWujmwcPPxxiJK6eZKOxSFI1U52f8PFWmKigOEXlTht
	 m1YAj4ECKdHgReh89Uj3tCo254o0BPOV7lh1M7T6zn+vueaJ5RJsnKiKuM2S7PaUGR5//
	 zkBQBHlRRtJ2lzINOqvqwM4N8Vmi8K8+oQkX1AxKaXi4ymu0X7q4mEQLymJq+89CjjCOF
	 xguxX9co4bPv0pN7B2xJhtNOf03oDT7hDIpxUpo58O5fYuIrMGwAiP0uXEZnNNeEF04Vh
	 AVlRAs/z4K15P1PN506yuZ9Ac/JluNFGP//BysmLDMmU2nt6Ub0nAr0pCuIWPiQnp8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dWhkAlm/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF0606A68C
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 14:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0BF0606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWhkAlm/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795703544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
	b=dWhkAlm/rgUPJl3OyPpQzb7XCB7dWuPSJ07TXheuGSFN2uVe3I9XU/TzKF4kp+gW8Wzogo
	PTZD2ssp9kGpNZENFnJXmKpiZF6/3WyyuvtQBWSB2Zs1Z9N8pKOsk/IyZEj3XZVQYyZzia
	SFa3Kx2DJbJT7Un3EZazyg7sPxAXlLk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-42QqVL5MMkCefOy4b2OBaw-1; Thu, 26 Nov 2026 14:32:22 +0000
X-MC-Unique: 42QqVL5MMkCefOy4b2OBaw-1
X-Mimecast-MFC-AGG-ID: 42QqVL5MMkCefOy4b2OBaw_1795703542
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b37869f851so106562597b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 06:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703541; x=1796308341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        b=WtcEV/mhwxK7duJMODnBMww4Y7VJuVsqbZSZ6I3N34jiKPWJsjICUaO+ZlwVoc8fgB
         Z8o36YvSUSWzmXK3zv3Y7lm60vtsNF8g94Y8w/LpY+WNfUovAREg54Ss3FRjDy9X4Af9
         ajCtoFBpgOH2+crE6398/GCQjxyStH4Lw8iXOlXn/74IXz3xrxOjkj1OoOENOh60RnX6
         AD4EHHvsM7cJb4WOXu+EaH1TnzUdg8/HY0jYpbx0ZZn9TjQOu8Zn/Ohe3B6vsjprViDj
         Hi85lLHvYWH2l2aNTNbsEh4YnLM6wBCneLr5s5bpHV9r7It0MlXNWHDmLmNug1cw/SQc
         Dugg==
X-Forwarded-Encrypted: i=1; AL+hErGR2G/A7T9YZ5y7sTQ3uI/zalkkwA6p8MkJIGz3NUH6fy51w1vuOYF6tBOk/TrslFl3JPrKjKxvBy/7xA+83BXPH096hk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zwwR+/mZHvKvjMkIbwp4Mae4yAGCkihDdy0WIw51H4mz19vl8
	qHnIJx+iKX1cYkcAJ6SaPBXvZAf6gUFjiU1FyMp4JkYaQevLSLZ9k8bWMiJzEHkmSzTWHEqM8JE
	aNYYFfBr7Eocgkc8ATiQZIPfaWWQygdI8hkHUhRmqgsIAU6f5XaIshPWb2Wo1on0LMskSbht5nb
	b4+T9tr8x48A0knMoMoEdUjZL0QvWu+XBiCeWQk1v0AttGQF3iDJ1g
X-Gm-Gg: AZFdTZcRgt/OVCTweU3rLFknbuSkmqXnF7A69N2vw4AnQSbViQBbUMOZUl25aXX5B4T
	U9TO8LoaMyohHsHCncWTH0FWV+UNe4WunVlXIsRrcWire3jKcgh1RQ8CMGxHFbpLWc/Pdtd+JOJ
	6SSERCWt5qvKruFW1LCjmPgmqWSbmxvTRf8Ve8a7hZMKox6iswL6/Q/PoWQ6QIJY9oOhkj2tPMr
	dV4fYx6kX0fY75esU8/ErF298shtk2r6MoSYFrTHkeujA==
X-Received: by 2002:a05:690c:7349:b0:8b4:fc2d:2fbd with SMTP id 00721157ae682-8b52042becemr71775647b3.22.1795703541303;
        Thu, 26 Nov 2026 06:32:21 -0800 (PST)
X-Received: by 2002:a05:690c:7349:b0:8b4:fc2d:2fbd with SMTP id
 00721157ae682-8b52042becemr71775297b3.22.1795703540562; Thu, 26 Nov 2026
 06:32:20 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125091157.1822521-1-huangsj@hygon.cn> <CAHc6FU4h-FRvLkO_0ouTey9MbX=n61t3abt4hPNFOthsRGG9mQ@mail.gmail.com>
 <awgi6a0Hayug7RJH@hsj-2U-Workstation>
In-Reply-To: <awgi6a0Hayug7RJH@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 26 Nov 2026 15:32:08 +0100
X-Gm-Features: Aa3M54qEByO_EHNX8OHGBPouiZLwpLPKlFRFRV9aYOI6i2TAngEySFHZ6dr1dD8
Message-ID: <CAHc6FU4KLxzoQ6NJQUnFfcbKufqwqdhfcGhva9V44K=J7HCXRg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y90NJkrh2VPGjoeWvBo5g3pzFbMpJoY9gHeQea-Ikbo_1795703542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 at 13:20, Huang Shijie <huangsj@hygon.cn> wrote:
> =E5=9C=A8 Wed, Nov 25, 2026 at 11:25:12PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > Huang,
> >
> > I have some thoughts ...
> >
> > On Wed, 25 Nov 2026 at 10:18, Huang Shijie <huangsj@hygon.cn> wrote:
> > > This series adds a superblock inode iterator and converts the open-co=
ded
> > > sb->s_inodes walks in the VFS to it.  The design follows the cursor-b=
ased
> > > construct proposed by Christian Brauner:
> > >
> > >   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-ka=
ntholz-241300d20168@brauner/
> > >
> > > and is the same direction as Dave Chinner's patch set:
> > >
> > >   "vfs: improving inode cache iteration scalability"
> > >   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbi=
t.com/
> > >
> > > The caller owns the iterator state and drives the walk itself:
> > >
> > >   CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
> > >   while ((inode =3D sb_inode_iter_next(&iter)))
> > >           /* do stuff */;
> >
> > The pattern should be:
> >
> >   for (CLASS(...); ...; ...) {
> >       /* ... */
> >       if (/* end iteration early */)
> >           break;
> >       /* ... */
> >   }
> >
> > so that the iterator goes out of scope immediately when the loop ends.
> > Hide the details of the loop header in a macro and that this becomes:
> >
> >   for_each_inode(inode, sb) {
>
> The fs/jffs2/build.c has used this for_each_inode.
> Maybe change to for_each_sb_inode?

That's the least of all problems; just rename the jfs macro.

> >       /* inode is referenced and unlocked here */
> >   }
> >
> > Use that to convert the simple cases.
> >
> > And then we've got preconditions that are checked while the inode is
> > locked. Those can probably go in an expression:
> >
> >   for_each_inode(inode, sb, expression) {
> We still need add flags here.
>
> In evict_inodes() and hook_sb_delete(), only the expression is not enough=
.

I know, these are the two cases that check i_count before the inode is
even locked. Leave them as they are for now; we can get back to that
later.

> How about add a raw code like this:
>
>     for_each_inode_raw(inode, sb, expression, flags) {
>     }
>
> And add a macro for_each_inode:
>   #define for_each_inode(inode, sb, expression)  for_each_inode_raw(inode=
, sb, expression, 0)
>
> Most of the cases, we can use the for_each_inode.
>
> But in the evict_inodes() and hook_sb_delete() we can use the for_each_in=
ode_raw.

No. Convert the simple cases first, with iterator constructs that are
as simple as possible. Later, worry about the more complicated cases.

> >       /* expression was true */
> >       /* inode is referenced and unlocked here */
> >   }
> >
> > This unfortunately cannot be implemented on top of the
> > sb_inode_iter_next() pattern, at least not in a reasonable way, so we
> > actually shouldn't use that pattern.
> >
> > The locked iterator would look like this:
> >
> >   for_each_inode_locked(inode, sb) {
>
> I tried this way today.
>
> The macro for_each_inode_locked is complicated.
> When I tried to add more hooks to super_operations to implement the
> procfs issue, the for_each_inode_locked becomes more complicated.
>
> BTW: the procfs issue see the link:
>   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/

Introducing reasonable inode iteration constructs is a completely
separate problem from introducing per-super block inode iterators.
Please keep those issues apart.

> >       /* inode is locked here */
> >   }
> >
> > This doesn't cover all existing cases, but that's okay. Don't force
> > things into this pattern that are not a match.
> >
> > We can always extend things further if it makes sense.
> >
> > > The lock does not span iterations.  sb_inode_iter_next() takes
> > > sb->s_inode_list_lock, takes a reference on the next inode, drops the=
 lock
> > > again and hands the inode out; the reference is what keeps the cursor=
 on
> > > sb->s_inodes so that the next call can resume from it.  As the iterat=
or
> > > is a cleanup class, a caller that breaks out early does not have to c=
all
> > > sb_inode_iter_end() explicitly.
> > >
> > > Two optional channels let a caller keep its own state instead of fill=
ing in
> > > a shared context:
> > >
> > >   - iter->eligible is called with inode->i_lock held, so that a calle=
r can
> > >     reject an inode before a reference is paid for.
> > >
> > >   - iter->status carries an error out of the walk.  Setting it to a
> > >     negative value makes sb_inode_iter_next() return NULL.
> >
> > Nobody needs that. Just break out of the loop.
> >
> > > Most callers just want a referenced inode and use no flags at all.  T=
hree
> > > flags cover the walks that need something else:
> > >
> > >   - %INO_ITER_F_REFERENCED restricts the walk to inodes that still ha=
ve a
> > >     reference, preserving the "only handle referenced inodes" rule of
> > >     landlock's sb-delete walk.
> > >
> > >   - %INO_ITER_F_NOREF hands out only inodes whose reference count has
> > >     already reached zero, and %INO_ITER_F_NOIGET suppresses the refer=
ence.
> > >     Neither keeps the inode alive, so the caller has to make the inod=
e
> > >     unclaimable itself.
> >
> > No flags.
> If we do not add flags, we cannot convert the evict_inodes() and hook_sb_=
delete().

No flags.

> We'd better convert evict_inodes/hook_sb_delete this time, and then
> we can add more hooks to super_operations{}, such as sb_add_inode/sb_del_=
inode/sb_iter_inode.
> With these hooks in super_operations, we can add more optimization code f=
or different FSs.
> For example:
>
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.co=
m/
>
>   and
>   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/

Right. One step at a time, please.

Thanks,
Andreas

