Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7732E336C
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135217; cv=none; b=t02w545kL0IqxqqNkquiWLG1GtPQy7efNmdBL7XKG3/h/RHPWoG/UwnOnU6SxNfwtwpRGJCVoPDo96Q0MRbNpLW5WhrE9tRwfHzZO9ORwfWWUMP2BSMUxwnN6YiFYBD0r3iYHAhls/EJ8NGTug9RtbEY937jF47SIW9ngOrY2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135217; c=relaxed/simple;
	bh=8KEjXP08gAH9mtHlZwTSZJHkrRvWvyV0abRhH8806fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFzo3Mto9pXqihuYXz/J8dhI5E/hB5FFD3KOf0me4W/Pd1wKAyYo+MK6T+CVGxBUOOmSlmyX7EpQtEHeNqsFQHPmG5xm5CRiTO+DnG/EbzEseVwvezHv2iXLR5BncWICxpXihRLScUvp+xn9cmiIDu6vv9jgifnG3paOpsGISzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LYBkBoct; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LYBkBoct"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so5305430276.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 16:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741135215; x=1741740015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLByKeK9jbAcIudXTB8h4/g+eKrBdZDjVDhHL4wGDkY=;
        b=LYBkBoctszf5rC2eNNrABPFqPNlWLnGPtCrmPAusBquV+EryKb8A1dvWiljC9Rn+hV
         kRELiQPMw/E8sYsPnvn/tSbrBuie6kxnJuZcSqtCmUaWbGtZWf/cj2EbZkgy6xfS2/D7
         C1DiH52qG9CG6e7kDNY7x6zXDtzMMFfGcn9e4q69JHr1YHXLssTqTq5pHeg06ZFJuu4d
         NyOC1FY4GBYEH/y0QDZ499MtiCdozx1VCrxY2HCyR1MZ3PnKwXaHDbBGnrL0KJzoYoIl
         1rGlsDgmk2ZvKNd2rFtyCpqVNUodm7/LuMHlC7nK+x2mTie2SXOh7qHk3WNRQAhmJfA0
         t08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135215; x=1741740015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLByKeK9jbAcIudXTB8h4/g+eKrBdZDjVDhHL4wGDkY=;
        b=abUwkSb5B4Ti6voum7adYjLdNIX+fVHQenfyg50iQ5vyhmQQ1nwVkSZVdERytrVYvC
         FRvexF3qCN1iyIZGV5lPiPQsQkcjrqMOAP3jKkBid7ephj83mIxMO4hVPa/obXjDUd1y
         aSmbVm1S2JsR4aeuR78+XiqDclcqmR37SB1adDm15YDVLKuaIHGRfHcy8rgmAYdVfhsD
         bxNQI/i3DQjJogue+EzVOHEoFIqufEeyPXFCIl42cTtXWONiQ4bTTyZlGA9/nJGzMii2
         Y7DBZ4vPsQKmPkkOGF5uc7mqapn6kTS+zYLbZJP6ttEaP2SbBQMerrSJWvf0rllhGU89
         npvA==
X-Forwarded-Encrypted: i=1; AJvYcCVtmHJYMaZSBAGXGHlbU3u8WKsMHZ9CSeseKhVFWvW8MEQS358Ssd7HG8VOREmYbPDKDogNnAi/tF4Van7I8rgI1onFIDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWYINFc5B203bMeekkLT5Z/RUMPbGVnYGkGJsuzK5+aEfXIAZ
	F24Q4TjU6wlY9mvLnE/WERhyibTVFTmd86k/B6MF86QCiD4gR3xjeIm9xKKZ2zv6h5YDns9kPjE
	zJaT/w+RcIdLYmHz7ADYkNaJNU+p3EsM9Ie9D
X-Gm-Gg: ASbGncv4G2mU5pfYukkobuAr+8kf1L21N5KCpK3aM0ByYT1T3IjsVPX30Pgsmya7KAG
	gpZCVsV+J0paMp1LUlVO/DGJr1Gos9bsIB5yYwBc/DjDY2RhwrkxAnT7OYU07ihm//yjFUMBJ5B
	KHDni2M44nKn63+dNprDjTZYoMWw==
X-Google-Smtp-Source: AGHT+IEzmMWOQvRMnjDkFhghROqg9lxOvTBles4ByHr5bhpu3fcrvkVJICgDGQ2HmqiNLuH79Zde6tj1J0pYKTCXHas=
X-Received: by 2002:a05:6902:2009:b0:e5d:92a5:9f79 with SMTP id
 3f1490d57ef6-e611e35f307mr1471560276.34.1741135214898; Tue, 04 Mar 2025
 16:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com> <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:40:04 -0500
X-Gm-Features: AQ5f1JqF5eg5kGEnn453gAfWw1axYxi2H7tbUtolXQD5gFiAWaVD4kDHxBozzFk
Message-ID: <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> The security_bpf LSM hook now contains a boolean parameter specifying
> whether an invocation of the bpf syscall originated from within the
> kernel. Here, we update the function signature of relevant test
> programs to include that new parameter.
>
> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> ---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)

I see that Song requested that the changes in this patch be split out
back in the v3 revision, will that cause git bisect issues if patch
1/2 is applied but patch 2/2 is not, or is there some BPF magic that
ensures that the selftests will still run properly?

--=20
paul-moore.com
