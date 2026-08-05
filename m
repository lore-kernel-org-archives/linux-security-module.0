Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB932470454
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942664; cv=pass; b=LZ0pEHdlR7aF2BWsDWotG50fdVV8SPQkQNF2k8vm9KKGqoSBbvNbYAeJRzoIcgIsQlvnAzVelAMFI7X2oeOlDdvCEk97joM4v9ZQGngWkMBoTfGD8PlN9GiwOCqb7m0O1qbKsAI2McR6phJp74pjWS22KFAgzllJlzfpX40mNm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942664; c=relaxed/simple;
	bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSuzwxH0nqGZGlmTt2SKFlb1K0jeKiaxSAFnwKTPfqI95z8q5FZf2vOprgnYqwZ7GQz4lWIm8UaU5eN80P7fZCp44AJDUv/IOIhOO+CB6UiNZw3OKRtgU+463XYm5b2JbJp/v4oKs1tOMiq+k0WsfI3Fg4DBPne0OJHs+6+7GzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EktfBeF+; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EktfBeF+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacef7d299so118865ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 08:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785942662; cv=none;
        d=google.com; s=arc-20260327;
        b=OdlCHpwnFBu5hDiOLBsSf9PkqfQ++PRyD7crcb5ZrNmvDl5JCnAMvKoz1glPIO/nvJ
         yECV2vhYlhDCfn05GElNWKOrNJmhaRo6asprwKZNI37IPeSIdv9E9Vl0ryI3+HjznCk2
         7Xmf4oYESUWgv3ysB+dNiiJQIAUqOVBubtDIZ6k0/6TrmF8DAnt7xlu+yorA2SfqqZ9H
         vZ9plOyl1qrOcMNLA9DOaj4noHZTSRF02h5tj+SoGpLui4XlJBNs1zGEM1kBhmbIwyZt
         +4Vhl26jXuQceUfdYLb8IzYhvlET1sJ1ueEvvI1oDPCqCWA0pqxyX+vDRbXXKKoYjOXH
         SGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
        fh=v9pXANZcysw/ZsnyTM3QGPk4AFaazz83+tx3o4pVKU8=;
        b=YFPfxTZEA7AvXKeWjhWNYQzWbeIeJDu54BR8DUYhd7FxQ9o9CJ6NS2tCzwNskDwQoI
         pdu0yYHPzwMvgHr8UWWyH8vdViA9eN702JGj0UcXIVMnnd1AMnFUfxwkwkwAXdPJ//s5
         i7VlJnYPYp/3M46wgkKjtKl1SoUqvOCx3gbAGT/3ZeEJLxmEr8qn4ai59zGrFEAo61c0
         82M25ErsaP1gogmE4LEmu4Q+0vFkiZpiwweyJ5QpL9tRTkYhf9YSZy7N79UbJbQRhZ0S
         t2NRDtHqB+8cvpjJsLV/Vxrhn91jSvAMFxgYQX9PBoWfSJTupUYEje7MW02qXmleTI45
         7BtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785942662; x=1786547462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
        b=EktfBeF+Eli/hjyQAyfsOwBYrqV/5BYcCuBgoTnnKs+g0hgiQ/fqEAhXkDeJdmcEfo
         wUCzHe3fxTVa3FZbgkN1S56iRDhOf/7FPxNzzlSVs20aMnPI3PrBR7P2MJFwn7t8zUNB
         tM/78rNvoViiNeJ03UtQACOPmT4zzY/2ZLEnyPigasKU2TRdAP9TeoYokiZAcxtC14NT
         MvynT2b5v418NTqvtDZcx5sXLSt6Ud1yvb2w0jttlIWxtjS1w6GN/F5dc5XD1dQKRW6z
         Y15ok+xnjJyxyYciaTrC1Z2UEoOsjkhWD4CV83uKeaKTbNudQn+unTDtlInBlPflw7pY
         fKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942662; x=1786547462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lX2TpoPEgr9PQK1qCyg1xp2rJ99DufHUG00Jec8j5k=;
        b=mPqiel0vosdNnbeRibJv+nfyhABzbzkwFg5eHcykDpQGnjqV1JA8QlqaUwqYd4JcWr
         MHKHeWMcaDJWFHOgW3X0djPAYbek3E8Mhakix9K6WklTenARTrK697qnqAXdPx8lEWqD
         ExLw5Hna22JH9/Hn7XXGRDTJBiNXXB2HD3eWiJ2aTKBi+a1Pirg2eu378sQGSMLFQREn
         9A04ub61THvQoUvMZoe6q6j6U8UjBfijJ0UuC/f2KpLREQgaITZXVsFIYg+wdXedcn/Y
         xqvgJo0OT9FRFJWr39LIUsXg44x5zqVK5HmkEpCAuJfzQ5/AHhoLclnKJ7LFM6FUV6JU
         nn5A==
X-Forwarded-Encrypted: i=1; AHgh+RrcYAR386Ob46BTlJyUX29+umTu3NVDmxtrfgRy159Y1YmTr+T1bSqaFEDS5Hqzs4Qdsr69QlbkhF3/0wuL/wt1BTvhl28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1KYKgWfJ6DVSqAubPU11uVJCCakqDIaaOu4Kn7+/cAdIKIRI
	8HDHkm+KUnzAgX5R1SvE0esSqbtoDSNZ+oJiZY2PN6HDsTYs7VdY60NzW/lFiLmjkPO+X6RQxJd
	ZgyK9h7E43Ze4SYoDbfTBukJ6NtaIrsxQV9xYxEvO
X-Gm-Gg: AR+sD11ucQCKyn7cqsWTqW5U6y0+vg2HqNy1hUnIVk4Q2QwSUlj1h1Ut4OFLu8ZQGIW
	LG97ZV+P3KKQaTXZxXVKJJtzcadzOHOFEH3zIPSBGb+7716/a0mg78RJ3SoQt7Z/+0BZqVYRLYS
	WcT23fqFw60luoIpnXlZmcpBE4reQWSgidZx8EHvhZvugg7NpfOpb+SYat5PV2e17pH5VG2OqMp
	bJapEsxORwzP51IBChadsjdy1yotDy00rRaQZxc1vCqkhP5jgM4gZvzmbGqqZll+cbPR+RPhOBr
	t96qXp2ZnknyCfq3a8rKpy4asPJEE6cUlnZXgUmqbX1hkEilZ6chdSc0rLdnWhannQNbNlgN1bM
	NgxJ7LrMZM+TqQLwp43OpisDxnwHYsks=
X-Received: by 2002:a17:902:da89:b0:2ca:6bf:5bac with SMTP id
 d9443c01a7336-2d0cae8f44amr11533235ad.8.1785942661451; Wed, 05 Aug 2026
 08:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
In-Reply-To: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 5 Aug 2026 17:10:24 +0200
X-Gm-Features: AUfX_myTcsrk-R7oyPxABub-MizWAf2aGlhLPWIrIHNJM514VudAdz5cv_qhGcA
Message-ID: <CAG48ez31uJ1utneG2VepgkpYp-zpmypoBJ5TTXOxiPLrZsXTrQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>, John Johansen <john@apparmor.net>, 
	Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
	Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 5:39=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> AppArmor's begin_current_label_crit_section() is a scary function called
> from lots of LSM hooks (in particular VFS/socket-related ones) that check=
s
> if the label referenced by the current creds is marked FLAG_STALE, and if
> so, attempts to use aa_replace_current_label() to replace the creds with =
an
> updated version that uses a new label.

ping, I've seen no activity on this fix since posting it
