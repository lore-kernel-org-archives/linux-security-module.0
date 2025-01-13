Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15F8248C
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737000; cv=none; b=sH0EH/NnQCtH+LjY+Z5OZgQM7S8JICzhLCEb06WnhkArp3qa2SiirPL4Xp1zn2iXnVljaTf8k95DYucBWWTCif3b09VRNL/bNiR4rS6/Zqfgf6C1hHjdtieCT0kiKD1NiZCHu8sH1TuPIfNHm/huoMPm07dy+GeWcNES5Fb+GIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737000; c=relaxed/simple;
	bh=C1iu4TmU/AZryZK4710MbhiDlwhEBApAQBoxuQB8Gbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHFq8QY9qcPK+lKLl3tzrWap9qJwBP/j8gRQ1OGuDZDmKGK3/zsO98ubSIlZ06VgKH+z2Ol8Xg9X91255lbtsat3Dgu3EO81pWT8pzPKfjUYajPlcdleHKENf61q5gKAMuX/qNZNxMO3IdYqI7JgiK17ZuXMxTLvXemkEapEJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=boq9L8Re; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="boq9L8Re"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a91756e5so6623760276.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Jan 2025 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736736997; x=1737341797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1iu4TmU/AZryZK4710MbhiDlwhEBApAQBoxuQB8Gbo=;
        b=boq9L8RexMcsmglexIYOcxZ0MhmZl31BQ0u0TT55zZxUPAErFHwkBVu/GF3GT3YD/3
         S2WqvYi4TNG1Q6bWH9CggBXiM379cw6k0q3LxXjhh+wBZHmzf98hKuJwA++SItWPm9Wp
         hCBQARhS5uqu2WWfHJ/161kdkr6FL6PYiHsm0NwYjqRtPXuRUHlV1UVl4WnJML6nzq4w
         ueAzbgMJBx0CHO5dWy+QRhkNm1spQhPbayUM0uMe60Gdm9ZgYmVh+BRVyaEO7/woW8VJ
         0dIPjX4YJZodK5ovA18GAtmScZ9OHB7vpklN6rWkqUme5UBBDJ1uQ/9+c9+8jwPMR7fB
         2t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736736997; x=1737341797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1iu4TmU/AZryZK4710MbhiDlwhEBApAQBoxuQB8Gbo=;
        b=KLKj1SWoqDMVSotfY69NsfFOoDTAvfBWVExYhw7RgVmDtGVs/QoseYGF4udqUd89nN
         xNNdkDOZZdwZUS9mgK1USa7seL25Q68s3djyO50NYA9lm8IJ1AnsBn1Vuau3d1pXlLXP
         VrAvpLRR43El0O7+aAEo/oRCqWIdE44a8eD+t474rdZlV5bUokCg5t0h7NcXoeVsgEuE
         6hTPFBU8kVcYpS8W8GHFGv9FEQIxrpv2NTGOxV85n7GF5WNGiuY8pSqGvkMN3cmdwJPd
         Fs/AP1DAxwwP6nVlQV2ROsxjHiyojPjrJbquDrgVLjby+zXh8gEjD6r6C8rcbM6kXLiB
         Tu1A==
X-Forwarded-Encrypted: i=1; AJvYcCXCfkya0Ikp9syaGjAJpDJVtNhYItJAGscbsRsgb73dExvw/Xi7ocb4kIiaEOpf00VSK+od6qK/ilMKLVjYWulL9tjzHDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEL+rlPnO1YiekdFiaivKgM0ELFWzjmK2o07bjgretc64cKFU
	juG+lXur5RoALRv2LFDS6Q1MArrlLTc1u//gpU9m4MqF0mBYp02z89rNZ6UCb7GUBxcuxPB9DUU
	/GBUqpxt9AIkznhkv3X0yk8N0T9/tYtCQaYkh
X-Gm-Gg: ASbGnctibnxP7MVGmSoJMjhvc/821yP6r85y1z9l4xYcIEEU7mDnRGYKqmW+kwMnHV5
	1Ej7a/UCi57Dmtmi/i8nAfAVO3qPuamcuKo/T
X-Google-Smtp-Source: AGHT+IFjS7DdRTcEdBRLB9UTOd3mDij4P3x6llwm89cu6gVhI47+WAfxD1vVcp4PpGcONy8Uv1dZysPvrHpMXqA9mNY=
X-Received: by 2002:a05:6902:15c4:b0:e3c:8b14:e7ce with SMTP id
 3f1490d57ef6-e54ee1f4a31mr14579604276.34.1736736997649; Sun, 12 Jan 2025
 18:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
 <CAHC9VhRbZLtBZ8dH-kASnkQUehG4Cu=zd23A6Jj9zfnyeGOTsA@mail.gmail.com> <3c73cee2-a4aa-4e85-bafd-d5571e857849@I-love.SAKURA.ne.jp>
In-Reply-To: <3c73cee2-a4aa-4e85-bafd-d5571e857849@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Jan 2025 21:56:27 -0500
X-Gm-Features: AbW1kvbyZN2Ngdlc0r-2OxHSCbyV0tl9D8n5OSt5gTQRGL2HTVecrwUevJ2okxg
Message-ID: <CAHC9VhQxxwyDkXvN5S7XbbbJTk5-LN3MXteX+F+Bx0wTxujhow@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, john.johansen@canonical.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, mic@digikod.net, 
	gnoack@google.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 7:00=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/01/13 1:36, Paul Moore wrote:
> > Hi Tanya,
> >
> > Ideally this patchset would be split into into seperate, independent
> > patches, one for AppArmor, one for IMA/EVM, one for Landlock, one for
> > SELinux, one for Smack, and one for TOMOYO.
>
> I don't think we need to split this patchset into individual modules,
> especially because this patchset does not affect the result of kernel bui=
ld.
> We sometimes need to do "git bisect", and reducing number of commits help=
s
> saving building time and testing time for bisection.

Merge conflicts and spending time having to coordinate maintainer ACKs
is a real time cost.

Split the patch please.

--=20
paul-moore.com
