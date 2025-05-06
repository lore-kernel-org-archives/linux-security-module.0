Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382338382
	for <linux-security-module@vger.kernel.org>; Tue,  6 May 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551841; cv=none; b=UBm6Ng03lw2u+45KzZRqMD00/q/ipjryJQ4K5YaZ7BLPaCP0Bxj2NoMLSPOjWHNYtZzFLdIYKw0q+jFRJvwlFLb8U0Zf48uU02qKQy8h/e0SxO3Pq+/5EL7pLr+H5HT+VmYomvt7J0+Qde/YY5tTjMDiZEziXsvbhUY88GTvAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551841; c=relaxed/simple;
	bh=Y1D/Ai7Th8b1ulsQV8Rw/WzGuOfLtn4luAEIHycJPbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz+7KsYhWjyq/uphioSEqeaMdQIvG0MWHUIeH9m/RS4J3onIuEp3IOzfVe7RZ1/wlvUr8+rk7thgyMVcv1k+8taC5l7SSqeLYEzO17UWlLLRUHE9w2QqnpyRFx1b4E6sLpwEAcnoLAyLAnbb4BbqtDj+E0X9MQEHLSZ6R31aqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ho65UNVd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ho65UNVd"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 23E283F206
	for <linux-security-module@vger.kernel.org>; Tue,  6 May 2025 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746551252;
	bh=WQHjxQ599keg+lxgKKgv5hY1aqkd9MG97ygANGkcWy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ho65UNVdU0TpPIDaxVPqfcJu4n9rDTe+VYQXTwEXp7ZlNznz/9ZN+dNTZg9QXVVrF
	 tOuFdujAwkh7bY4c4tDKO1d1Y/ZB5QjVnK5nVWpGiSmo8G13p2saoKAvweEqssS5BQ
	 R5BupcqBqfXrufv5dYiYj5+zHSeNgdthCp3fjKr4ZC8jyx17++vmkXEApIhAE9V/6V
	 KZilmxVpmgpp+dbvEIgEdZ6TJUncm2x4nMFBSAmSCeiWIVzWEFfBmJXfZSEliVgDxM
	 k144RnjVtpSupDG3zSpOeXLoxckmGr8uoHaPvfsZk4Qqvw5e+CTpB29sPJPLURD13E
	 cd889P70NJmdg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acf0113e311so524841866b.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 May 2025 10:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551251; x=1747156051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQHjxQ599keg+lxgKKgv5hY1aqkd9MG97ygANGkcWy4=;
        b=nPk/KMva0RqYR/zKvZRaoTsnDOcLdbrm5XlATSTl988ErsRHgaw47ktG2/WkcszGn8
         aC84RISt4osPPZudCSa6KNYWnZ+ykvgiMPy4JbgMqz4N1EzsJcoNh+hD9fsXocYQa+gs
         Ufa0yeUuUo57oxt9IYmZUKiNdjtvNaeMKK3J6rO4YdsayByxeoSD8x+ZnzjpL69PODM+
         FPYZ2WoKINyt2rk/Ftdbigz7AWur76tjTVb5rSNV+XAD5ixq9Iua0MDtia6jWSS7R70p
         DJ5M+t2673fTELmoHS8FfuzAdHxrYrGXTfOxhsw1p4dDfmcOR0zM6SfP6t+CQc6nz4zh
         huVA==
X-Forwarded-Encrypted: i=1; AJvYcCV1uyO9zzJX9GI+Oocxmr45ScmecgJXVtf6OjZA3ll1pZ2b9kfTUTLQolsTgwFF7N044nA+jnq3FYIJ+ZlXiC+nwIVyGeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPwJSxO+vQKhYPFQ6pZMn2TWohsht84M+gauSPL10ZjHwBoOH
	VrIw+4Ztav6NogztNB9J2WIS5WukZVGX3EyOOY9FOKwFsf+XjRzPAd+pqL5b6m8JjHyZnEXfp57
	xcau+39pbjXfVF0E5dkss+7a+UJyZ7C1mZRPprUiTSSo60iVeYtlwT5B4zn32xCB6sa8gvYOM3m
	p5CUt3vdzLTKRIswYss5/MNAOsCb+6wD94NBPsEVVzBiPz5K+Hq2xPUYRMkzSoHNGmBs83i/ols
	O+NoQ==
X-Gm-Gg: ASbGncsU++mGI0NhkJdSwVNMmjC1IYH/FcCeNVbS4fIHyWND+QO6x6xfotBFgePTH3J
	je9mKR62UwV1lpMEuEwn//Jn9kgZ2W2iTZ7Wqe6dNEe/WsqW3EfO2TEnsChCnADxWa9GV
X-Received: by 2002:a17:907:a4c1:b0:acf:c80d:ad81 with SMTP id a640c23a62f3a-ad1e8d03300mr24484166b.39.1746551251638;
        Tue, 06 May 2025 10:07:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEELCfRqIOuYUnndVtrp9GHbcIPFv6oQ0mX4mJunFchFQKzR4N7i7UxFMlcDKaCqsfET+x4XtS3/doFGJc8mF0=
X-Received: by 2002:a17:907:a4c1:b0:acf:c80d:ad81 with SMTP id
 a640c23a62f3a-ad1e8d03300mr24480566b.39.1746551251309; Tue, 06 May 2025
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506170425.152177-1-colin.i.king@gmail.com>
In-Reply-To: <20250506170425.152177-1-colin.i.king@gmail.com>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Tue, 6 May 2025 10:07:17 -0700
X-Gm-Features: ATxdqUGnt11yRJyWyktYtIrCkZT5mDo5sbrkN2hZjNJrjV5n2rzCVahg-DNhbLY
Message-ID: <CAKCV-6uAdn9SvUFrYqGo0ZzJUtPAYgRFcfHPgmrG_GDt2Ob6Hg@mail.gmail.com>
Subject: Re: [PATCH][next] apparmor: Fix incorrect profile->signal range check
To: Colin Ian King <colin.i.king@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:04=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> The check on profile->signal is always false, the value can never be
> less than 1 *and* greater than MAXMAPPED_SIG. Fix this by replacing
> the logical operator && with ||.
>
> Fixes: 84c455decf27 ("apparmor: add support for profiles to define the ki=
ll signal")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  security/apparmor/policy_unpack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy=
_unpack.c
> index 73139189df0f..e643514a3d92 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -919,7 +919,7 @@ static struct aa_profile *unpack_profile(struct aa_ex=
t *e, char **ns_name)
>
>         /* optional */
>         (void) aa_unpack_u32(e, &profile->signal, "kill");
> -       if (profile->signal < 1 && profile->signal > MAXMAPPED_SIG) {
> +       if (profile->signal < 1 || profile->signal > MAXMAPPED_SIG) {
>                 info =3D "profile kill.signal invalid value";
>                 goto fail;
>         }
> --
> 2.49.0
Reviewed-by: Ryan Lee <ryan.lee@canonical.com>

>
>
