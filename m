Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF554EEAE
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000339; cv=pass; b=FxFShue64sj9d1RcSqCWyos9BLV/roXsCbVXilV3HQHbskbC+u6nhw6Slzk+TzB3pSKNRu83zmD0ZvS4uDnOWOwnig9u9u9bdemzFAisyCAVnGWqco22JHecEjuD/2aUoLt5ZoMQyK3p5QNavu0nCDYPwkFgXbbl/1ZFPraw608=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000339; c=relaxed/simple;
	bh=hbHSPhq87+/pwYwNvx5gX2zfxPRsJyJzwGcwpxxTEbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJWYcTRhQhOaRJhxQ2CQiht3P+QGyxBt3d9Z0P1N7IADU8PJNpc43xPSI+nscGZkh99J3eBJZuvyejKNPs/VarhxIqnCRdTchFj69TR6wt+zezHn3JaV3SHZwKiPY3+bzN6N+A3sasSlJxbmKXmF4BwlZAxr3nMB3oCPBGBAfIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Qu1L4A; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Qu1L4A"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1b34ed603so712373a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792000336; cv=none;
        d=google.com; s=arc-20260327;
        b=kqcE9QfjaEubE9d2071vP3hLvQaCxTAFAR5MSqSilQYymloEoQ3lLRVz7GPAgY0GUZ
         h9GKGc3UuIFZKK6MxwKs7LjPlVZsTSfX2rWDtTNa4Hynf9wFwsiRO82kUJcSMpgDsA/5
         M+2g/liJdKa6+BK3GoRdE1PX+8Z+ygPnmAX3lPbE0F98GRHYpq/bPj1nh4ZYFyhQToLk
         UeTr74Q5RiyS+QJRgBOMaJDUxZOWtSyZ+vVHh9m3aBN49u+JdqNRQRpPS1v+rqrHFEDO
         Wc7mEek9xBefCIaiH723nV24xvCASBOLXJoQ+vJ98ikNnKeyjgcavTfqM04utINrMMsN
         gSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        fh=JP3QTR+AjvGlc7/ACRjjsYA2/C4g1uAu0JY2T75bCOU=;
        b=aF4eBjSQvP7x0t/GGhgg9Y7+UlYefuBlXvDLSdiK3Ow3iUWfUfotDWUBQHchuiyi8P
         ECJcoNYhYzzbv1V3pHMQANH/LcBwmsKwnP6PiIp+9LgP4kPFYsd1ODWXX7Uw1hDbeTvh
         fjzzKQb7HY475Od0f45++izhpvE+HLuUp1OF45oRzLiI4GKMxsFjFFs/L0KfhdIJUWOd
         3buRHpxZLcJ5hAyGFxsZqJZc+AZoosl5dvsVdxWbG9NNwiuudiXbufYDJ3agp/vtRLYV
         M5sZziFESYrGN7NU1m9N3N5wH7xihoIUpG9nRUgP1LaY75IWb6ROF+SACkTBiCwA6Dg3
         ydVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000336; x=1792605136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        b=R6Qu1L4AHJBuDACn4coyHjQUcnDafj/0vdancQ/EnPgGCGymLwW5yN7BGIb8tu4op9
         GM6DhSbKUn1RKLznNwv8otDYFe/HrSkHBsxMnC0dx3xlyM6pemKy5Lvyzn/Siy1OZn7Y
         9NlHfkHnFWqAW9bSdePJC56aeKpMsIe5LZJZQAjENpYq1V8KepoSzZcpUoUYwoeZOSwy
         JMSs4/jvpiIne23lCw6AkLphAae6zCfINStfEv3WeubyjoFELyK2UM7/c7BJz2eohVUh
         vDzturfzThHADm8teuq4PkDxmWb/sBVfHK5Z/ABbT5Tzi6qo5JSiAr7aujYldY4/6Mx4
         SHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000336; x=1792605136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ug622xXr9QyPlP/Ov7DfPJB4MLhUVndJohGbmWVpREY=;
        b=UaWxTXK7JXq/NpS+o3YgLCDoj6x2G6HKb96sr3qrH55SVujlrLd3c5YOK1pGqJnWWM
         TdBorZNj6Id9tWTrsYH3Me6i7gf2wB6+pjVm2cgWPwszfM4J5NDpYyIPBUtuCPYHiL+c
         P2cnkCpVf2Zxuu6nF3MzFZR492uHiHyM4RFe5cLC3RbNhzuukxQCpLeI5cE55Yub4W5B
         qKwEwxwNXsjYcxTWpFTcfiT44+A6M94UjbyEmVpfSX5nfIwLvv/w8KOhsN/pgJnDrGaP
         +jcPI6ONqleU6+RrN2InAq8GfayjZheuWmET27H2DoqKaj+gUAjlRdazBEc8JklM0W5h
         aWMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeK+EZQeaPH5lPriNr05byHkitXgzYWRS16ZmMvsd5yxP72du6nD3ovVwXFdzsli/ku7bbjgvySJBIJJVJ+g3Wo8lO8uw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW4lNeSZRjt56M88HT0ZBbxMi9jUy4exH+gCV+8K4T/Ml55TIx
	A6+jjYz2o75AAfLr0rbJ7E+he5hk8DoEDeOpYD3/Dhi+iWkrZRKEc/7zexbaWWMwRd9XJ4knuhr
	DxWj2Ol8AarEyUnDePZmiq1odd4n23a1X+WimQLCV7hg/
X-Gm-Gg: AYBFou0n/a/jTmfvZq8ywMLi0uBEyZCpFD4+3fCwB/9IYqiHuSTlpmMK+RObzU2yqNW
	DX+zGfQXu8Oz85PjeoqizgDmVOZNyr3veuC94pq+rqzvWGaAdEda2earKML9mGkX9wcip2QIJXn
	4OBx681SI2TG6pe+cFFCF1GOW2yvUtzJZ++ppe8VUFVAx5eBbYZ8JLiNZWpHz+Y/zu9ToNBGjeV
	hfYuQv7wuiuqkbOBqaVMtmzcYUq6NoSfz/9gtJ1hWRZP2xqLC1uYeLxx5+C2gKRvL54BMktbRX0
	S+ryCA+gcIcjqY+yUecemJJNWa1KQQBkumtZ0yf03+cbjfJSixcfaoOPf1Usze1zn8lrT4lBVni
	3ooDXAJY7
X-Received: by 2002:aa7:d496:0:b0:6b1:a51d:2091 with SMTP id
 4fb4d7f45d1cf-6b1a51d2173mr7110113a12.3.1792000335396; Wed, 14 Oct 2026
 10:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-1-nicoyip.dev@gmail.com> <as9otxVeOLbhkIMy@kernel.org>
In-Reply-To: <as9otxVeOLbhkIMy@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 15 Oct 2026 01:52:04 +0800
X-Gm-Features: AclHuK-mF7f2-ToQFw5yb6eWZea95LJSk6oMoOQo82NHSzDQBf9ruJ97DzyUm-E
Message-ID: <CAAo+4rXGputXtxgkLLAtFSS=utgr=S=ajbqDFZV=jySZ1yz+sw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace filters
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jarkko,

On Wed, Oct 14, 2026 at 7:34=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, Oct 13, 2026 at 05:03:57PM +0800, Chengfeng Ye wrote:
> > keyctl_chown_key() replaces key->user under key->sem and drops the
> > reference to the previous owner after releasing the semaphore. Readers
> > which do not hold that semaphore can still be using the previous owner
> > when key_user_put() frees it.
> >
> > For example, namespace filtering in /proc/keys can race with chown:
> >
> >   /proc/keys reader                 keyctl_chown_key()
> >   user =3D key->user
> >                                     key->user =3D newowner
> >                                     key_user_put(old)
> >                                       kfree(old)
> >   read user->uid
> >
> > An earlier instrumented run reported:
> >
> >   BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
> >   Read of size 4 at addr ffff8881128abbc0 by task poc/88
> >   Call Trace:
> >    proc_keys_start+0x353/0x440
> >    seq_read_iter+0x25d/0x1190
> >    proc_reg_read_iter+0x19e/0x260
> >   Allocated by task 86:
> >    key_user_lookup+0x1b4/0x540
> >    keyctl_chown_key+0x3cc/0xbf0
> >   Freed by task 87:
> >    kfree+0x149/0x330
> >    keyctl_chown_key+0x7b0/0xbf0
>
> Last night I missed the text below.
>
> It is somewhat messy to the point that frankly I could not read it, or
> at least I did not understand it. Have you read it yourself?
>
> There is a whole eassay and I can only see that key->user can change
> unless key_user_lock is taken, and READ_ONCE() is required to pair with
> the writers.

That READ_ONCE() should be unnecessary, since key_user_lock now
serializes both readers and writers. I will double-check whether to
drop it.

> I don't understand what is going on down there, and what's your goal
> with it?

Yes, the messy commit message should be cleaned up before sending...
Sorry for that. Basically, it describes why the three `key->user` use
sites should be protected by the lock (because there's no
synchronization) and why the remaining access at other sites doesn't
need it (because other caller sites are synchronized). I will rephrase
the commit message to make it human-readable.


>
>
> >
> > Take key_user_lock explicitly while /proc/keys and find_keyring_by_name=
()
> > copy the owner's UID. find_ge_key() is the initial/seek lookup reached
> > by the reported proc_keys_start() fault; key_serial_next() applies the
> > same UID filter to subsequent entries. find_keyring_by_name() reads the
> > same replaceable owner when looking up named keyrings.
> >
> > key_serial_lock and keyring_name_lock protect these traversals but do
> > not exclude chown. Taking key->sem would sleep under those spinlocks.
> > The embedded key->user->lock cannot protect the dereference needed to
> > acquire it.
> >
> > key_user_put() already holds key_user_lock for the final reference
> > decrement and tree removal. A reader selecting an owner before removal
> > blocks its final release until the UID copy finishes. After removal,
> > the lock and reference-count ordering make the preceding owner
> > replacement visible, including when another task drops the final
> > reference. Mark the pointer loads with READ_ONCE() and the chown store
> > with WRITE_ONCE(); the existing lifetime locking provides the protectio=
n.
> >
> > Retain the quota-owner UID rather than substituting key->uid, since the=
y
> > may differ for thread keyrings.
> >
> > Other owner accesses already have lifetime protection. key_alloc() uses
> > a referenced owner before publishing the key. Final key_put() cannot
> > overlap chown, which holds a key reference. key_gc_unused_keys() handle=
s
> > unreferenced keys: serial-tree removal excludes /proc/keys readers, and
> > keyring_destroy() removes named keyrings under keyring_name_lock before
> > the owner reference is dropped. /proc/key-users already holds
> > key_user_lock during traversal. Quota reservation and instantiation nee=
d
> > the separate accounting serialization.
> >
> > Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> > Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GPT-6-Astra
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v4:
> > - Move the quota-reservation and instantiation scopes from v3 1/2 to
> >   the complete accounting fix in 2/2; retain the combined lock coverage=
.
> > - Isolate the namespace-reader lifetime fix and make it independent of =
the
> >   accounting patch by relying on existing lookup/final-release locking.
> > - Pair READ_ONCE() pointer snapshots with WRITE_ONCE() in chown; explai=
n
> >   lifetime ordering and preserve the quota-owner UID filtering semantic=
s.
> > - Include analysis of of the other owner access sites in the changelog
> >
> > v3: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail=
.com/
> > v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail=
.com/
> >
> >  security/keys/keyctl.c  |  2 +-
> >  security/keys/keyring.c |  7 ++++++-
> >  security/keys/proc.c    | 15 +++++++++++++--
> >  3 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index d14ace88e529c..c89a4d6efed40 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -1039,3 +1039,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user=
, gid_t group)
> >               zapowner =3D key->user;
> > -             key->user =3D newowner;
> > +             WRITE_ONCE(key->user, newowner);
> >               key->uid =3D uid;
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 15bf4af8f2821..4a13749bc54cd 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name=
, bool uid_keyring)
> >  {
> >       struct user_namespace *ns =3D current_user_ns();
> >       struct key *keyring;
> > +     kuid_t uid;
> >
> >       if (!name)
> >               return ERR_PTR(-EINVAL);
> > @@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *nam=
e, bool uid_keyring)
> >        * grants Search permission and that hasn't been revoked
> >        */
> >       list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> > -             if (!kuid_has_mapping(ns, keyring->user->uid))
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(keyring->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (!kuid_has_mapping(ns, uid))
> >                       continue;
> >
> >               if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> > diff --git a/security/keys/proc.c b/security/keys/proc.c
> > index 4f4e2c1824f18..aa42ea4becec7 100644
> > --- a/security/keys/proc.c
> > +++ b/security/keys/proc.c
> > @@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_fi=
le *p, struct rb_node *n)
> >       n =3D rb_next(n);
> >       while (n) {
> >               struct key *key =3D rb_entry(n, struct key, serial_node);
> > -             if (kuid_has_mapping(user_ns, key->user->uid))
> > +             kuid_t uid;
> > +
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(key->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (kuid_has_mapping(user_ns, uid))
> >                       break;
> >               n =3D rb_next(n);
> >       }
> > @@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, ke=
y_serial_t id)
> >       struct user_namespace *user_ns =3D seq_user_ns(p);
> >       struct rb_node *n =3D key_serial_tree.rb_node;
> >       struct key *minkey =3D NULL;
> > +     kuid_t uid;
> >
> >       while (n) {
> >               struct key *key =3D rb_entry(n, struct key, serial_node);
> > @@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p,=
 key_serial_t id)
> >               return NULL;
> >
> >       for (;;) {
> > -             if (kuid_has_mapping(user_ns, minkey->user->uid))
> > +             spin_lock(&key_user_lock);
> > +             uid =3D READ_ONCE(minkey->user)->uid;
> > +             spin_unlock(&key_user_lock);
> > +
> > +             if (kuid_has_mapping(user_ns, uid))
> >                       return minkey;
> >               n =3D rb_next(&minkey->serial_node);
> >               if (!n)
> > --
> > 2.43.0
> >
>
> Br, Jarkko

Best regards,
Chengfeng
