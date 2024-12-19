Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2C1A08C5
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632895; cv=none; b=DkEjZNdNLG5EIDy0VRLCWUOyf6oX2O/tie3GwBrwHxpkfYmQHRSKsaTYY/vlUmW3f+bbaX4B2q2hBRmrTmjMr8gtDtQ5xRlxVztL191L4kj1NjiimYqFJuEB230E1P3k5Wqse1u06mF+Qi9gfXFSPeC3BKCN2pL8NPoVceot2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632895; c=relaxed/simple;
	bh=PZrksKbVCwALT/BKHe0sgDxS0zE36G0ghQIMGarCZuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucw3tE0ki715eCN8CBXei0RiicUD6ZY75D6vXV7uQCB+JQ7Nzn0RzNZnO7T2Ebue1FOGa7ZVvqdlom3DWTwBlog0Wf9MNVd6Vy0BH+qhwfrEbDHwG1YhsCh2x2OvjNZuILYKuXxrcv/LJdtIyGlSJhemQj91Zlkrhxgwzt7WgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AzdV7Y+F; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AzdV7Y+F"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f145e5cd83so9806677b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 10:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734632893; x=1735237693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zmy5f2jtsDyVkGn1yaqGCifrzHRxpajGypgt29o7QI=;
        b=AzdV7Y+FG6fVJmwz3+h/LlYij1BUrDc8JVAqK0NkHKzG0KtPrb+tUnVBNhGWaZAnGB
         hUY8rn+sXpl3yjW30/MScjTqabXCa3a+trqEEHuBOMuURuFOLG3WUwmMi9KMr3MY4WkR
         C0nYJq4oy/gEFzoFaJiAAS4gMlt6JV4zv2Gr1G/UTi+6poRmmV3VEX81IUFVSZfulG0J
         GmuLv1WzDcQUOr8O90Z+LSiAJn4XghEAIpwm+4A8USHw5EXalbIUROkpgtAYoePPn4D8
         +qHgdewMCUnvPbotOxLdKipCDZdJw4YQoUFuat0fPUfrIyLBjC3+HkZz1HxgPKdxm3VL
         87SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734632893; x=1735237693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zmy5f2jtsDyVkGn1yaqGCifrzHRxpajGypgt29o7QI=;
        b=fAeXK6JVZRrr2SMOJzXaCCRiOF88xQwO+OrGeJjikgN8NZrWUQzP1/CG6ViedLCk/E
         BH7CVDkCYZa9iPF0b5Mvlu8hXNYshpnm1E0ClOl5TDBpS/bm38QpszbGmuF1vBHeeAyn
         5S2uCwCO8+BFNOdsElb12DCw7n3Zq2euOUQBMXTAADNzgPdXOusk6/GWdhR7uQ0L6PHo
         alsWhNStBlsOoUjq4BBlXDQG9cBw2NylnTLIybxL4wS04etGRb402F+pYteGkrA7T1BA
         V8B+0kNEwbA6M7t8PA+JSk2rZf+EqdPQaEhinNtBReKQbxyoYeWOA6kLfqZTmp7trFyt
         J/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCbnc2MaR2El/9gMLziM7MHGvYeUEFd7ZbLJM2V70GlO8wXnJlsTsPlx4g+brEQpTaGhqZg79l67uM4ZpZtDRFwoSR1fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GkVd8CigW9Memm20PUcj+gzGE1ErWh7XC+X4tM4EyAgCLrl/
	bevFXJxT4eft92Jt2qq8bdTrY1cDKi3G9wmE9hfhEhmjThH1MVcsPrsabejMM3cEEfEhJgXxDD3
	+DDCHHP51PUPRc1LJE23ZdlD/6ZWVkRMwXSfHHu4NkBORSaw=
X-Gm-Gg: ASbGncvNMvsrcPXMXRXudYXOGsV3Q5PYS/OUdweYusURJhFfmE/F3T7/XiPkO2Mrp6n
	LtKCcIvcY7v9BiEr9XFEdjwszOtiTM4uOtT3o
X-Google-Smtp-Source: AGHT+IE12V3e82FfLr+A4qhI2TiVCtRjWfYa6rpYzS4Gk8j7Ij0CDUzQ9zZeG8G1wA5x5UxqWZkUZPRjdjquSu5gUXw=
X-Received: by 2002:a05:690c:6183:b0:6ef:79d8:c908 with SMTP id
 00721157ae682-6f3f5176516mr8164807b3.14.1734632893064; Thu, 19 Dec 2024
 10:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219172859.188117-1-linux@treblig.org>
In-Reply-To: <20241219172859.188117-1-linux@treblig.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Dec 2024 13:28:02 -0500
Message-ID: <CAHC9VhQ73qdL2Qf-jOMMVSf=+h-H8K+mz165XZztb5X6XjH11w@mail.gmail.com>
Subject: Re: [PATCH v2] capability: Remove unused has_capability
To: linux@treblig.org
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:29=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The vanilla has_capability() function has been unused since 2018's
> commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
>
> Remove it.
>
> Fixup a comment in security/commoncap.c that referenced it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/linux/capability.h |  5 -----
>  kernel/capability.c        | 16 ----------------
>  security/commoncap.c       |  9 +++++----
>  3 files changed, 5 insertions(+), 25 deletions(-)

Now that Serge has the capabilities tree back up and running I'm
assuming he will grab this patch, if not just let me know Serge and I
can take it.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
