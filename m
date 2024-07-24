Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C14A18
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852610; cv=none; b=ShGshBtdqYO0DchXdW8Fnv3Rj/3pb4G9PdRv18HgTX9w++kM8Ld94aMRsbFrQpzrLSMr0QUBChnrY8BxdrZ/9Y+zmm86AAa+7xMu2VoUoEDDF9sPopHnARaK1JCUg7e+m/fqcfx7Re97I8LoZsXTpquHqsfsKK8ifixuFOhrm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852610; c=relaxed/simple;
	bh=xcnLzfTXgYpBsrPe0Cp0LZSob6SdOshKVqgBDArFwzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTD1oSUxNa3t1KeW2frdF457gm8uYYPjI6OWcv+xBpfB5TqUC5wqrsWxIoYurKktcNWj0ZkfSwdtz6yWjI+fApQ+Rf7mOJMufSSHP84nyz3jqeiMljqkEDPGNgMcKpDej5MjxixCwPZelvzDOHPz6AGxBgg2Jeg8cWDzplr6Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=In8CvAqq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="In8CvAqq"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f8626780aso1900707b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2024 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721852607; x=1722457407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gYlyIbBkXb8qsAW1cRX82zo3FxiuDkqxGc6DCAuBao=;
        b=In8CvAqqUZBweU+/svZyNLy08WpJXCmrLtID1YfTxHam3BBBrER7XXmXb91I/n7sNe
         bn9euJ0ObNf8V3z7KIsfRk1QdrDUKZL6iWVImUnPTaaGBzNwqvTQixaP2CBwtIHoqA8e
         bR8IyRB/vhr+lNrvoaHm7j9QG/B5EsuSocjZl1W7WQSnw9c8VHiIOwOBzzlev52xZdnw
         hqj4OhsrL9D4tIeviAQgBBhxdD8DgbmFWEDfqgRkIsr35f3WRcUAWFxhTV8ddEwygIlq
         ibpoUmEfnNLxoJuf1qafW0F1DvqctQuTL+/ddLX2XebOc1shrF/ZX83iH2aalFjFyDIb
         wAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721852607; x=1722457407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gYlyIbBkXb8qsAW1cRX82zo3FxiuDkqxGc6DCAuBao=;
        b=uUgZdOP2lTz7gJHQr7VrxYoFvyYbm0iaH8usxnAbJfpuuZrr8+yWYWDKlA20YwmdNP
         gpgtyIBR450xAnlmU8iVfDS3/DlIfw6sO8wLzll3/zNdgkl3PRv5YVBsy5+FcWAToIA4
         oqn0FUUWIQrlprFyDMPBLpwLmkTQHy/RpMIFwR5/nnSQ1LyQV7qyb86v9S77yvZo9Ori
         oY6dpQb69xzLO8Yjj2h52Sad/1Vs/3HOA6ALVxBKTkd9IaXk96Y/kSRh0RGV/uHIBRDu
         9o/GjqaULP7MWyIFxFcA2PQuDpmy2p1gR1NjeIZi0EvCRBP5F7IQQLt9LivYWOdi5+5R
         rLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUArcASFnFyq5G5cmTC1nOGct3ijjUUCeAGh1QLne/V9O3/7pIlAEBj/RSFU+sISDxPRT6ckFpx/Xb3A59zRB8VzFcW1iwsNkRxaIIb+vO2CYCLYaBO
X-Gm-Message-State: AOJu0YzZagNIzZeMm6ElID7aMR4zmNo0aFlaPn9nEPY4H/JDTkwpwf43
	1AMz8rfsSxFfLQfonY4AfPxMLrUeWtNmnA2H9OyRzTiaYi6c01bvrtkEbEIROY+xJUfxwrCosKk
	fGfhwkN+NQnx4XJQ/kf/lkjGXot+2ZvlG8X3C
X-Google-Smtp-Source: AGHT+IEEcMOMal5KuJ8dK2KbEhMkWJaWkbUba3UfO8Xct/hz3BHrKr71DZX/SGkmGDlwXiFsYxniAoqZTENJSPiWQdM=
X-Received: by 2002:a81:5c8a:0:b0:620:2cfb:7a0e with SMTP id
 00721157ae682-67514e42a34mr6143987b3.40.1721852607459; Wed, 24 Jul 2024
 13:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com> <20240717200709.1552558-17-Liam.Howlett@oracle.com>
In-Reply-To: <20240717200709.1552558-17-Liam.Howlett@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jul 2024 16:23:16 -0400
Message-ID: <CAHC9VhQHQ8aWu_eYDXqmMrPkUCd=KV9MV7WbjOtSMCa1GjfGBQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/21] mm/mmap: Use vms accounted pages in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, linux-security-module@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:11=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
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

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com
