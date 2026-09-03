Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09DB4F0555
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454205; cv=pass; b=WcJ6O03wl4YtyZIp3Ga6jkM687HRijjCsEa9z4G+jXCIj1iF3pNHTP9d4dUSiEOFQV83GeWRbFGHw+2iPcWnEPZRSLy54jcnvFwI6MdBlTQWVfZnq2GMCx/PatHY6JJtt+/qgBRrrPpLEgR+2LnMy/9H8z+qbIMLQ9T0lxvEphI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454205; c=relaxed/simple;
	bh=fIzJ2UzV1e1OhGgyxGwDuKbdIbdlV23EY1glTplhvE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX+50fpjyGdX2HBe0xVwvgsSdVGwg03VL0mN01xbuT4jWBH8rWOqFqKpWuPyuBVV+OAOK+ZI77xcGjyVwIqUkNkcIQLUOT1oD7ISBPSow38HuWn5grBdhUQXdD3iMr6Zm7ZcbTYHP6gVVmuJVlhUjMgZcRP0gBqQXsVqPwcr1W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d5xJJ/s+; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d5xJJ/s+"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-852c481415fso3078986b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 09:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788454203; cv=none;
        d=google.com; s=arc-20260327;
        b=TOGi/NEkLx96WHlKrYYdl0Jrh3uS/BapqpP7jIrfVlBbTTe3YyFArn6QB04jWCYMQQ
         UovVFAjOseARpMyDMZ5DtGb0LCfSUw5oHSFD34PKgFzJe98TDm7HKB6IEmnG6TAh2uPH
         P6pJW+A8GEO2yU+cVPO4dK7PNROYV1BAyXs+qrUBE+KJ2fwa2onwtbJ/zdDq6kX7DQET
         gKr5Y3TelhOOadL4lu/Cr4l3wrI8ON2jOFuKK5qhQw2UblsnVqReil7qRTs4YYp27UBW
         4f0l1XiiT8/oBsLoPYjs5kqgyNA7Znw20ug3vdvmYm5hVkOm+MdKCIB0Salyqn6dqxrb
         7hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2HQUVihfuH1EnVw3l99N8g3U4J8AO1suXuMcFxz4nu8=;
        fh=HwPP9BiM5SUlSpnoVcRPoZqV3jXQvlx8JWu8KERjxo4=;
        b=P//krAfWIRVQkfjbNoWDj+mN5248MLoyIjRNc+dWNcTuuUAiRmHtxrF/z3iGsXAjxA
         +eCpjvTLCNxE0c2vMHwWe2QGp9eMDJcx81icAOkBKCdYGu8By0PaQo3lK3ykJZD8+2EQ
         XkNY4tLySKu75pNm2FPEdxYaCe6qGFSMs2ydf/W7ApW2j+5WuCMIzCv7QlcUQOBNRwlO
         0T59vOGXSdOgO550ETYkcP1yANUkG1wxeN+snSrUvoPZkHTw9Fd8kXJ7CjSiVs7jik4+
         V+VJ2Hn9d3IbUmpBrhPS+yJtKoqiabRb2TJWLFq/eR4um2INK6OuohdW5XnGGygvEMls
         Ygkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788454203; x=1789059003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2HQUVihfuH1EnVw3l99N8g3U4J8AO1suXuMcFxz4nu8=;
        b=d5xJJ/s+bZ8G7cWlXDwnUBOPPL8SWcKkAjBqVEKf0k4KhYK9bAhQNuAshxxnm3oSNG
         sSZ4BQmTBFCPFBAeebo/pK8zvQFpLzMgiimZ4O9PknbACOpudWvxED6ArnkbLWKw8FCh
         +IBn3NHozxUwW8bvALGbsYnVz1LRE9zhT2AlS4w7wxnhBYzsac9vsY+tSgEsjkK4BN7v
         MXWO3o4iMN4FJRYFXQqzayhQtzEFTv0XDbT/1HorIgjNqEk6eafAYALYShPQhbYda1wn
         9T5654dscRfI8x4p3yFivJORk2SiIhsZpI7yhJq97hcCgl1rk25k4IAw3xdR7g9Vfd2w
         XMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454203; x=1789059003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HQUVihfuH1EnVw3l99N8g3U4J8AO1suXuMcFxz4nu8=;
        b=rNg0P3ALpoXAGPQZ+Wd2hgPckCLNDd1FNWDb6Y/qleBmuWBnBgksZIe8ev7oZYX1WH
         E9TAr1ftImPwkoakASNmKoitUWNBo2dHsnWjaivz5jSPvOWx7dl1UUDYKxjZ18Qyyii6
         hlliZOqpmonUw2gc2O2Fd8CI9PbNdA8rSshRinGWGyRiLoOhy7KaYNwieL+FI+NeyLth
         gQWj0UDF6ETWxB8+MP6KaJ7g8F26UmhS3pOCoxmxuoUkMnKrI4DZCobfJPdckLwN5chR
         ydZ3GorP5ddACHXN/Q+uCquosGBpzMVljjIIQItxgePcyXK9fypQ7KZ+CckPLQzdLe3S
         Iuzw==
X-Forwarded-Encrypted: i=1; AKwUvBwDwuckRnAQk1K0JrtHdmmf3HDNN34St6b0+zn/8fRgj7LmK+cQru9d4OcpDYVDyGlGBAa0hn2P6k4npx+BfzBueimR84U=@vger.kernel.org
X-Gm-Message-State: AFuF++l4sP336WmDTdnXetKrM2zBbylZv5jCqU9GRZZ1LKtmX4t8yUpA
	Hg9thsaBu/FqRjKIjkmnhx6xQLGz9b5Cvw9yzFXnsxllu3Kcc5lDGeS/YmO2aGx2d3bzRjQiBEk
	3y33GJYaRiav2g1njD0MgXHeb8bP0qSOJFG7JuNeR
X-Gm-Gg: AYBFou0GB75rvzQFvh0BOuRNFOqPFie/7aOdUC0evaIyo7CoLeLrCrrtvwhX5BLvgd+
	B+HQ7wC2hRBD8LkQxSXEU/hzGlD3yVX6jOp2ZLc7KjnwH8Ml/dviuscnCXSaj6liRqCppbj5wiM
	Y+c7sdJKQKfP/pGJMdZk6bvtHql3fwZsmrH6r7anCHVzXQOWiUybkT8IE584zZa1iJTdQeXFM7D
	Jt3/M5Upkm9o3XezfmR5WB6qv6ZWrrOzQStBQ+nkGBj82GWPg7dZrYIAS9kyUVEB1PYdKAe523l
	B2KLCQPiIrWlNgD3b9wQtrX+amsU2rGGLID0Y6LAhUOb
X-Received: by 2002:a05:6a00:4c96:b0:857:7337:5db8 with SMTP id
 d2e1a72fcca58-8616ae4e171mr356491b3a.22.1788454202717; Thu, 03 Sep 2026
 09:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903155615.516010-1-omosnacek@gmail.com>
In-Reply-To: <20260903155615.516010-1-omosnacek@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Sep 2026 12:49:48 -0400
X-Gm-Features: AcwNN1Vi1fFN8XgqNIFOZOP1XJFQC7hXS3V-fOBEGIFKC-xj0anHhARHzxX5Hmo
Message-ID: <CAHC9VhQSoWBfWrf97Ch3ZZJXkOvhbwNOGmq8rMxLFzq+a-CkQg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_MAINTAINERS=2C_mailmap=3A_update_email_addre?=
	=?UTF-8?Q?ss_for_Ondrej_Mosn=C3=A1=C4=8Dek?=
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:56=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> I'm going to use my personal email for kernel contributions from now on.
> Update MAINTAINERS and .mailmap to reflect this.
>
> Also switch to use proper spelling with diacritics, since I normally use
> the full Unicode name with my personal email address. I'm leaving
> in-code occurences unchanged though, as that would be just unnecessary
> churn.
>
> Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK=
8KuseMQS-9tNA@mail.gmail.com/
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>
> Hoping for this to get picked up via the SELinux tree, since the main
> change is in the SELinux MAINTAINERS entry.
>
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Of course, I'll take this via the SELinux tree.  Since I'm going to be
sending up a pull request to Linus soon with a v7.3-rcX fix, do you
have any objection to me sending this up with that fix, or would you
prefer this to wait for the next merge window?

> diff --git a/.mailmap b/.mailmap
> index 6803f3bd2865..0e672a60afdc 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -699,6 +699,7 @@ Oliver Hartkopp <socketcan@hartkopp.net> <oliver.hart=
kopp@volkswagen.de>
>  Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
>  Oliver Upton <oupton@kernel.org> <oupton@google.com>
>  Oliver Upton <oupton@kernel.org> <oliver.upton@linux.dev>
> +Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> <omosnace@redhat.com>
>  Ond=C5=99ej Jirman <megi@xff.cz> <megous@megous.com>
>  Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
>  Pali Roh=C3=A1r <pali@kernel.org> <pali.rohar@gmail.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc320b373656..875d0baed8b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24772,7 +24772,7 @@ K:      \bsecurity_[a-z_0-9]\+\b
>  SELINUX SECURITY MODULE
>  M:     Paul Moore <paul@paul-moore.com>
>  M:     Stephen Smalley <stephen.smalley.work@gmail.com>
> -R:     Ondrej Mosnacek <omosnace@redhat.com>
> +R:     Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
>  L:     selinux@vger.kernel.org
>  S:     Supported
>  W:     https://github.com/SELinuxProject
> --
> 2.54.0

--=20
paul-moore.com
