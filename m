Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7022D876A
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378211; cv=pass; b=H1zJc4wwdVPLbthPSPsCJsNXMx8XoeAEkACvtprYL+hq00gYdEuhV4utVNNRqcrw4lfmnPr0Y+tDxR5fK7AlvgIQ6DZFjrY/NiLhZ4TWFvCmwzv6u3PCxLJBOqZZrR5lnUXeKQwCZ2foRLtSPY/yqAi/4BXYPiC8Em3+rUz4f30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378211; c=relaxed/simple;
	bh=v13IBvJ3Cs5k45Op8zhzzynqZs/Da4H7F6eGXP4EZOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTkOVUc4ejVCcrKE780SjP9gsuSNr4ZQcN8UcrlKsK9Wg9f1uQYK/MIYqSkaKYZpsOliOuXaSyx3AJIuSmHEoZKnOcR/TaWrOYmLHeYsTC5K/OcxWRtffyvMv57rLnLG6ftjhz0+OB4BInY1AIlpb2LPBARJQu+rH8je4jBCDVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aYFA5tCO; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aYFA5tCO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8535a9be75eso1249631b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 12:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788378196; cv=none;
        d=google.com; s=arc-20260327;
        b=dQwxbmOgOS4sZ7vFdzPVzGLkfJNQ0wp1rpV9zBdAvS+m9rWKFEofH4zYHgok0F8M6B
         b0N4IZxJnYYX9nF+3pQUnreXW8envWIjWK+2dFXvO7jcZHBRqGyBZ6qGaGi8QCyAj+wq
         w+iA6VBeDPy8OeTtP18qsxlJcrHiE5v6zh1zQcITzt6yQQSVu39nKvn3PrVg/+SpQoRb
         z1ZorBBsbRoYqk9YwO3QI6SD+JEHl3B79qGta8PNLK/QnJu3uc6w02RW956EhvJk2Pxl
         DT5mTKILYQSBna5yRyCLdDVA5NJmzsVW/Db2eLPZMGN4/+H0Hu9Tr0i2fvWmq+xxLABs
         VmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        fh=dowhTw/OSn/1soLM9JOef4W1bduJ6kTH6AyxE1W2icc=;
        b=LwzQO5KyeCBm04zTCSFCgjt+51L/m7YjwiYA8O/nEj3cg/Ye8BzE0z/u4OJSrpYin8
         pZvmVcmyxZsOtoI6Kl0YYO2cNh/foEezlaeGwZ7GIBadvCyn/EH5xjMEaAusDUfreZyi
         TK7irU2E9/gn4aYA4NgornXW2R9U0RcV1CKTT3dygP5zlvpnLPsgHxEHLXvVcFLEPxWr
         +2sRz88TJlpz0D2ENbMdA7zufjUvHZSS4NPeFHcuBMcGPE6fNYilQBV+QfOfRVnhO1i6
         6Wzwtxo/WSEzvZzfFdrSWPxk+/HCrJCku4Y0Z5VgyY3kuYssunCrxsTdlmiOSQkZwISw
         F8ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788378196; x=1788982996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        b=aYFA5tCOZ5UjOiabbKf+4Li2QUBDULtgqc0UtYdMcN42FuRj6wzgCLFhAKAaI60NZg
         7u1Eli49zAV6MQy2b78QDrhXqwsAAyzcu0FxEVwk7WavXov/6rxM2LcwYoEZz+y3+VJW
         UPE1ELzTJgWxSva8X0e2e1NXkBo3cCfyVB0GIATavl2RU2ZDH7e8KvDWAqlS6L4lRWc7
         K6dMtF07P92DD6er/SfN4xho3HHF40di7hzQcuudBqZKdhG7XH6aiNRsVxtH3VbzeKgV
         MtP22v903BOORWOseI5xsYPMTLbzRrrQg9QhGLpbqq1N/BcLGnPT4dTtTl6qp/VcSKPD
         sBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378196; x=1788982996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        b=BRp0yO6Ndu1Dhn1QPN33jOUomhNZxa5IjtXI6FdaqpAsZkq7lwLgPsjChjulMzf98/
         JFD9SSEf8CbTrrcBajXEQgO5I3aE5qYx9Ky3L0YbE4GX3SJpl8Ap+xVCoTtqTe8s0jV8
         pVgD8YnhpYKQWEeBO4RbESLdwiQFUGnhnjYRTp+mniuua2guRsYrOVPUPhqGr4ymXyxC
         lm6M2h41yPYSeILjFjldvTbHuV4N3pf7sNUhz/20UOdp/fF3Uglcb0ubhLBFXq0GnlGh
         t3PqawGh393IlF5nHQeoQFTCixh+zF1TGHzS2iraxoWy+8OLN2JAemOMYWHlIoWgpRex
         AcCA==
X-Forwarded-Encrypted: i=1; AKwUvBzS2p2nWyFEOIjHlxo3KMofYmSvg0nfM4rqbeKPmH4rY8FZgRMx0zY8G2UUhdlHt+wBXEb8zREiPOpfJT8XWuqsL4V+MkI=@vger.kernel.org
X-Gm-Message-State: AFuF++k5Qr3XeYRzXmIh79R19eNd3bE/7OagO18Jmutv0nGQiGcQwyem
	STdHTlPlXkbTYF9UJdgVJGfguZDImRz2x8QsAxdAxGhOOcSyFMLOw5N5ARt5MeNfVyrmqSV5Xhl
	f8mr+9AVOGxV+IoRA5mq4Nddydso/eOhC/wucKEh3
X-Gm-Gg: AYBFou3M7P/Qy0vSya1Zs+Zhhrbv9rXZopYRzmcJSWLJlQI/C7if2mRs0BnfK6I665k
	JqBD5Y0T601zHf84htMTDmlHHljHucYVl74Az2HTdZ0KIAMtYvxmDihXSsWZ4l/EVElbQAyeO4U
	PXG0qRbVIVToYS9/WwMMKzemymDhhtf88Kb0t2dB/WAcz2h2Hr9MCEVlhEZwuM2Dm1SLDAX8oR1
	G+J4US9A8cbrk59fI4XGOherTtU4w2R4JM8pcu1NRhoZ8W+QC0oQJhlZBpXsxppCajXahu9pUdk
	NTtuwdad85uNub+b2Z7I1i5taBU95MgwPBB5S4Q2QYgd
X-Received: by 2002:a05:6a21:2d04:b0:3d1:8876:fb1e with SMTP id
 adf61e73a8af0-3d9a9695714mr11592712637.0.1788378196405; Wed, 02 Sep 2026
 12:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com> <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
 <apbU8-fpioNIwUA8@mail.gmail.com> <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>
 <aphBNqQK0JeVy5Sm@mail.gmail.com>
In-Reply-To: <aphBNqQK0JeVy5Sm@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Sep 2026 15:43:04 -0400
X-Gm-Features: AcwNN1XYNCXydNpNM6ZU2Rnek6l8sLmm3paMheXeGevlLusJ85KkWm2it_ZUJS0
Message-ID: <CAHC9VhREB2krVp9XkV6Psp4PWhYT14281+1TQUZL7o+GTo1cXQ@mail.gmail.com>
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

On Wed, Sep 2, 2026 at 11:20=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> On 26/09/01 06:15PM, Paul Moore wrote:

...

> > The core issue has little to do with BPF, it has everything to do with
> > in-tree vs out-of-tree code.  The BPF LSM is explicitly mentioned as a
> > "pass through" because some have argued that the BPF LSM is in-tree,
> > and while the basic BPF enablement is in-tree, the actual LSM code
> > that is executed has thus far always been out-of-tree.
>
> Yes, the actual code isn't, but all the building blocks are.
> The BPF is just a sophisticated policy language, in which,
> given, say, ethtool hooks are present, one can say "block
> all ethtool ETHTOOL_TEST_CMD calls for the XXX driver" or so.
>
> Is there any way into turning BPF first-class citizen from LSMs
> point of view?

As I said earlier, the important part is in-tree vs out-of-tree code.
We are not going to add new LSM hooks only for code that lives outside
the kernel sources, regardless of whether that code is written in C,
Rust, or BPF.

--=20
paul-moore.com
