Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC764D8CB
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728172049; cv=none; b=tCqiH9wXx+7zMPAKPCOPHxIDSMfTvvieZAUXiyUC9EK0wIzcFe7b4qewB2dJwmeIZfi6kRfDHI2srtv25t1PkBObghQOexdzetmg94G2Z97oFBSncAhO2Mpwp5u0fq4loRNRLp51T2e+FVsSEj2VKkhoeKHNhJw8POJKnZBAytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728172049; c=relaxed/simple;
	bh=CSSDLz09Kx2wqG7r0GpN67FwKPAFzNmtdiEVz74rZng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlK52VlKmH8OjmpGL43fpM2/H4Unh9mJhWfmOECyEsLVLtTwDxlG0UcSN05xjXbQLZNsy67B3VKe2LClUrRdnXrjXoxRjhhZhwU+oisn+7CfJdM0RTz344en6LjiDDSt74z3eIl+qrm5y2vaboKf1ZNE8OxEdIOKUOn1pjiZceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4u3nRh1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4u3nRh1"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e263920b6bbso2625673276.0
        for <linux-security-module@vger.kernel.org>; Sat, 05 Oct 2024 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728172043; x=1728776843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V93EH9jfEo7zUGyn4gpH3g6GWHGUHSQmtiGsCvNwnNM=;
        b=B4u3nRh1O2lY6bSmwAQFViiBNvfzwQIhVu02gcjO72NJnxfZ0TWWfw1StTDwZWPKXX
         GO2lmtgDZVa+4rfiaHvjcy+Gcg7REA8YO+T5T+eO7vQqr+/AoZCDHbdhqCMq9MLNhD3s
         wrDmrT97UiI9mLbFqsazke9SzEBkFABR9B9+Yd0iEJhEdb5Wry+Sv5y0GbqU0U84njKw
         jG3EG2k6fzy5NaAeKYA7Pf6B1csEOISmZPRviqOnyrxuAmfP5vFX9L5X77urkc9zDQ56
         rwRWeI0xno/tYOm/+LM5HD8YJzQvV4gxPewpvEstBz8HL7fEfxnz+3nmgkw9r3T/wOrV
         1mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728172043; x=1728776843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V93EH9jfEo7zUGyn4gpH3g6GWHGUHSQmtiGsCvNwnNM=;
        b=dIl08q+ze2JGk/k+GaehVYoQBgk2Y1zRAb8U9ipXYi5FbohErs2sHqwhUGHls8LLr9
         4qNwAdEROB61aHxaKxuklCyFprLsjhR6meVjPRib/CX6TgSqXU7DFe1qOFDlsBWmX0R8
         uJRnH6DDqhHWWk3bNNOcT/eNkEJvVblfFxvCFY+VMcOLmY0okSa79+bAnhe8tPbzrnfc
         dzT0ajGc8XCcPgCNxlgoGJFCiFw1u8Yb2i+r+V6tvyPeZ/uTOrZHki0NHgMQptkdfwVk
         cgsySmOwtRlEuwg6G1IZA/Ydp8kFE6vYJoVtJ6lgChNf4jVMgm8JLWT5mbmTuPS3Cj4q
         H0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKp3UqfEbPigaHwwP3CeNN/Bmeh5tOrMrvwzCZ0clP3rZDBZy+Py6JC/mu7L2Aq5s18adCa/rfkkjenVkeoN8IrjkdevI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfMSHhnkW+o+eezj1EfiI9RA0Bu5wb1gFbGnWpwVuNODN2Mhq
	A6dORHjRHZLuvbe2RcyW+OXFRKyOf5R5e/BC4H8EjE4KoaAysyvokFYxdAWsXPnk6DjVQiRZBwO
	t+EmPr5mQEKqUXMl5i8KFgpwV+4xBUM13uJv3
X-Google-Smtp-Source: AGHT+IE6fpIifp84ISK7ZTCUTCZNH3QfjQrPy0ZXW86HnEqnr+AYjjTajNFyyaCqoBrRQ7jmAMhQW3xSQj7qcROIzD8=
X-Received: by 2002:a05:6902:f84:b0:e28:9013:a879 with SMTP id
 3f1490d57ef6-e2893951487mr4952989276.45.1728172043075; Sat, 05 Oct 2024
 16:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook> <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook> <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com> <20241005170235.GA24016@wind.enjellic.com>
 <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
In-Reply-To: <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 5 Oct 2024 19:47:12 -0400
Message-ID: <CAHC9VhRvTzYoMsWHUa_-h1EmLk1-hNGK5PpEo8D171p7yAiepw@mail.gmail.com>
Subject: Re: TOMOYO's pull request for v6.12
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dr. Greg" <greg@enjellic.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Kees Cook <kees@kernel.org>, Fan Wu <wufan@linux.microsoft.com>, 
	"Micka??l Sala??n" <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>, 
	Micah Morton <mortonm@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:58=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 10/5/2024 10:02 AM, Dr. Greg wrote:

...

> > As we have evolved TSEM we realized that we actually want to be first,
> > if that isn't also a coveted position.
>
> The current thought is that we frown on an LSM desiring a specific
> ordering and would probably reject one that required it.

Agreed.  We do have a couple LSMs that do require some specific
ordering rules, but those are typically for safety related reasons
realized after the fact, or some legacy/compat reason.  I'm not going
to say we would 100% reject an LSM that required a specific ordering,
but there would be a *lot* of questions about that requirement during
review :)

> > For example, internally, we have TSEM 'models' whose only function is
> > to validate that the extended security attributes of an inode match
> > what the workload was unit tested to, in order to thwart offline
> > modification attacks.  In this case you want TSEM to be running ahead
> > of the security attribute based models, since presumably, you would
> > not want those models making a decision on extended attributes that
> > have been modified.

In this particular case it shouldn't matter from an access control
perspective.  Sure, you might end up doing some extra work in a LSM if
TSEM were to occur later in the ordering and ends up rejecting the
operation, but that really is no different from any other case where a
LSM later in the ordering rejects an operation that was allowed by all
the others before it.  The important thing to remember is that just
because a given LSM authorizes an operation, it does not mean the
operation will successfully run to completion.  Even in the single LSM
case, with the LSM access control happening so early in the code path,
there are often multiple ways an operation can fail, e.g. -ENOMEM.

--=20
paul-moore.com
