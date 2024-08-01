Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38414F9D5
	for <linux-security-module@vger.kernel.org>; Thu,  1 Aug 2024 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474804; cv=none; b=JvQ1Hxb2UFUEgmzqGWghUz/ZO7o36QwYs2ZYiWZQzCQXMytZReZfp1W+3qX/rzbrsKobcUjY9oRdzxvcrXvxzHxThUDdSMEglNzFpTDaczqONfyi5d6gQuCikZgP2NmNKAEBvrmaDipjz16OM7UtxLD8S4I3V9l7xFdk6kUTwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474804; c=relaxed/simple;
	bh=OnSsYvdBqSCc4TBDdCpfp4I+U0UhTeDr0zgNlOvyOSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZKz9YtNJUS5g68e4unLel9lhyNm+C1ONpC/1qmh0yNF9I2LnIURHcCB2Scd5t1mCmDheQNRyHFWiE0OHiu4K0VlIRdHnm/rmXD3TeEHQ+lEHmmtSYzLrlY+EkpyWGoWqKGHVHOP3c0/5LJQ2lfVFkmywnUXvMEHiOretnQUKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BBo3Cpq0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BBo3Cpq0"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0b167da277so4676231276.3
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2024 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722474801; x=1723079601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0BQ8Evsp2ujGcmQXgR29t+nVAHCPZluf+918tPs5HU=;
        b=BBo3Cpq0xhHPc4ON5tl3m79cOXHRrcI4u/gDX80+CIUhfdQOxNmZRthVhZssfYxhw8
         NiCM5JPgJBD2ehfmgQsCdK6GDOPwHDZ378n9PeuuliEJZY1DRbQUYBXDA+HmYnihBT4d
         5La4xrbMVIPtBsf6xmF8ux5cydiMFKmCK/aI8YUa2PaIZDF0YvzwHD/a514uthsrTXro
         k7HbVZXav1QKMibDu2dnXoNkimp5OOzpzorX8UsMoNqMKdsFBUTV4ve+rDvZ9UBOzS8r
         YEfongvRQ+HGQXs46ddSeVX6mVeL7Vms31stzmRpsejyJpYw6UctHcHtZSmlUd6kRJBM
         e6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722474801; x=1723079601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0BQ8Evsp2ujGcmQXgR29t+nVAHCPZluf+918tPs5HU=;
        b=Ni5jHSjcO3fCqqz46K4pCKV1J6KXVO9QTdYzSvB9e2sp6ac+sjcxHvnQwoDWtqLKUg
         utMC4yn0WwzWuAX27hc4eS9wdAKGrJAFKUxUrV34Ufp5g5PRTf9ZXBa3G8JqSgJjjuEy
         /qIAwAj9YxZI0g2olOclgaKzB8X0wZ/FOtWMBIgh5rj7kKukK0jj+x+PTvehUOi8gQ0G
         ab7uDPpWOCPDE3ZquJqdJ4ixnLxi6Iz2lU1vxwPlI2NhGsU7wSOGlx/li5AKNlYiHFPj
         6G8lMpRmdv2/iMhk49ZFHuMByWTOZ9mAVUexuuMYqq34IuB/qxAu3AhyP1j69YA+DeeN
         fdFQ==
X-Gm-Message-State: AOJu0YyYZIegzRgV4wXleDPkIgwC6sPZeszoP1TXGn2FY1JPnrdsqplz
	OxY3EwtJq1asHe4XABoqiRgmRy7zUyRNJoOxk9HNHzMYzRC2DPAIEarOnpcEmdxEBpZZXxAhBwi
	fhsq2A9uNBJj0cpG17XMoJAWeJ8/ttvKWzTAl
X-Google-Smtp-Source: AGHT+IEVcS5Y1pQQ44fxDfqsv9wajVZz4s+9pi10Od+67a9dM1+LMq3MC4sbAmucR+3c2YU00r/3n34EJzp3v4TvEN8=
X-Received: by 2002:a0d:c802:0:b0:64a:3e36:7fd1 with SMTP id
 00721157ae682-6874c15ea29mr10497307b3.10.1722474801266; Wed, 31 Jul 2024
 18:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
 <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com>
 <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com>
 <CAHC9VhSx96-KL-8u5FCa1Bb1H5J6bn89Zv1gfPL9Hxo0kZOKLQ@mail.gmail.com>
 <CAHC9VhSVTkxC9GfYkMm5LRx6MzeD-Lk=ffTnJAvg-=XdiZB=fQ@mail.gmail.com> <CACYkzJ7Yi4qJYf-b5N=Jq9WRX3edAeymE8=fU3pwwxhSVYZgTg@mail.gmail.com>
In-Reply-To: <CACYkzJ7Yi4qJYf-b5N=Jq9WRX3edAeymE8=fU3pwwxhSVYZgTg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 21:13:10 -0400
Message-ID: <CAHC9VhTZqccBF0TbvuDT1OyO4gPbx7D3C966ppXD_fLeeWoMYQ@mail.gmail.com>
Subject: Re: static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10'
 used before call to jump_label_init()
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:33=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Wed, Jul 31, 2024 at 11:33=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Tue, Jul 30, 2024 at 4:36=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Jul 30, 2024 at 1:40=E2=80=AFPM KP Singh <kpsingh@kernel.org>=
 wrote:
> > > > On Tue, Jul 30, 2024 at 5:03=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Tue, Jul 30, 2024 at 7:34=E2=80=AFAM Borislav Petkov <bp@alien=
8.de> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > this is with today's linux-next:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > 09:44:13  [console-expect]#kexec -e
> > > > > > 09:44:13  kexec -e
> > > > > > 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-ne=
xt-20240730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU l=
d (GNU Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:5=
5 UTC 2024
> > > > > > 09:44:16  [    0.000000] ------------[ cut here ]------------
> > > > > > 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/stati=
c_call_inline.c:153 __static_call_update+0x1c6/0x220
> > >
> > > ...
> > >
> > > > > KP, please take a look at this as soon as you can (lore link belo=
w for
> > > > > those who aren't on the list).  One obvious first thing to look a=
t is
> > > > > simply moving the call to early_security_init(), but that require=
s
> > > > > some code audit to make sure it is safe and doesn't break somethi=
ng
> > > > > else.  Of course, if we can do something with how we setup/use st=
atic
> > > > > calls that is even better.  I'll take a look at it myself later t=
oday,
> > > > > but I'm busy with meetings for the next several hours.
> > > > >
> > > > > If we can't resolve this in the next day or two I'm going to
> > > >
> > > > Thanks for the ping.
> > > >
> > > > Taking a look, yeah it's possible that we need to move jump_label_i=
nit
> > > > before early_security_init / inside it.
> > > >
> > > > I will do a repro and test my change and reply back.
> > >
> > > I'm pretty sure we don't want to move jump_label_init() inside
> > > early_security_init(), we likely want to keep those as distinct calls
> > > in start_kernel().  Shuffling the ordering around seems like a better
> > > solution if we can't solve this some other way.
> > >
> > > Regardless, thanks for looking into this, I'll hold off on digging
> > > into this and wait for your patch.
> >
> > Since I don't want to leave linux-next broken any longer, I'm going to
> > yank the static-call patches from the lsm/next branch but I'll leave
> > them in lsm/dev so you can continue to use that as a basis for your
> > fix.  If we don't have a fix in hand by the first half of next week,
> > I'll drop the patches from lsm/dev too and we can revisit the patchset
> > when you have a fix ready.
> >
> > For casual observers, the lsm/next is normally an automatically
> > composed branch made up of the latest lsm/stable-X.Y and lsm/dev
> > branches however in this particular case I'm going to manually update
> > the lsm/next branch.  The normal process is described here:
> >
> > * https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
>
> I sent this a couple of minutes after you sent the email. I was trying
> to reproduce / confirm the original issue before posting the patch.

Yes, I think our emails must have crossed paths.  Regardless, let's
see if we can get some ACKs/Reviews from the static call folks just to
make sure we are doing something silly by moving the init point.

--=20
paul-moore.com
