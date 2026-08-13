Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E63B83E0
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646260; cv=pass; b=AvM5jH2RONiKxartu9wmpC4GDPWbb2wQPNA7kAqscJgLwal8QU6QvUSlckBVVvLNkQJJrivPN0kJR/nbUtK+KI4q/clKE/CKZQgsuTlMDXSqFYqkMBKfkaRb1X8zoQS9CCnCgMwkneZ097U3ye99EUdAr5TVzC5HhaVWiNe4LSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646260; c=relaxed/simple;
	bh=8KbSxJwx3m2I0QqesFzBuyI/iOXYKuTmEIrlWf+3Ed0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tur4PlxQ9c3Ndb2R19w9tNwlbV/4Culzn8ZuFzYKbxuwXW5XvIO4zTTqgzjF5+wLoeSMwAklEtNcq8AtorPnK1GLhK2XDJym0EaWU+vKuXxlmQ18q+ga/xoFbq1aHtKuMSZ10Vm6ncfIR3fqm3Y39VzLknKv44OGVGptBM70WpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FsKFh/+L; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FsKFh/+L"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso3188795ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 11:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786646258; cv=none;
        d=google.com; s=arc-20260327;
        b=FA5uLaNtwE0plE4IHA2u75aI/2cJ1g8zsu1GO0G5eZKbg0ULHOb8GJARu8pMMkA6Ob
         bSxyFt5HgPm8TygVJWNNfLgPQZF5XYk1Zxg3DFzYHpPZqVTuY2PwBXYfZM2mWEW16ypO
         +kB7XpzI6dtQq8zcyVjVQNd+9TDoKhqhyBcnH5q/mGhNKjPuH5RTd9Ia01RtYHcRCzO9
         Mrpp181nMq0tZ9YIRV1jVOtjVG5dm2dg4T9cWZXpUcBLLE61UxKkO+Ym1ucAzSfc8zj2
         /VOrNc4zt5rzm0rE/hrEzB5zHcjPpgUcTlRrrO0vDDLkL1pz7ebSE/ANaRtiSaRtz23Z
         K3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrFyaySZemBX8fPU45g5ZTZ6m4q/Cb7hguiIrZTIlKw=;
        fh=abZXrZHFtrq0xipQ8HJBnbgsIfvTjyOo0lKzRyDCwys=;
        b=UYUdM16BWz0v8DOcoowtfp/tNqEvwX9rMf1oK+DZZOK0D+nL0eJZ9MYpg0uKF99B3O
         0GkYcR120VCTiiLT3EXxEO6b8vjOhKEP2+aYwQqr4DNdkTfjSG1lFVvkwIPOG7INrDnn
         O8mF2oozTRsMVuNKoVJchf/E8fKAyHt/JA+Wp8KuAwjg1+UBdizQeibyB3l71M5WCoNn
         toUjQn7JP0TXEMuniNlm/NlPjsb7EALSxQIoD8is2jajR4uBDtOHLlVlnHGJHG7jmuYu
         2hJCKenRRwCWqVzVsjkXJ7gvFRyis1/NcZCeg0UKZ7crpz8IEBSJFiZIGdQ8Wi7dKNun
         SH7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786646258; x=1787251058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrFyaySZemBX8fPU45g5ZTZ6m4q/Cb7hguiIrZTIlKw=;
        b=FsKFh/+L10CI0mDq3qwAuqYLoKrxk/miG52P8fUXOqE35/cPddouyMulDRtSmDdh2s
         Ip80j0Rzct3bxUSWyfQFfR0ewmwuweUu/FKov/xZXrAHBDJozqXSWyQG0H9nflqN/wX1
         GKlGieZ39HZLKvxu5JULBVi3Jl1oj2pDjk1jRcrsc8t3AMLtQ0N/QTuueitXI2LHGmWl
         A4rbWfkSdwmWdMuQqPoL3V8Ffga8UgX3LommdlzM8um3CkWmI6thkY3BG8lVoHfB83s+
         f2TqwPinWJ46weNiMIZS15XDa7v7J6q3k3sB58ZM2gGY1EPzSEVWJq7/Oyku+RL2MRxk
         wLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646258; x=1787251058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrFyaySZemBX8fPU45g5ZTZ6m4q/Cb7hguiIrZTIlKw=;
        b=HXgqPX6hC7G2yBOicUV9Nzb+kB/S0FjVoIvyXHGyn4/Rk22kSZYF3FNcAvKHv04j1k
         ZrE6peomUMkPaG6+yj5ZOLYaSBbX64gy0riQ7UDW2xAOHNHWhi+2bFp9hrp3gfE/evh6
         xoAXKfR1A2Io6JPrSnCxsfKVuR92LYNfr5pu3ooak2hPtJz/KOPxdULLaw9EmDFaB7hl
         4242ULVOSsGDbcqCRclnSJFaQDWBIxJ79Os2DcrHTSZmY05gl5cmxTM2NQ35nzhQV6MA
         RfVFdU3jrD9Acg3BiQdWHmpyaKzxFYwnan5Ns1U/ex4H0z1S0JciWKdWAxsDdY7yDR6V
         NlpQ==
X-Gm-Message-State: AOJu0YwTDD3t6DP5rqsoBzzFDnkcQPOHBoQ+dJupiSof44/B3Hd06deX
	9krbGgkm0uFqDu2EVXmyAIv03AZ+hCgBE6Z1DdgQDyAyp2AboMdwBL7khhXmNYILhKt+n/+GqJI
	AAlBUdj/4LXyoceMd9slSghOyVygpoUeo4n2KbdHmz/HCAM3jRwluZg==
X-Gm-Gg: AR+sD138CcxJnQfjyYlSZ5NHUBqBgHIUwtJpVqzRNLhPSNxchSeBpG+k+Am7fpm70Uv
	/dgaPxFq4NTdglGfgLRC6m9yJHDYCXo6bz32QnQdeEBWPcB6FNVFem+FF0Wu7AvFX5dG/8n1JoP
	E+cvjxL+M3DLv8n+vzQfLVPxNnTbSlRiYSXB1AkFIZhpH2aOUR9tdaDbvdIOJze41V5kq7M6t6a
	vyq478I3kVcINCzuAqK8aG8V5p+bHorM66HFAkwco1hPu2IPQ7h8sTaTgR7x7QPnYL/ohTDehU1
	P/RiEYZUmM9wF6JN1bOnSPbw3xzk/jWkJttj55Pnt/TY
X-Received: by 2002:a17:903:2f8f:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2d37e8525abmr82161225ad.12.1786646257894; Thu, 13 Aug 2026
 11:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813180816.223079-2-paul@paul-moore.com>
In-Reply-To: <20260813180816.223079-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Aug 2026 14:37:25 -0400
X-Gm-Features: AUfX_mxxC-RQb65lKaegYcqY92xUpq6fv6zLHlJqvcJKr8M0nnur81oWpsfcf2A
Message-ID: <CAHC9VhRRgLifObY4Adgxe4FBmXn-wbxYmx6unMXtmdTtbWYMog@mail.gmail.com>
Subject: Re: [PATCH] lsm: update the BUILD_BUG_ON() in audit_log_lsm_data()
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On 32-bit systems the newly added namespace fields in the
> common_audit_data struct exceed the BUILD_BUG_ON(sizeof(void *) * 2)
> size check in audit_log_lsm_data().  Convert the size check to two
> u64 types to both fit the new fields and move to a size that is not
> architecture dependent.
>
> Fixes: bb20ca26f960 ("lsm: add LSM_AUDIT_DATA_NS for namespace audit reco=
rds")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608131232.Owej9tlx-lkp@i=
ntel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/lsm_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm applying this to lsm/dev-staging to fix the kernel test robot
build failure, but as this is just the dev-staging branch, please feel
free to comment on how this is a stupid patch, ACK, review, etc. as
you see fit.

--=20
paul-moore.com
