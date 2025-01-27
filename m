Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D552198E63
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011585; cv=none; b=fqvPkabx+F1tWC8T8y3aM0O1iXPblPdbFh1uVha8XoNx9WhGa+lxzcNzzTa5x7WoFj9DEGdEtjBrSeaqJvlK3sNcEkLVOhOuGVnxvQk1f54HN5b4KcKQPkjf+/ohlCNYnlXspSbLBL4HHrD1NbuwUq/2kyMsX38hHLKfA0b9qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011585; c=relaxed/simple;
	bh=mx/LOgtmA7qWNjxGpvHesrDGk7l6/i7NWLFb6Ho4+SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKJ57LrksW7pe787ezOOdpcPi6rN5VSoVmxUa0lhzHdbduXXKo0AVxdCmcD6ZNwqnYaE5ikBDOOCZXzdXgj6CpHp2t3iE5fYmJvqt1/17ZaWbhxJVP6kJ+JnWRQfCnT3grqFugRlQ7u+CKdbM9Dx+73gKOUrtEg3U/1Krlrb0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U0eaf5tG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U0eaf5tG"
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E23473F480
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738011573;
	bh=gQGlNTxdBFzzr8vBchoLXLW34W904568hRvQiORagrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=U0eaf5tGGiFEQiBk3iE5DcTL9TWmbAogFamQBskfBNEgw6vgPXqeWZvgalBdIoBc7
	 9WePQ4y28U5dY/qnRADytBGtBHt4iAd2nMgc46YwxVXywLmLynUZ5syQxS8LHxY4xZ
	 NKEgjKMfBhpZujwS9TZwHsilVS5VaR3I/G0OYfGSjdf/uFs91H5fVvX8mC2DEZbjVJ
	 pEBSfKR8iMaQEDtttHKK4ptVHzrtbz3pLwHR/Y4A5lWIsmdg1KgHyYSXWt9hYg2d4U
	 qfGPGmK1pvD/sHskhhYov7BjwdufpWhhnGPdv8+InhUWze62TyqN+9E2j/DjyvSZfc
	 dOLbh69QGjx/A==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab2e44dc9b8so619771166b.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jan 2025 12:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738011573; x=1738616373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQGlNTxdBFzzr8vBchoLXLW34W904568hRvQiORagrs=;
        b=ozcGenMebdSV+tYAach2RH94S6OEnlgb9Ci75E4nzFZnbQUuMdNwNZwDO7sMxoFhb4
         ppktU/LNsThpv2+7LVKMeXmq2TCsADoLxem74DxjC9a9V0dRwwmL8La1hjRCN421Kv//
         0wcUDoZANA6BQdZqRCDLLwI90GqGo8SFpMiAW44a8DxLRaAnv5d9pbvBiG5H55+JDRf9
         1644Os7JkKuAUsqnauUrBJfSm36qbyGLlYxPhLoCTJQIeqKp1tVc+mfMylH4+uT2tTpJ
         QCyfV0/T005ChYy5jdZWFMI3Tbz27q6mBnhy3dP1/6baEAShnmfpmEOYEMqQl4eTQdeX
         88GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9DgufWuwt254HYvP1UbT9QFi7hBDoNJpotJzb5rkcBl9nq9f3Ypl22T91LsVHx2CHMpedFb/ATwXsIXW4+GMk0pl/ScA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6a3fOUScyqQsJgeO9qqyF6GrUYzjvGbaNfT1b+B8CiIPQqu1h
	YvL1G+veqLtqyMmYixC73LXaAGrFZzN/pDc+UDL0Ke8BnqEd1bhv7mLw841tW1w2BTaOtna27nc
	WKzTSoZLoeE3Yjb1+VkzFR2aSVMumui92+tnDY4KsGsJIMLjuoUeyHuF+/4C3G/c7LX8CvuLYfz
	5/hb0Ks7hqQISZ3xwCX4Jg/O1G5u4viGA0ayqfw4ARqCDbw0fd+zg/dYzYZ4o67oZ1
X-Gm-Gg: ASbGncvM7BiB8MXns4uvd3B8PithEYMoYFQ8Wfghl2AZvvL/zLKN1IbsWTfjYh7HFPr
	+OVyaRRA4h/Ld6y0Lxw73MUdVXEjoOqunB0gcN1bHcK9cVdxaBAnlWgw6fQE0
X-Received: by 2002:a17:907:7f26:b0:ab2:f255:59f5 with SMTP id a640c23a62f3a-ab6bbada799mr82489766b.16.1738011573253;
        Mon, 27 Jan 2025 12:59:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENl/Z2UHRvb/N1dGDukBTnLoKCGZWuwO5l9LFHqTqir7HRPJ1sriCkV2rXrgh8NZj9dejS+DTR/WIIeul9qsc=
X-Received: by 2002:a17:907:7f26:b0:ab2:f255:59f5 with SMTP id
 a640c23a62f3a-ab6bbada799mr82488066b.16.1738011572880; Mon, 27 Jan 2025
 12:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127205404.3116679-1-mjguzik@gmail.com>
In-Reply-To: <20250127205404.3116679-1-mjguzik@gmail.com>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Mon, 27 Jan 2025 12:59:21 -0800
X-Gm-Features: AWEUYZnjUjiQ1zZWGav8HmNl07KvoOIluiSJmcazFZoE-1JpclxsniNKKfgRq7E
Message-ID: <CAKCV-6sRcOOcLOqc62PyUKqbmmqTOje8vf0kDhLdNKaa4r57_Q@mail.gmail.com>
Subject: Re: [PATCH] apparmor: use the condition in AA_BUG_FMT even with debug disabled
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: john.johansen@canonical.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the record, a previous patch that removes the sock variable was
previously accepted:
https://lists.ubuntu.com/archives/apparmor/2025-January/013449.html
(patch) and https://lists.ubuntu.com/archives/apparmor/2025-January/013463.=
html
(ack from John Johansen)

On Mon, Jan 27, 2025 at 12:54=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> This follows the established practice and fixes a build failure for me:
> security/apparmor/file.c: In function =E2=80=98__file_sock_perm=E2=80=99:
> security/apparmor/file.c:544:24: error: unused variable =E2=80=98sock=E2=
=80=99 [-Werror=3Dunused-variable]
>   544 |         struct socket *sock =3D (struct socket *) file->private_d=
ata;
>       |                        ^~~~
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> Plausibly the sock var wants to be eliminated altogether, but I just
> want this to build.
>
>  security/apparmor/include/lib.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/=
lib.h
> index 256f4577c653..d947998262b2 100644
> --- a/security/apparmor/include/lib.h
> +++ b/security/apparmor/include/lib.h
> @@ -60,7 +60,11 @@ do {                                                  =
               \
>  #define AA_BUG_FMT(X, fmt, args...)                                    \
>         WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
>  #else
> -#define AA_BUG_FMT(X, fmt, args...) no_printk(fmt, ##args)
> +#define AA_BUG_FMT(X, fmt, args...)                                    \
> +       do {                                                            \
> +               BUILD_BUG_ON_INVALID(X);                                \
> +               no_printk(fmt, ##args);                                 \
> +       } while (0)
>  #endif
>
>  int aa_parse_debug_params(const char *str);
> --
> 2.43.0
>
>
