Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F8148314
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140892; cv=none; b=qgW7YFfhAtg006OkggWnlyavd4NPMztDG3YKoU8RTEbuHlPtoOvL+KOQSYLYn2g0dhFz+nPq6odG2AC08AsLg3IBooE16PBfO4+xNliiJliUQEyY132Q7g7sGaSo3AVHiCn6Yxj+yUgVDZUBS1JmPYE8ulyvXwxSUl1V5OzpnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140892; c=relaxed/simple;
	bh=qQ7kaU1aXWa368p5QkZafRlvPh4Fd0DUTFztungHHGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6wkVgCUyUc+Roq0TPYPzsh48eoW2Wa+/TpQI8aLgzvK6exJwGuXOmzPThgvRxOrZAtxEuMyGHRwT8CaunARlZtQTF02aVciWEZa5OSbyGpDVxunoT5+d6apjI53OzN1BaufCsd5VYIy2eBHeh/vjXgGpO+ejqjeHGHLnuyv+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HvgnQkLF; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HvgnQkLF"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e60b75f8723so3433281276.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 18:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741140889; x=1741745689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=HvgnQkLFwLcFLN4ZPi2E9d9WKKyDc6LC+vLKHcTJjkm4MgWYNtfSRnmZvkZ+ONpDog
         zSI6yu69Lul/YwLMxM82+pJ9XhQnJsbzF29fGYrTvf78PCci05yYK5z3rczvgGFtC1AP
         XJTbPZXmlOMgHxvRXsUlEyXZlCWlSG4yX0d94YypbUjbJUNsorCJnIPR/XQWrOdvuIZ5
         eufCuoFmoepsQGlDuHfAcARmPP+r2OIqiQQBbrzPj1JKmk1skk9Bl/YVsnU5Pa8TwsWu
         5G5N/rDRqNe9Hz15dFNo4GobJjW1vuiy4Ij94xzOJv+iMNWx78QRt9jdtjmHbNyEjIGH
         aRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140889; x=1741745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=VlnS40tAORldY18Dt9QnolssFb9Tyr3V2yAI9nlUM+DP7Tf+ZfAHc0jlMjf/DBctOr
         mj3HpTigFx93ZGd+63qXUKSqoaw9CyAPA/Wd2Rs4zc77e0Tl/MKcSxeDltEf7WFjNAwK
         jTgGafuL41A/azGBv3e5C/OtGBReZ/A0EBc3DDluy0dSkI2HzW8wBAUDxl+O+ku5Hqfd
         aH3OOc4boOimPNOiOmyBpgFODi85A6bhomNuGnQXGs97S4lluO0BBJgPYtgEK+zdngQQ
         2m2PGfWF3qyV5VVCHztN5AhVvf/2CuPYBVfuD6yZOpG5HYBeLlQXxD0AwOyy+BWctcVE
         SMIw==
X-Forwarded-Encrypted: i=1; AJvYcCWCf+H+BjGZkz6rqG2lK3GASBVS3e7hJkRxsjQnr2zkfRpdsrKWxfoVhmjrgSoRriTGnyp3GDMcE3tQ6RAq4cAB72jVuPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ95xw4eyeEkaPtjEH1XHxwK+FAyUP3a+I21HvDILT/Qe8gF1A
	BZwkfGZoHo1xDwLIQZwsMUoogV/CdoLwIchHzfjidkCIoScbmr6bunDv1EsKUW4sVJVK6+mcFGG
	nCtw8Muc3dF63Xl+BbTuTWus7y6QJAfwtYruT
X-Gm-Gg: ASbGncukaQ3p1u/gZ7NC4MF6qZngPF8VPcArqe5EpNyXZbJlOpPszxjPkO6jdgyXKk3
	EoV3RHqTopNBXfNIM0YHhCjjvbCPGEB33jCPhbOKqhtSd6v9rNH2Ipxpl1r1psUllZ0e59NaLvU
	131dW2EAl0qY+I79WIL2fio/7HxA==
X-Google-Smtp-Source: AGHT+IFJme71+h5rqacVhXNFVVflQX6fN8c82oiacs7z+wy8sz5kKm1uZj7SdqykCNgwPKPqL++9yJVZA6PUA9xV/X8=
X-Received: by 2002:a05:6902:120b:b0:e60:93c5:9b1f with SMTP id
 3f1490d57ef6-e611e19a06fmr1861920276.6.1741140889157; Tue, 04 Mar 2025
 18:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com>
In-Reply-To: <877c54jmjl.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 21:14:38 -0500
X-Gm-Features: AQ5f1JphmYgOBnsZGxupPq2rhiEO06B4bjDitVWyy9PS-JrQ5h-eCAMlWkvCD6Y
Message-ID: <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> The security_bpf LSM hook now contains a boolean parameter specifying
> >> whether an invocation of the bpf syscall originated from within the
> >> kernel. Here, we update the function signature of relevant test
> >> programs to include that new parameter.
> >>
> >> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> >> ---
> >>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
> >>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
> >>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++--=
-
> >>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
> >>  7 files changed, 11 insertions(+), 10 deletions(-)
> >
> > I see that Song requested that the changes in this patch be split out
> > back in the v3 revision, will that cause git bisect issues if patch
> > 1/2 is applied but patch 2/2 is not, or is there some BPF magic that
> > ensures that the selftests will still run properly?
> >
>
> So there isn't any type checking in the bpf program's function
> arguments against the LSM hook definitions, so it shouldn't cause any
> build issues. To the best of my knowledge, the new is_kernel boolean
> flag will end up living in r3. None of the current tests reference
> that parameter, so if we bisected and ended up on the previous commit,
> the bpf test programs would in a worst-case scenario simply clobber that
> register, which shouldn't effect any test outcomes unless a test program
> was somehow dependent on an uninitialized value in a scratch register.

Esh.  With that in mind, I'd argue that the two patches really should
just be one patch as you did before.  The patches are both pretty
small and obviously related so it really shouldn't be an issue.

However, since we need this patchset in order to properly implement
BPF signature verification I'm not going to make a fuss if Song feels
strongly that the selftest changes should be split into their own
patch.

--=20
paul-moore.com
