Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF43233722
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617180; cv=none; b=gRI0Puxxj49V0RpggGOiFzAmXTaG0aABzfLduhxsMPgRH0A/dSHh6YSgpij+86v57yVMZEoRG9/iU21uEg2wKIctqyLcqxu3IaBDQhSpQbboSAeLKXUAjFptm7fZHePLsyKBdXP8NQX5kjdGkUtm7lPvxeUITcn0KMOaIyRjbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617180; c=relaxed/simple;
	bh=jasKmp2aQuprGgWI5wC0BqX8f7HQURC6vV2wipWoXUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry0obpkdwP+ksV8++s8EJoa86bCEi1Z/jCOipEXWWHdqwkH0rS54P1YlzsOAaKplNV34PLw8CAYPcRJ4Zh7zOcX49M7TDkmyYYlvaxCt/LirQgLCapPIwta3vE5cbgzp4u7e227PD2NiV+kjRJdqgAWaBZ0RxZ8YFk10CY4UZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZKbzoavf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZKbzoavf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e75bf727fso20518487b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748617177; x=1749221977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAAu3PNn/g5swmaHMNzxUtR7zHSWqNSkf/EYcL84FJM=;
        b=ZKbzoavfJTTsa1cyffhW4nXl/B2WC9layXNA/Xwo4HB1mjXpmYbPZnxWkFNlisELmd
         jAeyAgL9mMb7qJbVHJOUBWT7WsY/P8iJiU447v9jhfjs8clOJCQFPqIz5p+tUUaRg4QQ
         pqa/2gHJnE6jlOO/7+SiXrX0Tzaq/qm8opI2itTNMgTnTztfNWYxQLoqoUO24cHElzhr
         PX2UL8PcTbab76f871N6wVhxRyhIyMMaGe4VjQhDAln3ez+tuvmXMeuKK4kOIuyQWpA3
         8vYI2H81GIXnusEcRhT/wb+GCs17fB1zPeyPi5Zwwor0ddJFGOvho48cupfENEED+BIr
         a1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748617177; x=1749221977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAAu3PNn/g5swmaHMNzxUtR7zHSWqNSkf/EYcL84FJM=;
        b=b50mtrKew66dU3keU22T9glC6ZmOuqNpB59vMjiH2OLRCYaflm1+yHMKBJJl76NtPy
         yixs1cPUFLBiqFamO2DuV7NTmWWQ9nYWKtAZui3FvsJlSaK7cMG7XLQszD2fP8zE5agq
         lzMA2/mOFXrqZFYD4dkLUg/PdqSkvu2oyYksTGagehjqdCH611KJkB9Z+7WQENcRNew6
         pubzTGEq24Wiwf3ON6rxHMtkIZ7ZwYegb/7eW1mqAvPmywQx3UrpyLwmR4qZ7HrW8shC
         mFH17mrJsoQgc8h8HIMM7S6rS4YRXoJIp7PLNHRvdJB2cbkMw3wR1BONGMgnxTx3Jeje
         9p8g==
X-Gm-Message-State: AOJu0YxL0ShpW/lvYbxs7Xkc8itjel2dyiHsJwD8hXAZ3zYUxtJlL79U
	X9RXDvjHkqC6oa6j1MC/LEmS9rxYPjxZFNg70wzejtzHJRDmoPmctz8MggkgfK5jUybcgezLcbU
	L0PduXB8c31cHr0HmxTsUrRcOWIHfRbFbPllFiLyq
X-Gm-Gg: ASbGncuoXtEXwI2JyicHw0/BgwJVr/TNOJMFjvPPfOsqtAM1TUW6uIAuAM/OKcrMjC2
	1NA0eY7jnFRTpr1UgVamvTWMhSAiy9qSjYrdc4P7QLFg5Zn1RyIlrWABvFg1MyMWH13wXv6aSxX
	qrNRDWMWGvir4aRh0wOUcubLUlsNgFZnIFzhfyiIo36NQ=
X-Google-Smtp-Source: AGHT+IHHnVePMsvh3ufc14xyANHYkK76dmtQi3C9pr0hEAJFnSpRDvuBz9Sw+cjnx2wg+DaroEvhGoRJ1j6utE6EWUc=
X-Received: by 2002:a05:690c:c0b:b0:70e:2a04:c768 with SMTP id
 00721157ae682-70f97e9b96cmr52596327b3.14.1748617177588; Fri, 30 May 2025
 07:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521140121.591482-1-git@nightmared.fr> <20250521140121.591482-10-git@nightmared.fr>
 <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com>
 <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr> <CAHC9VhT5JrhzGhRnJ4VNo6e941o-xdAG-FC-Q6wDbSZhgSUWOQ@mail.gmail.com>
 <2495c0bf-5a24-483b-835f-abf433687889@nightmared.fr>
In-Reply-To: <2495c0bf-5a24-483b-835f-abf433687889@nightmared.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 May 2025 10:59:26 -0400
X-Gm-Features: AX0GCFvKjrCn57dBCtHrgxUd83Gfghrq1tsQqynYBLqWk4EKe074m06s3Cas29k
Message-ID: <CAHC9VhSvwOZXnh4o3O8_+QXXKJ32D=9ogoizvNzEEGpzQWhx+A@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon Thoby <git@nightmared.fr>, Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 3:03=E2=80=AFAM Simon Thoby <git@nightmared.fr> wro=
te:
> On 5/30/25 01:49, Paul Moore wrote:
> >
> > My thinking around possible augmentation of LoadPin is that both
> > LoadPin and Loadpol share a similar, limited focus of controlling
> > access to kernel module loading and Loadpol has support for a basic
> > loadable policy, a policy that could likely be extended to support a
> > LoadPin-esque construct that limit module loading based on filesystem
> > pinning.  It probably makes more sense to think of adding LoadPin
> > support to Loadpol, rather than augmenting LoadPin to support the
> > Loadpol concepts, but for consistency with upstream we probably need
> > to speak in terms of the latter.
>
> Thanks for the reply, I now see what you meant. I will try to put somethi=
ng
> together (hopefully next week), starting with looking at how we can expre=
ss
> the current LoadPin feature set as a loadable and user-extensible policy,=
 and
> then add non-filesystem-related policy entries (like module name restrict=
ions)
> to that policy.

You may want to see what Kees thinks of the idea before you spend too
much time on this as he is the LoadPin maintainer.  I'm guessing he
would be okay with the additions, but that is just a guess on my part.

--=20
paul-moore.com
