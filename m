Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475973;
	b=y9igr1wnXLopVM+OlfkeV2WJ9pLkF+wYFyNn7mLdfXS+1+BVuNVpPc8zJ8hDS02wSngR
	 yG5I0rRVxzOVc/uR+ptafUOzzTfz5/X+oY4CSUKWhCT//04FT1M/yCsm9yy3BEd3UB1NQ
	 UzUZoOgsrgR02BJwQcDnhHNY5KFlfcJDFVMPb56WiUyfQRkif8EfDQ7s1kgOXqHAo9vNv
	 kMsKsRD3uonSQ+Xpt8002WyZ5FZaFudYwVQ962I9ewk/9wpYpGJRDGR19m3VJNguH/Szx
	 SjFx5tt/fzLPks2jg07/ri5Ej9SsdzdIEN/UsY/UuaOP+STJjQIvF3XPol26XVNDnRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
	b=glj7r/yYYlpOJQkcMGv1j6h8ifHCJdfOVWJnDtavDCY2hacDttlRofC7CJTPNdp/yQji
	 a8jT0vvV7pzHd+90CfVROuU7id55SVY1K8+1MhakJsHmiR07fply/4Gym4qgfU3GPOZhL
	 r3tvRFAQ41Nrulj7S/3MwyD3E60+Q68MMS3+Z1ImJqQjoMSDj9Ufdx/WhrIyvMHDEfBkg
	 UkAYLv7gmpyPzIxkardIg368JkSg+1xUX20p8y5LA5QYX1uTyfPrAxdPKXd2Gtp2OcBqI
	 UNGxUiYxmWIxdqlV7UEYxjoMKLyNM9xK/pxSbwF4wMOgtgGHPw+jnAxJ5u+SlHtd7sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YhXtktK3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20469606A326
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 23:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20469606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YhXtktK3
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1261367b3a.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 15:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475971; cv=none;
        d=google.com; s=arc-20260327;
        b=H+6e2Qd6Ucuvy3sO3VT8iLbaRsKdsU72Ubs0Xk5labxYnu+JfmqvBspwj/hsRQM+wX
         70lX7+PVxk7zJP2+MmS/b/JbskSFlYtpMoC/NZ4bs2OOqHpNQ+YKl7K8v3naozCNBqKo
         r1OSVHQsAXGndwtUkaO6FSU8JxgJfgzoJgBUSIfyRnPSNkcpCDitTXssziqweqpHNBVf
         hKu9dbhxHhGa2AnLVKVgncxNSRbyvbwONbp+zkTyjimqIL0feMGsUHiasv5Gx+8cyFtb
         JVAFK8o+8ZiGVekaZrXC8yPc5/iFNf92J/fuO74aXhe/FHR3Xmv5Fy6DXh4KGId6PPbG
         GKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        fh=RHS54fyBYaWtNZMTyP7CLA2Svi/S3gNtj+o/m8rYX98=;
        b=QS8BmMNKgntQlYJ9UZtVopvfkoWuUrjfTK5+QKT45TC1v/pcSziPDYmvIInH8oGR7h
         vqBx3iIB50b6SicY7412GfvKLZjsNEo3hSZBmCGT6Pyz0Q0cQOntkMtcYrNrr9I8yNea
         PUfgHnZGUOKy5ZIQ9ok5vQ9R3ABpZ4KRLQSFuT9g8HffZmNGowNufGkGsAPzaeL5fZBZ
         HqHiCzMJdhveLCRFfaWSgsiYIPT7xoAn5FgRQW1QEI7u91Wu33He9XQKvA1OuxPVrkH7
         MIRg/fAWxD2T4EoPSWQwZPzRvEPTbI0WS0Uc2ueridyGXOJiHsZluNbhY2ClWyC4vJSL
         tOCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475971; x=1796080771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        b=YhXtktK3TaxHoEAlQRblBl5NwaiIJzMRG08xeTEasVOlhXF9VzuYseXJhgLWW2EHGt
         JukoaxQupFfWcUqLaF5oxSvwZynvmpg5wICI4n+s01aIPBDvOkU0KbknfNARAEWMBVN7
         OKYXJaegBPz6ilzvzpEe6ACY1YEwIQVhkcYg5inow+PiZfU/wA6/6QKhD3ePBVWJhPrL
         ERwCuv/jfq+xLZhDIsBTa0sAaLtawlsX3BJ5AfDooQoz4b2oyft7coosdea7B7X0T8EA
         b4VjDkmEl/GIJJrySearV1rDJhdFqmMygt7PmizPlzGdZTWHEWeZjplLfY0n2sMGlpjv
         8/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475971; x=1796080771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLhWqv/VagBjB5zuhR0ieKg5bnQX3hK7LoyWZzsgt5I=;
        b=T+iIF3k2blKfF/sdLXdTvwNSrRbfCiQJMnX+VLgQINzffb2KEvNfHQMqqWytjalfjn
         evklXpRon0pH4BbvokOXAOfJ/QkPc/w5UGOJi8zAmgMHfXsNxmMT7Wfn4idW7xxBVMIJ
         M9C7wmA84ONH4lJltIeElbm3ZA3atVBIxc9q2EjdmvARDFiUbEuh4Do4l4HM3OaPfeMx
         YT5jYh0g/fhN9ebNb1g9NBTcH66w1NWocOCakOqO1F4q/B9Ug/zfO96Rz9U9HnbmTPqO
         49zON0q0eDDBoGi8lLkN9/YQaE/SoXL9X1ZaShQrbjRORG7s+NOgT0IsNTJDAI/oXjI+
         6AoA==
X-Forwarded-Encrypted: i=1; AL+hErFCc41Uh7q2Y+kjx+98RadoKV/XRlkI2RWDPbBwZgkf10K+904m9TmC6s3EWFVzFbHBHuKf9AenNJHFEBn6d2Id3JdbstU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jCLHNZl5k5ak3iWPlNRuj/c2NPtwr73IVOyAL79QTSZyNBe5j
	YhrtvI133fwJxS8uc6qqkyyV2OVpCgUI509oFau8mSS1IicQYEl9kWbvuWyqqyT4MGkOjIilCZ3
	+h3f/ANOZ+WTkpXO7p26s80//PXiYrk/nwAGxmqrQ
X-Gm-Gg: AZFdTZczkDu5me/aO4KD0uBYGyS14KTPuz+2wk38fD6XPT/+QGuDbOUOr4YvmPmE08c
	9osN+O/BY9F6wB+pBL1DiOnVR68FgeY0DjZN2rXEw95QrUOoQo1svurib5V/zJdwFAX2dwr0RVD
	YbL6qKpklk+6PJq33iiEi4svSPNm+v1dS5pIZ+CM06CfZbXP7o3u+1ssecaqHoGOFEy6hK8fKdY
	oSuU9ieAzodne8WnOKy6zoL+CIAhr01U+skBLLrgLfsc7GW1u9rkOXEv8CUlJ8InBbdJjTq/5jd
	YpxGyPWjxDFRZrPjB0JbjRJ+zGjyZAwTr3zpV0UhfxcrS1G3Ir4EMLuLyqXfnnbDKBtyLgCKJCo
	qW5jWcv5azhHUJY1q7O8v5mMwY/fZfowtgMySvqWJv3K/VmiNyRiH9kS3JRPhK/ivfkmsJg==
X-Received: by 2002:a05:6a21:7111:b0:3fa:f23f:a1ef with SMTP id
 adf61e73a8af0-4014da5d430mr11922129637.61.1795475971432; Mon, 23 Nov 2026
 15:19:31 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:19:16 -0500
X-Gm-Features: Aa3M54pQLfC4vU3-6-r9j0PdP3_OAJ4uOdt5cmk3KHNndD-uhH08FyqH6wqPWRk
Message-ID: <CAHC9VhSq+VXrs-M0ezGGW66d=-w8rjqCggpnS=ORiRZwMRPdmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ns: allocate the namespace id before the
 namespace_init hook
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Currently the namespace id is allocated only after __ns_common_init()
> has called the namespace_init LSM hook. Most namespace types allocate it
> in ns_tree_add() right before the namespace is added to the namespace
> trees. So the namespace_init hook always sees an id of zero.
>
> The namespace id is the only identifier of a namespace that is never
> recycled. A bpf LSM wants to use it to track a namespace from
> namespace_init until namespace_free, e.g., by using it as the key into a
> map that associates data with the namespace. The inode number doesn't
> work for that as it is quickly recycled.
>
> So allocate the id in __ns_common_init() before calling the
> namespace_init hook. Every namespace then has its id by the time it is
> added to the namespace trees. The initial namespaces still get their
> fixed ids, either statically from NS_COMMON_INIT() or for init_net from
> ns_common_init(). So ns_tree_add() doesn't need to allocate an id
> anymore. Ids are still handed out in creation order so mnt_ns_loop()
> keeps working. Mount and ipc namespaces already allocated their id right
> after ns_common_init() anyway.
>
> If creating the namespace fails after the id has been allocated the id
> is simply never used.
>
> Landlock logs the namespace id when it denies the use of a namespace.
> For a denied namespace creation that used to be zero. Now it's the id
> that was allocated for the new namespace. That namespace never becomes
> visible to userspace but it's the same id that other LSMs see in
> namespace_init. Update the Landlock documentation and selftests
> accordingly. The selftests can't know the id of a namespace whose
> creation was denied so they only check that it isn't zero.
>
> While at it, drop ns_tree_gen_id() as it has no users left.
>
> Reproducer, 100 user and uts namespaces:
>
>   bpftrace -e 'fentry:bpf_lsm_namespace_init {
>       @[args.ns->ns_id ? "set" : "zero"] =3D count(); }' &
>   for i in $(seq 100); do unshare -Uu true; done
>
>   before: @[zero]: 200
>   after:  @[set]: 200
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  Documentation/admin-guide/LSM/landlock.rst |  5 +++--
>  Documentation/trace/events-landlock.rst    |  5 +++--
>  fs/namespace.c                             |  2 --
>  include/linux/ns_common.h                  | 16 +++++++++-------
>  include/linux/nstree.h                     | 18 +++---------------
>  include/trace/events/landlock.h            |  3 ++-
>  ipc/namespace.c                            |  1 -
>  kernel/nscommon.c                          |  7 +++++--
>  net/core/net_namespace.c                   |  2 +-
>  security/landlock/ns.c                     |  3 ++-
>  tools/testing/selftests/landlock/ns_test.c |  7 +++++--
>  11 files changed, 33 insertions(+), 36 deletions(-)

See my comment in patch 6/7 as it impacts this patch.

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
