Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629063B14DB
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325298; cv=pass; b=sjlUvsXcRqY4thB+1OzOAihALnSGeBHcQO8GaEoJ1WN23j+KtFO0ffBMDB3/BKVeWd6Vk+LzHVzU3ZVon621Ow3lO+GG9NYNIEBl5InFZOb/fASU6XUq/Xu15XUVUATUNB/mKCHg6H1iLhADd5xjR8asWG7DfjswHbSBFnhfK9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325298; c=relaxed/simple;
	bh=zSmz2yPYjiL5Avgk0X07vGS1nKayN7kOm6WyC+Rg1bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsO+qw/vKvvl5mBC14bPRfAHUlfHTgqtmjigqMcJRAiE+EZEeFtpCEboWeCs5sIcDJ6Fs7affmel/T7ijNs32CtMigWJuD2mX5G9bU29baC+T4DRod8BVSukAFggz0c7CLSabxHAvbQZ2QiDzQAkt448nLZwP1XsX0cAHAmX0CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D0MLg71N; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D0MLg71N"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caed617615so94319085ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 14:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784325285; cv=none;
        d=google.com; s=arc-20260327;
        b=AunjeiHd8UDAAdk1MkbG2A52kVFO46gmeW63f1gKcfNL57A9lUbHE9T+x2axtbwuMn
         twv9NiM2wJLv5jFu8zLMbD/wv1TV6c74fxk1AbwQIjYUVUztCfEDI3GiY4+jdmy3h31e
         UDVnWVicLKWhjAx/4p72JpMUg1wm+ZninInaQmcv+Jt4gTFoDIkKIvMDoRq1f67wh5qq
         ChJwzc8I+/6fvkxzjT5s0dAS5LmaSifu8siG/WbqmYJNfNFeRhFuby4RGcKsAXAgtaew
         Sx9G/45CjB8UZSOzsoSmvA9exOSOUfoPXlibm0eAr9gJN74D7nVxDAlAnmNZRe4ilzhs
         m7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ihuNkb81utoGJM6V8/eOXX9YSEtfZ9LASl/5Zr5mgU=;
        fh=0B3Zk8aWSoGL4CRIFbhPzJqC0PoOgR6tvn1Mb52ELhE=;
        b=QkGuoWKc/FvXaZhVqgEHT2T1oitabvJSIR1St+r0mVW3Eori73Lo6qXSbqSgztJkVT
         C0aEnwZ1wAEplejqNdBRLSNHq7re0sLjNcUAUch+QbR4GblRjeVOCkxymtJLQ5b22r8w
         8HbqJmEEBYe9ZoOGCBbHPtgI8BUBXUqYrzRV0nJxa4+uhLSYItlT1EL7VmIYHE/PdSqO
         778ynDy9R9vO0T2b1g5YD7TgeMeD1cnonohGN3aep9uM4R/MfTHXn1kyE1ZMcgiBl+dq
         ez+4uwERK9ES70t4z/tmt8EwpcCONOAtpO/EwRDL6UFz5fOIf3i70PW048ONrVcyx9oK
         lrNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784325285; x=1784930085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ihuNkb81utoGJM6V8/eOXX9YSEtfZ9LASl/5Zr5mgU=;
        b=D0MLg71NDka+UtBH+kdPZwtsYmQv4f3LaV/lVZg3KIjVGS7nryFRQHanJiKzG5cKet
         /s6eyu5+QxEeZ+CngCz06J+OBLvyK/3SglsjIALtgrM5JexhqvpDZ1knbLlqG/i9pLsa
         3T+52xERj+iKcihzFEyCz3EaQ2dM+ucvQqw/REu9jloZ4l4YSw6aIE2nVupstwhlAqJz
         9KngWovCKzYCtjvySOu2ME7IJXkSIDGYrBMbE5TdOtA3D39hg/znPOR07ivoI8tOZI24
         WqoN077LyyXfYwFMmifGCLr7sQUsx1z3p0RaYtG+8kmCMPhIsusqvcv+h1OerXTO6AZm
         ZytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325285; x=1784930085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ihuNkb81utoGJM6V8/eOXX9YSEtfZ9LASl/5Zr5mgU=;
        b=XjfDiP5xTC8QmQ+cgrp0AUwAhcPNYzAbXzfPSA6fsHx6qRuyp7oANp9uy+Wm/lqFbs
         WrhW31nXfUasCiB7H7e6eeZybdYy1lm5i4PYZJFWpo6nhbanFvJBg4FE8zESos2/YFkp
         KeUu6swpLQ7i6IBUx0JdcP/KnwykknKkBvP+RFNChDSxs5ULz7NyuiGkNP3oQrXIT993
         U4UuM8dCl9yjoWckE9asWUv10X5hDtbnRcdqwvX1x8K2OPlnb/ZxgCMo6yo+lc4RMCGh
         iLCPGTRgJzYTzKS/Mrvc9CNJHHmP3S7z4jdyDksMeM8VJ2u/fy9Jg0ZS6pG8zVkKm0Kf
         fAWg==
X-Gm-Message-State: AOJu0Yz/1V3bzqcCoJZtnXv6I1tj/0mrY76wgjq5tRtxmwVrclRrNb7/
	zm2qEfNDTWtIfa1eCk5uMoWOwCnM0mj74M8nO4qsMELgHWAYMn16eZwGvbLS3MQjtC7p0Vo25yR
	AxXCazoa8VfB8Q63k0DncMgD8w7lxgZK/mc1WrzoinAkbhlv70DEpdA==
X-Gm-Gg: AfdE7cnmGO5zRV2mDArUaQ0YGFz/BHec2zJV92E8EvI7P7ZQk+xkd+Gl4xA/QXY1vIB
	MD7WO4pIPl3jrozFc/ou13IlFW+iKETyb0aKOn246Qdo/ax0X4/TS8Pc67Yp928HHJxEuur0YSA
	7AJVTgzKo7qFw07e4VKz2Udj5EMz36MhXArpzEAnCdJKhJKJ6HZkAfcEmQKi2gkZ+OqdYn135pf
	X6IbrFgG/Oou9gst6Q/dQTalrTQOREFJW3OVU9nsnxFn5MsosMyNHw6fgIo4A==
X-Received: by 2002:a05:6a21:648f:b0:3b2:924c:566e with SMTP id
 adf61e73a8af0-3c3ad973471mr5360833637.36.1784325285355; Fri, 17 Jul 2026
 14:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717215254.383183-2-paul@paul-moore.com>
In-Reply-To: <20260717215254.383183-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Jul 2026 17:54:34 -0400
X-Gm-Features: AUfX_mzG3RIFIx2gy2bjVnnjX731Mc308xTjINQFGsYk_c57slrOdocd_-2rSfw
Message-ID: <CAHC9VhRcJGj3Pnrpmpi0uRi3ndcMVGGQorsU4dJ-vA_uQmRuQA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: leverage audit_log_n_untrustedstring() when possible
To: linux-security-module@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Make use of the audit_log_n_untrustedstring() function to simplify the
> code in aa_label_xaudit().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/apparmor/label.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Untested beyond a basic compile, but I noticed this while looking at
something else (unrelated) and wanted to send it to the list before I
forgot about it ...

> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 3fd384d8c41a..a165cadf8249 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1743,10 +1743,7 @@ void aa_label_xaudit(struct audit_buffer *ab, stru=
ct aa_ns *ns,
>                 str =3D (char *) label->hname;
>                 len =3D strlen(str);
>         }
> -       if (audit_string_contains_control(str, len))
> -               audit_log_n_hex(ab, str, len);
> -       else
> -               audit_log_n_string(ab, str, len);
> +       audit_log_n_untrustedstring(ab, str, len);
>
>         kfree(name);
>  }
> --
> 2.55.0

--=20
paul-moore.com
