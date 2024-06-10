Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB88210E7
	for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052285; cv=none; b=Fo6C2NZwsmyjW4V1W43sitVr2GDSQz2UwPxx7HOGf+LtrABkHpFuRD45v8HOSZWGhxIXeqtNliEWuPsUJBTwMoiEajrGxyeusSMFlTarSmfUEQ8uc3l0340kN/3iYb9+NqmkC1L5TSg2wstIiMsbWHj3fqCwSzxf4WhErYTYcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052285; c=relaxed/simple;
	bh=2AMpvZTyySR52Q575EvvbyYkR5oPISP1+4gct2WOnNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlxBOMSSj/Jali4aqx2tlHsI5hnWvbGWOOK4WKNGd21Xuqe4kGmwuQM6/N1RCqIkNQMT9DChoxuudR6Y/WWo3jCpVGgXUtKNI+3/ZrevI6wgJFzPxW9InHZwr2cgq0heG8FNokscGqFKes/qermLluh9XyGtkElYcvvPC8rp6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QP0ZVlXn; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QP0ZVlXn"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfa584ea2ffso3890877276.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718052282; x=1718657082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcoA750Bj+ZN7bjH86sGDKqLI2brF1ReIBjp5AaBwhc=;
        b=QP0ZVlXnPzi9JHSb9MI9yByHECUpe4ZIOkg61l1ioIz6jTHJyBd37Q4pAlyRAPgt6l
         8xBkGM9N3hGvqj9btiOzmw15M2HlRmJepSNRYlltUuhGxA06IujUR6b9v/c18HlMAcwW
         HFy2SpzSUz6k/LX3LWIay8nUXv5OO70g85CJTwA1oftokNjYyTaOA0t9IZnY34QKZos+
         4NJWoAOBgseg5HOG0euABPH732rkWSmydSiduFVHKZlYxBV4a7zA+v9FZQhTgMw8ofXO
         4+KKoEXDEIFUpxXB9nncLl+JqfLtevtlRePW3g+p00iveGKE4aD2l3JKrNsZZjmxygie
         VKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718052282; x=1718657082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcoA750Bj+ZN7bjH86sGDKqLI2brF1ReIBjp5AaBwhc=;
        b=RzLwa580e1xNbBrqQGZvUDRmKw7KqcfGdi29JNhwzyVVC4yLRKxUTl1hfQOOlDJt4m
         J5oSIKCTsKkxD+t3xBkG9WIID1aNB6vu0kGe6fI2zzUIKns6mgt2OBr3a7ANS1DJQqxX
         4zbnJQsi9SAOx0IztVl1f+u0igXmina90j7New0x/SkWTQ9KpYQM2uPpqgUumTBqeKjm
         yyRCtPBnJHq1CbzSAXTxLHRLD985DsmI5/VFFWIwBzzVonlsTQqJVL1o2Sh/DYZQPMem
         jtIBpuyh24USQ5cvlS+8zncvZVPQaVQ6R3Dan56r2NJYJAipJWMiRFfzgMhotytQEzD8
         d6uA==
X-Forwarded-Encrypted: i=1; AJvYcCXKMc26PfcHsi1Un2pT/jwGT/vnd2FlnFDX6QTMYNOL1P0K9qFiAswSHPYUL5P+r7zFuonghNxligHb6DRh74IveEo5A2FuskOkNeayOL++J5ROmM4D
X-Gm-Message-State: AOJu0YzdOsbB6oueBCD0szW6ejPKH57YkC5DLck8Qus+yj2phu4E5aux
	8JW/taJioCqH8YQQA3GZVu/yOFwwuIphbe6qiD71B65CAFKxfYZYdoHPt2vwGGSbasFrLE5pzlT
	9yGxhRQRI7iGylSOuEjuzfFsz6pJtlUvdtM8i
X-Google-Smtp-Source: AGHT+IG3SmWEZjN2PWG+EsAgWFrCFp7Ijii/YP3+foCW4tNLPIKtnByY5hj7IEgbBVJSG4st69P97jNgbcAYtpOSl/w=
X-Received: by 2002:a25:5f44:0:b0:df7:c087:57a1 with SMTP id
 3f1490d57ef6-dfaf66d1ddamr8231100276.51.1718052282366; Mon, 10 Jun 2024
 13:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook> <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
 <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp> <202405011257.E590171@keescook>
In-Reply-To: <202405011257.E590171@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Jun 2024 16:44:31 -0400
Message-ID: <CAHC9VhTucjgxe8rc1j3r3krGPzLFYmPeToCreaqc3HSUkg6dZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Eric Biederman <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:04=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Thu, Feb 15, 2024 at 11:33:32PM +0900, Tetsuo Handa wrote:
> > On 2024/02/15 6:46, Paul Moore wrote:
> > >> To quickly summarize, there are two paths forward that I believe are
> > >> acceptable from a LSM perspective, pick either one and send me an
> > >> updated patchset.
> > >>
> > >> 1. Rename the hook to security_bprm_free() and update the LSM hook
> > >> description as I mentioned earlier in this thread.
> > >>
> > >> 2. Rename the hook to security_execve_revert(), move it into the
> > >> execve related functions, and update the LSM hook description to
> > >> reflect that this hook is for reverting execve related changes to th=
e
> > >> current task's internal LSM state beyond what is possible via the
> > >> credential hooks.
> > >
> > > Hi Tetsuo, I just wanted to check on this and see if you've been able
> > > to make any progress?
> > >
> >
> > I'm fine with either approach. Just worrying that someone doesn't like
> > overhead of unconditionally calling security_bprm_free() hook.
>
> With the coming static calls series, this concern will delightfully go
> away. :)
>
> > If everyone is fine with below one, I'll post v4 patchset.
>
> I'm okay with it being security_bprm_free(). One question I had was how
> Tomoyo deals with it? I was depending on the earlier hook only being
> called in a failure path.
>
> > [...]
> > @@ -1530,6 +1530,7 @@ static void free_bprm(struct linux_binprm *bprm)
> >               kfree(bprm->interp);
> >       kfree(bprm->fdpath);
> >       kfree(bprm);
> > +     security_bprm_free();
> >  }
>
> I'm fine with security_bprm_free(), but this needs to be moved to the
> start of free_bprm(), and to pass the bprm itself. This is the pattern we
> use for all the other "free" hooks. (Though in this case we don't attach
> any security context to the brpm, but there may be state of interest in
> it.) i.e.:
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 40073142288f..7ec13b104960 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1532,6 +1532,7 @@ static void do_close_execat(struct file *file)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> +       security_bprm_free(bprm);
>         if (bprm->mm) {
>                 acct_arg_size(bprm, 0);
>                 mmput(bprm->mm);
>

Tetsuo, it's been a while since we've heard from you in this thread -
are you still planning to work on this?  If not, would you object if
someone else took over this patchset?

--=20
paul-moore.com
