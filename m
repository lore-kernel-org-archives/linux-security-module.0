Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675913AA5F;
	Thu, 31 Oct 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394720; cv=none; b=crRAtlNSz9RkdsNSfjEIozwo8l4zVx0GDzo2VKjaS5Azu0c5NK4h6ve4RRwBJs2fMH2N4V8DzYNLB5edQHslW6+/ytucdcEA/YjzHL2mZQ3M0cW2LKXa2MIByxAeeDB4wZg5lL6GOwmFpdsJ83lCOwjQnVwXVgSsMG1sAehAs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394720; c=relaxed/simple;
	bh=lsFXMq2mzHC0L12rWDazIP7DmVLnHcQquBa0J1+WFLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4h5gbO8WUo9qbj1wdNia32KJsgYEnQBEaSEVoVJQYxKI3nfGGYTfiy8qS0IJK9PLF8kBjNJ35dios4IIZqu4lZvDQuVONlG3beuxaFZrZaTkboyEIDSMn9O8nL3fjLloJjfx/ysF0HHmgktITNFSuX3fEzX+w/G08hVvZzck/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzwRWhS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzwRWhS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE7CC4CED2;
	Thu, 31 Oct 2024 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730394720;
	bh=lsFXMq2mzHC0L12rWDazIP7DmVLnHcQquBa0J1+WFLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kzwRWhS8X4YqRe+bSHoV0mquuHlCxcl4snHJSZLnc1+6+5KijvdUU4jsIkTkhDBL2
	 pca7FUMKM0IGNTOcEG+Z0Uw4rGFLu+WsKd+wGuIk5Kvv2IWyv6tPeBvsLwQqOoIdpo
	 iNt1DVsPu+cWPCso3l3qTaVrrSRlakglq909TAqnehW5ZoZCGlO4EzhBumH/zRy8bs
	 tkdYA+gya9zDNu29ijNPcaH0Fg5WcDyStGn8I40uQd084y4+Bs/ckIBXu8scETmiEp
	 7MRXDsxAoMFia3P/xEywNk/+BhBFE485qZCVESsS5TKsADUqkqJOMBZvwOoiwnQAHy
	 wjOcuAnK0lDYQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so10605667b3.1;
        Thu, 31 Oct 2024 10:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXD1x0ZZBUg8cMKgl1qDNaE6OsaOT13MJ5HkQd0pm3qDC70ZnUFQP6Zz5FhznhmUny0d0esmZp8ECDdMkVx/qY=@vger.kernel.org, AJvYcCXgrFByeBerc+H+Vwk+weDeirEV5ceCLeSzovTdauvYHK/2BiuavPKd1exry9SpSVHFIAe6Gn+yHedHoM69@vger.kernel.org, AJvYcCXvP0zNic+ab5gDQjBhlkJrTniJTMufsiw4Jy731+Y2LjfmJij/i8Ym74Vgs5p5iEhjGwkYMWZPwlsQgL1a6elxZbOgqJud@vger.kernel.org
X-Gm-Message-State: AOJu0YxaagrnzqB+Pu24gnvXbsSoSOBg1uBlrX/4XZ5Ruimylhn7qNwH
	pwAxbSVcy4XWLFUrsdbL02gsp6+qnXecS/5T15ZLZdtgfum2pTW0PxmnhPhLT0hCb+zcapCNEpM
	xKG2GhSrNcARCIaC8OArDKo92NW0=
X-Google-Smtp-Source: AGHT+IEpmRdRaHrcaPkBzZKPArPZBJMYQ0qzUxtE/KVLRQyJRxEm7VQjjkJckQ49x7K+kG9LjeZJrXHUiA30Wn6DgoY=
X-Received: by 2002:a05:690c:91:b0:6e3:4436:56af with SMTP id
 00721157ae682-6e9d8aa412bmr175772267b3.33.1730394719288; Thu, 31 Oct 2024
 10:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031155857.3262806-1-colin.i.king@gmail.com>
In-Reply-To: <20241031155857.3262806-1-colin.i.king@gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 31 Oct 2024 10:11:47 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHwAJP4U5TQcT5igz+xt79xiUdMxUHitzLZGxNK5jO1Qw@mail.gmail.com>
Message-ID: <CAKtyLkHwAJP4U5TQcT5igz+xt79xiUdMxUHitzLZGxNK5jO1Qw@mail.gmail.com>
Subject: Re: [PATCH][next] scripts: ipe: polgen: remove redundant close and
 error exit path
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Fan Wu <wufan@kernel.org>, Deven Bowers <deven.desai@linux.microsoft.com>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Fan Wu <wufan@linux.microsoft.com>

Thanks, I will pull this into my tree.

-Fan

On Thu, Oct 31, 2024 at 8:59=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> Currently if an fopen fails the error exit path is via code that
> checks if fp is not null and closes the file, however, fp is null
> so this check and close is redundant. Since the only use of the
> err exit label is on the fopen check, remove it and replace the
> code with a simple return of errno. Also remove variable rc since
> it's no longer required.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  scripts/ipe/polgen/polgen.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/ipe/polgen/polgen.c b/scripts/ipe/polgen/polgen.c
> index c6283b3ff006..01134cf895d0 100644
> --- a/scripts/ipe/polgen/polgen.c
> +++ b/scripts/ipe/polgen/polgen.c
> @@ -61,15 +61,12 @@ static int policy_to_buffer(const char *pathname, cha=
r **buffer, size_t *size)
>
>  static int write_boot_policy(const char *pathname, const char *buf, size=
_t size)
>  {
> -       int rc =3D 0;
>         FILE *fd;
>         size_t i;
>
>         fd =3D fopen(pathname, "w");
> -       if (!fd) {
> -               rc =3D errno;
> -               goto err;
> -       }
> +       if (!fd)
> +               return errno;
>
>         fprintf(fd, "/* This file is automatically generated.");
>         fprintf(fd, " Do not edit. */\n");
> @@ -113,11 +110,6 @@ static int write_boot_policy(const char *pathname, c=
onst char *buf, size_t size)
>         fclose(fd);
>
>         return 0;
> -
> -err:
> -       if (fd)
> -               fclose(fd);
> -       return rc;
>  }
>
>  int main(int argc, const char *const argv[])
> --
> 2.39.5
>
>
