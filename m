Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D385322B
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615714; cv=none; b=UZUuh6deE+nrV0npIK2m7yt4Gow6AKv4AhsHaiNQr6fBCSliFxXP/0xZX4RGlsIvx9brpSEACjvm6607bi8kLWsmHTnvDXk163ehC/fELZSREDPFSv8EUyHzCbd8GbRCSimP+uE+wnz05Er3Je/Ks83e+hCMAB4JtWZXZsCIoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615714; c=relaxed/simple;
	bh=lA93WJsvl92fEN+e3o7YO4/3sHa1ZEPZrGW4J9LxunE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi0cScpcG3D2MTEqGPK0ZCMMSzDU2uDcrdC52ynDVdPHDgeQEACB2YvFVhypIfB9AxAqG7CgPzSOt5xPjHMiRkGz61cYTz5lSVhPcbsiv2yiJJsRX6DEdc8vhekN9GecD5kMs6AvTLRJkREt0pP5NT0phEUIjxso0BmGzHb7tw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J939lYun; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J939lYun"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fcd8090fe7so3258367b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 16:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740615710; x=1741220510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQb8xHBG/FR0hbx6pk01W2r0mdKrQfyVO9coElE3pw0=;
        b=J939lYuneuZWUQrkJvbPdGxmYYUyvfOLN4l0NbjdK8WrKF+Mq2s6otL437IQ4aksnp
         BmnIPcX9NL5c6L3Z41bEzfKBkcv8GWO4ERluiWhjEcUJuZykn1Oo+rm1et9Avr5Jaztd
         xPKCb4BRhK0Lnd3qK0vBwms18KLhbam/cetOPdB2hkiWVBFVD+jTtDAkdyPm0VgxFBUr
         zjIsc+mRBBVGl7FU2tsRaq5eQmVy8gh8pQ+D32++rSAKKjZG8jY5Wats3xfAfasZ0Z48
         Zstw4S+FpeHahidpzlz9ylXZBQb13ow4bR1UGwjq3xtNZmSPCg6iok1gLGQdZUEG22iD
         XZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615710; x=1741220510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQb8xHBG/FR0hbx6pk01W2r0mdKrQfyVO9coElE3pw0=;
        b=xEjb2oBJEh4kVRfd3IQr6o2dnk3unDR3K6odpb/F76r+B21KtnJPNDEu8hf76/Uvv7
         9pSwOJX5QAf6I3+mfY1++I8QGFpxKYeuOSrLWCYPlpE6CDOa05pm12gttg+GBklwXpyU
         JVv5V1+XMe49jhLXVIpkzx8XE0tNez7HkDKF0MRzJQSym0jcQ9VOPSPAvad0t+8XcuYW
         snUpWqMkpUKfKl0FUZa1VGDBba9K1DmxvzOtn7B9PqjWmqiV5KJik3+14pJElhKWREg+
         CMfLtEveGxJhFoJatl5Yi6loYzkcl4ddUFkQywuBM2JnByGPs6NhkaH6jSBjmF1nrMf7
         WftA==
X-Forwarded-Encrypted: i=1; AJvYcCVja7SyULf3gd2Gc8kZrVJ2nLnSiRQbqGb3FcY0Rq3RTHO7sk+irnbthANL3sIvyGtg+t9wdnRuE08Bf9FO4EXr2/RcAQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxafNbILs86vhGL+wePF3NMTLOb4qgDxXQ0SvJXmyw80mp4B//x
	jzbXbfIzZFHBxCkxJ+Hc04tgeiwiTzNcpQLlM/bDwjZ4D2DA0SXLLSsUQ+YRj1ryVUqZAQWZ0jP
	BRUUYsGMM87eCiCIi+O2UiKXOkhStc+A6BuRJ
X-Gm-Gg: ASbGnct2cWPSevQbGi48RAGtF5WSegnhrTS6KTDEs9tdUgd3X0wgWkOu/XtH7Lh+Yfr
	VjRYxTaCY58BXrOfW2+evZZPZiU22wDf88s5dtGzNqf2DuxgE++gpQXBGwKoW+dKM8yAuJrJh8p
	W1GjNxrmo=
X-Google-Smtp-Source: AGHT+IE9M596fOsnvChdCaxBZdSAWh6n7T7MHXBJgqbUdKmToL6i4dODJlYnfR7DdaOaazxEJtI53RpYLKKE+GFsH3k=
X-Received: by 2002:a05:690c:6c04:b0:6fb:91a9:94d9 with SMTP id
 00721157ae682-6fd109aac64mr93407707b3.2.1740615710538; Wed, 26 Feb 2025
 16:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
In-Reply-To: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 19:21:39 -0500
X-Gm-Features: AQ5f1JrZY5tKZxOzch7-SkqlEDKzPUv3kMxeIjzsldzlnYyGW6kgsoWl7IDE9J0
Message-ID: <CAHC9VhQpkyqaJsxj9_d4d6Vpc+FVbSnH_HeAFAVEdj0trGCh1g@mail.gmail.com>
Subject: Re: [PATCH] security: keys: Make sysctl table const
To: "Ricardo B. Marliere" <ricardo@marliere.net>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:50=E2=80=AFPM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows for struct ctl_table to b=
e
> in read-only memory. Move key_sysctls to be declared at build time, inste=
ad
> of having to be dynamically allocated at boot time.
>
> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>  security/keys/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks fine to me.  David or Jarkko, this looks like something for the
keys tree, yes?

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
> index 91f000eef3ad82370250e5238d9c9c80757aab61..cde08c478f3272081304e6db3=
4e36b64ce0d321a 100644
> --- a/security/keys/sysctl.c
> +++ b/security/keys/sysctl.c
> @@ -9,7 +9,7 @@
>  #include <linux/sysctl.h>
>  #include "internal.h"
>
> -static struct ctl_table key_sysctls[] =3D {
> +static const struct ctl_table key_sysctls[] =3D {
>         {
>                 .procname =3D "maxkeys",
>                 .data =3D &key_quota_maxkeys,
>
> ---
> base-commit: 714d87c90a766e6917f7d69f618b864d350f09d3
> change-id: 20250123-sysctl_const-pcmoore-fa14389b8329
>
> Best regards,
> --
> Ricardo B. Marliere <rbm@suse.com>

--=20
paul-moore.com
