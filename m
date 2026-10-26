Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046699;
	b=R3fI6D0ggpzcv+xC5DnIVYdRai+3szmR27jDuQ/EfosaliHg5yLzygTg93FpXHXb2mmo
	 Is8C6HNiu5u87RhgYHUyNSyMHJ+N4nQ8x1wOsrmwhk6K2Nlulsft4i7npSOfV2ZpGtHO1
	 jJIVOzeRedo7Iyfa2DI1RA2O1rJBi3NHyIqAzOoVeyVD8ms/sTrCUjIYDKuclsd6w4rij
	 pELwpxpzflClJ4SlnFnb/+IOt2v06sVHZHwCDkvO3z/IGdG5SMR+6gKXog+OMdiiqQy3u
	 nRst2rVlOuVQ2XgS8JhWRvyoeyJqIaxA+EMdgjb0N/vp0Zv+Lojbv9TnB4AWgZ04g4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
	b=WVGOYnvdWfIwDAb9J9s1PrgRnAxAheTSI/QEj9c+T2OUX8BsIF5XckQTvybd9fdm/7Zn
	 dYg+kCgpkaom2s+jYXzuQXtfUyloPa6uzkV0mLz3v0/J729YZOTgwTgaSBXV2Mt87D0+r
	 zSFXYS1Y19vGPKU4fJJEt0sIWNT2bu9DjdG7Trv7rYhmxOvFDIJXcqXSTcsshY0DO3H7J
	 tUD6HNVLFIm3g35f+m2cxRcCArW5QFMYa6IFXmzeH8+zofKTN20SBZEyVS8DFyP9eEZQV
	 LMrpYiv2FaXmYuPZOfd0hExAEMmmm6MhfSUT+TIPQ/bGhYbC3g8/IKWjEZeHMrQvzjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD7606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 20:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94DD7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9e53d011eso23943515ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046698; cv=none;
        d=google.com; s=arc-20260327;
        b=dBYlZ/IK1i0KDNAgfxkP72rjbNaO5F1Hd0txB/oxunMPULw7dhsu/svgfIJ4r/06KM
         AbOVqESpV6DtWgseV8KQPsuuXLehM1rAVny62AkD+z8xPHTeBBvS8YFDDNtriIeI0fZP
         YnYFp9Hqe/JP2B63wIF0roKJU3dqetRKCGxKQ03mAqA0kJNrATk0O3BX/4R1XkiGPExb
         EdcZ2hNYuH0YXyZ7mEIT6YIwfaJCYaVAu/SDdeRkYbOLvF8mOT34Ucz5A2DbrTg0PhVS
         4JcAI0KuvxIJ36sVySjXEC3S0jvRVSwg/H0AKoRpbs/RHhqrIyl4YrYNxG69BIF1Wc+G
         k5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        fh=oRO0ALK8rfIIvBQk+jHUHoa3I+kjmoZgQq3iqCK0YsE=;
        b=Bv4FxO1MhMmc2u+EAjkiwWiDo0m5QfpYLFob+eRgk47VdlPLN5kEtvyK3RsSKTx/17
         kX9BqKgGOG8QvpZDmsrs0HoVTpqw7Bjvw4F+ZUppRDFj0RRQ2xxa+GYskuetCNzr+b8q
         o6abyrVvmXiTNM3nE0UbzEG99bhkSnb6gpqrTIQFalUrUlP3/R3kiJqBvd0hl8OLiRZU
         AmhnTrUaUERE5RQpUGZNuhmj/3n/3X72Uwn96bJ7pVtYOhZjUkYXySwoCeueEewf+5Rg
         G8iO15W4YJno24B8Gk1tyoZtbniu0DeZ63VTrMqjacc6U+LJVo8CY1E7ZaY3p6QqdhBR
         gvKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793046698; x=1793651498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=L+wootqW5T77UGOryyw3TrOnPRmPjLL2i4uoI36Fb52hAChavbUjC2oAErcwcWcJq1
         gwgn++rWkrUiN4eZmtVkxuIBOAsAZefl8wqr6EQCDZZBTjk1hO2UkuEyI8i5m5RjX7DJ
         EK1ndGeANRMX4aTbpO+nvR7fIU63VxFQ9ffp4FXCojFjYD+fdWAL9RHBV9A1L4pnrwWe
         CwArxDWTNOmGZ0DS0oKM86YGqSE9zdjWjrY330iiwsDo23ENOID23IQ7tNUIGTMjbHgT
         BUbvwez+Hzl4lCCb8TSHKJZNqHNNnbu8YjtxV98iTts8xUYoVruc0kCp8wqVv0S6jf5w
         /EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046698; x=1793651498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=uviSudMeNneFGYPX98K5qK3Zotye3sU3YEcPq3OhYS5OvXcc5V4KkUoibWiO0Ppe2a
         ogaHZfUIKzpb7JZAblUfXS5naSd2EY7dfWDJmtYQNEELHmL8RccYu2WxoezcEo2RkZPa
         ByWXynZ1Jp0gSMNGBonvZJooRaftAk75ySx1ji2IXGGEhGAuyG+apCwVH4dmVoiejNjJ
         af9QWExDhKyv6iwjcHuFM9GZb6dcuTY6WmarB5On83RRQNKN0NuH9Hxb4SbKIXsNhbdl
         rYwqySSvz40Qffl8icm86pwqf/0L09r5QXbPjSbIFn0IqNLIkLwyVtgxiF1CKIi4faX7
         kKgA==
X-Forwarded-Encrypted: i=1; AKwUvBxiy+k1KvQtgfRQBVc0N+OvTtzuA8STC8BVfbCVUv9sSyiDYjo2KM8ZMrfYUmKZ7bZyyoyYl/DMzCm6v6gatWm3f60Vj04=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsv+iVUpP0v03TiGNVb0jpUOYnJfLa0AYiR63tU87WurOARTnX
	y0KMKsbqvROxHR+H5GoIZD67nW6ITaHG3jDBlOK1MLxf9Fzz8BuwTlTJQgGA649rhC35hpARwJT
	6pxZ6Yu7hJhWMzO4qINypCyXM7MkgayaGACqqoye5
X-Gm-Gg: AYBFou1TPd/r+2U5RZ9poCtYKAyO4xj8vLbJr3itdUoVua1zg5hg6tunbU7aTvFqq84
	8G/lldNrwTW5t2itx6WA/BXNFLhYZoRCQ+1YKnCKIX2CnYWrJjgk/DI3Q0E5gYSP0mLK5k1FSiq
	F0JABIZ5zTsuAh9WTzmc38dP6YL2yIGLtxxRoHA/2rbDJw2ysH5U78lxaTZBPXDLjYu1Z1boDXx
	kze1kXY50JKBrVeqWAdm6mlp8bYhNxZnzW8aUusYDn/tIpdvi2Wv5v/S0X0aQ3vldRRdXs2jpji
	saHYsHXX1f9R0T8wgdAaifzsv4sGpebvM4C0FZ0JFXcYUfmkSl7VkNaKaGprYfSNKiKKcn+vWKj
	bzNF/w/Es5+b7lxZy4WZjd+VZCCM4FndQLM0I/RwjpvwCUgLnLBGbyKcba6IInjzgacwBVfkGsu
	71P41PKMIIOJAA8Q==
X-Received: by 2002:a17:902:ecd2:b0:2e8:30dd:523d with SMTP id
 d9443c01a7336-2ea9c620609mr71569325ad.13.1793046697876; Mon, 26 Oct 2026
 13:31:37 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Oct 2026 16:31:25 -0400
X-Gm-Features: AclHuK_MBYtdpmV00LiIGiHwgdDyciJ8YZFfqnRLK0ynU1qoZWOLvejR9vdc3xM
Message-ID: <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:57=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I tried to switch systemd-nsresourced over to the namespace_free LSM
> hook that went in this cycle. I explicitly developed it to work nicely
> with that. But the version that is merged is broken for that case.
>
> The namespace_free hook is never called. security_namespace_free() bails
> if ns->ns_security is NULL and that's only allocated if an LSM requests
> a namespace blob. Nobody does. Landlock doesn't care as it only uses
> namespace_init and namespace_install but a bpf program attached to
> namespace_free never runs. And it can't work around that either. We
> could make the bpf LSM request a blob but that would just be a way to
> make the hook fire. So call it unconditionally like we do for
> superblocks, files and bpf maps.
>
> The bpf LSM also marks the arguments of namespace_init and
> namespace_free as trusted. Curiously that patch was also dropped.
>
> namespace_init is called before the namespace is set up and if anything
> fails afterwards the namespace is freed without looking at its reference
> count. namespace_free is called on the way out. There's no kfunc that
> takes a namespace yet but once there is one a program could take a
> reference to a namespace that's about to be freed. So add both hooks to
> untrusted_lsm_hooks.
>
> The namespace_init hook also always sees a namespace id of zero because
> the id is only allocated after the hook has run. The id is the only
> identifier of a namespace that is never recycled. So it's what a bpf LSM
> wants to use to track a namespace from namespace_init until
> namespace_free.
>
> The inode number is recycled way too quickly for that. So allocate the
> id in __ns_common_init() before the hook is called. Then ns_tree_add()
> doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
> Landlock keeps logging zero for denied namespace creation because that's
> what it documents.
>
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

From what I'm reading the LSM framework patches don't meet the typical
LSM criteria for stable/RC fixes: there is no serious bug/panic, and
there is no functional regression from a previous release.  It also
appears that the existing Landlock namespace code still works as
expected.  This looks like one of those unfortunate circumstances
where a new use case wasn't tested thoroughly enough before the merge
window, so it can wait for the next one.  We've already identified
other LSM/namespace issues that are targeting Linux v7.5, the
security_namespace_free() change is one of those as far as I'm
concerned.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (8):
>       lsm: always call the namespace_free hook
>       bpf: don't mark namespace_init and namespace_free arguments as trus=
ted
>       selftests/bpf: add verifier tests for the namespace LSM hooks
>       landlock: pass the namespace id to log to check_ns_type()
>       ns: allocate the namespace id before the namespace_init hook
>       nstree: drop ns_tree_add_raw()
>       lsm: fix the security_namespace_init() kernel-doc
>       selftests/bpf: add a lifecycle test for the namespace LSM hooks
>
>  fs/namespace.c                                     |   6 +-
>  include/linux/ns_common.h                          |  16 ++-
>  include/linux/nstree.h                             |  29 +----
>  ipc/namespace.c                                    |   3 +-
>  kernel/bpf/bpf_lsm.c                               |   2 +
>  kernel/nscommon.c                                  |   7 +-
>  kernel/nstree.c                                    |   2 +-
>  net/core/net_namespace.c                           |   4 +-
>  security/landlock/ns.c                             |  11 +-
>  security/security.c                                |   9 +-
>  .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
>  .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
>  .../selftests/bpf/progs/verifier_lsm_namespace.c   |  38 ++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   5 +
>  .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   1 +
>  16 files changed, 314 insertions(+), 54 deletions(-)
> ---
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> change-id: 20261026-work-security-namespace_free-7aaf89b5b00e

--=20
paul-moore.com
