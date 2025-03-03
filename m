Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA12147F3
	for <linux-security-module@vger.kernel.org>; Mon,  3 Mar 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019091; cv=none; b=sFFQOnTKDkIs4dvTYNVpGQlLkVpHfiE0cLRyy2peqXt++sbe6FSGfBT0TCCHcA0RIr7oALOe4yI0f+UGVoBwAf+b/n5Kpw099i+mJ8eBi4unGyoE7knM9fvkFR6OaFyRG2zZU3fasdlsxl4yDl8RYu7+FQTK5phVjZVL29pKLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019091; c=relaxed/simple;
	bh=jw7/kQA5OwPx9eHYWIvFPKi7vpT4waOduVJmre7wldo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tJF+0oDtRCVazXZNEZ+YMncZEC7ZiLZhvwOeGc54sIKrzpdFLEeZWUgklP0WsFPjyJ1BFQlDliFLT/RnXLRRlVRFlY64tVJlwNkuz5mGd7piN33Ep5SNE+QQT609fVvMe79hvTrnfAXvPPO+24yaCyEx7babTTO6w8+DSLFDT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=un7Mjq0T; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un7Mjq0T"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e54bade36dso1375615a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Mar 2025 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741019087; x=1741623887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEqWLXEew5uRYbyxTZYQ6MgCQaS4BNkNIeAHqm8Uq1k=;
        b=un7Mjq0T4YAxxYp6VLTHQRRpsub6dg2oZhCSpJ+vlRj+FcZ+D/vq2SI+1NwaR2IeWR
         w+KOhB/khdmpwZSdiULQuDtx4QyilZg4cLeMYumjfa/R5BKKqj+8hHs7Qgwrsvp01EM9
         reYpUbQnQpDt2nH2hNCxKl2Wp4wrFRo0Asr07OkrAycZZguRb61LejW++YrkZ+/V0y08
         10EOClbPY1IYVxFUn3g+EHWJ+QsOg9h9g+UdDEm5vIK8RD41kEqqIQv1TTqpaKKD0cfE
         rQr6ASceXXHdjlHz4UzhJboLupUEc8EWrlmxAIfG+Jqll0NdQXQfHnUCFtn/mngmO0CO
         hkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019087; x=1741623887;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEqWLXEew5uRYbyxTZYQ6MgCQaS4BNkNIeAHqm8Uq1k=;
        b=kVcm5YZJbF/vhGuNx0vQ4KrBspnAlV/kCcDJvT45+AuvkKKNfNKzYv7yhCcwxuniQh
         eTTuPe+u4IXJs0kOm7ZW4ORHqV/7H0mmufh3OLzVUCES/EJ+07HABfp8MNTa0mxDAssp
         BQkWR77gDK/DYk+cIvNbOXq5DGRHYAVS5EbWdGDkFiujuY7H2/IaU3p7zuFNtyQp5PZj
         fOz4GQXzXGqRU6FT4xGh3M1BVlABZr17mLNBan7XJBoRZgoOdYpT2bnfVRo/10u3c+hO
         xKQ3JKr26Ov7hZgwftGijASK5HW0OKbgEnLX0+l5c2mzNQnJptALDVmVNwPt2yURFnP/
         USgw==
X-Forwarded-Encrypted: i=1; AJvYcCXHJIIztoWcTIcbEEXP3/h432QJnAYll02Bvxk+xcYoBAbBve3ShBSEzhlUZC1AHaEx3b/NL8oqCOpS+4RFHcHYqaz2o4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Op44r/3YxNpr3jjTRHTuOrNaEaVVcBJdvHYBcG2KIbnTE+op
	Tn2kKuTOhDDnlDooobLEYIxSSTo0iisXnzhv0Hs0agdoKS64PH/oW8LRBtNX1p3mt6KaxaDQjLc
	dSg==
X-Google-Smtp-Source: AGHT+IHPGxhI2JuHu2Pq9WNx5PLNPYFHLH06yAjoBMoN79g3tVeuwj4rZpgaYAG2cK0qXBWovekAZvCizRA=
X-Received: from edbef3.prod.google.com ([2002:a05:6402:28c3:b0:5e4:cfa6:790c])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42c2:b0:5de:dd31:1fad
 with SMTP id 4fb4d7f45d1cf-5e4d6ad45e8mr14731923a12.6.1741019087095; Mon, 03
 Mar 2025 08:24:47 -0800 (PST)
Date: Mon, 3 Mar 2025 17:24:45 +0100
In-Reply-To: <sbib2esl6bev7tqww3rgyykpxorpyaix7dujwwm2pg42egg6an@rdyjnecj5vti>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226211814.31420-2-gnoack@google.com> <20250226212911.34502-3-gnoack@google.com>
 <sbib2esl6bev7tqww3rgyykpxorpyaix7dujwwm2pg42egg6an@rdyjnecj5vti>
Message-ID: <Z8XXzUggsHkRLEqG@google.com>
Subject: Re: [PATCH v2 2/3] landlock.7: Move over documentation for ABI
 version 6
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tanya Agarwal <tanyaagarwal25699@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-man@vger.kernel.org, Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Alejandro!

For context, in this patch set, we have three commits:

  * 1/3 and 2/3 copy documentation from the kernel side unmodified.
  * 3/3 revises a section about Landlock's "scoped" restriction features.

I thought it would be easier to discuss with the "copy" and "rewrite" parts
separate, but actually, as you also noticed, 3/3 does rewrite large chunks =
of
the 2/3 commit along the way, and it is probably not worth correcting much =
of
that wording any more.

Would you prefer if I squashed commits 2/3 and 3/3 into one?

On Fri, Feb 28, 2025 at 10:23:47PM +0100, Alejandro Colomar wrote:
> On Wed, Feb 26, 2025 at 10:29:11PM +0100, G=C3=BCnther Noack wrote:
> > With this ABI version, Landlock can restrict outgoing interactions with
> > higher-privileged Landlock domains through Abstract Unix Domain sockets=
 and
> > signals.
> >=20
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  man/man7/landlock.7 | 69 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 68 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/man/man7/landlock.7 b/man/man7/landlock.7
> > index 11f76b072..30dbac73d 100644
> > --- a/man/man7/landlock.7
> > +++ b/man/man7/landlock.7
> > @@ -248,7 +248,8 @@ This access right is available since the fifth vers=
ion of the Landlock ABI.
> >  .SS Network flags
> >  These flags enable to restrict a sandboxed process
> >  to a set of network actions.
> > -This is supported since the Landlock ABI version 4.
> > +.P
> > +This is supported since Landlock ABI version 4.
> >  .P
> >  The following access rights apply to TCP port numbers:
> >  .TP
> > @@ -258,6 +259,24 @@ Bind a TCP socket to a local port.
> >  .B LANDLOCK_ACCESS_NET_CONNECT_TCP
> >  Connect an active TCP socket to a remote port.
> >  .\"
> > +.SS Scope flags
> > +These flags enable to isolate a sandboxed process from a set of IPC ac=
tions.
>=20
> s/to isolate/isolating/
>=20
> AFAIU, to be able to use an infinitive with enable/allow you need a
> direct object in the sentence.  If there's no direct object, you need a
> gerund.

Thanks, this is useful.  Changed it to infinitive for now.

FWIW, the same phrases exist on the kernel side as well, unfortunately.

> > +Setting a flag for a ruleset will isolate the Landlock domain
> > +to forbid connections to resources outside the domain.
> > +.P
> > +This is supported since Landlock ABI version 6.
>=20
> I'm wondering if we should have this as a parenthetical next to the
> title, like we usually do with "(since Linux X.Y)".  Don't do it for
> now, but please consider it for when you have some time.  I'm not saying
> you should do it though, just that you consider it, and tell me if you
> agree or not.

I added it to my notes for further revisions,
I think this would indeed be more appropriate in the man pages.

Is it possible to set the paranthetical without bold as well,
even in a .SS subsection header?


> > +.P
> > +The following scopes exist:
> > +.TP
> > +.B LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
> > +Restrict a sandboxed process from connecting to an abstract UNIX socke=
t
> > +created by a process outside the related Landlock domain
> > +(e.g., a parent domain or a non-sandboxed process).
> > +.TP
> > +.B LANDLOCK_SCOPE_SIGNAL
> > +Restrict a sandboxed process from sending a signal
> > +to another process outside the domain.
> > +.\"
> >  .SS Layers of file path access rights
> >  Each time a thread enforces a ruleset on itself,
> >  it updates its Landlock domain with a new layer of policy.
> > @@ -334,6 +353,51 @@ and related syscalls on a target process,
> >  a sandboxed process should have a subset of the target process rules,
> >  which means the tracee must be in a sub-domain of the tracer.
> >  .\"
> > +.SS IPC scoping
> > +Similar to the implicit
> > +.BR "Ptrace restrictions" ,
> > +we may want to further restrict interactions between sandboxes.
> > +Each Landlock domain can be explicitly scoped for a set of actions
> > +by specifying it on a ruleset.
> > +For example, if a sandboxed process should not be able to
> > +.BR connect (2)
> > +to a non-sandboxed process through abstract
> > +.BR unix (7)
> > +sockets,
> > +we can specify such a restriction with
> > +.BR LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET .
> > +Moreover, if a sandboxed process should not be able
> > +to send a signal to a non-sandboxed process,
> > +we can specify this restriction with
> > +.BR LANDLOCK_SCOPE_SIGNAL .
> > +.P
> > +A sandboxed process can connect to a non-sandboxed process
> > +when its domain is not scoped.
>=20
> Does "its" refer to the sandboxed one or to the non-snadboxed one?

It refers to the sandboxed process.

This correction would be overwritten in the following commit.
I don't think it's worth fixing any more.

> > +If a process's domain is scoped,
> > +it can only connect to sockets created by processes in the same scope.
> > +Moreover,
> > +If a process is scoped to send signal
>=20
> Is this a typo?  s/signal/&s/

It is a typo, copied from kernel documentation.  Oops.

This correction is overwritten in the following commit.


> > to a non-scoped process,
>=20
> Should we use plural here?

This correction is overwritten in the following commit.

> > +it can only send signals to processes in the same scope.
> > +.P
> > +A connected datagram socket behaves like a stream socket
> > +when its domain is scoped,
> > +meaning if the domain is scoped after the socket is connected,
> > +it can still
> > +.BR send (2)
> > +data just like a stream socket.
> > +However, in the same scenario,
> > +a non-connected datagram socket cannot send data (with
> > +.BR sendto (2))
> > +outside its scope.
> > +.P
> > +A process with a scoped domain can inherit a socket
> > +created by a non-scoped process.
> > +The process cannot connect to this socket since it has a scoped domain=
.
> > +.P
> > +IPC scoping does not support exceptions, so if a domain is scoped,
>=20
> Please break after the first ',' too.

Done.


> > +no rules can be added to allow access to resources or processes
>=20
> Please break after the second 'to'.

Done.


> > +outside of the scope.

Thanks for the review,
=E2=80=94G=C3=BCnther
