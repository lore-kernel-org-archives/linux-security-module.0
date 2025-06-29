Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA6224B02
	for <linux-security-module@vger.kernel.org>; Sun, 29 Jun 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207261; cv=none; b=BnAYuppfcZQ4cZ3h634QnPAWCu/4clepyx4XeFTM8d07V07ikFyMQVkmWnR8GJm/eOL1htBRyJNPqdXC2oOrkxE2v0u9KYFf0z+a5iyVjs/FXvfDri6UhIUwhd9VtDWnev0WNXBkYPfTrYuEknVlrUkUMb0rhytGWyXEF4RpwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207261; c=relaxed/simple;
	bh=8n6o9bwrxkN+4gbzwe6Km9SGKFqHTyRJVSydp61XDiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIu6iVTwQZZ0uC76kuqSxHnPKRbvc9BNgE5iuVrzlefY+OKBhDTQM08p1hU0CdXssEWB0nZ9t7QrVU36DAirH7Sy/6y4MXpK9OBeGri4720XwhlA96q381iKX2AmwQHnhYhNls2vKpNs3P5th9wJ/bTG+WeRs0P804CBQLN5LSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8dhbIvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8dhbIvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880FDC4CEF0
	for <linux-security-module@vger.kernel.org>; Sun, 29 Jun 2025 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751207261;
	bh=8n6o9bwrxkN+4gbzwe6Km9SGKFqHTyRJVSydp61XDiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q8dhbIvjWH9ZiGPCYXjSBW2HDpBFp2YnZJGH4NINgHeOs+8nE6ER3kFhJDMoziiAr
	 pe4kPCiRjTpVp+/pD7meKi9YpyAlfqeFrsAl6OTr79obRaDgyWrnJNKlNg/NNqEyVp
	 v1A3e9XUAf9LyVvX5ap8Nbu/wlgkdA5K04rw7u3iExTjyUzdgbUzh/tvas3acvKGLc
	 nLERvZA1nLTHbQJdVNo4ecSG5D2pUMG1psP+o5iQBNd1FqkRGSS/5ckujZ9zKKVH6Z
	 ylwBnTlb9g8KWREJF1O2mR8MMcA+XVYWqVsO1/CuEJF0apCpgHgSWlkp+dzygtztka
	 ZFYipQCXz6aLg==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so2336395a91.3
        for <linux-security-module@vger.kernel.org>; Sun, 29 Jun 2025 07:27:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzn/xNIlvCO00CPo1JthPsAYVm4W1uo/x1rhv4YzqgXOPBwYHLw
	6+QMGEbT8eWEqiTh9L+jimkKdY1/Rww49XwAAzhFTe7D3AbB1fBRZaFLt2bSWxkoya8cPV9sepE
	1iSoFD1zKN+rBvl2NFpSs1UcfzB6Bf6Y=
X-Google-Smtp-Source: AGHT+IFcs8JwyMKWUBS437Rit5vj+1NFcI1Rwd06m4rZ0N31xz1e/gbCBuVOWPMmk33yxgs+vLc8hmtVSafQV+4fsiU=
X-Received: by 2002:a17:90b:586e:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-318c9231255mr15362987a91.17.1751207261209; Sun, 29 Jun 2025
 07:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629120301.1702897-1-ariel.otilibili-anieli@eurecom.fr> <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
In-Reply-To: <20250629120301.1702897-2-ariel.otilibili-anieli@eurecom.fr>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Sun, 29 Jun 2025 07:27:29 -0700
X-Gmail-Original-Message-ID: <CACmP8UJ+Mp_53e9cnKDV3st+3_H_nYW3qkfvib34BS_s+5UPng@mail.gmail.com>
X-Gm-Features: Ac12FXxg7gTtFE7_7AGEDiIR7x_5wsnS105gb8j9IZolYrlV0DY9kJctS_iBRFQ
Message-ID: <CACmP8UJ+Mp_53e9cnKDV3st+3_H_nYW3qkfvib34BS_s+5UPng@mail.gmail.com>
Subject: Re: [PATCH 1/1] uapi: fix broken link in linux/capability.h
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for noticing that!

Acked-by: Andrew G. Morgan <morgan@kernel.org>

Cheers

Andrew

On Sun, Jun 29, 2025 at 5:03=E2=80=AFAM Ariel Otilibili
<ariel.otilibili-anieli@eurecom.fr> wrote:
>
> The link to the libcap library is outdated:
>
> > $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/kern=
el-2.6/"
> >
> > <html>
> > <head><title>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/<=
/title></head>
> > <body>
> > <h1>Index of /pub/linux/libs/security/linux-privs/kernel-2.6/</h1><hr><=
pre><a href=3D"../">../</a>
> > </pre><hr></body>
> > </html>
>
> Instead, use a link to the libcap2 library:
>
> > $ curl "https://www.kernel.org/pub/linux/libs/security/linux-privs/libc=
ap2/"
> >
> > <html>
> > <head><title>Index of /pub/linux/libs/security/linux-privs/libcap2/</ti=
tle></head>
> > <body>
> > <h1>Index of /pub/linux/libs/security/linux-privs/libcap2/</h1><hr><pre=
><a href=3D"../">../</a>
> > <a href=3D"old/">old/</a>                                              =
 08-Nov-2007 06:34       -
> > <a href=3D"libcap-2.00.tar.gz">libcap-2.00.tar.gz</a>                  =
               11-Jan-2014 16:49     37K
> > <a href=3D"libcap-2.00.tar.sign">libcap-2.00.tar.sign</a>              =
                 11-Jan-2014 16:49     819
> > [...]
> > <a href=3D"libcap-2.76.tar.sign">libcap-2.76.tar.sign</a>              =
                 13-Apr-2025 18:20     833
> > <a href=3D"libcap-2.76.tar.xz">libcap-2.76.tar.xz</a>                  =
               13-Apr-2025 18:20    195K
> > <a href=3D"sha256sums.asc">sha256sums.asc</a>                          =
           13-Apr-2025 18:25     14K
> > </pre><hr></body>
> > </html>
>
> As well, give the complete reference of the POSIX compliance.
>
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> ---
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Andrew G. Morgan <morgan@kernel.org>
> ---
>  include/uapi/linux/capability.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capabil=
ity.h
> index 2e21b5594f81..ea5a0899ecf0 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -6,9 +6,10 @@
>   * Alexander Kjeldaas <astor@guardian.no>
>   * with help from Aleph1, Roland Buresund and Andrew Main.
>   *
> - * See here for the libcap library ("POSIX draft" compliance):
> + * See here for the libcap2 library (compliant with Section 25 of
> + * the withdrawn POSIX 1003.1e Draft 17):
>   *
> - * ftp://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/
> + * https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/
>   */
>
>  #ifndef _UAPI_LINUX_CAPABILITY_H
> --
> 2.34.1
>
