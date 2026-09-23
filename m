Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80774756B1
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190883; cv=pass; b=ByF5rP0BnwRvwbTnglEHjybPNfOgcCUM5RBLmlzUc/7wz4ldO7EMA9GrH9ZjJQn9qoB155tOGd4tnL89uWVamxgRi6/hc2Y9G+d1lhUthQg9VypB+lzYzhQ1Ngn/uT6UJ5TVKEIsaLM+M5bsMolTccw/Puy58krF+Qf2/kEBezg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190883; c=relaxed/simple;
	bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNZ1aVjcBsy6eshXZx0z0VAUxmWAd3J1162yos/82QGglT9SHEnNr6TOUVQyEb/0+hisO2rIHHid+eOJgtsPr7clHbEcJBQzIdvIyt0GbdyLT7g1aEmcM6NT32ufSaN9wkkNbTchTdxwPKRMhYK3zTM7AQXtgRjS8g8Rh4ZDxpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN6/y9qs; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN6/y9qs"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5306abbdccbso1595921cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 12:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190880; cv=none;
        d=google.com; s=arc-20260327;
        b=d0IjpuJ/BnrSGtkgeGYKtRPxe+e7AJTRUobxKG4pKQII3kUbDCp56jSxl0W4/uCyac
         ABvLdrf+V9pHYrlnjAmmMFkwY+yxvAg61iO4m4UhtWDpQxeDVeiSdPdHXGx31oY+TAYW
         Al9JM3TVRluyjnxMS6uTTAa3+FExyqEo/MiOl4ja0uG996umMBRlGqeHoddM+lA2Krn+
         ks7POnsN0dx275Z58k+PEQflQ4CQhnE/dBVJLqL81yEQBb2y/LR1Ni4DJcGyEf64F9HG
         R86GZVGMncqA7X+MB5TJgUxcK/A/s7IMZUW8D6a42G3EFx0YYhIDsu9BO3f2Up2ySjOU
         DtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
        fh=Me13TvY5CaogygMzH3CbsmaA6/KU7LMjpBRa0PT9prM=;
        b=CY30x7Bz9VZL8qhM7v0ki7cK/TCaeL4KqKmwOO9hTHe78F62hW0XNhTvw7zq2AEl3j
         3rx1fy2Rw8yjVXEi09hSSdvPYc3LD5cbCPbcaBHsH9Nh3LiG/cQ+cxsOOI/qMcESjMjc
         IEqTU1hVUK1F6lzGXV1VdnbK2xepTuEpfdDpSNofXo2+ih9kR+amweHLYKMdlt1C+/P+
         bGdZ4EPZZs5xOEPUK93lKbyZM+Sl7nJShTVZkNLxU+6rQSnlwZ9lNm1kS58BarXsK3fA
         mqkH3qesODp3dzmoDNKJap8j8u5bwIzaunaP7dkQeNinEfS78/HFog8TqscWl0O0FwGx
         5Sjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190880; x=1790795680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
        b=PN6/y9qsQJrB4EqOwn8c1Bbz7EoraFGwL3VZnlCG8TVJ4sZ+uCfICKKOORm0DRvGzf
         zdrNOTG7UKDaQ7Kt6fR0tKYcqpbgMj6DxubsD+KX+saUnnMtJzc4KLceNgspEQUWge9a
         vzyRWiAuFBNM4dRsHw/HBH3XF6vtiWoGtFLKhb2yFaSwyZ7w9rsqgqXJ3eyaIRoQ2I88
         kr7uSVLlgUZMGBtRD+O18htCpxTdNl/w/hwyeqRP4qF4XJ+GcZfVFGsbtiv/RbYcT8It
         WP/e0q2gGoRQ+Oj3EFOrvY4Z3tG60yOf8/IS8K+/orOvEo/a51h6ZE9dE4Yx8Fc0Wu0q
         ph1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190880; x=1790795680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gPCH1FawZYUr4HVUW56LhKmqq4sdZ/hZDa7tEp9rEU=;
        b=lhMulCog7zqiQCqmMeWx53JoXigtK7ME4G8MnVM1RLgIPE9vQvCmKJuGNzOOS4PCvK
         j14u8gVqeVQK2/RoF4Y7MOlIfnanJx+5s3CJ8W+EX7QDiOg1pBAh7USQ0d+ikk1zRh4O
         yWrEyrJalympmE/outpi8sbJU9O5TV0Y/4jvOetLRXVZxOVoaoQRXxouy1Ae2aY0IP2u
         7PgnOX/h9F8pHfWRM8FdW9V/8llaeKfGWR50Iq5oItLgrJLDdyQhfkqXh0S4y1JAdMZx
         fPWFWrAZAC6ZWuDWOe6e7JynZF7fFRu2g7fy6O5fH7ZXdbOjEW8PvdEPtstNHXxJ0Vws
         1oxw==
X-Forwarded-Encrypted: i=1; AKwUvBy05UavXjtHR6ZFX0GM10+yT/UlX4DEGm2G3KZo/89qF7i2z8vID7zZP6ZtMVger38sWUDwmz4ICxCz55emx6ycer6XaNI=@vger.kernel.org
X-Gm-Message-State: AFuF++nhapks6fsjiBagdply6j3P/rQOmjo492Dqa8jlbQeKzCcJ0yAP
	xBdvaZxIaxWgXWjn7w2h2uXsqLBz34+NspsXIPNlNR7mtCGK4U8T3MxEu1zsEYiAbRap+H+6UBZ
	SLRKVGO8pTY1XJkHXPYc815pbWJhap5qLduqa/bI=
X-Gm-Gg: AYBFou21VyZCapZbkp6TPUiD2qNbnbTGW4Zm4g981kADhdFyK0Q3LPAyw/K6sC/aVwx
	ROejGfCIhx1su8DHOI8hadrPl2ZzyN0o6DrGZHh9kA3mmiAAsQMZ+G1GCoJXdfa7X9G2W8X6+rW
	cFiDr5Dt8oteLQwfDzfvQD1JhWTn16Zhvh7NyQERqeqBT3T1vdKJSdapSgU4hFNpDdh5xKCLQch
	ezs9/T0viEtIrit4bcShH00d0i9H1dFvC44Q9Puv5XhMvo1Gjtu5laupS8e9bU2iiaboETwHG+F
	w+awKLRNPOGmMLP8DUCLOvWio/IFIQ1W29qBkj9Hav6bT1zjwD1o/gdI8UIwuFpr17kXF2pAa1W
	GY+fXsDG4plwztry+sFwRnPGbJrN7tHc=
X-Received: by 2002:a05:622a:408c:b0:531:2087:63a7 with SMTP id
 d75a77b69052e-532fb7485afmr1858331cf.19.1790190880383; Wed, 23 Sep 2026
 12:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
In-Reply-To: <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 23 Sep 2026 15:14:28 -0400
X-Gm-Features: AclHuK9d5OdaJO5Ll7iOJ6jpvdM_SUqGbTaoCVRmfsl2t7C9t_IuciwujiuXmkw
Message-ID: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> @David, simply for my own understanding, did you ask Daniel to do
> this, or was Daniel operating on his own with this patchset?
>

Daniel and I work together and both have things written on top of this
kfunc. He reached out to collaborate, I agreed. We're also going to
send bpf_set_file_xattr shortly.

This implementation was chosen due to its immediate mergeability (it
only touches security/bpf), but was actually suggested by Kumar in v1
or so of my original series.

That said, sorry for any confusion about this appearing as a new
series rather than as v7 of my previous one.
