Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9481E6DC5
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931540; cv=none; b=M7wfu7OWUt4jflp0sKZg6MqOiBAE+oTRTvgBOhGMXWMgdNacS4lQEQ0TwiHj9BlrsoPHycEazjYk36IawCEt1RHaHoFMa/clkxfjOjks0d/bZWL6GDrrfYue89BIQr3clfHYrxE0FMNCu5MJvFFe+wwgqbhgTdkYQiW/YenM75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931540; c=relaxed/simple;
	bh=JUqQcth+48yfR5IRsTgNIhgR29SjLMaLxedyYS8m8CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNW8f5zV+WCEYStFGPMOnS5WEUmDWBNTveSaD+aKlknPbC9498h8UsJjB3D0CpaZJ+xj6uuChkgQRfQL6K7uj86awZMDCRWuI/7TUs8KgN2knpWlgqEpM9n7hg5n+1YBSlZ02S3F69PVbyiuCu9G///sfiGjbO+Y26mwY+fu4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FpdG7/vk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FpdG7/vk"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso217034a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756931538; x=1757536338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ5BuvO47PQ9ewZ74GpkgcMd6NO4tOTKv4Zu027LJSk=;
        b=FpdG7/vkPJMDuRMoiyqqOtBKQA9SZW1OxJAtE1GdU0vLThwnowuKC/8CtZHGqPBsLS
         t4lvf98l7b09+9vZhwGme0okqRdsoqWQqpnkbidWzTQZpWEyxii9RSDTlHxASRB9/rL0
         8U+GcYLZK+68QwJymxDV2eRSmNRgaLjjQsqeZdbGgoiA9vTnSxAl5ZOSarIm5fxobgjm
         iNMHOy12Hj8oHOHMX476MAIiRA88HmdbjsTD5fH8R0Blu66wMX52SSIPoChdsjrywg04
         dmSmlVGn1AflS50XjrTt/vLJmD/mwKny3km76YWtdMrQFw8y4t8pyhIxu+oTmZBg3WVB
         tPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931538; x=1757536338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ5BuvO47PQ9ewZ74GpkgcMd6NO4tOTKv4Zu027LJSk=;
        b=Y5y0vW9Xtb2jxRm6/ryUI3psN7OwO6um88KuIFauQm2ZDR6TLmgnrle6ZsjQTOJjZ8
         qU+RfIzN+0EAMlBL4l1c8kYlCvgcOle59ZE/3WX2Ynf24dMgTrnip6sXOhhHymzz8Tjd
         s9jus5eQQ6S0t89dR5juUpDbsWnBvvKadZ3mxLokz2Yxypfrf/4J/HN/QyWxvLln+Xct
         QqcRDyoHofeWqmv+/75teSlMw6ExwbhT2PRkAipbIpvr3hzaDFPTEUOYGn8Wry5AT58c
         Mevoc8m7OTlKE8ojRUDudLRdW5HBODHlDiWDrTnTReJ4hoLaDXoTMD1f6X/l0HlAZQyv
         6CXQ==
X-Gm-Message-State: AOJu0YwkXDcy3DkoLopp7kzcznx7L2dxlHX0s8C1G2sIvIKmXEROiiQn
	BOOyy07izgRqW6iOkrpiD1Jmxa3o0Qun+rdW+W+BZ4CxQiCMnQXxfO9h94u5O1R70NU2QHn5uIx
	Jic8W0KsKVy6dw+wFJ3h0B5YuSq8/Oe+B8OPPeznf
X-Gm-Gg: ASbGncsYqwcjtVNopBORuNTLdOvfp2PqvTzgEgIvz91Viq6jBrAV8DE06lhxP88kunx
	iSyQSVJ1SsmoDPLmf4xtX+Mo/8Avn5fNOH05ye/4ccj/Dk21fbvmvw6gFNhIBUf9VRw6tmEXQHz
	/XQ4vmybuoV+MjUlmLb7qoGeNUd/4c9C8Ie24ekRljOEkJmaL7rScmDGc3samoGBLOqg6LcK225
	z8Tt4g=
X-Google-Smtp-Source: AGHT+IHWOotiu9t3J3R4HLk+zVm85x2J3ZLURGCvKo08zpnUTB2Nq7s2ZiHCnKKIbSxlGxWk4FiAQSQ6hXeX5qsrKUQ=
X-Received: by 2002:a17:90b:5865:b0:328:a89:3dc8 with SMTP id
 98e67ed59e1d1-3281543cc5emr21520105a91.14.1756931538487; Wed, 03 Sep 2025
 13:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-63-paul@paul-moore.com>
In-Reply-To: <20250814225159.275901-63-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:32:06 -0400
X-Gm-Features: Ac12FXyNJitgpL2yinQCFeDyrkKRUyO_0xYJ9X1mCNjeHnVb6sYzdHeJtz7l_1U
Message-ID: <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/tomoyo/common.h        | 2 ++
>  security/tomoyo/securityfs_if.c | 4 +---
>  security/tomoyo/tomoyo.c        | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)

Tetsuo, does this look okay to you?

> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0e8e2e959aef..3b2a97d10a5d 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -924,6 +924,8 @@ struct tomoyo_task {
>
>  /********** Function prototypes. **********/
>
> +int tomoyo_interface_init(void);
> +
>  bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *addr=
ess,
>                                   const struct tomoyo_group *group);
>  bool tomoyo_compare_number_union(const unsigned long value,
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs=
_if.c
> index 7e69747b2f77..33933645f5b9 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *na=
me, const umode_t mode,
>   *
>   * Returns 0.
>   */
> -static int __init tomoyo_interface_init(void)
> +int __init tomoyo_interface_init(void)
>  {
>         struct tomoyo_domain_info *domain;
>         struct dentry *tomoyo_dir;
> @@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
>         tomoyo_load_builtin_policy();
>         return 0;
>  }
> -
> -fs_initcall(tomoyo_interface_init);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index ed0f7b052a85..a015cf0c4a00 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) =3D {
>         .flags =3D LSM_FLAG_LEGACY_MAJOR,
>         .blobs =3D &tomoyo_blob_sizes,
>         .init =3D tomoyo_init,
> +       .initcall_fs =3D tomoyo_interface_init,
>  };
> --
> 2.50.1

--=20
paul-moore.com
