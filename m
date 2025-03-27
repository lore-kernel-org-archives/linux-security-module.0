Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2D2914
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102236; cv=none; b=Zt+ZLfIvmRELwOAw2OvJepMkGl1tLq2boaATgpwXi+43SBRZmaM73eitdIeyFBcgvrPgWR6FnG+Arx8nAhWCBKnDB1NsX0PC5+lo1ybEATfnPUqrhl/wV2yvkER7mAXhXEqIHu8fuIHrcbwqqWcjjO6zrH12RTOl6zLSVKCiOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102236; c=relaxed/simple;
	bh=ZV+lHTqy2y18sHJQYhQiUkM92LLosntDULZ7IsN9AuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4VyAFiO2tpv6tylAsMl7TZhxGAoe3iG7DqpbHj2ocdHqOiFDo1vvXUY8lypIqTPlFksqi+BgKt0HPB9a76hNfNDYLdF5KIU0BiCzRJh6q2l0Ejdmdo9R/b7sNXcMXxpSnQ82w8UbFvibUxgVAXYcwOWmG7Bqbtb+P7ezaTyzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QZxT5thJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QZxT5thJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so1726782a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743102233; x=1743707033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eckh3c+xZEpUAPcGpuJWSWBJz7nrFu2WDtg6sHEX70w=;
        b=QZxT5thJ6UJr6xbe5k3gkC3nbBHDn6OYIaJOu172bF5U97AeMWILLVjVv1jG4nRcqr
         LkEnDfDFmJ17ou308bkqTd4sS2RAh9wPPlSQfJ8++3qQL9Yz8zTPr0jaDScbf4GG+G04
         zPZaiII5nVYw/PD7o9mrO/Q2U5WgHxY9nwNWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743102233; x=1743707033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eckh3c+xZEpUAPcGpuJWSWBJz7nrFu2WDtg6sHEX70w=;
        b=WUwFmpHzpSANL06BAs5mr/kEmw0wvPTBz8AzkjCcw8AGWxkWQvYeUi3KfkW8HZqReI
         fCxmKM6BR5psZr/ZMedod2Vrrjoe54uvTKj82rZTpVjfFaNncN3xXdOtAjiQamyL/9kJ
         F/40vPiBIdOS/9BduHsv0qs7P5j94iUksMdZDxpc2paCgF+qWMbwzDGkf6XS0Rz0+BBr
         xCGxKMUJTVCUrhSvumZiAZSleL1jO6m+QkDTM/pmXOGedul3w0LBCQmGp/2Zpge1tFnf
         JWZ78v0My0hScjOhZY54yAT08f776ml793/i2MhTJukBd15kqYiq6YaemSk7JHZhOJNL
         0bJw==
X-Forwarded-Encrypted: i=1; AJvYcCVXcqokBnc4lQvUs1qwIwVLaKl9bF40NNRLJLsbSeGk02t5JPEegabGv1P1YenofgXIq3XarCvdKzM8hKYEcvO8k74AeYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRtaVNfMdKCaqx8dcEbOJBW+2Fl0TFR87ULqNJAkyYex/k52n
	Ux6ied/yWLrs6AubiOvZkrcXS5Ed5M0HmFpIY+brorqeqDvAuKS97MFvNIyk8Ok1C3IKMVND8Nn
	Pmt0=
X-Gm-Gg: ASbGnctaOAdiqwObPW5X9EDydVudIgzeICAcJNqqMQx+gQii+RbVbZaYFJlIFerzt5r
	814Fk6Z9sv9+RUleIJA138rZmPGp4ms5VfWRg8xBYRGuKCmoVaL9qrmMq1nGPfvm6JVgr3ClqdP
	5Vi5rxIdHK5mKCUDhL2tGQyUlpoB4i8kyt8iLWZydPdih+Vbw00R5pJwHE1/s95T5Dgk+8lDHjb
	67V5UgEdmwk7Mc63XEQwEF7B8hFsSHfS0HpORHRXYhZ9EQWgtW2p8mMRcPbQHitdRUOC7gVRxpM
	GTRTPhXEBYYrmdQ6PIV7JRlGosR4Ik3AhqoDVLB72004qPIh7D1xPZjb8rrNUxfGK/FSKYedi87
	1vDmB5BJPdmqpo4Fkc1thaICDBJK1Qw==
X-Google-Smtp-Source: AGHT+IFc6kobSjUYj7iplzBk1Lu6L0U46I9IDgGJjHcpoShTIUwXL3hoJgNKQscHKRVlpzVSCsEPfw==
X-Received: by 2002:a05:6402:2753:b0:5ec:c990:b578 with SMTP id 4fb4d7f45d1cf-5ed8e49fafcmr4962651a12.19.1743102232491;
        Thu, 27 Mar 2025 12:03:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d4752sm215686a12.27.2025.03.27.12.03.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 12:03:51 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2167186a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 12:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlXGkhat7eLNa5VkAZcLAjyzCedFkmEyGN3M+61fbv8IeEPjnTG2BAq3O5MrNeHZJgonTObT5Yz4kDZAcTsYu57uKrFbo=@vger.kernel.org
X-Received: by 2002:a17:907:724a:b0:ac6:ecd8:a235 with SMTP id
 a640c23a62f3a-ac6faef94bbmr415071366b.28.1743102230511; Thu, 27 Mar 2025
 12:03:50 -0700 (PDT)
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
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com> <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
In-Reply-To: <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 12:03:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
X-Gm-Features: AQ5f1JqA5bKkmZKwxCnmbWV1-xhL46E4nM7-YF5EKDpJAQBP2OdnLsbOul3uyVQ
Message-ID: <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 11:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The best fix would be to be able to cache the "this doesn't have any
> extra security rules outside of the regular POSIX ones" and avoid
> calling the hook entirely. That's what we've done for the ACL path,
> and that has turned ACL costs into almost a non-issue.

.. just to follow up on that, because I tried to look into it, but
didn't know the lsm and selinux code well enough to actually make much
progress, so if somebody who does is really willing to take a deeper
look, please pester me for details.

But the big high-level case for pathname lookup tends to be the calls
we have to do not just for the final inode, but the "every single
component" cases.

Which is a much *simpler* and more targeted security check than the
"any random permissions". It's the "can I use this directory for
lookups", and if we had an inode flag that said "this inode has no
security policies that change the lookup rules", just that single big
would likely be a *huge* improvement.

Because then you don't need to try to optimize the security check
itself, because instead the VFS layer can optimize it all by not
calling into the security layer at all.

And from a "this is called too much" standpoint, the "every path
component" cases tend to outnumber the "final file open" case by
something like 5-to-1 (handwavy, but not entirely made up).

I think the main case is

   link_path_walk -> may_lookup -> security_inode_permission

where the special case is that may_lookup() only sets MAY_EXEC and
MAY_NOT_BLOCK (for the RCU lookup case, which is what matters).

So if inode_permission() (in fs/namei.c) could avoid calling
security_inode_permission() because the inode has some flag that says
"none of the security models disallow MAY_EXEC for this directory
walk", I really think that would help.

I think trying to optimize the AVC hash table lookup further or
something like that is a dead end. The cost is "many many many calls",
and each individual call is fairly cheap on its own, but they all walk
different hash chains, and it all adds up to "lots of cost".

Hmm?

                      Linus
