Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B119D886
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142200; cv=none; b=A8BM0p65QvHFR+r62akyywMQdnjLY5lAl3g7bi3kjx1xIhxENImPJdvA34MvBac67ZmuMTcQJ/NxGdaw+paFPcoSiV9LMP7XwMNYpM+lub/dTynu1WOvexg7G0FXnrY1hVPKHHsUvGyjEV9kfhPitPYSMEtTW+M43/elwZzc9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142200; c=relaxed/simple;
	bh=DHR09VYVRkGUGP0l/vA4+20intCid7dDJWNip64G1sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpkYVdcBYQHDjfluMiywKkiKXKPrDpA3fzdcbkwTUcBo01dOtvIznORe8ZVvFf27CxdwZaWyxUUBxc3tF/bB4s+p3Vt87ewNit5KIrs1VzphXWL61wX55y/jn+AKR9XiW1JQ1WyChM7YsFOkT8w4poYNHkb5JNG+KmR1NqtKNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoPTLJPR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoPTLJPR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so16589a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2024 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721142197; x=1721746997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQXyGuZsqmv7+37GKhT1A2NCIQ7jfA+IZBk14phBRDQ=;
        b=QoPTLJPRSEAsmyiHvuKHvsgRIBssbG+D5pYuQ2mxtkILDMoKSOxa1Fmi0IHDUvobEo
         U5jmx3fQW3bBsTvofTB9b6A5CIrhfJBXcM/tkHbghRK6tTp5TJ8cEufZ1Pw8T6o99wSK
         /m40jaHhdrN2z41LJ6E4pmibGtqGDX+/Jlz3eaT6RR3aQ4MCRY2qEwM2TjTvlxlS2QRJ
         9VzncfEE2XCOZEj4V3UK73T91QHA29DQlyt3Wdi7m59s6pA2VSJl9RMZ2D2Gr40Ej1h6
         tr046IqfIm99zPMMn7TXNXgpTf0zQnHHTe6hNFhZyBgAzcBL/RQNg0Og1pihELrs7k5s
         bugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142197; x=1721746997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQXyGuZsqmv7+37GKhT1A2NCIQ7jfA+IZBk14phBRDQ=;
        b=J3AaXPu3KSplh4Ki2LYYyFvBZ6G0Gq/CLLBKtzVC/rUxjFw9vRdL+gvfQJPOcVILwr
         skWDxYWr5+y0RoICVJx1pssnrSUwiqIr9TUvesjokZ/izZHm8q+0EWACXgrojITzKB7P
         /vjtbuki1i4vLHVcc4bkeDnPOo8w1qMeKgUhyUE+KqZMbUSnSeVkEbNBcjTB4ypXlEq5
         vNeldg4DpxNnvPAUp5UsNllgNqW4y7U/Ovu7AADPP26onY/kF7vKLQEEksGa/Bc0amXc
         CNwP3ejCSnoZlyqsM9QKHle78tqMqyd0i95SJ6o9ejmNgwpHqwcEFS36ZgwS4pVk2dfr
         N3zw==
X-Forwarded-Encrypted: i=1; AJvYcCXQfd+rWbZq7D5qkS9NWGIdlfzbao1T6N4TupiC+D+VwAcLqAOfUHvDs0oUX3J7FsnUmDQ9MgyRkAVmjvZdVdK8hx1TF6SYr7wLt8bBedXPKIy6FAaR
X-Gm-Message-State: AOJu0YxtP06cG3Z2U7O2Xy3fcGYxmvOMNLXEeWbInZQfLoqa5f/l7RQ+
	4QNp8lLdpycgjeQP8HpejMVtrGRuEPybA1qY7lPQCPJVmoMzJyhOUSlPGe8rckn/dsQMsgHh4is
	FLhRfA8KO0pxsOeAyxCstDm/6F+ciY6kHU7mQ
X-Google-Smtp-Source: AGHT+IGAbpbbKqsLUGXh464cytP863iXT7qQnuBJhBT38qhaCF0Grsul4hxlGXsYzxPX+jxvJ5qXz6HHJ6C646I/Z5I=
X-Received: by 2002:a05:6402:4304:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-59ec5417830mr368292a12.2.1721142196804; Tue, 16 Jul 2024
 08:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net> <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org> <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net> <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net> <202407100921.687BE1A6@keescook> <20240711.sequuGhee0th@digikod.net>
In-Reply-To: <20240711.sequuGhee0th@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 16 Jul 2024 08:02:37 -0700
Message-ID: <CALmYWFt7X0v8k1N9=aX6BuT2gCiC9SeWwPEBckvBk8GQtb0rqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Steve Dower <steve.dower@python.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:57=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Wed, Jul 10, 2024 at 09:26:14AM -0700, Kees Cook wrote:
> > On Wed, Jul 10, 2024 at 11:58:25AM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > Here is another proposal:
> > >
> > > We can change a bit the semantic by making it the norm to always chec=
k
> > > file executability with AT_CHECK, and using the securebits to restric=
t
> > > file interpretation and/or command injection (e.g. user supplied shel=
l
> > > commands).  Non-executable checked files can be reported/logged at th=
e
> > > kernel level, with audit, configured by sysadmins.
> > >
> > > New securebits (feel free to propose better names):
> > >
> > > - SECBIT_EXEC_RESTRICT_FILE: requires AT_CHECK to pass.
> >
> > Would you want the enforcement of this bit done by userspace or the
> > kernel?
> >
> > IIUC, userspace would always perform AT_CHECK regardless of
> > SECBIT_EXEC_RESTRICT_FILE, and then which would happen?
> >
> > 1) userspace would ignore errors from AT_CHECK when
> >    SECBIT_EXEC_RESTRICT_FILE is unset
>
> Yes, that's the idea.
>
> >
> > or
> >
> > 2) kernel would allow all AT_CHECK when SECBIT_EXEC_RESTRICT_FILE is
> >    unset
> >
> > I suspect 1 is best and what you intend, given that
> > SECBIT_EXEC_DENY_INTERACTIVE can only be enforced by userspace.
>
> Indeed. We don't want AT_CHECK's behavior to change according to
> securebits.
>
One bit is good.

> >
> > > - SECBIT_EXEC_DENY_INTERACTIVE: deny any command injection via
> > >   command line arguments, environment variables, or configuration fil=
es.
> > >   This should be ignored by dynamic linkers.  We could also have an
> > >   allow-list of shells for which this bit is not set, managed by an
> > >   LSM's policy, if the native securebits scoping approach is not enou=
gh.
> > >
> > > Different modes for script interpreters:
> > >
> > > 1. RESTRICT_FILE=3D0 DENY_INTERACTIVE=3D0 (default)
> > >    Always interpret scripts, and allow arbitrary user commands.
> > >    =3D> No threat, everyone and everything is trusted, but we can get
> > >    ahead of potential issues with logs to prepare for a migration to =
a
> > >    restrictive mode.
> > >
> > > 2. RESTRICT_FILE=3D1 DENY_INTERACTIVE=3D0
> > >    Deny script interpretation if they are not executable, and allow
> > >    arbitrary user commands.
> > >    =3D> Threat: (potential) malicious scripts run by trusted (and not
> > >       fooled) users.  That could protect against unintended script
> > >       executions (e.g. sh /tmp/*.sh).
> > >    =3D=3D> Makes sense for (semi-restricted) user sessions.
> > >
> > > 3. RESTRICT_FILE=3D1 DENY_INTERACTIVE=3D1
> > >    Deny script interpretation if they are not executable, and also de=
ny
> > >    any arbitrary user commands.
> > >    =3D> Threat: malicious scripts run by untrusted users.
> > >    =3D=3D> Makes sense for system services executing scripts.
> > >
> > > 4. RESTRICT_FILE=3D0 DENY_INTERACTIVE=3D1
> > >    Always interpret scripts, but deny arbitrary user commands.
> > >    =3D> Goal: monitor/measure/assess script content (e.g. with IMA/EV=
M) in
> > >       a system where the access rights are not (yet) ready.  Arbitrar=
y
> > >       user commands would be much more difficult to monitor.
> > >    =3D=3D> First step of restricting system services that should not
> > >        directly pass arbitrary commands to shells.
> >
> > I like these bits!
>
> Good! Jeff, Steve, Florian, Matt, others, what do you think?

For below two cases: will they be restricted by one (or some) mode above ?

1> cat /tmp/a.sh | sh

2> sh -c "$(cat /tmp/a.sh)"
