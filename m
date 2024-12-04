Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA46F06D
	for <linux-security-module@vger.kernel.org>; Wed,  4 Dec 2024 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283939; cv=none; b=KZ5HyGiJzRyKTScCdNuBD/6qmuPQD80IdLxYTWKG+VeX7TaBnbbnSA55ilhxVcqzidLOgmDHl7L06pUeT2kOljhZE12XlNe05smzbngAEYMTnzsTTq7gTQ6CBTIIVi3zy7JXXgaaoqs9Zarr+pFs9mb0E7dXrOuxbilfj2Uqi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283939; c=relaxed/simple;
	bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBFzvMEIwMbko4gnq0TbKMJXkBiezG67aBVOdKW6TC7ESDAaR/ZFJgpONSM33NEZjlblzxO85KwrSGlNHt67fw+rcsY/EHiOP2qDSwRVT+jZ+TI5XsTYUaSPCpwtei/L/df+C1++/Gi6/69apQwChFRFHKm8vI17cW4EAOB92fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YqOz8u5T; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YqOz8u5T"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e38938a55e7so5332402276.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2024 19:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733283937; x=1733888737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
        b=YqOz8u5TnRcqvD2j2R+fJYo5RYCCQmSjn6XkK5dm2c384gnHP9I0Qj8skbh1mjFbSZ
         sHFW8IOZezK9ANBVt8WDiuNmFhrTZXaH4kyPiCFQLqwPk7xIuSZqUiWIY2hijrI377er
         YvoHUL6Ig+2k44oxYur1LQFNvQ3XdkCQb8qPbB4w55gfHsXEvwdmN8esI+vN7DM4V2Ts
         cl8ZEPrm06ZDSnFvhcoUwNUi202XpbAwgQ5HdECrT02xw11znyq3pLZzjruog+KqIZm1
         8E6oti+kxHQUj7YhcOXHys861gjAUTwaNrD4pWfdABlKQLNHwXdmQcPQKSKggNoBJQCn
         gHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283937; x=1733888737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1XbbGsUJBtc2zHLxA0NJaY+IxjwSMN+nIlUbS9g7z0=;
        b=lmI0m/9s+zmaXMvQbeRyj1M8P2WDOjNOM6dPnNCkHnUitBMZytlj2pwQSV5qWMWiOI
         VKr7OfEpfBwDf0fjbRyxqp5X0Efn4yxcKL9iwL3gGFnvT7LtAmlp4whw+1KwyXjM/YCu
         oWCoTKvINSrmOhF/U/QNqlX60QtwcpAZW+MV9u0PdHz0Cspq1683U7XkudrkfCOo/XRv
         7t0si9BHcmBbJBdsIfw+l/dpvCRAtYpznTK68h1BIa++2u7wZE7XhGinDc3aD+FHz0r1
         QvpxZi9XyvkF3U4omypub2f9iK9Ue5Dxql1nw/xqi2ibirA/Xh/Cu0311BFEM892s2wX
         831w==
X-Forwarded-Encrypted: i=1; AJvYcCUH2tIdkiHEsBKuDzzpoBMR1yOXkJGsdz5N2gbFy/3lvZ0K0O3QZWLwuRh2fzB0M6/TjmpqqyquxYeKXcSZhoGNJtcDwAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzie3/PwAKXMCF+je6DXPwjVO9A4f1u2dVs5PZ1sFGgi2vz22S/
	xtFCyhSkNdxfzH8GgVfTpTJCXYqKfvuDOhDNJWZwVp8P4nnPHbX+p3fJfi2hEjqCcUnZ9a/AL7A
	ECC560STLYuvF/2KWJ9vns9vv2Z8ixI56/b5E
X-Gm-Gg: ASbGncuOAS2vWfC6YmFF4GWOzlS0usGoXUs/JrSjCBLIED7+nADuqWHYbt+2aDmb5Rm
	Kb5jO6idDnUltIht4gDZc8LXIt+FNTQ==
X-Google-Smtp-Source: AGHT+IEnXWo1p3qjR3U8AU/4Sw7qLma2QQ0LRrci3nJqI5tWuNU5cRLLQ8tXAXSK+umt83Aaiyni6AwdQeANpibv2VY=
X-Received: by 2002:a05:6902:340a:b0:e39:6c6a:f2de with SMTP id
 3f1490d57ef6-e39d438d9bbmr4803300276.47.1733283937166; Tue, 03 Dec 2024
 19:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112182810.24761-1-av2082000@gmail.com> <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com> <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
In-Reply-To: <e8e6824c-61d4-48f9-8547-628bbbd3063a@linuxfoundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:45:26 -0500
Message-ID: <CAHC9VhR5NVHOz84RBzi9L+h=kqpe3RfaEXDa+87BCLPAt+Qskg@mail.gmail.com>
Subject: Re: [PATCH] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr`
 test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, shuah@kernel.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:00=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> kselftest patches usually go through subsystem trees because of the
> merge problems you mentioned. I take them through kselftest tree
> if subsystem maintainers want me to. Some do and I pick them up.
>
> I pick up patches if I don't see response from subsystem maintainers.

Thanks for the clarification.

--=20
paul-moore.com
