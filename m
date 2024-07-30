Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220EB18DF99
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371795; cv=none; b=bnC6QCFhDAbv6uKwF1QLQ7CNofqZECo+DBb+dBz8NSi12OasF3mPgCZeQivqFnLsKcA8QRH+BBrM/KfyXul8wr1CTkGkIsQBZ17JNbJrABS/Ii0qRZLUMH/yZpY1ct7c+qhwx4yh87aqv+vGUqBWiV/b64eu4/xFIqLiy3xZULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371795; c=relaxed/simple;
	bh=GWv+ZFGY198S4GMsg1i1vpuKEpJESv8rIQXb72hP/CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhCxyn50WnNPqYWMbQsyQVXycq2gGiyncU9XYV8lWxsiSRmQi+Gr10byCwbSIRho8vahM76DDPyr022wvIhzei62+v0uo0FOTjOVuCKPkk5pKUYbuy/vHb+39IXr90qI+FSbcQEvf1VUWkHvkpnH7mVivJhXdR0JfMxsWfHgzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BFT9sRVz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BFT9sRVz"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e026a2238d8so812537276.0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722371793; x=1722976593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CJpG48DfBkv73wDhS0TNI89h1uSGTQ6XB17w4gXvgA=;
        b=BFT9sRVzS+M3hRAUVZde9e+57P4sZYZDCgnbJuAxpbwkHO8ZoUheOVqDF8JI9v8kpN
         69ENBKiKb3vr5nLieR3nQd1pLT6zxaR/JNFPkdiEdchVUqP6mEZ4j6oPkW6MsOA1CADe
         U8vri0rAg+yJuiGm9tLirEOUVVkwo/QxRadfGst2AEH1wJqKvZ7xoplYbn5iXFyD2jio
         eieVaf23fXVfxty1baT172A4vIeX+NJfGmQcm/0ZUaWFEPKAPZqCp75S3zoqWJQz2kOY
         TmR1722a9HIsXfLe11wKWaxtYy/AINwewuRi4bcgjXqgcSbTx5AwE84ewQxlIEiXPqHr
         NJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722371793; x=1722976593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CJpG48DfBkv73wDhS0TNI89h1uSGTQ6XB17w4gXvgA=;
        b=Rr/zgvkUJYviBN1VFzVkMF2WRlm17YziCfZ5nygD6hiRfV9qtFdjnQGEHEWJ/zkH2N
         h41SfMPBPImhwmWpSBXApaqXsSRfrXGcoHg8W7KvIuYhB9mqFl+qUqIBy6nloPTLuBmF
         ZYpW4wpcEXB2Pawg+hhI9pja07hDE8WPkrRXcrtqD4grqxGNUJ5eoX7iPDEZtijL4+xT
         KdwnAQOP4prBGQlUUJAJDrJLA8/fa2IhNUoq5Nkc0/XVk4mnvrOply6facpGYSYRsv8I
         FaBNZm8OyZRXziH7l2QkJ5dUdZGvYNgSObfRIlVQMwIx+ArxaGgSQ9tNdz+3qnFtyaLG
         +s5g==
X-Gm-Message-State: AOJu0YzNNVg29s0w92GrQlYf6BwU9zq17PVceYT6GFviHV9pPGoLV5zV
	9rEaF50/7UQPRZKpCRIh3qVu9c65SUclK0qTGBJbvaAXJ3DWfHLdORURUkI0C4KnGgSIqHjxIWP
	nYVEN+ARWFa2wH2xQK06OgDJrL8VdwqlS+jja
X-Google-Smtp-Source: AGHT+IEZQw6rzIgi+g19tIdh7VmQzLO5da5JOokpAgfKAaG3jm3UEKihnEc/Is5zaLUy6SBuyPeJgwr2yEGK9pRCmx0=
X-Received: by 2002:a05:6902:a83:b0:e08:8ecf:f563 with SMTP id
 3f1490d57ef6-e0b544f1df1mr15138320276.16.1722371793005; Tue, 30 Jul 2024
 13:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
 <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com> <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com>
In-Reply-To: <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jul 2024 16:36:22 -0400
Message-ID: <CAHC9VhSx96-KL-8u5FCa1Bb1H5J6bn89Zv1gfPL9Hxo0kZOKLQ@mail.gmail.com>
Subject: Re: static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10'
 used before call to jump_label_init()
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:40=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Tue, Jul 30, 2024 at 5:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Jul 30, 2024 at 7:34=E2=80=AFAM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > Hi,
> > >
> > > this is with today's linux-next:
> > >
> > > ...
> > >
> > > 09:44:13  [console-expect]#kexec -e
> > > 09:44:13  kexec -e
> > > 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next-202=
40730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU=
 Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 UTC =
2024
> > > 09:44:16  [    0.000000] ------------[ cut here ]------------
> > > 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call=
_inline.c:153 __static_call_update+0x1c6/0x220

...

> > KP, please take a look at this as soon as you can (lore link below for
> > those who aren't on the list).  One obvious first thing to look at is
> > simply moving the call to early_security_init(), but that requires
> > some code audit to make sure it is safe and doesn't break something
> > else.  Of course, if we can do something with how we setup/use static
> > calls that is even better.  I'll take a look at it myself later today,
> > but I'm busy with meetings for the next several hours.
> >
> > If we can't resolve this in the next day or two I'm going to
>
> Thanks for the ping.
>
> Taking a look, yeah it's possible that we need to move jump_label_init
> before early_security_init / inside it.
>
> I will do a repro and test my change and reply back.

I'm pretty sure we don't want to move jump_label_init() inside
early_security_init(), we likely want to keep those as distinct calls
in start_kernel().  Shuffling the ordering around seems like a better
solution if we can't solve this some other way.

Regardless, thanks for looking into this, I'll hold off on digging
into this and wait for your patch.

--
paul-moore.com
