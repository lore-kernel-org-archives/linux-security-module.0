Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29EE1D61B7
	for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950634; cv=none; b=CWJcT/WWTa7a2DHNGaivkbNqfGvN5qjhRAcbMSG2LVCqs0MXDXWg6ls6yGPhvQ4DLrfeInAsTVmTamCUDL1EuusiF0Gn12w3rpF7znXUtJdlvnJ77iqN3NPQmeHgWIjO/lRcQ3DClhpJZJYt9ARWWpeh6JuDncFkh42V+rlI3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950634; c=relaxed/simple;
	bh=1t2gSAFuBD2pmTHsdNa89BroU/+iTca3RYH3ziKTQkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISz29edsK3U/6SlQVfn44A9Us6SRrzQBNszK0n06tMRdVMZU3EZdMNzqTkrRuG4CaB9jo1paKYpduyNq8CUSDZpCTmfsMC4DapBH892TuzGWvf/heBuARE42mJCpyo5hC8bhfZjuaFipKWdaow9kPrf4r+Pyf+2utmgQYXl6tWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eecyzQbl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eecyzQbl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f325c1bc1so4269212a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Aug 2025 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950631; x=1755555431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv7bfonbOtnyi9GXdkuQQycl89N9wubFNFBp3GJPPOY=;
        b=eecyzQblgywX3H6nDiILBZ/VmqpAqdSbeXlx9Y0X/xuh/jqZhGroWVRSdLPsBBYVfa
         L5hijNwFJrJ90qxRufJJ2uwAf0qzqW/B2Lgtqz0PUti7d3cqyFuiokfRzfTimvmQN4xt
         5e5RcBiCnuyao+YrA+it7h10N2XjMcg1JWtEai+kJix5mSB3XsfZs1/cw3VBZmtXJ/XW
         qKU0AwolcmMThpzU2ZkjoiY0YoXfIdxLNYvLUuZAOaov8Re6M5wCt8vwB4pvXVup8ggy
         6u0NqTGHiNPDIoTwTQNHGtz9Sn5dxvU18p/epeN0ZYuROcEjKRaLyy2q9b6OTsa6fS7Z
         Pw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950631; x=1755555431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sv7bfonbOtnyi9GXdkuQQycl89N9wubFNFBp3GJPPOY=;
        b=JreT+UIyZ9DWfQW9z7H12V6/DcBXIKq++DBCaRJzJuxhG5E8idPCTX7YEe2fJ4dFJS
         /wgxeuNNDdMErmz9QhiPsTdJhFj78WbyIoWu3vEEHOU4zxXVNy/WEJsp4LkRQKjips6k
         gauyB69q8IEoqbLbknSX5GCCdOLVnsPybAW45Bsm3UpuNrAWds+Qv0t//D1qVGojdHAq
         WZPl0C5Y8KCVK1iTMjeuydCvvLjp8+3ifry1tHAKMDCXbxDYDPRVqdRopLxQWpmzVYQJ
         URSAxki2Vewj0mf2Cy1unfJzO9zxsEH66MC7y0PpIsfpyBs1OnoaVq9sDq7f6/a7W9Ch
         XoYg==
X-Forwarded-Encrypted: i=1; AJvYcCWtHW8EJby2fr4dW28LdK1xJz/Xigaebxmxrd7wJyZzDfghvxEJWrCkegdXhftBwcDJDJnLCj7x+DLLn7ylEdbwt8cdGVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKVtoBxiwjW/eF0MSsDCOyVv+/BswKWt7OEpMksJxidki2ki/
	Mnj3WbOp6+hNlgzCcVOXdFQs0mEbe2nSgYYrGBol8u2tgWpcA8/PJ9SEZ5UoQHfAjFtp/WqT2q0
	5wCfc4tNVKYsN3pdTlKkXhfDj8kf4bjx46puQRVWx
X-Gm-Gg: ASbGncsibnzzIMnsuZUj4PgDB7BNjvrE8O6601eo1PzYaX3wSdv0s9VsuJHfNKfTHqL
	Fb+/3YqGKiC2SQDtgwVs+1b6wZzlC1MVmstqbVdlmTVBIkQHzXIsBlpap2bngorhRKQodr5eb08
	2S+S//Y+ZX/b36NDH2f4CGGH91S+GDCeiz8JWUMqYg2dKGZoXtPCoxi/Zk995XeBaqVPa4n8zlC
	nyq5m4=
X-Google-Smtp-Source: AGHT+IFwFEBMYcuh4oMcdsq/fHgVqQT9Tc8p5Bbo9xtS2j8tV/hcAwRwQa/i5ZfaQKMacfbgAwKozV5H4uA2yniz+B8=
X-Received: by 2002:a17:90b:3910:b0:321:2160:bf72 with SMTP id
 98e67ed59e1d1-321839d3f14mr20936515a91.7.1754950630749; Mon, 11 Aug 2025
 15:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
 <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com> <87pld788yu.fsf@microsoft.com>
 <CAHC9VhTPrrgRh7v-H7qpizbxHNcW-V1qj-=24+Z8at2w4Co4uw@mail.gmail.com>
In-Reply-To: <CAHC9VhTPrrgRh7v-H7qpizbxHNcW-V1qj-=24+Z8at2w4Co4uw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:16:58 -0400
X-Gm-Features: Ac12FXyuWYLohIYpJotYXh5r2pfwoxJNS_CY_qqw-DoJKGoTJNQfJaZ4ATHiamo
Message-ID: <CAHC9VhTWZ1McpFoqhsez+pm7LFSdsF77S6fx0iM9hVc3jOxS3Q@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 1:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Aug 7, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> >
> > > On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote=
:
> > >>
> > >> This patch introduces LSM blob support for BPF maps, programs, and
> > >> tokens to enable LSM stacking and multiplexing of LSM modules that
> > >> govern BPF objects. Additionally, the existing BPF hooks used by
> > >> SELinux have been updated to utilize the new blob infrastructure,
> > >> removing the assumption of exclusive ownership of the security
> > >> pointer.
> > >>
> > >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> > >> ---
> > >> v2:
> > >> - Use lsm_blob_alloc
> > >> - Remove unneded null check
> > >> - ifdef guard bpf alloc helpers
> > >> ---
> > >>  include/linux/lsm_hooks.h         |  3 ++
> > >>  security/security.c               | 86 ++++++++++++++++++++++++++++=
+--
> > >>  security/selinux/hooks.c          | 56 ++++----------------
> > >>  security/selinux/include/objsec.h | 17 ++++++
> > >>  4 files changed, 113 insertions(+), 49 deletions(-)
> > >
> > > This looks good to me, one nit/question below ...
> > >
> > >> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
> > >>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *at=
tr,
> > >>                          struct bpf_token *token, bool kernel)
> > >>  {
> > >> -    return call_int_hook(bpf_map_create, map, attr, token, kernel);
> > >> +    int rc =3D 0;
> > >
> > > I understand the motivation behind initializing @rc to zero, but to b=
e
> > > honest it is redundant and will surely result in a follow on patch fr=
om
> > > someone to remove the initialization.
> > >
> > > Do you have any objection to me removing the initialization during th=
e
> > > merge?  This would obviously apply to the other two as well.
> > >
> >
> > No objections on my end. Thanks.
>
> Okay, merged to lsm/dev-staging with plans to move it to lsm/dev once
> the merge window closes.

Now merged into lsm/dev, thanks!

--=20
paul-moore.com
