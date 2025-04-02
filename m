Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D52E3385
	for <linux-security-module@vger.kernel.org>; Wed,  2 Apr 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626325; cv=none; b=UHlJQLCjCpHzbfllCjG3cSWDTxokpeYHeSmMKS4XHAfpvJjXrRDKgKEfGY8IPmDrd3aTVNccfOl4368ssO+kY7gOJyAdw9A7Hi0lPBzO3vwui5ooa/2cmOFrrK2T0jtuTovYT5vo9q0du/JLsOulNPA8pN3sgOs8SOxwVZbuKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626325; c=relaxed/simple;
	bh=/T2pmxRuRYT5dmM8afSa07afxTtwCQy7pymfkWfY2mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P69X6Tz000fnzFaQuzY/em1wcyxH0KXFPQfkTY9ZL+SyJHobDcxjz5tB6sqWLSpb16jj9meux2KHydl210Wg+WM0Q3PwDJaT9g7/9eYxwDCkriGix6uGAIw5+N7MIJpKt8Q2XmiYcRSKW0LPZxiNlRdjEfVARoF2gfIPaqBxLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DR9Imalm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DR9Imalm"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6df32ad351so179207276.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Apr 2025 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743626323; x=1744231123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhuc3Y3hp1dqy1B8GUo1mAHuHRbRWFPLzCIoduBmsXk=;
        b=DR9ImalmaLXp8R9dfeDeuvwpamKzX91NUAKDdRYYH3sJBQkRd7UVOw43ICXVClqhhS
         AwpTD0vSszAK+NXzkWJavjk3AV+rfY4pJGVjy6qgICV5l1GLZlx7k5TpnUuUkaPKev8P
         LHJmGM7AGBOTn6h+D1wfVbECODKHYez5TomwpznXCR1d30L+4/aGxsqP7AMGZElDpdPN
         gIvV3FTr+5hb52A8GQaEsLgj2YsriTJD1dWsU2bcxB2NEPrdxiLDUsSn8rg3lB1ttjJC
         1A+qkAcPuvSlvLUncNwpP7fK8+pgaARWSHx8j1Q7XoDXPqjLMe5Lh81eDTmeNNUY0EIP
         oekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743626323; x=1744231123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhuc3Y3hp1dqy1B8GUo1mAHuHRbRWFPLzCIoduBmsXk=;
        b=C4a57f9pI9679MCLkRp32SwAajEhivLdgs7Bbo/0lRJ8KM9kG4A5v4Bbk8FbekNOKA
         +RB5AeIn91EDr7DMBmGn/6rT22+sjOPuRI+Y2+S+wOwHaIFWex6+je1Pq9p9DWr+q7Kl
         XCnuu8N8fpq3cLXkb90azOaeTu8Nly/SIfobtuNpHBIKtcZYdoou65krGckedxD0Zrzx
         9DZJHEPOJhQ/1KCwK01J4+UPv6eruUgQbOht0IeJ6M6H80ZXkz+5Pbj17IwLQdD+IPYd
         /g0b8S8hLPixBzFgeUzMVpu93gIWtazxFDhiWM1LQIbH5I8P2V8Teq5vdtV4SifPi5YL
         9Weg==
X-Forwarded-Encrypted: i=1; AJvYcCXk8AS/N5rFnhjxBIscttvWu6fp0KMmJIg3mvXl1BdAQwPso1AK06j1+RoDE54G5XM+0deQzLUhHp3hjZYAOfveZLsffyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BAFJKT+b/ukB3VJBIZQygodNurrpVQyOUrkheyaNX228fszs
	Lv3oaTPVVWYwubQjWi4HflEnTccQYEurT2z7ioWeJD9QDynoMeRd+KmnGxb9Ugorxaltm2XxAjf
	7huQeoin9getVE5BHOHlFQcWBbLoPiFQbrTCr
X-Gm-Gg: ASbGncvGlyA6YxwrKX43tvgFgW5EsN8Cqz4y0+92CeKlYpx9dpZEFm4iudfnSK3vnDU
	6cdtWwe44HhSRuEfU9cTTxmI329QPkmcCLtaSfRJepWayjXD/Su1wB+vi+8ZiWc13Jqb6WauNIz
	u4XmUSUsp3ET5Y5S6oE8d4MVxC6g==
X-Google-Smtp-Source: AGHT+IFHjJsKKyqKBvb9el7hYxrLzC+Gwwmb3s7tqGC6agBs4p5NAHg8LnYnKViFVGx9xCuT5y4YM4gD9uoG2SB3AwU=
X-Received: by 2002:a05:6902:2681:b0:e6d:ee69:dd3f with SMTP id
 3f1490d57ef6-e6e0a0ffb22mr170729276.5.1743626322975; Wed, 02 Apr 2025
 13:38:42 -0700 (PDT)
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
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
 <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
 <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
 <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
 <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
 <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com> <CAHC9VhS9xYg5_EaX83hyNX4EMr=c4EaDZ7N=+opv6BA6iZo+mg@mail.gmail.com>
In-Reply-To: <CAHC9VhS9xYg5_EaX83hyNX4EMr=c4EaDZ7N=+opv6BA6iZo+mg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Apr 2025 16:38:31 -0400
X-Gm-Features: ATxdqUFyEHJS9PY6K5iY-ZrkT1ocLYPu6GuqP6AaEak7oZcZydsPhJOMs8z_xUM
Message-ID: <CAHC9VhSpYBxkGxL0r-58q8-+CcX6tQxQeqmn0T1NNiDGXo=0DA@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	"Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:06=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> ... I do have some other ideas that should
> allow us to drop the bulk of the SELinux AVC calls while doing path
> walks that I'm going to try today/soon.  I'll obviously report back if
> it works out.

For those who are interested, here is a link to the patch that
demonstrates what I was talking about earlier, with some performance
measurements using allmodconfig on Linux v6.14.

https://lore.kernel.org/selinux/20250402203052.237444-2-paul@paul-moore.com

--=20
paul-moore.com
