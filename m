Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641562A0B
	for <linux-security-module@vger.kernel.org>; Tue, 13 Feb 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866098; cv=none; b=csqqvCRf76oP76+WhU5H6BAvZlFCB7kv+ksR/P7Nbi+p0t7PVuHgRlXhCb10L9atjrTP0mwPQVVxABvDyTnJoVXycYKWt3+q7Iyk3/T5f2/2Xcegv92srMsJQyxodyYaSYAuZXPl2mgwt3OXEJHSoSvzRj4CAh2DG+UwAOGQCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866098; c=relaxed/simple;
	bh=w8GJGRpC0djALnvUj2t2GIhn2kY0zgu5+Hz3pckS7G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYfz/ilj0Xwt1P3GfvOpnLCJI1xdm0vpSnNPayxz9ECBmD+QML2DHo7oArz/6WxdZg1C5sBQe/NbBXOvv9RKqXHj8NkleV4TBWMsno8/y1SyuJia/a7bzZeN1z97H2BfoadDIPOsJzpk9+lp7OlxnwENBlPQzOjCS2fnq9uTakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BuAuIAMN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BuAuIAMN"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60495209415so47710047b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Feb 2024 15:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707866095; x=1708470895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTKPTPepn/YXbEerAwe7sUKPyaBIskz9MZBv0nYsy1Q=;
        b=BuAuIAMNAUKCnyYVg0sncrBnePg4fPs38zpumHDqHqXrEsjTDzihKEjMhCZ2piMGRg
         DvQGGEmBtGPMPZ93IYtxwny6f/zfKLX2NX/c76d2kQC5gJX6Ck2VP+wLg2my0QdYWz6f
         KJvjtRT8GUNfOZ3RTdv93nsM6QUmdupn1uh34utaEksC4ge2jRVctY4VkFdChkECWQ6h
         L5HdKI//IKdbbC+SXnLS18pWWmuzMLaxwIWjV/C+omd5VBJGQxVeUglv4BQYvXiaSloQ
         qHqdx3jDfQdg5fpZZYPjBtSw3tRoindUnXT2Z7QVPdvlAAbmB5c0boTqGqxhg972Qt3M
         fYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866095; x=1708470895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTKPTPepn/YXbEerAwe7sUKPyaBIskz9MZBv0nYsy1Q=;
        b=ft6q4tHNYkX+Pht1tljG3gBjwStaCGHDgS80fMSAHPt+3/fKiy6TyUWzrvWkYQ4Reh
         JhL0hS4jKx7oDfNdL9Vy2s2Xg9wl5AhVDkvmhvGl7jNSaBzVZzVmwfZhZa7+TPZRVYZN
         eowpWYlzwnWpcmq6m7OHTZdm88yQ/CgOVPB5WRByWIbvQvAncKpnjHX4/iD1EDSdy30d
         5DMx96y938Dr6meMvf2QSqsnl8rP7Eb0/0Un9OVN/B2gvHGRz2Tf2sxDr9L3ICIMKQLm
         injQaSKctKAIYvur1iwc3TlKte/EevAcALzCNRW+JDCSA4bTRD8Wq7ibz0mh+wDDXl2F
         R/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVp99pMjJT66yL9p0xFf/y4LV5KNVI05+jyn3WtQfDxZ7b6MgMkuWrKndvXHg9JSShv23+Kyt166qTDavAswkVoqK+RZh741+DUNIK40XGIoR1lbgmq
X-Gm-Message-State: AOJu0YyvcNdUJbQR7eLlg6OwpZkFmilM+F3vNyVyp3s/OrA19YMc7GpA
	3tT/K6v6EJh3BF8c+PuMQX610sHcO9+pXxV5W2vhjHYTKONHUzsrAjULQ38U7sdmiAyUHeuZLVw
	oXxaaD4lZxniuBpoyEjKUzFpjM4Og9G3K/iNC
X-Google-Smtp-Source: AGHT+IFpx+522+yNLyDxmFV56oYBUQQzE6mue3Y4nUhRB0vethwpn3hrjzeRiazre1ouLZ0D8RFy4snvUO3E3rRkZII=
X-Received: by 2002:a81:93c6:0:b0:607:57c4:6a8c with SMTP id
 k189-20020a8193c6000000b0060757c46a8cmr831088ywg.43.1707866095530; Tue, 13
 Feb 2024 15:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130125659.1709410-1-omosnace@redhat.com> <21d56533-84bc-4be5-af05-a40072fc9e8e@schaufler-ca.com>
In-Reply-To: <21d56533-84bc-4be5-af05-a40072fc9e8e@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Feb 2024 18:14:44 -0500
Message-ID: <CAHC9VhQP12oA-ySchqQOBp+wfLkQvMsQ_7yoSFh1koGtoTe5RA@mail.gmail.com>
Subject: Re: [PATCH] security: use default hook return value in call_int_hook()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:47=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 1/30/2024 4:56 AM, Ondrej Mosnacek wrote:

...

> > @@ -2629,21 +2603,15 @@ EXPORT_SYMBOL(security_inode_copy_up);
> >   */
> >  int security_inode_copy_up_xattr(const char *name)
> >  {
> > -     struct security_hook_list *hp;
> > -     int rc;
> > -
> >       /*
> >        * The implementation can return 0 (accept the xattr), 1 (discard=
 the
> >        * xattr), -EOPNOTSUPP if it does not know anything about the xat=
tr or
> >        * any other error code in case of an error.
> >        */
> > -     hlist_for_each_entry(hp,
> > -                          &security_hook_heads.inode_copy_up_xattr, li=
st) {
> > -             rc =3D hp->hook.inode_copy_up_xattr(name);
> > -             if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> > -                     return rc;
> > -     }
> > +     int rc =3D call_int_hook(inode_copy_up_xattr, name);
>
> I think this is the only place call_int_hook() is used in a
> declaration. Maybe break it up into:
>
>         int rc;
>
>         rc =3D call_int_hook(inode_copy_up_xattr, name);
>
> Not a big deal, I won't fuss over it, but it might make the next mass
> overhaul a touch simpler.

I'm not sure I care too much about that, but as you say it's pretty
trivial, I can make the change during the merge if Ondrej is okay with
it.

> Even more trivial: use ret instead of rc.

If I'm going to be nitpicky I tend to prefer "rc" over "ret" these
days for return values, and using a very crude metric (below) it looks
like we have more instances of "rc" than "ret" in security.c ...

% git show-ref HEAD
7e90b5c295ec1e47c8ad865429f046970c549a66 refs/remotes/linus/HEAD
% grep "int rc" security/security.c | wc -l
28
% grep "int ret" security/security.c | wc -l
16

--=20
paul-moore.com
