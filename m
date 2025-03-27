Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3218C345
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743048596; cv=none; b=Qj8Hn8SaMJMzBqgjhscVXoVlF+cMPdvn0DWF5iLUZv4SKjZABjA9S4xmLkRlwNBpJ28gCteYoIvOI/oXaMAIwpcPFDcTkZ28aEO3XsJRRDy5CyKPgez1GSLW1ycWAAhyvEyWVWqNMcypC9sODQTdMqTqQlvVUpWb5IycNwTfMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743048596; c=relaxed/simple;
	bh=Lz1FQLkO9pjDr4w82/Pd95GcHEkMkqv3nNZh8P0KAio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUTylKPhN3SK0W7jy2s/7hqgA7j7Mij3gCt3lO1XoLQLpyNOSFSPGIqnn71GOEIX2vTHAK28U2IJnYQaZbaevMTRt7yjb6gnb/NzIEPMdHP2VulUnNYINEi3OX4M2a4pcDv/vNsusyQECPQXbZCW5x2QZqmDjKwFA+lTArwLfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UFYMplWH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UFYMplWH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so683665a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743048593; x=1743653393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOWeEw9Pu7F8nbiAXPD7wEj/kT9XBFmAh+hzKHsE59g=;
        b=UFYMplWHcT/n51H474rCtmkH+GU+5sQmsVm+h20tHQ4tuHqlPC7aqumCG8uQbkwGXG
         soC3iVjNatW+NTuW+Oyv2Lg7BPbx/2M19rnEwwAL1alZSJG1jqtmUHHt+DPK/YQlCXq/
         ISOV8cFIf4hj5cWY975vBn+RFV+gtX1+hlu+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743048593; x=1743653393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOWeEw9Pu7F8nbiAXPD7wEj/kT9XBFmAh+hzKHsE59g=;
        b=TGieoFYDJfBBNEwSbqvEEp0JGt7bCRu2is5ItQOjiaTHBuuHhBPGU3jnFusao3qOEa
         DrRv+Oj36TIBvDrPQc9350WnJ+MxClv01RUtN/ClNHZpmOYbJ82PIO5oN1qjLcTOqFRc
         AmVt1E4gem5wb4rAHY0MUNfKCpTYWdBtb+3+vQWGJMyAMlLXxUSAPXQkiBL5YTvQiW77
         Dxo2aBndYjUBGlhtxFS38LuRDKNPKpcJ0YpW8oFfymuRw0asBG10Ppo87lXCSURUN7gI
         KE16k/xgoeeib2nu5RzuX2ZCeW0RJRD7flgttW/n/fcXzTqIA8cpu4rci81obeGxWVGH
         X00Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPHCb1V3ZwsYX8O+HbWRQcVuPvpcJWTkMqwOv89nj6bmGowKPMjwwxRnukZoRMg7rFuzczk0bZZ2hy11Xmftgg96+WdgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4mOPWs8O0TXTqBrAlWqYBG3/MJApuKO+tZu6Kp5D25lNzt+s
	51WqeNC7UoU+9l2Gt1k5ereEotsU5PLIS8eqrPDzVBoMIf6sT0w95xAcXaBVKUDOsWi3XXXXqKw
	xK94=
X-Gm-Gg: ASbGnctXeg35TuYcX6IozmSwarUfUcFtRoeGAB2LfFvQUje3XC1PFeLSrnMtfCGhkHi
	zB7rgV6wXoKVLsRXSYIM5sOQKyv5ewFYaMeq37ENGrtvUsgEQV/h8ykaQG2mBjrtHANddTbC05a
	sJe9vHKs758MhDpukAjijofE1khKTovg34zcEyZzUY0dzey5LefIA8fy5xF/1Lo546v+rpi6h1J
	K8wAVg828hlohnal2O3AVrdBESUg7g2JbOaxVpIp/43rD3VGK2MOlOE3Y2waV7reycAjYHAsUsp
	D7g9gp3gUfpglZSjbKs4s84VDxBm3W+ewMYlDsvg+Ah8P4CyZeP736MUQFnFc4NCBD0Y7/q2s+9
	dByUMdL3DE567lZepO4U=
X-Google-Smtp-Source: AGHT+IFzWJ1ItJdf7G8Sns0fEGoF45QfnRNHdrz2xErr+D3kc65zZnmndpwn5leulR5riYBU8ZRXuQ==
X-Received: by 2002:a05:6402:2753:b0:5eb:ca98:3d3d with SMTP id 4fb4d7f45d1cf-5ed8f20ab63mr1840761a12.22.1743048592674;
        Wed, 26 Mar 2025 21:09:52 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb4471sm10552130a12.47.2025.03.26.21.09.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 21:09:51 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25520a289so82362266b.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 21:09:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKEH8lDI3Bz61mrRt/OEWRzgnt2TQ6t/rVxOU3Wxan/FWcC0Ir4FOvzwdqnfXUhEeNAuS0lzsrSBvfnwSglm0YYslcPRU=@vger.kernel.org
X-Received: by 2002:a17:906:c10d:b0:abf:69e6:438b with SMTP id
 a640c23a62f3a-ac6fae622dfmr169188166b.9.1743048590150; Wed, 26 Mar 2025
 21:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com> <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
In-Reply-To: <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 21:09:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
X-Gm-Features: AQ5f1Jphh6bvpH_hyDGYydwiPutImRu0h5mKD_G1WlOxtBvFwB1PFPSAJ7TmHxU
Message-ID: <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 at 20:28, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> That is not quite right. If you look at commit 581dd6983034 [1], when
> a firmware is about to be loaded, the kernel credentials are used.

Ahh, that's good, at least there's no "random state" to check.

But it does still mean that the security check is pointless - there
aren't any other credentials that would validly be used for firmware
loading, so what was the point of checking them again?

In fact, the commit you point to was made exactly *because* the kind
of pointless and wrong security checks that I'm complaining about were
done, wasn't it?

                    Linus
