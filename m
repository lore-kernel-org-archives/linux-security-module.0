Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC41A704B
	for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780753; cv=none; b=MDAQ+QXsOAOo0W254l6Wug+q6h78C+OhME1z5L3nEKG5OjhCjSCozX+wYK5bdan8kccGDH7lCBvb6gXFUFadA01iNm9T8OBW4FdJcDAmmSnkE06OinFiF0LsQ76RDXazflbppDtnguCLY67OazULr7mc+5r8F6bT5sU+QGjyHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780753; c=relaxed/simple;
	bh=wN4yGxSXINzDhFkHcC/bjuOi9mS4R56p+OcnBXeIYr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlUD5LwmpPVq0lxw/Rps726pEV0u8OEnwACJm2s/ouYYH5TBaEdhgaCAvebDUzJVFDieVpkDRHVVOGs4YojgekkmoS0m/MFDfFsAlogBF2ThtwE4nEfI1nPx1vSsCgrp9fEV2yptW19YMn1Ccrfd8Iu3a6QHVs8xCt4mcj6cabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTP9BtLP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTP9BtLP"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso31048a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747780750; x=1748385550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILFMcZ2c1g7Az+p/u2m4/MT32WFW34DxCQbbI9/Sr3g=;
        b=FTP9BtLPrg+POyMdsTu64YRwNZ4QzsA8Edmg9G/Mq2e/6fyMgkUhHFbtsVxsWNnjLE
         K1+lVMw84m+9SHkGk/dbBHxHIPIRNa5TqLEXLal5I9FJqWgmz61cARfYGV1X8WlzAvs/
         Se7aDG9b6BE3rWlIVcWWJxIqAb+XVuONuZOL/Rgn9iCCoSoDSnooH3JbXfAijly+VyZW
         oUyjoyPV569tGjD3TTVgjl0OtD0FhO4tWEkdT1G4nF4IK8q/SGbIFJB49mm+SC50Mtlp
         jPlBFmhx0fQQbdqvRzlh0uay0Ypc7vAizXAK2Pg33R9uJCaYdH4W17hKhhw2wtJRMMA3
         GdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747780750; x=1748385550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILFMcZ2c1g7Az+p/u2m4/MT32WFW34DxCQbbI9/Sr3g=;
        b=uzxyQdysnExTSPHizvE02UO1n6gjoLhE6KSqCDSkeIDbZRadGh35azM8hWnA66XnvK
         tr9EttB3Q31CWNeIk4iR4M9jnIWGGu7fclJs1evvhQLAD/muUIsoyFTKG8dI+ARV9Nci
         wN7VMVwMZ5n0jmONws8St0rxkyP8FglGsdXS9UWGl1aZMERfac/Q/IEvNM54Gprgf2U3
         k3YvKxbxUiUDYNhdo92o6S/rpP3mvrecLxRFMVg9sckpvhLHNTXRMstjAWJGfz2UWDOR
         pod68dFesL0mVzH3ytbuMZtXaeaCUATqv2RFn/LO+3WgR//EQn7HycgpB1U/M5wIMkll
         6egA==
X-Forwarded-Encrypted: i=1; AJvYcCW9p0MbhpasbqqPkmZJscwKwAkQBTbFbMlglj59UGJ6zaFfSOUtj9hxhDap3mslhAPoPrcXlHNzNKf3V0mPZmRbhbXRCpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+uAqjlRLEq/h/DluRXDOGsxBtlyuFS1C2hWfAH/TQO9JW3gb
	l0YZ6B1qOjvbdv7yMP2nKbYdZx7Ogxqc5bphU4OmVKxbrsloo2ES0kadUeMvCYo3RInsBkDv8go
	/fO5n1T7gF4B7expkuu92ys88fmr6qxF2nV9ktoaJ
X-Gm-Gg: ASbGncuwbmKomZ2A50fcVMTmgB4uVmF+pSDvr45qCvopj6KP8Bdch/bp5n6p/0WZZYC
	xHsFKdCB1AMc+LCQxBXpAsG3PTQ6VfGhsaVafTzgMW4Xlu1dOAozga/HiqHblgSumW5eM1pWuqg
	GAMzB/uy9wsrWUWY/ecI2CQ+1K61tSTmGLegel0h9/i6N5dmlOH7ZxjRhhGo+b5I5OVg4YXmMB
X-Google-Smtp-Source: AGHT+IHiM5utHlvS1KwtbMzIvdi8muzao2WgP49RJiwt9DhoDUMEmyA+7F/EX5MwVE5HhSrPQHgiE4+9FO6Ter/KAZQ=
X-Received: by 2002:aa7:cfda:0:b0:5fd:2041:88f7 with SMTP id
 4fb4d7f45d1cf-6019bf2f781mr321484a12.2.1747780750080; Tue, 20 May 2025
 15:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <aCeyKHNDbPLWQP0i@lei>
In-Reply-To: <aCeyKHNDbPLWQP0i@lei>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 May 2025 00:38:33 +0200
X-Gm-Features: AX0GCFuMBQxmG9Fb_r1Cs4pa1FI5Ei_amaGItaHzhD2McpCVCWBFjhX6X7HBMmE
Message-ID: <CAG48ez2q3iSXq_2C-DrJ774z-Cq2misdm53r5FBGrdwVbKDZSA@mail.gmail.com>
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
To: sergeh@kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Max Kellermann <max.kellermann@ionos.com>, "Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com, 
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:46=E2=80=AFPM <sergeh@kernel.org> wrote:
> On Fri, May 16, 2025 at 08:06:15PM +0200, Jann Horn wrote:
> > On Fri, May 16, 2025 at 5:26=E2=80=AFPM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> > > Kees Cook <kees@kernel.org> writes:
> > >
> > > > On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> > > >> I have condensed the logic from Linux-2.4.0-test12 to just:
> > > >>      id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(n=
ew->egid);
> > > >>
> > > >> This change is userspace visible, but I don't expect anyone to car=
e.
> > > >> [...]
> > > >> -static inline bool __is_setuid(struct cred *new, const struct cre=
d *old)
> > > >> -{ return !uid_eq(new->euid, old->uid); }
> > > >> -
> > > >> -static inline bool __is_setgid(struct cred *new, const struct cre=
d *old)
> > > >> -{ return !gid_eq(new->egid, old->gid); }
> > > >> -
> > > >> [...]
> > > >> -    is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> > > >> +    id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(n=
ew->egid);
> > > >
> > > > The core change here is testing for differing euid rather than
> > > > mismatched uid/euid. (And checking for egid in the set of all group=
s.)
> > >
> > > Yes.
> > >
> > > For what the code is trying to do I can't fathom what was trying to
> > > be accomplished by the "mismatched" uid/euid check.
> >
> > I remember that when I was looking at this code years ago, one case I
> > was interested in was what happens when a setuid process (running with
> > something like euid=3D1000,ruid=3D0) execve()'s a normal binary. Clearl=
y
> > the LSM_UNSAFE_* stuff is not so interesting there, because we're
> > already coming from a privileged context; but the behavior of
> > bprm->secureexec could be important.
> >
> > Like, I think currently a setuid binary like this is probably (?) not
> > exploitable:
> >
> > int main(void) {
> >   execl("/bin/echo", "echo", "hello world");
> > }
> >
> > but after your proposed change, I think it might (?) become
> > exploitable because "echo" would not have AT_SECURE set (I think?) and
> > would therefore load libraries based on environment variables?
> >
> > To be clear, I think this would be a stupid thing for userspace to do
> > - a setuid binary just should not be running other binaries with the
> > caller-provided environment while having elevated privileges. But if
> > userspace was doing something like that, this change might make it
> > more exploitable, and I imagine that the check for mismatched uid/euid
> > was intended to catch cases like this?
>
> If the original process became privileged by executing a setuid-root
> file (and uses glibc), then LD_PRELOAD will already have been cleared,
> right?  So it would either have to add the unsafe entries back to
> LD_PRELOAD again, or it has to have been root all along, not a
> setuid-root program.  I think at that point we have to say this is what
> it intended, and possibly with good reason.

Oh, I see what you mean, glibc's loader code zaps that environment
variable on secureexec for additional safety, I didn't know that.
