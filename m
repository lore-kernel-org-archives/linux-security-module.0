Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0623EAB2
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782436583; cv=none; b=j7Qww10kD9p8cxahgOnFjdmyHy3HBIhi2DrWADwbDpOUzfo6JYkj08q8U2tplOGXcdkvSsRjwa1BQZ94bGpYJIHTxmuOwhUsS2zgpqWzM47CV6bdTp1tHz1ByQaRc11lhLRqKXUczN5l1mDaFkHvPCH8+RjzsBSR+39kHrIo+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782436583; c=relaxed/simple;
	bh=D3QLdIwcTLbvEMGa6o7s5PeH2U5jQkxYibBM23F2Eu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SbWHZkappb2mqwYOo11rW7S7e2hWP9T7bkYIMYsHHRU/xpV0lfzYRCKvQHcQdcoizKA1BViSRbV4poWbc75pgJO3e6A/K6Llh9T+CZwFyMvQ8hltFNlUGkr4sM5H2ip9m7czu03/ho1q1UMNEo7RE1CC5eoeEPOlyT0yjdzqMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwqQTs1X; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwqQTs1X"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69e1f777bcaso290240eaf.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782436581; x=1783041381; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcbI/5B1iW8Uz0z0g6fi1QMHurwlhgv33YK9epdk51E=;
        b=VwqQTs1XBVtVqyXINRE5bWM/SFteW/6cr71HLznX+NNnGxize4uWEByqm4IcquWlIp
         V6p7T1+7P3EXfkjEuF9QJ8f3oiBzeh1onpJKJ1rOIyJRgdLtKpi+GdSLkuAmB7BL7cT/
         v7u3ZYV6bf23cG4XLzohc0QRZyY+3nIuNsSLLdo3qjfc92zO7865MmcXSIVssmeBUsn6
         McJyVTMFBxcBPb59CsAifa6976uT7yDXk9bu2AMeZcumLkkGuXcbXB9HyWYo71Sgx9w0
         QKhGFI56rQ4TehHsQj0J2cWOqAcBvCc2lCiXVgKJXk7r1jMRADYZxSAOZ45kYgQZJLmH
         +ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782436581; x=1783041381;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcbI/5B1iW8Uz0z0g6fi1QMHurwlhgv33YK9epdk51E=;
        b=ivxONlOaZhzAeMPpzai5n3lArZUuI/rDYt3XFzwdsYGCaGBbH7BCkk+vtfzFxOp2tX
         bDDm35sm8SkzvY6OSOHyvRrxXATNQxUAoN4GdQM0QIsVi+3t6xvLe/Acypigp++ZkB3I
         EstoE5poyf35IL9H7xHPiKxlLLyoLz7gYsMDYyLgWn5vOqWAPCCh9R94ujBaGLszvlAq
         g0JdkgIgAQBr1JDDnU315tgZzTkBr2X+BaCip7//JKdkvqvNrauklNL1yDaPv0zQy057
         iLV3ZWR3//g4y+LC9VzjWzJ5R2d+BogmXUJ49uZEttCKnBCK2LuM0wriF1UVma5kkUgL
         uZCw==
X-Forwarded-Encrypted: i=1; AFNElJ+IUk6NiqLf+aVD6qnN++oIz3lfu37K4t7BF58e2ZTqG5+8lc4nlReHLFjg5fLajZprOEW4ZKRl4A1a8O2U9CQ/ShMKbcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaumcmPyF1DObTr2uPciY0JWRXls+9Mkom/0n+puQMZdR77+E
	bGjcSv6xbQUZb+MTaOanrvZiTBjcWuKcJ8Zc7Eba1qLbb9fURoPGOho+
X-Gm-Gg: AfdE7clWuP03kgV2s5i1zEG7XkpZEn8oiQAZ2qcGiFnKesN1ikqLyd16MxVnaOPIPXa
	myuKh2OaeBh0NytO8aMMrF+eMKiNdnrNyDhg0FVSO/gTEXx7s+hZwedmzzXYhiKqjJ7SNElFlAq
	I1H2Tn/5P5cGUCmHfExs0kfOlL2SUhgP5dJ61pffq2gE4T7jHxGKZHO6Alqe2zoftYg+7WnGM0T
	cGoQsyi6ww5buMTzU9OS86jehdvXH9fMjXkecQKn6XPaasQytYriHwXc/HSKh8bmCTWUV9sT9Cq
	Hvv3dbkAWOxZdzMeBCcb5nFHzwOmxUDy6u6xbtVUxPHj54BQhznHbQRZSRk9dhiSO401y2s4NVB
	z4KHh293/cx3cxBbiCieFMEZfylSQ1e1xkLMBqwcvhYQA/d0Buk7opZQFIh/DNVz5pnV8pr5vBP
	JCDauhBn9oD0Xu0FFXHHkCDHxFY/rrui5LP7mPSqZHEYrHU1H/GiCcSbnfveM7M0TEQ0LGkzV4u
	IlgvFk=
X-Received: by 2002:a05:6820:2019:b0:696:1a98:bd5 with SMTP id 006d021491bc7-6a1343a7382mr3098209eaf.19.1782436580800;
        Thu, 25 Jun 2026 18:16:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a1415266aesm457275eaf.15.2026.06.25.18.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 18:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 18:16:19 -0700
Message-Id: <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
Cc: <ast@kernel.org>, <kpsingh@kernel.org>,
 <James.Bottomley@hansenpartnership.com>, <bboscaccy@linux.microsoft.com>,
 <memxor@gmail.com>, <torvalds@linux-foundation.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260624140301.93421-1-daniel@iogearbox.net>
 <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
 <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net>
 <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
In-Reply-To: <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>

On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
>
> For all the reasons I gave previously, I can't support moving the
> existing security_bpf_prog_load() hook at this point in time.

Paul,
it's not up to you to approve or deny where security_bpf_prog_load()
is called within bpf subsystem as long as it doesn't affect behavior.
Daniel's patch doesn't change observable state from LSMs pov.
It merely moves the call from syscall.c to verifier.c.
So we're going to proceed.

> I'm guessing you still haven't looked at Blaise's patchset from last
> September.=20

Blaise approach was Nacked because you guys ignored TOCTOU issue.
I pointed it a year ago before AI was a thing. Then sashiko
pointed it again and the bot explained it in detail. It was again
ignored.

Daniel's v1 sadly had the same issue and sashiko spotted it too.
Hence v2 is moving the location of security_bpf_prog_load().

> on-list.  As you can see from the lore archives, he has vehemently
> opposed the approach you are proposing for quite a while.

Exactly, because you kept ignoring TOCTOU issue.
Claiming support for signed bpf that can be easily defeated
is a shameless security scam.

