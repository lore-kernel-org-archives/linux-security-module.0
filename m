Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C72367DF
	for <linux-security-module@vger.kernel.org>; Fri, 22 Aug 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894968; cv=none; b=bHwljf2JoWQirjK6BLHdDkuMqbUvuvTIjdi8CRWGp6bdZqHC+9kwqwy97MT1ti1pgXlZgKraBuLdEylnO0qxRxjKE7yc30ltw7tMPkN6OWm9mkJFo1xDo6Yq6MHZ1v2Qdz5n0oe6fWmh0U3fLA76ySMQpUVxmwQhse5hv1X2ZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894968; c=relaxed/simple;
	bh=ZejjpqegP7pBTsXg9DqvJDX9XFOOUc/JCgIxN5DaavY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9+onJ3WN7g0onzh7BOFQJCvYkUTpLF7IzH14HTIezJmtN1bJ1ojG07/nrUcuaKJXPEaBhhl/oWabIeTp1mQsYlIM4fmF/l6uzOX6vX0dXd4Dd5IgakpaHrPZ4sbgb0p1bgEV/4kCHKait+Qeyp/6t1RS6M4Vq6Prjmkn5m1+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ISzxKzsB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ISzxKzsB"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2eb09041so2399526b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Aug 2025 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755894964; x=1756499764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKAAjhqefwh7uPKlXCd2E5AVbFKIHMZ8KVLO9HosMUo=;
        b=ISzxKzsBIWosgcOcsVgWgVvJPIIotn+CQZDRA2ljgU8GImow1RapGZLR8yE/+ebvFQ
         /QGvAXYo7mt9TE1RGFQ4E883vO1m9MiqgleliCoD7I3SPgo3DMwBQgTEeyzUoY+VWPZi
         eeZ7xHmqQN23xc2EvJF+TGvWpuWSpw1VbzWzULaF6FFS7hzFlsmQYvPZ/lDgZb/Bs+w8
         4M6RHc7RI7AytX8zhXOKmJxNauuO7KjpVeBB3OSuxPgEPKGbVSFysjTA5DYkJroPrpec
         RuJAYR8V6eqQHQm4hT8uNffMTnxtK1T/BNOKcmRm0iA/OdvVR6yv2cjafVOj0/qitcbX
         aoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894964; x=1756499764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKAAjhqefwh7uPKlXCd2E5AVbFKIHMZ8KVLO9HosMUo=;
        b=sz8Sn0HAR9ctVai7fcwuKLQYK3fxKL5eOoxLCoFUJgYL7Rp4c4yOoLRN4d4hF2K8F9
         Po72RnhNRYwXEbvAOowYXiiHkAg7ZdyYYkEJm0pOa4IpODdE2/FDwIDhlh1pj+QcvFx8
         5Sm2Q9IKLu6kyzacx63brLMCeRBJbdjVdFNXX/8SUS2Dp2GnsJed02Hn8qh+tMA0pLNZ
         Gdu4ikOTo9gZNd4sulbrf4/6ise7hSCvxNoOX2SdjAjBUMkqhQhhgjyND+zoZ3Jg8J1F
         YnTgYDpUyVqPKzvgMVISVQjoIEc3CFkJhCPnoQkNk22kpK/aZRODqqtJPLVtlzkukb/h
         ySbw==
X-Gm-Message-State: AOJu0Yw75izNWA4O64vA+Z+lm0WseraP3o3ckH/ICOp8V5MgmNoWnWn2
	lNsHwCbIZ+BxNtvVk5D7pqM6IdEqNqSeWWX8JzGtTjlDzl84eL5y32mwv+OFeMVfWvBfGDrBhAC
	dPFubb7JAC5YowS4dds2fJMjr4axtMALhOg4H00lp6gjBL/ThPn8=
X-Gm-Gg: ASbGnct266rZ9v3g67pDAUL2yK89gV+R8MoGsqz0ecWym5ohOHW3XSX9iD1xvc9HE48
	qInGXOBlXoiptsyWhK4cef9TjDYOa2psp1jKP9iZC/u/sD3TG6c/ciZhL0HcRNajPegTyi8SFcK
	YiCDubTTbBm5UOZL223ok1MW7qgZM5K5cbrMfTCkoOE7usWpDTS4jcBo2ET3fDIhdAc8yzxfupO
	LYr/SY=
X-Google-Smtp-Source: AGHT+IEeqb9LOIwDePeOzUDkkBBVBhy7VP6Szb0uOXwpyBOa6YvHwRKoPJKBWDzYak2H7n+uwfYdGUtWrsI70HXM30k=
X-Received: by 2002:a05:6a20:939e:b0:21c:faa4:9ab8 with SMTP id
 adf61e73a8af0-24340af31famr6874718637.10.1755894963694; Fri, 22 Aug 2025
 13:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814215952.238316-2-paul@paul-moore.com>
In-Reply-To: <20250814215952.238316-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Aug 2025 16:35:52 -0400
X-Gm-Features: Ac12FXwcxjutDfwr33r8XIpqPeJ5-fxP3t4zmwIbrZ33XjBqbxBeT86_UFAC3ZI
Message-ID: <CAHC9VhS7qSHe3STDZN8CM=cPT6h=Q1kzKPD42csOb8dmCYgs3A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add the associated Rust helper to the LSM section
To: linux-security-module@vger.kernel.org
Cc: Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Merged into lsm/dev.

--=20
paul-moore.com
