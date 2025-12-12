Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3E2517AC
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560144; cv=none; b=dJib3lQ5mIf3M31TZ/vPMCvR9bhm1HMWIrjG9HuBHSqIQ0ImDoK9fGf6dMpLjdDZfX+qsauISiKRAJCoX5HxMjYy7qzpjo/r4QpP8BotVN9REPsYlsuzRt47jRsXhYxKfB+cTnYZ747QpcvnRBHioxAu0xhwhPvH3zO+bBgT274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560144; c=relaxed/simple;
	bh=cYXCBkVhR4cFtph+dzJpvcD8UbpxST/F4BrRnNYw6Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKhnaubdtUsf/woqCtvwVV6sRYTXtKWsx/c5dAxnaqxZM8bzB/rOSPFij2pOC6vBd5siNG4PTLIZcI5pOjW4JhxF18+R3e9WTIph/rLKkdrm8nE/QYiLYpkuybOIJjyrtJs42wGjoAm3wqnCJ8yyZbCSQQchKn6OV/7UIqgsnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GujAPpYB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GujAPpYB"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78ab039ddb4so15144157b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 09:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765560142; x=1766164942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DNx7q1nprKHOMuwXJlt5aI5U179i0Za6lBgFGOGvN0=;
        b=GujAPpYB8kmN0yyz8Nb8K6SoIylnq6x34IUdPRtDDjk5l/oS6Ph8jbsMXyyyg/zGeu
         7gej+zdl5U+vbtOmWd0bL5i/Eal0GlCxkYMTPA6J+8UFPXkZG85FE1k+s7tQp+s/+nEN
         HPI5ngTADBafP4I9yyyveb+FMBQnnDHv4V78xsHPd7PX2/H7ay82JKY8vWYZKrrSeZ1W
         3ZApfXaL2SdP2U8C5zTufxswqWprVYNH9/0kusUJBMrNHCZ+nUyQeH5GSm4SBw+seP8n
         qojQ4kILE24jwfyYP0Hm8gzI/zBeXChCYVmxuPxLI3eUbbCKhbk/wI+XTQFiT8tG9mdl
         xBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765560142; x=1766164942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DNx7q1nprKHOMuwXJlt5aI5U179i0Za6lBgFGOGvN0=;
        b=XM/lrviTsRl7/TDGdQeJ+UJlf6kl8dUMqMxOc0WNUHOzxKdlyyAjY0yVPym53U9D5k
         XfBueH2E4Hp61T9TF1X9nM/y6ZZomLFS2HCotTc63k6T/AvulbKmwTZ6jJa4O4HFuWxh
         GVxet3fl85s9FjpAu7ndBRqy3nndMtAtmQLEe9cWkoSlGXZjCM+BYq7agq9oI048kGun
         YecWZHdGSyrxiXdfgSG8Q+ojS9LD3vX80os9lcAoQGZCGU0Ql4ggS4CugEqKWqSVkxrM
         kr2XCE95xb3ss1xe3lXqv8LPXeaYX/jjVCDnJwE510wxea/uTjNC8RclUL//loUhn/sN
         Zueg==
X-Forwarded-Encrypted: i=1; AJvYcCUG+JNRSIF3l5I3LygiCGtAwk2yB9UTQsaRmMpsH70OeiZMMXsghIXHf8/QGDleS1kM3e4/FYdtmiO+y11b2JRs+UZzdk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2t5mbZ5w5oC7zQP+RI/HCxQRdH1nCSUHlnaLk3vWz4GqXR4w
	azT6UV+ukFpzrt4IgNQgrlv1sAfkLvzl277niocco1eLuYyhTwoc8vFrPsXX8mW10smujBILrIy
	48YNyBVkCpxinb1ihSnOYE/1FKWM6uBQ=
X-Gm-Gg: AY/fxX50AL4uvLLELuvDTNsqf7zxLlPwYz9b2FI67JxpL9O1GBLo38CaI6s/x8xNPwi
	bbo2vTedfN5CyvnQnyjy6km8bVwr44XKsMMTsEBTOGrG6yIbnijM13ScGfWcqfApUsLJD1Altfy
	tB8gjy925So/OUpKWp/2eFPL8mZ+XTDUr0PGCcSUx7txzAj3xEsI0VNDmV4ZHOUDr2ntecWzbs3
	isQ8FYD2BRpZWre0VoYru15fggQP+wWTwkzaodksk5+8/IxMdtbOxmbdcXezmRy0tGpClE=
X-Google-Smtp-Source: AGHT+IEae2gVBe9S5f4vqW6Tgq02M0ullvp+1i/bz9AIHqnotjXgV7fv0dkOXIGM6zFhOjEHLFQ/cYWsUj2vuSbwIBg=
X-Received: by 2002:a05:690e:1388:b0:63e:b41:cebc with SMTP id
 956f58d0204a3-645555bd57cmr1965388d50.17.1765560142308; Fri, 12 Dec 2025
 09:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com> <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
 <CAEjxPJ6CbZC-=onSGgELygnt_hsqaN0JS_jJFxWn+hYt90s2Ng@mail.gmail.com> <CAHC9VhSU5yLQkCchCMUx+OLk+_2YY=1fjzth4s+_ELwgXg5t-A@mail.gmail.com>
In-Reply-To: <CAHC9VhSU5yLQkCchCMUx+OLk+_2YY=1fjzth4s+_ELwgXg5t-A@mail.gmail.com>
From: Timur Chernykh <tim.cherry.co@gmail.com>
Date: Fri, 12 Dec 2025 20:22:11 +0300
X-Gm-Features: AQt7F2odho1B2yFZsRPzXFlRstFa012hoDsKdRUxP66oT_AdCWZBKLufUkWgat0
Message-ID: <CABZOZnRgYd687neqk5e8vQu5y7cwPwbht2SHS-4=q0y3MWU=mg@mail.gmail.com>
Subject: Re: An opinion about Linux security
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, torvalds@linux-foundation.org, 
	linux-security-module@vger.kernel.org, greg@enjellic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> While Timur was
> added to the conversation by someone, I don't see any mail from him in
> that thread.

I probably missed this thread.

> Beyond that, I'm a bit lost.  As far as I can remember, and both lore
> and my own sent mail folder appear to support this, I've never
> commented on ESF.  At this point I think Timur may be mistaken
> regarding my commenting on ESF, but if I am wrong please provide a
> lore link so I can refresh my memory.

Sorry for misleading you. My mistake, I should have checked the thread
first instead of relying on my memory.

> In this post Timur provides links to his ESF project on GitHub, but no
> patches.

Am I correct in understanding that any proposals and questions I'd
like to discuss with the maintainers and the community should start
with patches? Even if the goal isn't to implement a change right away,
but merely to evaluate the idea.

When I proposed the prototype, it seemed excessive to me to prepare
patches for something that could be "finished" at the idea stage.

On Fri, Dec 12, 2025 at 8:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Dec 12, 2025 at 11:12=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Dec 12, 2025 at 9:47=E2=80=AFAM Timur Chernykh <tim.cherry.co@g=
mail.com> wrote:
> > >
> > > I=E2=80=99m lucky enough to have already built a working prototype, w=
hich I
> > > once offered for review:
> > >
> > > https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/m=
ain/security/esf
> > > https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/m=
ain/include/uapi/linux/esf
> > >
> > > Less lucky was the reaction I received. Paul Moore was strongly
> > > opposed, as far as I remember. Dr. Greg once said that heat death of
> > > the universe is more likely than this approach being accepted into th=
e
> > > kernel.
> >
> > Not seeing an actual response from Paul in the archives, but did you
> > ever actually post patches to the list?
>
> I was wondering about this too.  I searched through my sent mail and
> while it's possible I'm missing some mail, the only conversation I see
> with Timur is an off-list discussion from 2024 regarding changes in
> the upstream kernel to support out-of-tree LSMs.  While Timur was
> added to the conversation by someone, I don't see any mail from him in
> that thread.  My comments in that thread are consistent with my
> comments in on-list threads from around that same time when
> out-of-tree code was discussed.  Here is a snippet from one of my
> responses, which still holds true as far as I'm concerned:
>
>  "As stated many times in the past, the LSM framework as
>   well as the Linux kernel in general, does not provide the
>   same level of consideration to out-of-tree code that it does
>   to upstream, mainline code.  My policy on this remains the
>   same as last time we talked: while I have no goal to make
>   things difficult for out-of-tree code, I will not sacrifice
>   the continued development and maintenance of existing
>   upstream code in favor of out-of-tree code."
>
> Searching for "Timur Chernykh" in all of the lore archives shows some
> BPF related threads and the following LSM thread from June 2024:
>
> https://lore.kernel.org/all/CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=3DkzCL8zc=
9jHxAC=3DA@mail.gmail.com
>
> In this post Timur provides links to his ESF project on GitHub, but no
> patches.  I see comments from Stephen, Tetsuo, Casey, and Dr. Greg; I
> did not comment on that thread.
>
> Beyond that, I'm a bit lost.  As far as I can remember, and both lore
> and my own sent mail folder appear to support this, I've never
> commented on ESF.  At this point I think Timur may be mistaken
> regarding my commenting on ESF, but if I am wrong please provide a
> lore link so I can refresh my memory.
>
> --
> paul-moore.com
