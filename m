Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147D438474
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117671; cv=none; b=MATxIxVmxCZuostS4SmLnhF5OT4KQKy3Ikwm9x8jSWAdyNFL6utkJzi4N00Z40Nn6dR6C4lFbYsKwof5mHy3+5ZNdAtlCPV00uNCGpUHS5aNkkCzBuXFc92MfTqmBa6WE2qYS6NbqMjbLtbilPqB3+ZufSm2k0gL7wqd3jsVn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117671; c=relaxed/simple;
	bh=7l5HtpRgvbRP/p/vraPzGrmKeo7JcieAQWq5+ruq8JY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oumdqoKhopBhnsY9wc30T14slzBThPsW1+/3e8ZwbAUdLd989du1Fk4NT7HK+hg1nciKy2rkHXKRd/fbFATGFgjeNaf5PFfhk3wTZ4s1Korxu3N10WrFDOOoXUTXfjj02lo7fD6kTK1w8tkmUD99SD7F/OqzncsfUUMLf43ol28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Mu/vnMM0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Mu/vnMM0"
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 248A43F581
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784117667;
	bh=Z1wRYrxMf/b7EKNdkrawuxII4BrqF3kp1HpNStGRH88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=Mu/vnMM071eLhfLB7+CBnuDTpG11zc94o7NIhAaKu/stRWc8ty9CiGVjEI5pbiKhZ
	 etSKeT6KDMAJLQQINCnaPN8/QQC1M5RR1zdhBXY/FfGsWfTBgR7++8/+7y9fIpks2z
	 wqYBL6fGMMCnpEmVcmTRQ3QzHO9LSF5QgepK9fYO1UN+sQKoVKOVhuRFBfKHrb6XKb
	 zf6KnJWoBhhAPc9YzpV9hKg168viFbIfupe8yLjXoFVVsbdtGwzeEzisdFbcKBGIUp
	 wHG4FIlg07KgCVOiFrHuu+QwRV9Zu4i7YlD08iGLY67g2MzP535bqksUjtz8nywOAg
	 CdTSf5d5IHpOk2f3v6tG3FOJgT1kbEsgW5FMAn+TEj6RwXyFumT2+xJiCyjB9KYTrH
	 HDyQzF0NyY+6kf525AUVAp2kOzg5eTmBnCFAJKWehpNzYrotaA5Djcu9gUT7wvEKnD
	 9Yio+emwydy+UtKw1Pa2gJwXg2KZ3k/PASMDPABRuRB5wW6Kw+BrwucFQmlsNw/4ea
	 rVoF/3gg2RUIP3YcJYlrW+XxcHTtFTLyVjOaH3QsLI7ws/qJ8kaTtOWRQUTqIuT3Va
	 tvCXJgwayZMARKarNADn6FFMO6aZhVErTq5ku1bB9KjvPYRqWrvVatujmcgZc8plEb
	 jRSuXcoBBGiB1Vi/EUD6Xr3Y=
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7f582244e9eso165102087b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2026 05:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117666; x=1784722466;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :organization:references:in-reply-to:date:cc:to:from:subject
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1wRYrxMf/b7EKNdkrawuxII4BrqF3kp1HpNStGRH88=;
        b=lWoNj+ifoz/CpoQZXYsCVQz3cT2PloUd9M9LEs541G6nvf4h8FPB8ufKV/AhCrQzbQ
         16D9d/jgdbIAr/nch+fLxuvCgRI/PoNlmk2Wcx+AnNxKcwJTKNQGq40HCsbqnVc0Pw2U
         StWoG/hDP6aDtcNzvVHPsYDQpxFNfNqhHvm8GPquxKlYa0jl6KeDDI4v8MIo1fp9JNqa
         vAyfviCT9xf1cYTEkt9cL0LDJbc/n9U87+1l0E6V/AZYBqr7NN/fCbiOPR78QZgN2lBd
         Dt5M8c45R4Yi9GuuU8Oe6Fo+8C+tOpvwWNDTTbugmhLlOHjrWdxsHI0zxSVDlHp2WWiY
         kJzA==
X-Gm-Message-State: AOJu0YxF3j0RNWgcI9SHNRTFs21nxWKL+bj3nB4oXByo0QJaUu29oec2
	T6NBl4UY+XK92rvErBAnLDbnrP6Puq/acnh4dRMsokybg7Gd0FGpM3ZIOorelOsqsLH7+eDIxiV
	0KUHhcps9ZZTugoIC+IT9L3gmNAyilUlH7mMaixUxkn6jq/W30O/qvhZfwuZ8QD0yWQsyUqPoGh
	cuZLoIOJNAylsPSyiP/A==
X-Gm-Gg: AfdE7cldwxjkuVxcAbk3peKXgi2YdHk37klkcxs2pKtRWpQNOTtNDzl/ttmkrRsm3OG
	jqGBvmB3FOGvZ4XXTExdkvLR8B1BgmujFVjh3inasQU7bYQoHeW+Nxc8Cgyv7oD4gBN8XTocSQ9
	/GxGThLdX8t8LZyNBuWYLhhQ8nCMdGs/JuGXo0+q2/AdyxyhrKdUPLgsitY0mcGz0tH5QsLDRXc
	vUx9inHC/uJWREtuSPoQdFZexnAI6ui04huJaFZS+VZWTBP5bKweiT6M9jtF+qF1hn/o594nfG2
	m7xgHN2CtqB3c3kyDetJxhp7Wc4ya0zePYrFXGkb29NWS1cplwS/SFf/9dZjBUm0YpNoUIr5MLN
	Wnc9habprio9Hds2DxMtBiY5NcTwBMqI9kxvDMjHes+OQylWzsLOXu3et
X-Received: by 2002:a05:690c:7406:b0:81e:b7f8:ca47 with SMTP id 00721157ae682-81ec0109be7mr45483287b3.57.1784117665767;
        Wed, 15 Jul 2026 05:14:25 -0700 (PDT)
X-Received: by 2002:a05:690c:7406:b0:81e:b7f8:ca47 with SMTP id 00721157ae682-81ec0109be7mr45483067b3.57.1784117665413;
        Wed, 15 Jul 2026 05:14:25 -0700 (PDT)
Received: from [192.168.0.106] ([138.36.34.39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bc4285asm166373637b3.0.2026.07.15.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:14:24 -0700 (PDT)
Message-ID: <dd652e1fbc0620d7d45e61f81336428860441f2d.camel@canonical.com>
Subject: Re: [PATCH] apparmor: replace decompress_zstd() prototype with its
 entity
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Maxime
 =?ISO-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>, John Johansen
 <john.johansen@canonical.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
Date: Wed, 15 Jul 2026 09:14:20 -0300
In-Reply-To: <df2830d0-5ae8-4bb9-b11c-6051fc3784ea@I-love.SAKURA.ne.jp>
References: <83eb9325-9688-4a6c-9727-e137df773694@I-love.SAKURA.ne.jp>
	 <df2830d0-5ae8-4bb9-b11c-6051fc3784ea@I-love.SAKURA.ne.jp>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Sun, 2026-07-12 at 19:17 +0900, Tetsuo Handa wrote:
> Fix "undefined symbol: decompress_zstd" error caused by decompress_zstd()
> being guarded by CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=3Dy.
>=20

Acked-by: Georgia Garcia <georgia.garcia@canonical.com>

> Reported-by: syzbot+1f14a35d0c73d31555e4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1f14a35d0c73d31555e4
> Fixes: 17b5758bf35c ("apparmor: Initial support for compressed policies")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/apparmor/apparmorfs.c | 72 +++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index 2ae9ab94a5a91..152c7967ff1ba 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -483,7 +483,42 @@ static struct aa_loaddata *aa_simple_write_to_buffer=
(const char __user *userbuf,
> =20
>  	return data;
>  }
> -static int decompress_zstd(char *src, size_t slen, char *dst, size_t dle=
n);
> +
> +static int decompress_zstd(char *src, size_t slen, char *dst, size_t dle=
n)
> +{
> +	if (slen < dlen) {
> +		const size_t wksp_len =3D zstd_dctx_workspace_bound();
> +		zstd_dctx *ctx;
> +		void *wksp;
> +		size_t out_len;
> +		int ret =3D 0;
> +
> +		wksp =3D kvzalloc(wksp_len, GFP_KERNEL);
> +		if (!wksp) {
> +			ret =3D -ENOMEM;
> +			goto cleanup;
> +		}
> +		ctx =3D zstd_init_dctx(wksp, wksp_len);
> +		if (ctx =3D=3D NULL) {
> +			ret =3D -ENOMEM;
> +			goto cleanup;
> +		}
> +		out_len =3D zstd_decompress_dctx(ctx, dst, dlen, src, slen);
> +		if (zstd_is_error(out_len)) {
> +			ret =3D -EINVAL;
> +			goto cleanup;
> +		}
> +cleanup:
> +		kvfree(wksp);
> +		return ret;
> +	}
> +
> +	if (dlen < slen)
> +		return -EINVAL;
> +	memcpy(dst, src, slen);
> +	return 0;
> +}
> +
>  /**
>   * aa_get_data_from_compressed - common routine for getting compressed p=
olicy
>   * from user and get both compressed and uncompressed version.
> @@ -1517,41 +1552,6 @@ SEQ_RAWDATA_FOPS(revision);
>  SEQ_RAWDATA_FOPS(hash);
>  SEQ_RAWDATA_FOPS(compressed_size);
> =20
> -static int decompress_zstd(char *src, size_t slen, char *dst, size_t dle=
n)
> -{
> -	if (slen < dlen) {
> -		const size_t wksp_len =3D zstd_dctx_workspace_bound();
> -		zstd_dctx *ctx;
> -		void *wksp;
> -		size_t out_len;
> -		int ret =3D 0;
> -
> -		wksp =3D kvzalloc(wksp_len, GFP_KERNEL);
> -		if (!wksp) {
> -			ret =3D -ENOMEM;
> -			goto cleanup;
> -		}
> -		ctx =3D zstd_init_dctx(wksp, wksp_len);
> -		if (ctx =3D=3D NULL) {
> -			ret =3D -ENOMEM;
> -			goto cleanup;
> -		}
> -		out_len =3D zstd_decompress_dctx(ctx, dst, dlen, src, slen);
> -		if (zstd_is_error(out_len)) {
> -			ret =3D -EINVAL;
> -			goto cleanup;
> -		}
> -cleanup:
> -		kvfree(wksp);
> -		return ret;
> -	}
> -
> -	if (dlen < slen)
> -		return -EINVAL;
> -	memcpy(dst, src, slen);
> -	return 0;
> -}
> -
>  static ssize_t rawdata_read(struct file *file, char __user *buf, size_t =
size,
>  			    loff_t *ppos)
>  {

