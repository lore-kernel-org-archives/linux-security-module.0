Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36F36BCDA
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058938; cv=pass; b=PBLt+ZujMPyNkXRm8O1DGTaFlFFQtcI/rVkdD8/vFCTO1J6CKfJa5aR0VmG9pzAlOgDLjAPXNh9vNTK5SGd6Eqo9swlbz5DAAU2SAbbAx54UESCmZRSoOPDiZKoYUip5PBeR8PL6V3IfeZP60F3oluDzuORI9TayhAdxDM16x3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058938; c=relaxed/simple;
	bh=5wV5gHdu7SesU+8B1h67Oy7LFjH98plGqsp+cYWuyqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbwQdyctscsQYadbKD2FKSMCeTNC9Axn2vl96aHmD/6uyB9igBCng5IiLnsujYsf+oxT485ElFlKb/GrREe0CZ4Rq44q+uASWF81EmGrC2Uw+0SIfjoHaiLGYPNs1INhnWLmq+Yzc9AbIFyUIFXERjMpjZeWmvo82oWhAPzdUYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fUUHIbIf; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fUUHIbIf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b7adb38d65so21149215ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 12:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777058937; cv=none;
        d=google.com; s=arc-20240605;
        b=B+lZSO07YwO+Fmw5ptF0WYC0HxkU4yYMcguAbgqE40mp8S0M8OwZfG0hYgpH4tQrlc
         TQm7bYHgFz7k158XFOZqnJho7lNaCLvoYvDvrhNNUJeIsH7tCUsh2AW0N6CHGZVmuulK
         xK3T/DIiQWrr4dqaqursiztblS+A/5jwIwa+nEJ5BaI1ZCyyxS1VFoj5iyzc+fBE9267
         om/YeyLDtAaKluSMPxS1M7uN1aF2xV2uXt3OWOO+Df8w2DF469Vsjb36WkdqN4eMWvot
         anaAkzuzuN8ZFeLnbrfUi8y1E3tTGJZVvoqJpZOymxl8CYkqkG7VayQk7onJiQ/wWHsn
         iLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDRJWWsvL9yXO71FuHSZW5PUMD7qwmFF+O6fM18g8t4=;
        fh=OF09tS27Q0Jkhgu9VEm7FBchde/oSHVg6cMBUOX2ah0=;
        b=IsYn1D0G7tcwMOtKEOSiU0o7s256ZpFsqWHOpImlRLO5X66GzwPOUY5gniZHPG1Eb/
         RdovdvIhnCiVw82EHKCkAkpES20DEGzuMkJ8f0+xWEyAQZ+Nemza1z5gdf4IodBqMyv6
         a+sf614pqO33CcIja6KX/KP4W1UvelYZ4RAF1hFaLUo7BZrhieMUv4sdqQfvHQXtuB6K
         t3CmCrGgwRSBnKx+LJr4ADEBLeN7z2sk0CXTWBc5YkLLbHb+WOpvZS+32AaEE3dXibt+
         esPJOiv6pILZhiL9AWRmjZL4p+9JraUolMkCEWGHOorq1/wBNr4tHOS6GyHGLdrfgRGv
         s55A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777058937; x=1777663737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDRJWWsvL9yXO71FuHSZW5PUMD7qwmFF+O6fM18g8t4=;
        b=fUUHIbIfd6tLuL+723qCLpRz499hr0k/Sj7fEKa6uvYDiA4bqPfibsI5Ey0mKjYGe0
         e91BXSk6CGb/1fSfLHw+7cHSrbzuCRYQagnKNac8fjTRuMgLZyUxh+clyVScp53ORyFv
         SsRHLQ/5X+Ql8uqaV/ZoQyfxwryyD4f2HaA/TdfqIEFi5OudL2rAP8fe442Qlw01AxFC
         EVIfk/48AwOSbjvihcCfiS8Ov6/iW9wQv9CF3vyxK/uTmdFGgZ32T7wvux8eA71uDqNM
         bL6OMEPzpqia0UwgB4fr2PcWF9bmdbCiAtb+kAEVbqlfCzcVvrRm2t8Og6akrJ9zU22d
         Fkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058937; x=1777663737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDRJWWsvL9yXO71FuHSZW5PUMD7qwmFF+O6fM18g8t4=;
        b=R0mJSBGWpvFfqkWdO2R6uRAzPN7VN6eZNsSx1K/Et/NmAytlwVVjiTBslf8rke3AJ3
         Dae2hVnZA7hI7pTb88uI59NQguRmChhBe9Bzg32RcARkl/NqI7zYx5X/DcluavqE2YNE
         BdkQJsEyBZxFYM8PdPre2CuggKEK8Xcy5j+2ane7m3/Byu8MXXgECj5anHjJ4Pqk+mcc
         tQDKCQk1Dv0VJ07oRq9G4kt/KqysQEev+buIHLN5sTDN/nkmZIrZ7i+HBW/FXS78iiaq
         sUgLW7KEh/qidSXW2fVfKEHUvbMokgcnLuSs+5CbLGxQQUuSb9MDhJJ9NcK25wGbTiyk
         xFnw==
X-Forwarded-Encrypted: i=1; AFNElJ+fxvcY4v0mRbwjMIDqpMcos4LiSsEd7rp/ROYU5Z868qPj+YR4hMPBlornqNMzu/KTK5GuEWBvDvXzO9ifN7eqV90Ucvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6gTt/QoJVy97W68F57UspmxX7+DgU5b25n7g12Rm7rn0ISBh
	R8fcSTB57puwECl1n7/TaDNQoCqv5aYjCWAMNj3BQ9bGoLYLunjBv48LczIFjlDplRhuFyWK8Ub
	kutT+/u+LB8gnql3uzYZm2QOYrQ3wXV3ZZaHBNuPJ
X-Gm-Gg: AeBDieuIRfxkvDEAh0ReMusfUsnP3WR8pGZDRKTbWZxZk9dhm9+MYXReDXIJ8ba2pvU
	V8LYIV/16QP+rNsLCs8DL5N1V1TOtZmA+YO67bUHcZ3xmLXbcRAlB12ynhC9X3csrmYDYeiINZP
	Mj0fxrx2ngbs/7aT1pT97QnNxanFyy3dDm01zNJ+2NfPOVLeF6LcEKPrbnPXAI1HMgp79X4l+HL
	P4EAlj622cP1whHiUhZb1ANbA8l2ShTCFOanRDHRkEkXA5kS66YQ4Ll6P6+8t3auKwJNSPdRXyy
	jbwdFEmPIAS/oazzTg==
X-Received: by 2002:a17:903:1b6f:b0:2b2:3bb6:fbf8 with SMTP id
 d9443c01a7336-2b5f9ed0052mr337103375ad.16.1777058936581; Fri, 24 Apr 2026
 12:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312100444.2609563-1-mic@digikod.net> <20260312100444.2609563-2-mic@digikod.net>
 <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com> <20260424.ein5Aiwah6Ai@digikod.net>
In-Reply-To: <20260424.ein5Aiwah6Ai@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 15:28:44 -0400
X-Gm-Features: AQROBzAbmFGtOBrT0jCyIt-S8hm9XW21jA0XHRLCNrgB1YyMNZpQSq2oxRD04eo
Message-ID: <CAHC9VhRcokUR0ZKzCuZnZAyaFEMd6EH93BE3OTTKHY9Mo9pVkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 2:56=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Apr 22, 2026 at 08:19:59PM -0400, Paul Moore wrote:
> > On Thu, Mar 12, 2026 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > From: Christian Brauner <brauner@kernel.org>
> > >
> > > All namespace types now share the same ns_common infrastructure. Exte=
nd
> > > this to include a security blob so LSMs can start managing namespaces
> > > uniformly without having to add one-off hooks or security fields to
> > > every individual namespace type.
> > >
> > > Add a ns_security pointer to ns_common and the corresponding lbs_ns
> > > blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> > > from the common __ns_common_init() and __ns_common_free() paths so
> > > every namespace type gets covered in one go. All information about th=
e
> > > namespace type and the appropriate casting helpers to get at the
> > > containing namespace are available via ns_common making it
> > > straightforward for LSMs to differentiate when they need to.
> > >
> > > A namespace_install hook is called from validate_ns() during setns(2)
> > > giving LSMs a chance to enforce policy on namespace transitions.
> > >
> > > Individual namespace types can still have their own specialized secur=
ity
> > > hooks when needed. This is just the common baseline that makes it eas=
y
> > > to track and manage namespaces from the security side without requiri=
ng
> > > every namespace type to reinvent the wheel.
> > >
> > > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1=
-075c28758e1f@kernel.org
> > > ---
> > >  include/linux/lsm_hook_defs.h      |  3 ++
> > >  include/linux/lsm_hooks.h          |  1 +
> > >  include/linux/ns/ns_common_types.h |  3 ++
> > >  include/linux/security.h           | 20 ++++++++
> > >  kernel/nscommon.c                  | 12 +++++
> > >  kernel/nsproxy.c                   |  8 +++-
> > >  security/lsm_init.c                |  2 +
> > >  security/security.c                | 76 ++++++++++++++++++++++++++++=
++
> > >  8 files changed, 124 insertions(+), 1 deletion(-)

...

> > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > index 259c4b4f1eeb..f0b30d1907e7 100644
> > > --- a/kernel/nsproxy.c
> > > +++ b/kernel/nsproxy.c
> > > @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct =
nsset *nsset)
> > >
> > >  static inline int validate_ns(struct nsset *nsset, struct ns_common =
*ns)
> > >  {
> > > -       return ns->ops->install(nsset, ns);
> > > +       int ret;
> > > +
> > > +       ret =3D ns->ops->install(nsset, ns);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       return security_namespace_install(nsset, ns);
> > >  }
> >
> > Do we also want a security_namespace_switch() called from within
> > switch_task_namespaces()?  Of course LSMs would not be able to fail or
> > return an error at that point, but it seems reasonable that LSMs might
> > want to update LSM state associated with the current task once the
> > namespaces have been changed.  This is similar to all the "_post_" LSM
> > hooks we have for various operations in the VFS and network layers.
>
> What cannot be infered from security_namespace_install()?

We don't actually know if the namespace is attached to a process until
we get to switch_task_namespaces().

Now that I'm looking at this again, why is the
security_namespace_install() call placed after the ns->ops->install()
call?  From an access control perspective we want the LSM hook before
the namespace install, not after as in this patch.  From an LSM state
update perspective we likely only care about when the namespace/nsset
is assigned to a process.

> > I think we would want to pass both the task_struct and whichever
> > nsproxy instance is not stored in the task_struct to the hook.  I
> > prefer placing the hook after the task_struct has been updated, but if
> > anyone feels strongly that it should be the other way that's okay with
> > me.
> >
> > > diff --git a/security/security.c b/security/security.c
> > > index 67af9228c4e9..dcf073cac848 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > +/**
> > > + * security_namespace_free() - Release LSM security data from a name=
space
> > > + * @ns: the namespace being freed
> > > + *
> > > + * Release security data attached to the namespace. Called before th=
e
> > > + * namespace structure is freed.
> > > + *
> > > + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> > > + * RCU-safe freeing for any data that might be accessed by concurren=
t
> > > + * RCU readers.
> > > + */
> > > +void security_namespace_free(struct ns_common *ns)
> > > +{
> > > +       if (!ns->ns_security)
> > > +               return;
> > > +
> > > +       call_void_hook(namespace_free, ns);
> > > +
> > > +       kfree(ns->ns_security);
> > > +       ns->ns_security =3D NULL;
> > > +}
> >
> > The "namespace may be freed via kfree_rcu()" comment in conjunction
> > with the standard kfree() in the function above raises a red flag.  Do
> > we need to take an approach similar to
> > security_inode_free()/inode_free_by_rcu() here?
>
> I though at that too, but the key point is that once the namespace is
> being freed it is not reachable, which is not the case for inode being
> freed (i.e. because of path walks).  So I think the current approach is
> fine even if the comment might be a bit scary.

The comment in the code and your comment in this email thread don't
seem to align very well; one of those needs to be fixed in the next
revision ;)

--=20
paul-moore.com
