Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0462576
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038463; cv=none; b=KxkxdAbjhZi+gkUFULCJsTP8/v/DPq7cn3Isc6Je49Ot2Ekl13SYJ/LLIGwf1Ad3fWGJFnlM7IEDJcfpXX+0XoQnPAXjusD7u6OtNd3OQlZ9Tn704XU2l1fqePdVZbLz38BOYQzWURnN2LZEKpeDcnWdmHlQlvkGIhdiozb2iNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038463; c=relaxed/simple;
	bh=rkxtS5suWD5Evz+m11GQWGobt3dWkXZJA9nOgREsdpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq8bQIjL7249Y0vetAedGW/q2VgRiZyPUGoKm2RQ+KfD41GJ9SDDcz8GA27IE3EkgloKdHxWXZmQn3dVo0KoQfS0J2slYI3UO0BIoRTBGatNiWzO1qw1YIvQbd0rf2OQRnEe2MkF5qGtHAxNuF3X4lvcLH5HU8KsRBdqTp/U/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fO0lC0Q5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fO0lC0Q5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso2787480a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 18:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743038459; x=1743643259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI0EdooEMFFqAW+WoUqWF95O/QEtZzQxFpMruePbYtw=;
        b=fO0lC0Q5L7yl7BoWFzBl5s8MdxZCFE7o7aOt/C3TcVHso3WPBWeVNkAi/HS3g3GJk1
         ZHLjHRtkPAnHRHgdY576UtwsSsKyvhpn0JfbHDD0M9yVggBFp39i5Bk+IHCu7Yi0Ootz
         WTaoBDttKVa7MmH+vuxUVgX4d5fVMs4Bun1qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743038459; x=1743643259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI0EdooEMFFqAW+WoUqWF95O/QEtZzQxFpMruePbYtw=;
        b=mrwdN3K37FIRIL/+WxFWr/DRZAAT3UTigRekvHpfxhoC7pdiymLdj0aiNKkifATpeL
         pjVdct69UGBMr+UnOLngltkBMelAexTIDfIM7mDl1jWjVDA55X/9MrZuqFm5NKONT1ip
         fLxg7XHRIFIFMFYV8jJj09PDAyMYF1s259sXVRrK/d1438zKVhr5eOPUogwOP/f1sXA5
         WDkCtlpST/E0n6w9LLnnMx6LRgJwJAltYpSWFo8GCQJGzjhJwxqsDAeG02AoVVo+oTHi
         pSjB0shE8u2JWYWDWbKcwJWvd2KsLmzSAcRSkAyFQ2HrJ7pTQD9494kI7rUYDm+9sOt9
         83bA==
X-Forwarded-Encrypted: i=1; AJvYcCUz0vysSnnVCc2ZkI5ZlO+xeZ3u94FU9nrZQODORhkoaVxDg7YGlUiECxFJ5fGYtJCecYlv48UicRtc4mreMbq6k3Xx+D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCdmlXibZptv5AGMEJrx5QSH2hyVeL3zUZql4IqtTg5TNNZ/a
	AFCNCxJWzaIsAWFgiIZkNomtq7/WgKZx5nViNS8GQGoYVFXS6BlbmbtPOq546lAN3iMNwQdhiUZ
	4oTM=
X-Gm-Gg: ASbGnctIU3PUCjjDUxseOUvWYtBq78zn7QxyJfM/OCc4MeQ4g9YrB1576q3lQ+E4AMD
	BV4pmIvly16OeTdrqpx6oRAgYD0ZzDZMO5kUEbQAIi1DWyKQEbdhoaJqidJMrnu8XJom67MzDAO
	8Y/yJLTWcPlgukXNnGI1KMP7p2mu1s3bJh2ZUQEwDQJx9pRb1PkDjrY09jHjVf4szk8QKPLQ2dA
	xE9zDcfPJ/+NxgN6N2KEqla859HvF1WK/Ihc9VrFHO6AWin5zhKZ8/2Bs/JyMwG44cgHe7Quikj
	x0iiLELZp7AP1Pk1QP4lWcEEUk08j4e1orT0+AlSOu9Ys5eg/eDhY7n4F+M01vxZqYXyx7tzEbu
	8BxT6VOnaKK8HxH2tJIE=
X-Google-Smtp-Source: AGHT+IGvieoxVV2f6rCh1ntnXMaDJxBuZC4HbWcRPZG2qlEMyaNcduWac6z/4xjoprHbgIxEB13icQ==
X-Received: by 2002:a05:6402:42ce:b0:5db:7353:2b5c with SMTP id 4fb4d7f45d1cf-5ed8a3d3a08mr1663749a12.11.1743038459099;
        Wed, 26 Mar 2025 18:20:59 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c74b9sm10153901a12.62.2025.03.26.18.20.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 18:20:58 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2aeada833so89859266b.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 18:20:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh/anD+hkj9jz2/jJ0nBMLUgzCPZilfsRfVpzONOhQyFPhIcJVzUzYdSL8YbSZFPrYvUs20MlCSeoGo2+7C7QLMOwF0ig=@vger.kernel.org
X-Received: by 2002:a17:906:c106:b0:ac2:b813:ac25 with SMTP id
 a640c23a62f3a-ac6e0a48dc3mr490833166b.14.1743038457610; Wed, 26 Mar 2025
 18:20:57 -0700 (PDT)
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
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com> <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
In-Reply-To: <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 18:20:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrMmGY1WBP2YbkNsM86xUUFOzf4O7ZMelOhzvZwerRqYfGCFS_CQ-gr9m8
Message-ID: <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 at 18:06, Thi=C3=A9baud Weksteen <tweek@google.com> wro=
te:
>
> Taking one example from this merge request: kexec image loading.

So this is the kind of "why" I was looking for.

> Currently, any process which has CAP_SYS_BOOT can use kexec to replace
> the existing kernel. Android has 5 processes with CAP_SYS_BOOT, only 1
> of which needs kexec functionality [1]. By using these new
> permissions, we will ensure that this process is able to call kexec,
> while prohibiting other processes. SELinux provides us strong, kernel
> enforced guarantees which can be checked at policy compile time.
> Extending on this, we will use this patchset to guarantee that kernels
> and ramdisks executed by kexec come from known, good sources.
>
> The other hooks are of similar value to Android.

Now explain to me how the firmware loading hook works, not some
hand-wavy "similar value" thing.

Because it seems entirely bogus. Exactly because the context of
firmware loading is *not* something you can depend on. There is no
"one special process" that has firmware loading capabilities.

I'm looking at selinux_kernel_load_data() in particular, where you
don't even pass it a file at all, so it's not like it could check for
"is this file integrity-protected" or anything like that. It seems to
literally say "can this process load firmware", and as I've explained,
the firmware loading is done by random processes.

               Linus
