Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513F257435
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248386; cv=none; b=npTfOHbNiKprTsH6cE9OUouYzltyFWAmA0Wa0UW1PeKH7+tiIQY9kANjmVUn6fA7hBFnig55qSVUjCb4ddqDnrQ4il4x+S3fsWrS4yFPeonlAz0L+4QghumYbshULPf8Qj/GZn5PtAZmihLZcGZes6P9PY9U5kmmnKT5Cg0prvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248386; c=relaxed/simple;
	bh=emvmFV6gt4sH77fH9Bh1RItBSzfNP8I7enfoTm7bE2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9jxKttTSgfJ1Si5jgqVfWD+WzPIvZ6kJHUH29KRFf3miOJ2SiaWj0h6o05IAgqrg8ppUgUFAgOj65hwpws/obGV/b3bEaez1jVtobESxyh3w1CTt15eypOrVTjNbf2GaV8nSm7z1AeEObMvxdUrYOpgUYXi8lEdW5NsnG8/Ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4E1cU+r; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4E1cU+r"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1165440f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248383; x=1758853183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8n7EY/AGGTtwI6KgYgIDwupIYQFTu+v14oHPas8+fk=;
        b=I4E1cU+rI9Mz4D+xFTdxvD4GIv/38o4CGbRUYUvGfNkKMAP+A2faMdyPB5r5DGr1FP
         2fz2u+zqyJ2zz1Zi4Q/fJEwk1XPihngOyNSoFgiwaSo81t/02E5LTXcrPjKyZhuDvV/H
         3cUFUHs2y+JYO38R+/EcZewEgA8aBxgmNegnll1vuL3fNl3Uz3p8eR9JZIkDo9+pU1hJ
         LN0kf7PXwbPEdwvqaVwcE7X+H4320RBVh3JH5ecZI60gKYmSTU48nTkM1A/0MMnPwAkt
         VBxYP5dp1cRaLBZ4TcrHHMb+5vbwX50qQYYuLK30yJkVE4kN/CjDw8v2R2tH6A/knE93
         0Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248383; x=1758853183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8n7EY/AGGTtwI6KgYgIDwupIYQFTu+v14oHPas8+fk=;
        b=tfB4iZXflAc6gHYLYrA2cBVbT1/LgYT6nJ/Bl6MgNRk0Cf8ITyBoSC0jXd99U0iNCz
         PIIYztIvsvwiahcWkjKwhcZ7hdOYtpzxxMbzLKRldHkBWb5/1heVf+/gJtbDF/ZgQCTH
         35bFy3XFOv4USRMswBitJBUe5Y/5/8sQRnRH6oQQjWYdxjdH3uZ7Dgu9mYawxkhSCN86
         cC4YYEZ7LL4KmqehwQ4cChCl4nUvngWsrb/ME6/RSeH6nGekk2H4czrLVO8rfyqhMqrv
         msoSjFSW3u7cLuHlx4XHKZ2EmkoEy/Th6ltbGnh4LjZU1R01ZaaTzGLIgpXVD0eYMnKZ
         /ooA==
X-Forwarded-Encrypted: i=1; AJvYcCXYfCfgEmwp4oubjcawB6k2kQXR82gS5vzj+8g1IWu6KGCqwIQI5xXoP7pA2EAJ7Vt0fQIGlxf3lKPufYkgrb+hKVJ7H18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OLDm0asfUfkY3zpQI0MwHQLTKuxrvAAri2AqReZakKXtI4w3
	3MJIErMeZ2bJ5aWOXpXFU9QcdsqI8aFq0MVo1CTe+7myzHXk2xfYp+4cug1p/IhugB3GgCiVnRv
	lNZeiuMmRtsXheQUlVd3gEQaGKrmjmbw=
X-Gm-Gg: ASbGncvfom/KtDUGakBhXVPDZatm1EvESKS2rEL/lFGexo9tbiHjSLqkf2U2SJJdrTY
	CBnMvwnVkN/nGjwV6XVEq7fJhcRDWn6CNackunJB6O64zQn/GjTxQ2Lb6s9rWKZFY0jwheNkkwW
	wffhmPvPcyTkL+KtwNQMcSKo+wVHlW9S5rb0fWsgY5OTgbzwtovw3prlRwgmufOLqz64wEM5E1t
	zaNmPq6K4TSK1LW7EvJtzgUcWvZmeUHvecfETuUBGukpOKmQzw7bWo=
X-Google-Smtp-Source: AGHT+IFSIllND5LsmTREPu1Jp792g2q2mvMQXo40LGCv1dkyhPlNQC5E07prEnb0QS17ki7xd/BN+mS/CxsfwEqTolQ=
X-Received: by 2002:a05:6000:2689:b0:3ee:1125:fb61 with SMTP id
 ffacd0b85a97d-3ee7c5529a4mr959660f8f.7.1758248382964; Thu, 18 Sep 2025
 19:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-2-kpsingh@kernel.org>
In-Reply-To: <20250914215141.15144-2-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 19:19:32 -0700
X-Gm-Features: AS18NWA2D9XDvX4ildEjyo3VK1FVBBpLlviSn1PPafUMaIeLPTItIZ_4bwmvcoI
Message-ID: <CAADnVQLo8udasPu_tWeffY88opzpxb2Xj9c2ppt1Lvz5VkRUvA@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 2:51=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
>  int bpf_prog_calc_tag(struct bpf_prog *fp)
>  {
> -       size_t size =3D bpf_prog_insn_size(fp);
> -       u8 digest[SHA1_DIGEST_SIZE];
> +       u32 insn_size =3D bpf_prog_insn_size(fp);
>         struct bpf_insn *dst;
>         bool was_ld_map;
> -       u32 i;
> +       int i, ret =3D 0;

I undid all of the above extra noise and removed unnecessary 'ret'
while applying the first 7 patches.

Pls address comments and respin.
