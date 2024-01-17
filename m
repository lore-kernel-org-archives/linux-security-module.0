Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BC20DC4
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jan 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501966; cv=none; b=V4vY1CtNOgGQY2NS/lHluNM2pM6fEknDlVfwC7s4gCFcGZZh+bBuZIe1ci9IzFBqoAZZZtAhUVt/GP8hc5UnHBh2Mnn9at1PUaV61smOIJSlgnDIafy+1Td+FeLXVTx8SyTYMnuedNECsNd8AMCny1kn28CtDse5JCa+mlAkaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501966; c=relaxed/simple;
	bh=kkzjZHd7WNS4qBwCTQwi+455aFyXB+g748QuNeAbzBo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=lTAmvD5KWcXixTgfzVoE5YXvylyVu710ltsZ0QtLrO8Ez+R6syR9mUBTdFidv5KqzHQRBtIaNGPB0Mv9ZH4NC8uOmqCqEbuTqZT1L1Go/n9qWSsCgzqCLdETNcKpiC5Y8Pe7rZI5uUp3mIbAjQ2nXNoxPkwRZZCPwjJmoQm9yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E4kJUHOw; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E4kJUHOw"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd6581bc62so3080414b6e.2
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jan 2024 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705501964; x=1706106764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RONH//ElZU86u60opp7THU7PsxqZBvC44A1MdMu3w=;
        b=E4kJUHOw94wgHUapWkCjecBzf7N6IwfJeqw9RBS/vVMKe2De9ae8PiSyuV0XF+uY4v
         2F7f81ioV1hg68em+PKeGq1sYJj6Gfq9CHN1va0JxDJXficeO+1rtYETpwgL21JKMK8R
         PkD8OJCsEAi3nNDIjZcEUiopbsEgqgMe0OtoD2K00DXy6kXg+JnHqrf9PwlfR0/V7poi
         1+SwCiu0EknKBsUVRD9mRXjAIvWVfQ5+erTypOshe00mR/XYyN8bV+kdJO7td+jDmofz
         ksdDQBy0sRQ1LBsJ5J4aNufvmSCMi4oJ10vGZzPU3u6RLq31z7RZi8IbQA601bjR4aoK
         vf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705501964; x=1706106764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8RONH//ElZU86u60opp7THU7PsxqZBvC44A1MdMu3w=;
        b=jBlpHkTYGeKLhqZKuLUC82X0v3ZLqagooT4J0kUYEGTFkGb3MMLd6mMB/Gwt38mfR9
         ygY/ug/EVB1Oyqq0ucXtl1RxAxsv5YuhofzgUg0v5icdCChIPSJzEvhoZVnED3f+ORGP
         eBhAtCPw9sX9ARTHo3Deg2+zbJ1LoGJvJiQ13uvKwRLm6wbsGtnT14UfQCWSO1mhZW++
         f14EcTfXWq55hyjevk/ilOMnX2ahKpNrjEcSoNRx7ntA7VfhK3u5sFm1CoI5BANb2Mr/
         vp/VHGpVE4Oo51Z8ddIgDaotgUBIs/Jl0E17MkcnfOcxOf6KyNyMvs8kczGiB4Jx3w8k
         xoZA==
X-Gm-Message-State: AOJu0YwOlCpuBtkHyL/2JlLnxKad9nLyC7x0TF8suTTWQRh2xDKMnY5e
	ykdwKvZL2qu3qM09GfbmF0Q6gUsKmuPk4IE53cbFn4VX/K/f
X-Google-Smtp-Source: AGHT+IE87eI9wptFf+xs4U6oR2zLXgl41vrThD1gFTxI6V//8WMTGlbbkeIOJ6ozq/sUoNyyugHRJ1IDoJg3F/CGQZI=
X-Received: by 2002:a05:6808:1290:b0:3bd:428e:744e with SMTP id
 a16-20020a056808129000b003bd428e744emr10251437oiw.53.1705501964261; Wed, 17
 Jan 2024 06:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117014541.8887-1-yaolu@kylinos.cn>
In-Reply-To: <20240117014541.8887-1-yaolu@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Jan 2024 09:32:33 -0500
Message-ID: <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>
Subject: Re: [PATCH] lsm: Resolve compiling 'security.c' error
To: Lu Yao <yaolu@kylinos.cn>, linux-hardening@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 8:46=E2=80=AFPM Lu Yao <yaolu@kylinos.cn> wrote:
>
> The following error log is displayed during the current compilation
>   > 'security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offset 32=
 is
>   > out of the bounds [0, 0] [-Werror=3Darray-bounds]'
>
> GCC version is '10.3.0 (Ubuntu 10.3.0-1ubuntu1~18.04~1)'
>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm adding the linux-hardening folks to the to To: line as this has
now come up multiple times and my best guess is that this is an issue
with the struct_size() macro, compiler annotations, or something
similar and I suspect they are the experts in that area.  My
understanding is that using the struct_size() macro is preferable to
open coding the math, as this patch does, but if we have to do
something like this to silence the warnings, that's okay with me.

So linux-hardening folks, what do you say?

> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..37168f6bee25 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, si=
ze_t *uctx_len,
>         size_t nctx_len;
>         int rc =3D 0;
>
> -       nctx_len =3D ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *=
));
> +       nctx_len =3D ALIGN(sizeof(struct lsm_ctx) + val_len, sizeof(void =
*));
>         if (nctx_len > *uctx_len) {
>                 rc =3D -E2BIG;
>                 goto out;
> --
> 2.25.1

--=20
paul-moore.com
