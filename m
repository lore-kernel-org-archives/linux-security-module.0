Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE13BC34
	for <linux-security-module@vger.kernel.org>; Fri, 12 Apr 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936300; cv=none; b=Nuu2Yj7h204VGn4zIHLnxkwKyMNNIiQCjfVsgy7P4Rth1bvQMp2OSbO7CJOvGcgI3z74d9FjV3td6aM0fxiTwMUQqKvAF17WlbJBq4458saK3yE6USoRMmyBBhFdp2q6Sgq9m6lAg6Yo2CZTW7LunsICMLHc605Lz09bxTgNoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936300; c=relaxed/simple;
	bh=feaXepO6mCcRDgHe5YC62zkfeh1WyMJRpN3oTbKTR1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpG6KpvQm66aZ8WmXSpLopMDs/8mokJ9EHIxWKoiKGP6nYcX/a3L9hEIVMSVsyDZqG9eQoppAwxsGMFuKG5lZlQXLj6RnB4JIjoBiyZhLjPf4kbpb6aMnfoWjpTK+wFsKuXHFFXQykb0/rLkBg11s4sqxai068rLlKTRnO1GFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DOQiydPs; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DOQiydPs"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61587aa956eso9831717b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Apr 2024 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712936296; x=1713541096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRsLhmspJrGAlI8VzBOaMngZDHCKYEewxjKZbuVmGJo=;
        b=DOQiydPs5heo40A6ZpiHcdhwTS2mfVMwVFTusHpDOVfUJlNTlV/O4PgS7NDNiPY2Te
         /v1II6WyRg/jGTbgXpKkEW/QEcnMMekUkhrGMMCT8pggwC4RxuE16t6oZEGQxX951wk0
         O7cyBFvwlQHR//l7ajRA4hi6pLARioULhEN663Bm5g1T3FsEOPuKGRl9f5Lk1utUuGPD
         k5x883XPAUF/9h22YnxZmea/FlNoOCqwY3MFNOhDEcOBdB8L5pZyN8epT4MVkfiRUQoe
         2JPPdQ15eubsW4hrHrPSEiN0w3HLtTQq3Q/H0REpgIivj0P/HNIfVzzvqMb/NpiELeIF
         cR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936296; x=1713541096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRsLhmspJrGAlI8VzBOaMngZDHCKYEewxjKZbuVmGJo=;
        b=LoU/RTRPL26O1SdRbqMnfwsQRbA90s1F9l7MHjl//S+FQDPffALcstdGNFf9VaZqGl
         v4nvC2+BuJeMrVzTIxnq9uzCZ+/Yz9kGbO55GgJ1UAYVcWOUlf+QALkW7TXAKljyHRPJ
         qGagaSGnEXSS5wc1ZVN0fXm3w9YPXy3IKwq1cVJU/pA7SY+iGCZAEKe9Bhq0Mq+2Kwp+
         MDvlt9ihCstG+E9jH9nSYK7oH/lnqWQmfG0j4IFT7Ne136YY/V3UoHXWW8Fv6kNh57//
         SLQdidPvbGgSawyv/MwVDd3pOVGfnfAERomvX2gEp5Awy722m1F8dxHxa2Ry1Aax0pzb
         62Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU++tsWa1XehbnxNDZ2CNcEYJ+lqYHGBZqxh/TIKyLknAEI9BabOJse+ciIgqUKokn8LRh3SsEf6GfdUSpQWvWy4GwQ1YB/SkCfSFGU3LQDYJRXa92f
X-Gm-Message-State: AOJu0Yxx83MVbGCaMxJIK4iZSGjpH6mkNewGv1N456bT8/cLGEMFtvY0
	74rfrg/7fREED/NQU0YI1Eggb9wScdpVwBvV1rTOhbECoZDDmigmbhISF+mQFkiX+4oFCOCof8w
	5FbaJvzBc3OkNZ4xLhmI752lDpM7uGutDeEVU
X-Google-Smtp-Source: AGHT+IHGk9GUlGOTcnEZDYfJjj7QEfDwKDa2s/bpxEAk9fg7DLcA+nzBug9hzKR0y9xbh9qoLjYXcchA/vnqHeA8iEg=
X-Received: by 2002:a0d:d4ca:0:b0:615:f53:64de with SMTP id
 w193-20020a0dd4ca000000b006150f5364demr2773367ywd.29.1712936295896; Fri, 12
 Apr 2024 08:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207124918.3498756-4-kpsingh@kernel.org> <a6689b0b5564461b829a18379eb3e83f@paul-moore.com>
 <492036A7-4944-4225-B045-3C2F79DBEA31@kernel.org>
In-Reply-To: <492036A7-4944-4225-B045-3C2F79DBEA31@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Apr 2024 11:39:02 -0400
Message-ID: <CAHC9VhTN-H1m01BZ2Z_W_roTEeUGf-k=_YmOb-12ZNJ_996foA@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:12=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
> > On 11 Apr 2024, at 02:38, Paul Moore <paul@paul-moore.com> wrote:
> > On Feb  7, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >>
> >> LSM hooks are currently invoked from a linked list as indirect calls
> >> which are invoked using retpolines as a mitigation for speculative
> >> attacks (Branch History / Target injection) and add extra overhead whi=
ch
> >> is especially bad in kernel hot paths:

...

> > Beyond that, let's find a way to use static calls in the LSM hooks
> > which don't use the call_{int,void}_hook() macros.  If we're going to d=
o
> > this to help close some attack vectors, let's make sure we do the
> > conversion everywhere.
>
> This is surely doable, We can unroll the loop individually in these separ=
ate hooks. It would need separate
>
> LSM_LOOP_UNROLL(__CALL_STATIC_xfrm_state_pol_flow_match, x, xp file)
>
> Would you be okay if we do it in a follow up series? These are special ho=
oks and I don't want to introduce any subtle logical bugs when fixing poten=
tial speculative side channels (Which could be fixed with retpolines, prope=
r flushing at privilege changes etc).

I'm okay if you want to do it in a separate patch, but I would like to
see it included in the same patchset.  The good news is that recent
commits have significantly reduced the number of cases where we aren't
using the macros.

> >> @@ -846,29 +906,41 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uct=
x, size_t *uctx_len,
> >>  * call_int_hook:
> >>  * This is a hook that returns a value.
> >>  */
> >> +#define __CALL_STATIC_VOID(NUM, HOOK, ...)      \
> >> +do {      \
> >> + if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) { =
   \
> >
> > I'm not a fan of the likely()/unlikely() style markings/macros in cases
> > like this as it can vary tremendously.  Drop the likely()/unlikely()
> > checks and just do a static_call().
> >
>
> These are actually not the the classical likely, unlikely macros which ar=
e just hints to the compiler:
>
> #define likely(x) __builtin_expect(!!(x), 1)
> #define unlikely(x) __builtin_expect(!!(x), 0
>
>
> but a part of the static keys API which generates jump tables and the cod=
e generated depends on the (default state, likelyhood). It could have been =
named better, all we need is to have a jump table so that we can optimize t=
his extra branch in hotpaths, in one direction.
>
>    https://www.kernel.org/doc/Documentation/static-keys.txt
>
>
> If you want I can put this behind a macro:
>
>
> #define LSM_HOOK_ACTIVE(HOOK, NUM) static_branch_unlikely(&SECURITY_HOOK_=
ACTIVE_KEY(HOOK, NUM)
>
> the static_branch_likely / static_branch_unlikey actually does not matter=
 much here, because without this we have a conditional branch and an extra =
load.

Fair enough, leave it as-is.  Thanks for the explanation.

--=20
paul-moore.com
