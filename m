Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E93B813E
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222794; cv=pass; b=KjhwPN/tZ3Q3krxTW3BD8rqoFXH42hs2lyYrrnzDX655Nujpldls0Sn0NMLLrKeQmrNi2AiyS/QP1gyaESGY2ZXbU6VytcgNX533HBtCrCtBZBjZMeuqWmu4IAJo0GRtctcU7v3kL/2m1DSGbjaTQYO8w9tiy6gl9IOh9jV1mS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222794; c=relaxed/simple;
	bh=xDYLrGydvdDUag342oQXfooXnJpQsQ+DkeB1khpduxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXw84idCsSrMNdKSqwsemr0B+rJM0bAlSOFQjQfYCV3s7/3NVaNCcb5VaYIlwquVQNyhcLi1Z5GqGPUOFnSw5LgLKWMIez76pG2LtTaAhJn5/FJfvPAKQ7PhJdTFaioQxixNhJKjSwHyINjAnAg0xmPGrIbeSu9w/5KKyGpr6go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GbCk6K2w; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GbCk6K2w"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80167f56cdso1808893a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 13:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779222793; cv=none;
        d=google.com; s=arc-20240605;
        b=KOcMl47XdUjCR9FUMdjqUWi/yny/iuFeK/bGOPDVTvQ7hfCgteOA1lg4jmFD9jU2dq
         3A5iwtP20bhKCeiqzXoemjWSc2DRdA47XEeg4mUlUYACKryEoU04CFJafwF6JsjVdgq8
         fSQGjUgZptmSxzqn0jv4ehxOHpvnM0hUhFHBFNoTDJfp5HCdbNyxisP50tTO6hBpiJTW
         TJwC7S7pjfnZLSJVS9VW4i48dKzdwTBmaX53TmXXJCEMkRIBQvq0lVVJzzlJDO2gcBFe
         fbyttF4GfZfwkcdb+uDlbT0fpwkamQDAibJyG4ib0qfChhJj6ePI3qmYgiJXjggbTAJ7
         0WFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sYPyOA3Rtu9ZHZqq3A5dveESFOwy6WeEsdfBtKhsDgk=;
        fh=VJGBc+STmesYFOb+PM88iVzQeOjTjWk0eRm+HonTFSw=;
        b=Q12WwOophG3l73V9EmVlp0PHteKDFIfaz+8Yr6sH3ITQAz9tkj4i359VUqaI781qlI
         0CKxnVBig9eT349wahb8WrjEbdKAueR2wGTWvqtx3I3XnCqxde5BdjWWUdzreigh8Z3I
         M0N9ldifpqR1SVux5MSr75T0rAeEm0q79cRzfZeeBdgA0lzHDkTO4A+kZaSeGrkZXHd/
         GBIkEo+uqLTHmflXcIXgs8DEoyxkWZLKaSbA9u5ri0O1BDvakuiRX3mQD69Rp9uJRH7h
         9fhjNfzzUU6L396sYycwKdRmc3h3N9WHYCbZYawQInlmMBhYeGZgwNwpVRNIL8kxoPqy
         wLgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779222793; x=1779827593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYPyOA3Rtu9ZHZqq3A5dveESFOwy6WeEsdfBtKhsDgk=;
        b=GbCk6K2wIXg28uwwXxFQ/qGMVCX6ONXIoZCiPgQbjF4kvcixxOK0TugCvISaRwVBn8
         XEaKbnr7nusCRAE0zxw3ejto6KlIg6puTJYHKc9jZ0KmelYXVhAXtbSm+xBKvLUTxgCA
         59oI7dztEPYmpU3AwvoCw22C5BWIj8BD3mr1SiUwS6uAUVuvCbyWQdSLurPP2Hmz817d
         tZU8D2rhpf0itdZ64YZa6My80jT5E0RHusnp9UL1jWIKWN6KZs4L3AnSu0H/7eFRDmu0
         HwqkqP5ECrzpr0MaPdNeULttZppkploMdhjs7bOf12vhIpxrDFUdi6fvRxal2UZJe1ra
         ZAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222793; x=1779827593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYPyOA3Rtu9ZHZqq3A5dveESFOwy6WeEsdfBtKhsDgk=;
        b=nBnFpvM4y+LZpCLwcDZ6mIUz6+2feXuShtEPOUbQGnQuZj03CB3nzCfvdEo/XWhwzs
         SSMJnrDlkZQW/kPzJENC0iUqXkVawE8wIwEENHqncCWofRVOyw+O5UeB/I6eIJLBSpYg
         hYuYtlSJpXOe9S30GNtYpJfu9pSQdAT6IBUNIPiIcvndTbYNrtG4yvqkDjmrTxO0cL4B
         sZ/yw/+nvRumDVPJFFM1t152qamBWo164x9/nxBr8R4ib/GjetK3N9rJiRGfKPwe4RSD
         E9KZOA/bR4cgg+EktArseJSQ9u+PyB/5nJNq1L8ajPzX6eqrtjKFcpVV9fyMzpx6f1cR
         OvbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RKwmb1y3mFnHNKjA9Kvds5sgazs16soMxorjmKgkPxs/mbyOIkjDjiz54gPFkfYHvsoY1CvmqFTR50/Rw/7qNmOqT13A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OqAYnKUMntU6NHaqBheHkF0H2WcjLpV8q9wnTXlqYBLUzQZn
	IGhRavNKlRQNsDy57obA+OZkj/ug444w4wi90QL/tvCRzeANIb7pzgNoYqTcRYZnFusc5dymd15
	TrBusrGQTtymLO3IS3ltLpIkRl8BcvYizy0MV++Nl
X-Gm-Gg: Acq92OHpP0qghlarwlKxFxRFRfZcFW4zEjY7Ube/aR8Mv6WTj7ffyoLVWnRSwJRCgoV
	Ep7mdYicPjHVKuCd00ZjSN85KsxfkWkNJJMTBEAlaoHHYmbzaO5XwzqHufHMAb4uzg167T4J4MT
	bXXNxuGqZChTIhMDjN9aVOWwj4pVuXeJA3yOLe8MXmO9IOLUki+jb5NSH8Bl5Q2S6fSqCwTuWno
	4UfIrbmbZPD0EBbLh3eab+ihgrj4SM6XgqYnc+xSFVFeLLRlfunNcXwG3VWnrVhQQFiN418Rgs8
	62Ppc06cSSERh9/Tgw==
X-Received: by 2002:a05:6a20:939d:b0:3aa:c99b:5c64 with SMTP id
 adf61e73a8af0-3b22ec58a69mr25040640637.42.1779222792589; Tue, 19 May 2026
 13:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
 <aguvV8QCxK28ZHct@laps> <CAPhsuW7Rhdh62AoceQpsfm0+kVsvz8zq97fupm4mtBEyVTkkcg@mail.gmail.com>
In-Reply-To: <CAPhsuW7Rhdh62AoceQpsfm0+kVsvz8zq97fupm4mtBEyVTkkcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 May 2026 16:33:00 -0400
X-Gm-Features: AVHnY4JRRQcTVbhrcqMWkMq0TNU3br2FjZXs2xDjkFMyXvEps6l2ylKGgBsI8Eg
Message-ID: <CAHC9VhTv8sAgpP9Bd-_tZftemSVEQC5R5jkJ2mVGqiYnLj1KxQ@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Song Liu <song@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:29=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Mon, May 18, 2026 at 5:31=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > On Mon, May 18, 2026 at 05:29:32PM -0400, Paul Moore wrote:
> > >From my perspective there are two different issues here: should
> > >killswitch be a LSM, and should killswitch leverage kprobes to be able
> > >to "kill" security related symbols.  After all, are we okay with
> > >killswitch killing capable() and friends?
> >
> > killswitch doesn't do it on it's own. It may be instructed by root to d=
o that,
> > at which point that is root's problem.
> >
> > >In my opinion, making killswitch an LSM is more of a procedural item
> > >that deals with how we view a capability like killswitch.  I
> > >personally view killswitch as somewhat similar to Lockdown, which is
> > >why I made the suggestion.
> >
> > Maybe I'm not all that familiar with LSMs, but we would need to be able=
 to stop
> > "random" code paths from executing, and I don't think we can create LSM=
 hooks
> > at that granularity, no?
>
> There are much fewer LSM hooks than ftrace-able (killswitch-able)
> functions. In this sense, killswitch is more granular.

I don't know if I would say it is necessarily more granular as its
ability to filter access is limited to a breakpoint set on a symbol,
but killswitch definitely has a larger quantity of control points.

> However, LSM
> hooks allow LSM policies to make different decisions for different
> arguments. In this sense, LSM hooks are more granular than
> killswitch, as killswitch can only set a fixed return value for each
> engaged function.

Yes, I think we agree here.

> With current LSM solutions, we can mitigate issues like Copy Fail
> without breaking other features of the system. In [1], Cloudflare
> shared how they mitigate Copy Fail with BPF LSM.

... and Android has been shown to not be vulnerable in the first place
due to their use of SELinux and a well crafted SELinux policy.

--=20
paul-moore.com
