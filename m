Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760392EEE8A
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216143; cv=pass; b=M9fiAw2ZGrtfhB/HVxJAeQVo+my0FIfmraxfIQzShyxQCR48Nx6mZD8gbsr/EGv7rw5vU1W0C/EGCWVGgOwUFCz1UJCPw9BT0ZUsTLXzTHOGHvf4aW3ej9N3heIEUHk0UmrZtLauZM0KIIjPnAR9+K3D/3Zmk7YzJNe3zkbL+Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216143; c=relaxed/simple;
	bh=u2srwtIURoWJNKL9GOJUQTifUvW2ecbh8OdnwhyADKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9DdhuhTDbYwbfcFAajIo5uaBhnsgj2jEe6CWVTB/ghsBnBALdLwhtu4yVFQRKS+frfj0RtzzHFNt2HdlAJN3VBq2R5kYkOluaHJ/HIXtrQ0mPERtyzbPHVkPZ+jSw96hd2JPbh43h4mjuBU7ciIpHmEd/mvsSbcCM9OA2h5p9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c1CQdwvh; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c1CQdwvh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4168718a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 15:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788216141; cv=none;
        d=google.com; s=arc-20260327;
        b=iWbyI9pQtQLfNALJg+70Ug/K4n6rjT6muc1wZbJRRpYf5TO8O4nLYi9cUiMGFpSNIG
         gcjiehsBf2FL8koD9kiK2Gu7wsPOJx/yartTetT4R8X5rpKYcObiHq0ucFfmVdpomR+G
         CvrMSPzrK//s8gktK/i771LmajopfbyR5P3+kaEfi0tesNrMABFiDSnWP2mGet15pSbe
         6YuAr3T9HusAX7Oppr6GZGEvH2lyMoH0MLGsO+2JY1rVusifxCybnmUs6ja+StsMk1Yu
         2a8NpfJqXDXhcnFy2KtugXk1ahqSdyUlUkHudPQDSoUk/DeeLftbOVb0CfKTAY27QvCM
         T6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        fh=Suv9HGDvAAOH+ZneQpwrZ67UDWV7Fivxo0ABk+qQnUk=;
        b=o/kPYMppUPO9g8x8hYbK556cwONwtnzDgnDifUQfSPO0x14i7ilZ4jpArpKwheKWYW
         sIWV/MMDXnPtUXisUc0ixs0N4bvN4NfGDc5IceQoihqHKwH3rgjFH/lWkKISgKbnux4U
         yyhV7RzNlhuG8v61TQA/Q2ShX5xcACRKgctGp0W6Qw7IxjmkJAPMb3ElokFG0HSTwf1u
         PdYrr+HSsuaf98uSOf+OkhqSYYLB6+56kwZUA46GXDi+tIhTxcoDnuhF1iTQ+j9F1YKN
         YqZhzdvw+t7tYlHvsU3I9Y7c10VI3aTT6PiTTTAN5BrUTOh7PmeX6kkB5PnWvlnWJN5Q
         9qcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788216141; x=1788820941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        b=c1CQdwvhuHPaR1kj1yJsymkZHoVBtWUGSZL+YH9WDrc2IVZfW8BJuViw1xfnlVvCxZ
         8Sp2/tgSgJKD4+qnEJwFUiTjXekz0h0Fxir8zOvhxXbuRgz70hHOTXEvyqR94GdhQJdq
         a71sWc4v+5a8MKIcxhLvD2RkO+bGv6GWolo5QCfiPAOBTNkJAxh6i6lIdqhjbupwPl8s
         IaCew54tSThOP6a+lc+rUnN136LTCX8KoFxnDLVaiYqgBgo+OWLMVIlOATJlu6k2a93N
         WuqnjN6BDi7LT4ldz6e42P1AVAB5al3vwNm3sED8y1pXw86cfYWwVkkFNOf9MIkZLkEY
         dK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788216141; x=1788820941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        b=i5N1tJTWf1JAmhh0kg/bdfyA0buS+p3igQx5eT8WAZc7sUWNlgcA8ArmjpTjEpHN1j
         lJ3fCQVU1W42Xc36+pzOd1GIUbAB82juZBSq7G++CHqvVhJz/bbAZePZQpvX1vkXy/lK
         zZ0mWbdyl38i+Nd7LL1nSjpWL1hQBiJU2B5oD7r4p2PUGhw7QP3tJ2e6a7FISRwGKyPL
         WbBBs+9+I836o12QHgS9IB4W/1yjpYakM7X9V2IhCnTb/lQag9OS8zPL6+fAl+nAVBNe
         p2pXmuC9ar72r0WU3SA/KGEasGSwhvqwhybE6idoPfQXRm7iunAIoHu+MGDOq+yqOL2P
         dbPg==
X-Forwarded-Encrypted: i=1; AKwUvBx89LosFk6vFdcktVl1ZK17YRKVWb/2AbBAaWu1W6aWUVY3nn7siPFiFFLbXlZ+OfPMTXDfcq0fFZyoEzeNxjm9WKCW9I4=@vger.kernel.org
X-Gm-Message-State: AFuF++kzn4FxU6CC97jTij2BejwHJH99GTY79M5yMQh0KrZXm+uxU8el
	8g9z9bHpEqAKgJzyUOzTLg3kmsCm99GuYO692/5f6E/FT/eGJrnY6MTeDGK+YVX2jwDKJGAcn8w
	q7YpqMOnijnEQBuu1beKpNFbA4sn8dq6CJAB56rxZ2II/MvMeIAU=
X-Gm-Gg: AYBFou0NO2+8hd7fgRMILn9ogAqSgFup0oEtRiezzMKrG+dUXS4VBeOftitVswOfm8d
	QeC2YNLV5M8rNO6+eht8l8S5ZiQ06o6etwVzYWOVAaCc0VBkeDXljAjN8Rgys3qbLYN46jiu0yY
	DOM+a+SbLxOywWKo2bg/3LDgtl7vt88ErOYXnWUL2eX3RNkbQpWpDKadXNe9eg+GM9CArT2fWh4
	lj1T7waaAPsqvrhd67ftxUfW3LeiirfiQD0Sm3A5e7v40yG4dGpwghy+ZPcvk5N3LOy20l1XcO8
	e3BnOREnnI8WPFYoWqj6Xg2naTcK/xFtqXJy4J/salwq
X-Received: by 2002:a17:90a:2ca2:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-398bee5663dmr14737593a91.24.1788216140807; Mon, 31 Aug 2026
 15:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com> <20260831110934.241898-2-a.s.protopopov@gmail.com>
In-Reply-To: <20260831110934.241898-2-a.s.protopopov@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 18:42:08 -0400
X-Gm-Features: AcwNN1UCNECLFYeBCknRn3HYL6duonlMTll2FvhXvryaFxITMxED4MtxRIMPUxE
Message-ID: <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:59=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The BPF LSM programs are allowed to attach to LSM hooks, all of which
> are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> of view the set of attachment points is defined in the bpf_lsm_hooks
> BTF set. By analogy with existing code, add a new header file
> <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
> BTF set.
>
> This change allows attaching BPF LSM programs to more functions.
> The actual hooks are added in subsequent commits.
>
> Each BPF hook calls a [__weak] noinline function each time a hook is
> reached. This may be too expensive for hot paths if a BPF program is
> not attached. A future commit will optimize this by adding a per-hook
> static key and inc/dec it on attach/detach. This way disabled hooks
> will be bypassed efficiently.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/linux/bpf_lsm.h           | 12 ++++++++++++
>  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
>  kernel/bpf/bpf_lsm.c              |  2 ++
>  4 files changed, 21 insertions(+)
>  create mode 100644 include/linux/bpf_lsm_hook_defs.h

Adding new BPF hooks in the kernel is one thing, but adding new BPF
LSM hooks outside of the LSM framework is likely to be problematic as
these new hooks operate disconnected from the LSM framework (callback
and LSM kernel object state management).  We've seen bugs in the past
caused by the BPF LSM trying to operate independently of the LSM
framework, something like this will only make that worse.

--=20
paul-moore.com
