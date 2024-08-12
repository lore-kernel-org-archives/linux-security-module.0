Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116152599
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491200; cv=none; b=jJ5aCo6ILnNYUP6rv+czT3np8nWuD9lX8zoo3Z7J2e+JZ4NX2mNyiQn3hLFLm9sRBHKUuxAPMpYggPFslU1UyO+ynor1SVPuaXOtFKhCbCtUfz8EdjGpB4DiPRKkeCpn/jiKSxJH+CkLqQA+M7N+uZjewi1ROw0sMcJ4VTqj4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491200; c=relaxed/simple;
	bh=I7o/TuFiT1ulNiY/juCjMT5cj9AdysN9wAmi7vH9gKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8rX4I9qtBhQ51ZbiiAbVebij8ZDjLDOTgOp3IjrscAUO2Hb2Fy3HDAB1uyyG720pJ923pJ8fZOjO+yYIOJ+4qNzweDEAIXGsKUvQU0TD8HdcH41ORjfEVTlBk2nQxWZPkGNeyWxi/9YH2FHkMYRP6U7/vvEM0Nygd+XP3ZE+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RBkAVD7Y; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RBkAVD7Y"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so4455674276.2
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723491198; x=1724095998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8ueVjdRYs6KlVN2J9hv8wL+GejLjR9GrR718rCUfUg=;
        b=RBkAVD7YVDizINxtBpH1yHSq9pPyLwrHhTvMuIYjz6a8YfUfPHSPkaSfLc0/EnOJPC
         KCJl5GwEkGQHUnXhLfE3k9LcSr5bbkPrELSG2YWfe97FA46HgE13jtNGmI6bkQiGRVGT
         12QkKHsJWH97lAaxq+xsjS7CXucPEzL7M7PFCD0i4SCidu1zO0ubxZiH+Kqf5NGZTuFD
         6A7N8dGNujS7ACi01HAF+JbXqhjKHpFqR/XLX7XkYUcOtQJiMOxQHrKEj+bZ4ftXRBo1
         R+7YH4rZQYzNqkWO9G9s/aE5OTk8c/5gMGkIyrZ8k+EELti6jMIzKCLIZfbYlfZnSL1w
         Xa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491198; x=1724095998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8ueVjdRYs6KlVN2J9hv8wL+GejLjR9GrR718rCUfUg=;
        b=BZ1/wMpJYl8aYzofG87huQ7zt9Tzw4gFbLio8ysBdEesl6V8XIAUdL3795JmqUbhaa
         TwSWgvjzhyabv4+Dp1nOwH9JzYaYcQY5tzfbDDagwgOkDwJToDtZYb3vOaYwAA5UoQnS
         +AdrBD8gVRl2VOKdKhAnNq5d5HjFdnIRUfcmp+b+gF8m/EiS/4O0kZfWaos9IM3ef3xs
         0+vKTIJeuI3Nlt1H0n8wEDtUW9TqshrD5bM1kxHrGZODKcDT2wIBBmnVVs2CKq0lVk4S
         OwmL6noFXu8x7+O4tAIeof1n+8KLMEQ4hiblFwNoBMTj4lVHSAV9V9ZpRIuAP8LMLbq4
         C7LA==
X-Forwarded-Encrypted: i=1; AJvYcCXXoGn8GWiOzHLg5HksGduujEJ3vVjCiO2NyDK3M0QS3RMcSfPbxa/2qHeCN/lhdoJ9YIBEv0RSLnEyBcieKdpOL92z9BBaQNryv8WNausqcWgr1v8c
X-Gm-Message-State: AOJu0YxuYnNaGtAnhVtVnzAEMbgxdo+NFQ6btbJT0yLMSmR5s9B8Hm+A
	wDb7OWw1g4FHSLJe5p6I41mWT1VIYUKMOjniwomPwcac+iGF1sGUc2i313cnOopGl7C9cT5xj6M
	Nhaf5SleUZQVmLkT6JzLVqJ/SkKVyaVKggMWo
X-Google-Smtp-Source: AGHT+IG/T2WWeSxRTx3K6NjUZgI6/jCXqtBmNSmHWiEPCtzwVFftWXD+AHPOFIsHBFbzqMm/faid9c16SXjdccZDLho=
X-Received: by 2002:a05:6902:2b8a:b0:e05:e942:e7f5 with SMTP id
 3f1490d57ef6-e113ce676damr1747017276.5.1723491197963; Mon, 12 Aug 2024
 12:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
In-Reply-To: <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 15:33:06 -0400
Message-ID: <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:12=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> JFYI, I synced with Guenter and all arch seem to pass and alpha does
> not work due to a reason that I am unable to debug. I will try doing
> more debugging but I will need more alpha help here (Added the
> maintainers to this thread).

Thanks for the update; I was hoping that we might have a resolution
for the Alpha failure by now but it doesn't look like we're that
lucky.  Hopefully the Alpha devs will be able to help resolve this
without too much trouble.

Unfortunately, this does mean that I'm going to drop the static call
patches from the lsm/dev branch so that we can continue merging other
things.  Of course this doesn't mean the static call patches can't
come back in later during this dev cycle once everything is solved if
there is still time, and worst case there is always the next dev
cycle.

--=20
paul-moore.com
