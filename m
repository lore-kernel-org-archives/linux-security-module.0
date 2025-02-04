Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C594B204C09
	for <linux-security-module@vger.kernel.org>; Tue,  4 Feb 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698030; cv=none; b=Rx1FYxfPkPvQKpafN7KJlEOiECMepKnK8IFqdVSIAPqmqezUw6lWdNkKVoMH0r5ECQLynV91yZPFWMIcFCNv1GqSwABSLROnxlmiQ2Snf36pyrzcJL0GkPRRagfKhXTxf0DT1n1AJGVKPMhNDGfKxPk80EibSsuWUCfV6x4CFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698030; c=relaxed/simple;
	bh=cdGM8kH/xxgAF7oW0/bgae15mno8ZQcgJPZlTYmiWZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON0VJ/dHj9qHn06hJN0/sZUKdcDBXMmDebUsGAzKo3aYyQcxlYgdnIwIL/qsPCoqR5Cvcsowfy/PK4IsoYXlTaPhZ+UDDdluj7DM9fsDuslNoQMTuBZUMmedOlHiV1SI0pD3+n/WL+f5WXitrRJB74C6PG+RBJqlqqbjbDjo0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3NXN8oF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3NXN8oF"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f754678c29so41349377b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 04 Feb 2025 11:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738698027; x=1739302827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdGM8kH/xxgAF7oW0/bgae15mno8ZQcgJPZlTYmiWZE=;
        b=d3NXN8oFQqFBWyO+ks0oq+4M809qaZyO2jGqGfNsN+VoGNYYz+0QTB9hVBW2tvpugj
         H6tQTAqBdL+XeCTgwyrQLw933fsmCeQlO5WqYByqTvC58P/OKrqSWE9FNsLgr4yvTmtW
         6qB5rCWqD/xjbcoOP62icgHlvlKltiSlGxAIoSMTgrtodd2F04Z8n3n3/vkO1STlTdqs
         BIclB0A6qCDQFaTRqzJxYXlXMWkjLAJi5T7df6ZDFPrNbdHWpxS3iqQMdRkZmepAJIcT
         d5vjFHA/F6OfdSdyMCYE882LjZFNsZbR49XLtD5Bm1E7k2NFMN94OppGJ3HVbdnk0RFI
         cS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698027; x=1739302827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdGM8kH/xxgAF7oW0/bgae15mno8ZQcgJPZlTYmiWZE=;
        b=RHa9BBdE2MJzhELe9qD07J9fUNnuFVXmkHoNA8FnorCjlCOIOCP0fVv/GEapfsRiia
         d8LLKfiqQgKhf12UUAyK8lJoSt1znlsxajO8dZzxuGn2vYu556ub9OuILHuqopxeCm5G
         Iymplmd1GI2hrCctPvLqGI1rNy77hw58w2lAwIg0NNHeXfMHzAaQu00yoFnWMwZInKoi
         hEtreYBEmkinGAB/OSJYtbVlbbbU+FToDtvoZtmbAC8ZyZrgWyxQ2gpxDmm+ee5uGPsH
         kQHRCS+mG35TuFBjc7cYlifS0gOY4a1Q7YN8emGiY+KO2frd30Z17/utQEhjykON9dGa
         4Ifg==
X-Forwarded-Encrypted: i=1; AJvYcCUbcMFRZCHoNPDxwOpYnOjen8GRginePmQ6PJZz9XqJviOnneiBbWFTi95ttA33lkFu/IeAX6PCkWOuwa5pnkAscSTnJV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mwVnlyUkbhjRbDVuz8pUmRYTme92fMtv6JXA51570fDQdHSC
	AypG+Vve9wZcpeoLpDYwsfMRhVPFrf4XmbpqAhFcUMhfxVT2K+qLz6whCxL/L+imRlPEvVAxeyK
	2+ApLwX5c77kCnQQIFZnEzNyanX9HsCeDF7WA
X-Gm-Gg: ASbGncsWKkxdUTkhf5fjzfXW2XL4NIR+IrUpIRAqDEq4TxjvOpi0UJT4PHpRb0MoTGG
	sRSZ7wgPGLSM9+X9xI4ruZpJZK2Q5/GkzQpFKcuKFH5kZd0cVP+P9/w/+Vl9RO5W0vc0bguw=
X-Google-Smtp-Source: AGHT+IHWFCt3o0biOX5PlAx1Q1W7sOdakfYdrhJja4liqbRx2tgJL0CHhFhrdJ07R5vN7YVhHWgWbLaOhNespI1IhNc=
X-Received: by 2002:a05:690c:4681:b0:6ef:7dde:bdef with SMTP id
 00721157ae682-6f989f89aa9mr771557b3.23.1738698027698; Tue, 04 Feb 2025
 11:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru> <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch> <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch> <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
 <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru> <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
 <CAHC9VhS-uSaVmy65oA8p6tCzMZxMsuzdmxO-vf7L0p44ZKO=_A@mail.gmail.com> <CAFqZXNtq7SZSu_JyY5yaiOQy89c=5jG+vqdg3_RSUWm4JNN00w@mail.gmail.com>
In-Reply-To: <CAFqZXNtq7SZSu_JyY5yaiOQy89c=5jG+vqdg3_RSUWm4JNN00w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Feb 2025 14:40:16 -0500
X-Gm-Features: AWEUYZn2hhrCR2-AHfRC_KOGhFrEXsKH0qPJHGGH-UvtSfO7A88HAuI2_QqeHyw
Message-ID: <CAHC9VhRF0bka4zY5y1uNYUGXNSSwz6cdta+c0NH_YDO0MxauRg@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, stsp <stsp2@yandex.ru>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:19=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Feb 4, 2025 at 1:30=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > If a revert is the best path forward for v6.14, do you think it would
> > be possible to get this fixed this week, or do you expect it to take
> > longer?
>
> Willem has already posted patches on netdev [1][2] (thanks!), so I
> expect it will be fixed soon.

Great, thanks everyone!

--=20
paul-moore.com
