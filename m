Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DE839F3
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646559; cv=none; b=BqGUGPkaasNQghCnAj3jaCVSlJQE7oVcyuv++eCODyn/SvdPgih6+2QSwrrU1JYyOMwK6WyM6ugpnrgDq36dpaiSXpekSrnJYzBjIyoPzGew7+ZpBkZfZG/S+2pXEu+F6SnKhcD7zED4PGnNs9y01P9jFkmxMZ06mL2OjYFYUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646559; c=relaxed/simple;
	bh=0BNHICJWDsPhZyxdhWmJ+uG5xfSbgW27fugthvOms/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtDjOjmBqBIW8bM50IjlsXRFS1GFjkx9pcJDRjhHwp+P3tsh/X/BStkmtqnuY0BiHTUJ27GRLHD0CVWxV3PQIQzmXL28N20zOK4HO38MiLf381+hgRPT1qeKQEFWZ4p/wNM5M7vfV1Au2wdYIEvM4dDfINwKcpV+86bsMpzt1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Df2BxCCl; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Df2BxCCl"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-65cd720cee2so1178727b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720646556; x=1721251356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUUiE1xWbipMzcW+Lwvs1Sskisgr/3NB0p4XqiIIqwY=;
        b=Df2BxCCl74pwSqBZGJPunVyMCVQVyrRp75gFr21BFm/HMTuXEmT3H48VsAnLzva4H5
         6nQNlXJUJj5lw41lfeC9O+XpvwkmrsNVKOT4SaMv9AL7TOZl65cWN5uC6fq4TCsP2Lj9
         miYAsdUq2s9bQ/yQ+PFGTsmq2ebwpT/PuMVUZnQnHyeNGG58xTu0HYOi/3HC/FRRiunH
         KoK33zauJiydrKf2lUgtIzE0avV5ZGmt8udVc6F6jRyG3ZUDYxlBDCwszSq9lwpvUBrI
         NPOR6uhEMKT7i2rElJVUUtnlSGZ2BGKR2oGUjz3cJ9SXY8mS4dCdSzkwtgT7zMFma5pv
         HspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646556; x=1721251356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUUiE1xWbipMzcW+Lwvs1Sskisgr/3NB0p4XqiIIqwY=;
        b=DxPaR6yMa5RQP6xokjW0QPfTEeO1Q+vHEsxqkfPrYxGFXOmUSIU/9eO7DhFpLbo5QX
         f1erl+7LBAktOtoBgmivPx70BfPsWsz8hZoBALJKTrBY9tMR9Eg+pUbVxD0LVoPHZ5IK
         5elDqL3IhmKYcNMEfP+myLGEr9/urTTq1RdGGdNtKWOQZuPbhgHAPokc37tGSNh8ASTN
         pqJ7ymhGFa8OFaWQMZM7GDWptdEIN1hUtBXFHkABvHk1Oifp4C3peYJBrIBVFbp5KJqc
         cyTew2NMLhD0No9QlJoNAbut+vj05lvj09jm62iZCxqw99PvKi0Zdw6Gql7taIzH0FzY
         n7sw==
X-Forwarded-Encrypted: i=1; AJvYcCUN7Wa0XkbNrjCoMakfYj8tlX81X7i8PAMHKvUoQisUXHEsR9ENjwN8jt0zv2KUMGn+PoIJ1LQOaUrX/HfqgfeUKsstu2vxHq3OxXzeQpbyR9iQYIFc
X-Gm-Message-State: AOJu0YymbrTfHJob2xPnDf4Mc6GdUE8aVOUDjYrHE9T0OhbHuPfSfR22
	kAC2hVpZDz8wCW0AMjsm0BW0fQUdx9NK0Abio8xFFAkoO8Bl/qYHaWSXa8tDJeatEz8QAO9jpjH
	5qox/qLA+P+RPiavrPXPhr13hHSkjRj873A3N
X-Google-Smtp-Source: AGHT+IFEmQcY5GeddQt9TLiu/V/Bm0luCGaLRyN1p4cPBqjVAyuRZ9fBxeTQo9ZtiHdwffXfWQeXDbgrBfeJEhb4QAw=
X-Received: by 2002:a81:88c5:0:b0:64a:79f6:2f2d with SMTP id
 00721157ae682-658ef341451mr69065717b3.31.1720646556460; Wed, 10 Jul 2024
 14:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <20240710.Hai0Uj3Phaij@digikod.net>
In-Reply-To: <20240710.Hai0Uj3Phaij@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 17:22:25 -0400
Message-ID: <CAHC9VhT-n+a0R-XozggrTU2HskwEC+jRuWtKKz9bHwYk-j+dqQ@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:23=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Thu, Jun 27, 2024 at 02:28:03PM -0400, Paul Moore wrote:
> > On Thu, Jun 27, 2024 at 9:34=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > I didn't find specific issues with Landlock's code except the extra
> > > check in hook_inode_free_security().  It looks like inode->i_security=
 is
> > > a dangling pointer, leading to UAF.
> > >
> > > Reading security_inode_free() comments, two things looks weird to me:
> > >
> > > > /**
> > > >  * security_inode_free() - Free an inode's LSM blob
> > > >  * @inode: the inode
> > > >  *
> > > >  * Deallocate the inode security structure and set @inode->i_securi=
ty to NULL.
> > >
> > > I don't see where i_security is set to NULL.
> >
> > The function header comments are known to be a bit suspect, a side
> > effect of being detached from the functions for many years, this may
> > be one of those cases.  I tried to fix up the really awful ones when I
> > moved the comments back, back I didn't have time to go through each
> > one in detail.  Patches to correct the function header comments are
> > welcome and encouraged! :)
> >
> > > >  */
> > > > void security_inode_free(struct inode *inode)
> > > > {
> > >
> > > Shouldn't we add this check here?
> > > if (!inode->i_security)
> > >         return;
> >
> > Unless I'm remembering something wrong, I believe we *should* always
> > have a valid i_security pointer each time we are called, if not
> > something has gone wrong, e.g. the security_inode_free() hook is no
> > longer being called from the right place.  If we add a NULL check, we
> > should probably have a WARN_ON(), pr_err(), or something similar to
> > put some spew on the console/logs.
> >
> > All that said, it would be good to hear some confirmation from the VFS
> > folks that the security_inode_free() hook is located in a spot such
> > that once it exits it's current RCU critical section it is safe to
> > release the associated LSM state.
> >
> > It's also worth mentioning that while we always allocate i_security in
> > security_inode_alloc() right now, I can see a world where we allocate
> > the i_security field based on need using the lsm_blob_size info (maybe
> > that works today?  not sure how kmem_cache handled 0 length blobs?).
> > The result is that there might be a legitimate case where i_security
> > is NULL, yet we still want to call into the LSM using the
> > inode_free_security() implementation hook.
>
> Looking at existing LSM implementations, even if some helpers (e.g.
> selinux_inode) return NULL if inode->i_security is NULL, this may not be
> handled by the callers.  For instance, SELinux always dereferences the
> blob pointer in the security_inode_permission() hook.

Since SELinux requires space in inode->i_security there should never
be a case where SELinux is enabled and we don't allocate a blob for
inode->i_security.

> Shouldn't we remove all inode->i_security checks and assume it is always
> set?  This is currently the case anyway, but it would be clearer this
> way and avoid false sense of security (with useless checks).

It would be interesting to draft a patch to do that and make sure
everything still works; it *should*, but I'd want to see that change
get some good testing :)

Keep in mind, this still doesn't mean that an LSM is required to use
any space in inode->i_security if it wants to use the inode hooks.

--=20
paul-moore.com
