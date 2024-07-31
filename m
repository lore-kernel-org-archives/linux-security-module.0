Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4616C86D
	for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465235; cv=none; b=WRDNXIV1ew0xSDY0WU+YEAqNoTmCPNFfZ4gyVYVs7QoBnwXHgwmw6KYAB/Tnl2kq4wMydJ24Q0Hnq6ZBJfTc+NnmhY73XQo/AzXYkBeszoaOC2kwcc3jLJ31dHCewRl8w6PYeHKWTaEB2f3jkD5IR9SswV+sJbKh/lbTGl1iqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465235; c=relaxed/simple;
	bh=f6tsL8JBQOiIEWm0dBMmAi8XbIcgpoN4n5O0IPGl0Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcWWmWBPr/vnntV+B+p+vevEoFleuM4mk4zAMFkGYGtOr1eT9I/XMYcGq6QaLXkxPIchXB2XcMuBsp5bH6eYoXYBPX3J31fWSG/7L/+zNazx2YN9buhLmcqbT1wvN7Uh5cX6JDclielLORqydgTo7KP4XPVmdTNbPCBGnPeKm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZgOe8YS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZgOe8YS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE87C116B1
	for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2024 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722465234;
	bh=f6tsL8JBQOiIEWm0dBMmAi8XbIcgpoN4n5O0IPGl0Cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sZgOe8YS62+8Nr/lUIzmfvHgVmlFcTaFuJYhhWIQievbS0BuCwLkT2OmeYu6vlPl/
	 NCPd5kCKyAa/OHJLdPK0ltCkjAQldd4pJ6WTnYagl0zk5wJFbtBailnfK2FQahuVdS
	 ihoZDHd059DLfDV6z3ot73/UJkai4LjlYoabYeJtxvhF3/XZgkPL557U3CZx0I9Xex
	 bype4usQpD+5RLCH3CaHMokn+CX98KPI6pJh57tclq3QlLCoxSfK7rRgWU9RMwjoOy
	 2uIQq5FdUN3yp678MKI5t2vOXM6voIg0jOOUnIvcu1CHw5fh+WgYLz5BidFKzo2MXc
	 8wUMcjNsbBzsQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so91740141fa.1
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2024 15:33:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVM0inKdv7W0WeXYVldGmOux5sfnuHwUfgnBCcOFIE//ddnm/O
	sXnC0Hw1QzEf/U/ZCk8Htg0bSfYkaDOuv3z4nIi/IHlFtn/BMd00UX1hGNhJ91jipZEMNUOW0ST
	6bxjMFZ22/fBB5q6wy6158QdRJk9WYHzit9Bt
X-Google-Smtp-Source: AGHT+IEqkDYIUYgA+dpFwMbXnG49w+fYyvopH2UKs/YAoOj74cucLjjYPHzqoCnWIr422QeLxH1hwFJi16y2JHGIaA0=
X-Received: by 2002:a2e:2d02:0:b0:2ef:24f3:fb9c with SMTP id
 38308e7fff4ca-2f153399865mr5764941fa.38.1722465233242; Wed, 31 Jul 2024
 15:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
 <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com>
 <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com>
 <CAHC9VhSx96-KL-8u5FCa1Bb1H5J6bn89Zv1gfPL9Hxo0kZOKLQ@mail.gmail.com> <CAHC9VhSVTkxC9GfYkMm5LRx6MzeD-Lk=ffTnJAvg-=XdiZB=fQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSVTkxC9GfYkMm5LRx6MzeD-Lk=ffTnJAvg-=XdiZB=fQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 1 Aug 2024 00:33:42 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Yi4qJYf-b5N=Jq9WRX3edAeymE8=fU3pwwxhSVYZgTg@mail.gmail.com>
Message-ID: <CACYkzJ7Yi4qJYf-b5N=Jq9WRX3edAeymE8=fU3pwwxhSVYZgTg@mail.gmail.com>
Subject: Re: static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10'
 used before call to jump_label_init()
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Jul 30, 2024 at 4:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Jul 30, 2024 at 1:40=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Tue, Jul 30, 2024 at 5:03=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Tue, Jul 30, 2024 at 7:34=E2=80=AFAM Borislav Petkov <bp@alien8.=
de> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > this is with today's linux-next:
> > > > >
> > > > > ...
> > > > >
> > > > > 09:44:13  [console-expect]#kexec -e
> > > > > 09:44:13  kexec -e
> > > > > 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next=
-20240730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld =
(GNU Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 =
UTC 2024
> > > > > 09:44:16  [    0.000000] ------------[ cut here ]------------
> > > > > 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_=
call_inline.c:153 __static_call_update+0x1c6/0x220
> >
> > ...
> >
> > > > KP, please take a look at this as soon as you can (lore link below =
for
> > > > those who aren't on the list).  One obvious first thing to look at =
is
> > > > simply moving the call to early_security_init(), but that requires
> > > > some code audit to make sure it is safe and doesn't break something
> > > > else.  Of course, if we can do something with how we setup/use stat=
ic
> > > > calls that is even better.  I'll take a look at it myself later tod=
ay,
> > > > but I'm busy with meetings for the next several hours.
> > > >
> > > > If we can't resolve this in the next day or two I'm going to
> > >
> > > Thanks for the ping.
> > >
> > > Taking a look, yeah it's possible that we need to move jump_label_ini=
t
> > > before early_security_init / inside it.
> > >
> > > I will do a repro and test my change and reply back.
> >
> > I'm pretty sure we don't want to move jump_label_init() inside
> > early_security_init(), we likely want to keep those as distinct calls
> > in start_kernel().  Shuffling the ordering around seems like a better
> > solution if we can't solve this some other way.
> >
> > Regardless, thanks for looking into this, I'll hold off on digging
> > into this and wait for your patch.
>
> Since I don't want to leave linux-next broken any longer, I'm going to
> yank the static-call patches from the lsm/next branch but I'll leave
> them in lsm/dev so you can continue to use that as a basis for your
> fix.  If we don't have a fix in hand by the first half of next week,
> I'll drop the patches from lsm/dev too and we can revisit the patchset
> when you have a fix ready.
>
> For casual observers, the lsm/next is normally an automatically
> composed branch made up of the latest lsm/stable-X.Y and lsm/dev
> branches however in this particular case I'm going to manually update
> the lsm/next branch.  The normal process is described here:
>
> * https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>

I sent this a couple of minutes after you sent the email. I was trying
to reproduce / confirm the original issue before posting the patch.

https://lore.kernel.org/linux-security-module/20240731213429.2244234-1-kpsi=
ngh@kernel.org/T/#u

> --
> paul-moore.com
