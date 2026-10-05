Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C02BE043
	for <linux-security-module@vger.kernel.org>; Mon,  5 Oct 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179625; cv=pass; b=RoSTA5l7XkCCSCoWXfH0ebflch3RfHe4TQPY+s8OpbMEOK98sguO3Bf6KE/Pln6hZFKtDzvQR72C47I96lK2fsoOySpifcgQwgu3qtbtsIyAPq0imxry1Gq1ebDDCVnIojjudcWP24hRkg6w/23O4RLfeZkdyOUFA9cyfWDYkTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179625; c=relaxed/simple;
	bh=/Ze/jOMdibKyIRE9oGzvxNmCM4QVvN890ZX2bkJzS98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6fvhGI0UX/7KsRixkemUrGCx0CXTxy89Ah3P1En5VpCPFypRjUnHLqY39m/C7apSji/WJ84Q457kkjUlrQpRwyCX3vQALbBA5VqNGEOaKG+QEVS1XqKvD7V+ULi9NJYJv923Cz5MjhdfVqDpa+LZRPWtl6aehTh+eBy5cl9E8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxGWPgLk; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxGWPgLk"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb49a61d9so274461a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 04 Oct 2026 22:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791179622; cv=none;
        d=google.com; s=arc-20260327;
        b=Nz3YRUryWfxNmd/39JJKqGYvcYrABdkLvLoRQALZv8fvpIYTfiYyZ8144POrpONRfT
         dKWyKXLlzQ5StUNurynSzG7ZZJhnA1XVjcJusem0Dvu7TgcS/NF0xwthjyjZc93cKtUM
         z02pl2/sJbIYhnZPRwHq3UnzXM92aOotQvIgXX1dxsljKiN+fax9MogLoXeSbPlwuoFT
         I6bn4l0dftg0q7E1WBu7anWw/newOTb8xuHvQEhEr57nVKPVcQ8F3eeqcW2Bv2AgAIwB
         KjDJo6tigVUWDgUbgXJvyxolGeUnyji8cHxu6rksiP3QoqSyKR1GdOMXBvUEGgTwI+dr
         b67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gt/7oieYk6ShKB4VNuH1F4baGZHTdzQ+zwU/Jbje3pE=;
        fh=GTBHiUST4x75/Zat7cfTy6XERrAyVcRYlmd0HwgJEgw=;
        b=DYZKfY1qkAUn8VZa34xu6oy3oH0FHqrB6ORwHjEmdei+gGZVL31KVwBUA3QzPDq1fK
         mPt/W9TqIXBT3xzAi48fbyRc7Zb7QrW+laUTpboCyOmOeOxuvqOAcVuMJD5PAzPJUjsI
         9aCTlRtFEflMwC6FF1YXzGYciXJRLzMzb0l+MUuv7xiCzIiU7cSoMUWd8pzx5hmIJG/9
         Nqhllb/GYpUUtKPuRjUt7ZD3NEAAX96qanwgey5Xt/zlyxS/qT/FWMrogoFTA8VQdSwv
         GfdPcUbfZkCDDo7usK6bG23UT6Cgr2wlKdWsT+wCY+q7QNnDmpbf2443KYfPC9XLrM69
         97dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791179622; x=1791784422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gt/7oieYk6ShKB4VNuH1F4baGZHTdzQ+zwU/Jbje3pE=;
        b=IxGWPgLkO3H1hY3Eeu8f1TNXcRx//SHxDFYpI/LHwpgY/ep4Ne1N2H4BeKUHWo/rA0
         zFDgMof8Ok1+4ivJIYo+ZYXr3Kbl9iYrP9MX4YRkTuHxJQ2fzTp0BLHI5I9MRnSiXl/R
         66kfvaRovFY8aYcHqb1xuouKD5zOGSBNMwC4pwlvA6UWkvoC/S5G4gSN7pblXO0CdGL8
         5oqMTP9eyIYEj+8YthAzuoEQG3iHLDnCbqXtVKuZnmP/ePB7rHsWVu3HgFEW0dyn0UAU
         ptpcpYS72RyihM7jGe7zP7iiVLYtMJcsLijH2acFBRDIySyIJ35G+n+zLfRsFfs0W8NR
         EZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179622; x=1791784422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gt/7oieYk6ShKB4VNuH1F4baGZHTdzQ+zwU/Jbje3pE=;
        b=YG4T/Cxkz2RUqgJZsz89jxIurZBCF9kW1EtMTPUSB2hNJXVXKDjBLIWYVJuqaSbPXm
         m6R61+/MTdg9GmBEGFcSUBNjqTM4cEzwNYhfFv8l7mldbaCktuEoLTv9ca3O68cwwdLR
         kdajS4zc/UfOKoOpYL4WSGAfjQPDV6GoaqO6hxKCXxspYG5+/mOhUEGQp72DWjYYdEn5
         cS6JK9ybMfSHtH6zmhVSEv5aZpJ4CfNC0D0iuMGwR8naJ7gBk3BKOImTUtJFOfKLVudi
         NKQhFIJZzGmca2P+g2X+OX54yxwfRpxBUjpAJ9mtuXxXvOU0RWAR0AkpTYpO0O1z/Gyz
         8q8Q==
X-Forwarded-Encrypted: i=1; AKwUvByc3nf/38/ijgyPM0Nz04+gI/jURdBJdSWjTkbOPyw98yhlMih3tYi+lQbjNJKhteS+gCD892zhMYkbTwS6XdDj9tcpkaE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRJ2sBjjyyHaodkaAgAQc6zAxDL3vGF+S0sDfDYmccNoOpPKei
	CBKa5UBzMOqYmUq4TIhFcsx+jlqizXpwqHBbYY+0TyBkEJTLycN61/Ku2m3AegflVgqIiRDPtlF
	wSxJzkWjPzmW/sFqqXlYLS52AxRg9lA4=
X-Gm-Gg: AYBFou0MkFoNm/0ZZkPv1k+vceNzxusWCffi2YdqxEb8T4kyNLEs8/jxLBRsV5wrbRZ
	f5Qc57JGOdE2MiScn5tKh7/KtcPRbLYLxwPPYEupFIb6iCdt6/uZjnLdgzWf6wXhoIJhh5MX1DW
	dZSg8Wx8QTHf3RwgTyqdbbVxNEddOe9b452rHxv3worPLoL4hwnMLpxRoPVETZ0vj+UualUt/o2
	GJq97QiwwND5vTYSJPkwmT344nR7VEr/wQ7wmcOUgtsv0HnWyBe+WuMO8WlKYGwsLaB6NxcGlGL
	NtwjwcAUSixLlw+Fcutl1x1nrCRYvrOJ6SKkHEafND+ibZDBvcU6jI6J3qDF2mwDtrGw8npsjjo
	N8sl9XIw5K98=
X-Received: by 2002:a05:6402:1d4f:b0:6ad:723:1d6c with SMTP id
 4fb4d7f45d1cf-6af9e2ae5f7mr8588577a12.2.1791179621643; Sun, 04 Oct 2026
 22:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-3-nicoyip.dev@gmail.com> <asMIwpXXWQaD3gAD@kernel.org> <asMQMzqVkmYhwgMB@kernel.org>
In-Reply-To: <asMQMzqVkmYhwgMB@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 13:53:29 +0800
X-Gm-Features: AclHuK-pkRL-PIEptFTZp1svoeb3zjIH2fPWO872zakO885qLUCTEslthC1wtlc
Message-ID: <CAAo+4rULBiu6tOrdOjsgFcudjvyQO+DR9oZK=wms_3KxgFPNHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] keys: Serialize ownership transfers with key accounting
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 10:49=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon, Oct 05, 2026 at 05:17:42AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 28, 2026 at 12:25:28AM +0800, Chengfeng Ye wrote:
> > > Protecting individual accesses to key->user does not make ownership
> > > transfers atomic with accounting updates. keyctl_chown_key() holds
> > > key->sem, but instantiation is serialized by key_construction_mutex a=
nd
> > > need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown o=
f
> > > an uninstantiated key.
> > >
> > > The instantiated-key count can therefore be charged to the wrong owne=
r:
> > >
> > >   instantiate                       keyctl_chown_key()
> > >   lock key_user_lock
> > >   increment old->nikeys
> > >   unlock key_user_lock
> > >                                     observe KEY_IS_UNINSTANTIATED
> > >                                     skip the nikeys transfer
> > >                                     replace key->user
> > >   mark key instantiated
> > >
> > > The key becomes instantiated under the new owner while the increment
> > > remains with the old owner. Negative instantiation has the same race.
> > >
> > > Quota reservation can likewise run between charging the new owner and
> > > replacing key->user. It then adjusts the old owner's quota and change=
s
> > > key->quotalen while chown is transferring that quota burden.
> > >
> > > Extend the key_user_lock critical section in keyctl_chown_key() acros=
s
> > > the quota and key-count transfers, state check, and owner replacement=
.
> > > Also extend the instantiation critical sections across the state upda=
te,
> > > so chown observes the count increment and instantiated state together=
.
> > > The existing per-user quota locks continue to serialize quota changes
> > > against other keys owned by the same user.
> > >
> > > Keep allocations, notifications and reference release outside
> > > key_user_lock, and release it on the quota-overrun path.
> > >
> > > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's=
 owner")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > > ---
> > > Changes in v3:
> > > - Split from v2 as patch 2/2; see the cover letter for the full split=
.
> > > - Rebase onto current mainline and retain explicit reader-side lockin=
g.
> > >
> > > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gma=
il.com/
> > >
> > >  security/keys/key.c    | 4 ++--
> > >  security/keys/keyctl.c | 6 ++++--
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > index d0d583194b05..54c675b3b58d 100644
> > > --- a/security/keys/key.c
> > > +++ b/security/keys/key.c
> > > @@ -454,8 +454,8 @@ static int __key_instantiate_and_link(struct key =
*key,
> > >                     /* mark the key as being instantiated */
> > >                     spin_lock(&key_user_lock);
> > >                     atomic_inc(&key->user->nikeys);
> > > -                   spin_unlock(&key_user_lock);
> > >                     mark_key_instantiated(key, 0);
> > > +                   spin_unlock(&key_user_lock);
> > >                     notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
> > >
> > >                     if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &=
key->flags))
> > > @@ -613,8 +613,8 @@ int key_reject_and_link(struct key *key,
> > >             /* mark the key as being negatively instantiated */
> > >             spin_lock(&key_user_lock);
> > >             atomic_inc(&key->user->nikeys);
> > > -           spin_unlock(&key_user_lock);
> > >             mark_key_instantiated(key, -error);
> > > +           spin_unlock(&key_user_lock);
> > >             notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> > >             key_set_expiry(key, ktime_get_real_seconds() + timeout);
> > >
> > > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > > index c17924609317..83a9575b084e 100644
> > > --- a/security/keys/keyctl.c
> > > +++ b/security/keys/keyctl.c
> > > @@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t us=
er, gid_t group)
> > >             if (!newowner)
> > >                     goto error_put;
> > >
> > > +           spin_lock(&key_user_lock);
> > > +
> > >             /* transfer the quota burden to the new user */
> > >             if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> > >                     unsigned maxkeys =3D uid_eq(uid, GLOBAL_ROOT_UID)=
 ?
> > > @@ -1036,11 +1038,10 @@ long keyctl_chown_key(key_serial_t id, uid_t =
user, gid_t group)
> > >                     atomic_inc(&newowner->nikeys);
> > >             }
> > >
> > > -           spin_lock(&key_user_lock);
> > >             zapowner =3D key->user;
> > >             key->user =3D newowner;
> > > -           spin_unlock(&key_user_lock);
> > >             key->uid =3D uid;
> > > +           spin_unlock(&key_user_lock);
> > >     }
> > >
> > >     /* change the GID */
> > > @@ -1060,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t us=
er, gid_t group)
> > >
> > >  quota_overrun:
> > >     spin_unlock_irqrestore(&newowner->lock, flags);
> > > +   spin_unlock(&key_user_lock);
> > >     zapowner =3D newowner;
> > >     ret =3D -EDQUOT;
> > >     goto error_put;
> > > --
> > > 2.43.0
> > >
> >
> > I double-checked this patch too given the concerns on 1/2 but nope, thi=
s
> > does not raise similar concerns as every critical section is strictly
> > related to ownership change.
> >
> > E.g., I can be sure that the granularity is where it should be and lock=
s
> > are actually needed in the first place.
> >
> > Thus, I'm still including this patch to my next PR, and drop the first
> > one.
>
> By dropping 1/2 I found out that 2/2 key.c becomes:
>
> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595..de63120c51ad 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -449,6 +449,7 @@ static int __key_instantiate_and_link(struct key *key=
,
>                         /* mark the key as being instantiated */
>                         atomic_inc(&key->user->nikeys);
>                         mark_key_instantiated(key, 0);
> +                       spin_unlock(&key_user_lock);
>                         notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
>
>                         if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &=
key->flags))
> @@ -606,6 +607,7 @@ int key_reject_and_link(struct key *key,
>                 /* mark the key as being negatively instantiated */
>                 atomic_inc(&key->user->nikeys);
>                 mark_key_instantiated(key, -error);
> +               spin_unlock(&key_user_lock);
>                 notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
>                 key_set_expiry(key, ktime_get_real_seconds() + timeout);
>
> This type of interleaving should never happen in a patch series.
>
> Please don't rush your changes like this in future.
>
> Br, Jarkko

Sorry for the mistake, I should have carefully verified that the tree
remained valid at each step of the series.

I will rework the locking on 1/2 to inspect if there might be any
unnecessary coverage, and verify each intermediate commit
independently before sending a revised version for the patch series.

Best regards,
Chengfeng
