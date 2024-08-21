Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58814A4EA
	for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258138; cv=none; b=FcJ//fejD6RRc69XZAFyPkpuKYm81Xwhgp8AHcQjoJ497bb/R5CAxWP8b3Mxxqf8RRdjon4qQuvqVeQKIv8a38vGntLZ/lMRuiFbPtNNQAMVU6AXoJ2dwvvYlksyXAnaYCthYWDTeE1lxujbUydXQnD4mJbC7R0VODDOlyrazWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258138; c=relaxed/simple;
	bh=hzBeSbaTtIAToh/GaX5rZx/f1VGFsqzxE8W9F/KKb4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pfd7vytsDilB8WLl1r5P+wqNxCArsj2lvXhrmenOWA2o59s2YAndiRz4L/nTXX3PMP9FdI3uh0cDypRjW+ARGRmCAVAvkbzciBlZpQzspdvGLx7wMl7b3NG9E6/Oq9JenTH+ePrUwQOaxE89VhZ/uZGFZvI0jcuBE5Q7jRaEgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OnqKf2k9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OnqKf2k9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6aab656687cso8557857b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724258135; x=1724862935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssKb6qw6aeMO+6QGtyvALnPcAvbpew5UWcwhrzSGCa4=;
        b=OnqKf2k9Xk9j0A1QhT3q6q+kCA+r5CfBKLYyE30T03DnlCFqtjnw1XubPKW/pIhZK6
         03cdqrbj/gjk8RWP0YXvi4+29gtyGY3IdQRmbbkI5cyyw6Tg9Ohqxy4ujjU9tUImxWia
         VriTqRDNgnXSVMWo7YzQdPdtNIQY5nLbRw0R2aHSpcy6afCgY5k/4toAZVb4CWuOA9+t
         ShXO6Cd3RYlEtYHaqRNdYWDC/HBnE3BSZLrZDDjwwqLp5ScpdbCil6V7eG67k/1q3OyU
         LNB1U5PGuBmcOG+jusLNSStc9iPRIzp2s+1WXUdWj79dK1qQaGV3sg36ZuzQKDzbOvFT
         /NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258135; x=1724862935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssKb6qw6aeMO+6QGtyvALnPcAvbpew5UWcwhrzSGCa4=;
        b=AYGyOxC7ZHFF2QaYjetM7o9h3OgOiD8qurML/A8d+aksG6vJ0vls8OTLpPuCwtlfQK
         N5fK/DS6WLAqewcRGSkmP/goH3pEAX6V5UxUD1Fiu3hOP3sYpP70yn12EB63jCg9PcJt
         Q2e2vv6W96ALCzEpcQcj9MloYuIVoA809NujeamTdQPJfrOxyMEWjONKaKJiKgPaGxq+
         2iidzeRFmIn9hrasJNPSqJXvc6u0XD89aHWI5qysLfHPkTzC8SNLkhLLnMSKPfr9xk9X
         k07SgLWu6WBvCo+IljJowwKUw19SwHpb6FTYju4s/CSRfSa+MzaQQpcMevzGqPRiXWig
         UpCA==
X-Forwarded-Encrypted: i=1; AJvYcCXJczf5WbDSM+buFsgDa1gsYai818DjqD4+PsaAiydrhokWjigcmh7+ac2gAk15okcoDS3DZbpOsCQn79+YsGyTG6b2+6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WyrKphy2l2cQreLyZO1dBZ7cuuHVdXCg9EeG8wRjXGpmzM05
	vhs39IBvaCELvWNecTy2h1odl6KB8MgV6nwa3PvnHnPpXCdh1/UtVZegSThlgqKij00Avz+8UW0
	B/iMMIr9ksuWHq1Em3kxT9stcLoxBTFpgwRLcUW16tz4KDWI=
X-Google-Smtp-Source: AGHT+IFFJJaltNCA/IDKVau9jaELlCUOp8789S+uuTRwgIUoSv9E6HoUzHZ0yFPljmsWOYHtvETnEbDBnlf6C3JyEkw=
X-Received: by 2002:a05:690c:63c6:b0:630:8515:f076 with SMTP id
 00721157ae682-6c303cf67bcmr2591717b3.7.1724258134800; Wed, 21 Aug 2024
 09:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com> <20240820235730.2852400-18-Liam.Howlett@oracle.com>
In-Reply-To: <20240820235730.2852400-18-Liam.Howlett@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Aug 2024 12:35:24 -0400
Message-ID: <CAHC9VhTWRMKZiximDFAuhY0PwvHt8rk913LLKLQu20tjrnN7cQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] mm/mmap: Use vms accounted pages in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:02=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Change from nr_pages variable to vms.nr_accounted for the charged pages
> calculation.  This is necessary for a future patch.
>
> This also avoids checking security_vm_enough_memory_mm() if the amount
> of memory won't change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: linux-security-module@vger.kernel.org
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'm pretty sure I already ACK'd this, but I don't see it above so here
it is again:

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 19dac138f913..2a4f1df96f94 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1413,9 +1413,10 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
>          */
>         if (accountable_mapping(file, vm_flags)) {
>                 charged =3D pglen;
> -               charged -=3D nr_accounted;
> -               if (security_vm_enough_memory_mm(mm, charged))
> +               charged -=3D vms.nr_accounted;
> +               if (charged && security_vm_enough_memory_mm(mm, charged))
>                         goto abort_munmap;
> +
>                 vms.nr_accounted =3D 0;
>                 vm_flags |=3D VM_ACCOUNT;
>         }
> --
> 2.43.0

--=20
paul-moore.com
