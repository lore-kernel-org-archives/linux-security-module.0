Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA11C5485
	for <linux-security-module@vger.kernel.org>; Wed, 28 May 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443739; cv=none; b=uD49OkFKqXbDevwyk3SfwqfCuOVbN7yOrEF9GHdTuY7w52WnnNjqtdwi6Z7K9gyWOrbNkL5xj58Loo6cESbT3ZPLYyFcmsLmjFWi3PFUOX6eG18v+9ztfYQSiHP45YDzVKU7IqPsY9DHqYVZoC7ip5Qo0c0MsbWtZ7EXUj8NJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443739; c=relaxed/simple;
	bh=PZlmfJV7Wgug39OzH1hwrgPG1upz86rPP4T8kkNFJcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJUProRhRcOctbHq2oNKBnZGjwbddYwNvPXNZYfyPqmey5wYbRzSvgo95S33zAIakMIPdqH5O7NDfJw19nwtSg9HWd9pn9PH0aLwOgHNGTVHMcHHp+LLkOMiTtgxZUi8+2pXw5KNBIkHVB5OHKsvcqNy3o33zGvmYK1YgUVdBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiJMOhrr; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiJMOhrr"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-602e863492cso5568984a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 28 May 2025 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748443736; x=1749048536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZqR8UmBXPSXzPu3oEQ1Y8CJWsDYZqgdGGXCY1/+LFw=;
        b=aiJMOhrrllFPtNJkg/nYX+6z+oyCGiYqchTEYRydZkk70RpLqNWIqzrMxyhvvx4/KP
         kXPtkISG4clqYrDJWwgwjjdCdk5VvrrL8yWE8nwJpg1xxbPiF2j3CTGLj0t38ZxjbWTN
         Pd1gb24a14ed+AS6Ly+i693OSp0IveMZ27+Nc6smY/ZO+SIQXBV8s/IYZHDagGN0iRrg
         DN+72r18bXz5ZhQibmpEGg5vpZWy5ZW8llxVj1Oj/mq3KsndKuFJaYVxO1vONW4V2IfY
         a80md8O2GBAoo5P9dUHdbbe5N9uilpg6L680fL70BtM1CRLQk4Qu3udCXpfZBb2d32We
         BiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748443736; x=1749048536;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nZqR8UmBXPSXzPu3oEQ1Y8CJWsDYZqgdGGXCY1/+LFw=;
        b=msSHEgdhVsOzxbN3ahKWugkic1CqlKU+lsCX+JF31Afd+uTFZTT9QaqqT62COE2rmZ
         2ED+aDJMYeB9FrT+oPfH4D7mAIWr0EdRoK8OqwKzw1R0QmfWL9XaEH2aV47iR6ii4Jjm
         b3DKLwiWpkpdru3yoIHdQoJ0rIZAou2ZG1/mhB24yg4W+QxTCd3dfIaqLBuZHbSUNZat
         j1R7WamKDPq2/EzxyTP98BxZvBpY3/HqVOvm2w0tkIk6aGEkFSnfeF/3ndhW8FwVNJTS
         VQjpOQ48tXYCFyRIiA3Th8+Xh60XXl4c0SXw8eLsNghxfSeSJ9V6DFiGh+7JouiYDW7I
         Ddeg==
X-Gm-Message-State: AOJu0YwzbAGJeMB9X7163rTMW1u+h4N7VcnvNmiog3oCFTbRgunV0K9r
	h/l8jGPBu12B7+bM7W+s4fT1P6NyxNwXcsYCtPw9zHdvC3NjtDicCC1qtOreze2ILCChw10I5HN
	YbCVUzw==
X-Google-Smtp-Source: AGHT+IEQUnsQZja8bCOBYQLEH0ZqRT+b/YC/fA0jRpOPtHoFE+uSdDEscnP3uLAQGsif/YAZH8z/Xbgy2pQ=
X-Received: from edqk7.prod.google.com ([2002:aa7:c387:0:b0:604:63d6:6b90])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:d45:b0:602:ef0a:cef8
 with SMTP id 4fb4d7f45d1cf-602ef29d3cfmr11665970a12.18.1748443736117; Wed, 28
 May 2025 07:48:56 -0700 (PDT)
Date: Wed, 28 May 2025 16:48:54 +0200
In-Reply-To: <20250528144426.1709063-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528144426.1709063-1-mic@digikod.net>
Message-ID: <aDciQt8aYcW5qrEZ@google.com>
Subject: Re: [PATCH v1] selftests/landlock: Fix readlink check
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 04:44:25PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> The audit_init_filter_exe() helper incorrectly checks the readlink(2)
> error because an unsigned integer is used to store the result.  Use a
> signed integer for this check.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/aDbFwyZ_fM-IO7sC@stanley.mountain
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and d=
omain IDs")
> ---
>  tools/testing/selftests/landlock/audit.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/sel=
ftests/landlock/audit.h
> index 18a6014920b5..b16986aa6442 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -403,11 +403,12 @@ static int audit_init_filter_exe(struct audit_filte=
r *filter, const char *path)
>  	/* It is assume that there is not already filtering rules. */
>  	filter->record_type =3D AUDIT_EXE;
>  	if (!path) {
> -		filter->exe_len =3D readlink("/proc/self/exe", filter->exe,
> -					   sizeof(filter->exe) - 1);
> -		if (filter->exe_len < 0)
> +		int ret =3D readlink("/proc/self/exe", filter->exe,
> +				   sizeof(filter->exe) - 1);
> +		if (ret < 0)
>  			return -errno;
> =20
> +		filter->exe_len =3D ret;
>  		return 0;
>  	}
> =20
> --=20
> 2.49.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
