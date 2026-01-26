Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1246BF
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467826; cv=pass; b=oxcVN/PECEgL2MQ7a9CkkEolChHcMYRd6LpKPPN16qUfp/fakrL/kKYr++RBu/72kQJenQO/CO8fY6ppYZ2J6g4vbuAHReylpVszM66xN50guh/7K0Ae1anVS9T53oso4BuvGO0EvWTTYEHgjTNLAeIljxSKTqV2HDnH/BHxCDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467826; c=relaxed/simple;
	bh=46+a/iDHqPPQf3mwVZkJtqT/aUr/0rXY/N+3GsWaHPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F236ILpTcAFjUck5YSYF0KH60KDL39YEI9EE8vwJC8VBpHDQwsIn1aN3/fLuJaUCIAqvBopufxitLNqAHD2lvgYfTMB99RLpws8yiPochXQdMMv7fH/IWlbt4OxGGLeY+jpa97ss32bLPFZT+ehierKJ5WD0eq4PQ6H+sbyv/c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FhpCAHIS; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FhpCAHIS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3000650b3a.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 14:50:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769467824; cv=none;
        d=google.com; s=arc-20240605;
        b=LpSDq2vQNQhvs7DBhGoDYlR5zCmA99Lk34vgcSv8Sdk5wovAAfmvmv38PScoqKtJFD
         TXkc80CYfwDBhyudcft58/RGSRl0IIk352zz/FwjjbL6L6D1MfIxi7u6IB2Wd8BxExkZ
         BIiV/woZcLO0nwS1m1v28VGwWVChP8Jdd8fasz1yTMUef0DJVCweYGQyIT96ZWPmMFfP
         upOvm8GBH4jTseoiEEuFSoW8IvQF7d3HUIKVlFuKNbwZviwgQTHiCmaBItmi0rAZrf6T
         uhTqPp3U+CrYXVUXHzw/DFgA15FnbW7Y66o/nMMomq7mO0UUUCE6u9YJlBdvvGee1ozW
         2Btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsU1GLIX0RR/n3pdl+FDNmWQXgtjeVq/SYufc3kBVeg=;
        fh=Ad+QV6lwCbKgvm+JEcaVySdKnKG0wQFWFFQp34BVl0k=;
        b=dZaZfR4NQ3pUPPpo/yOuOYwRxHfcy7aUwf7eM+amotn6mWB1EsZc4YITqsqzhBqnOk
         4ufEJrbzR2eZAOGjPkmsEkKesDqWQho2/mxlEdd5ddFj9kWYnrRO+cPXWcwDItEt+5G2
         eXnFNnnBAkAEaiL819ZCkCWMBs9hDHG+S2c6LCuxlFMy70rX0tIiCJ9hsEKeTYKx7Adz
         QxR8mPVTCMYXneShZ9gl7qFCZZ7w1xNNhp81MCynZ6RemJINONy4MY5+Tz5CA86e2O+p
         uekU876FxZVifmsmXUkauFODS9/vSabW4tTprwRIkaDQHraN6baKCNahrfvsTftrZjjv
         u4SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769467824; x=1770072624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsU1GLIX0RR/n3pdl+FDNmWQXgtjeVq/SYufc3kBVeg=;
        b=FhpCAHISSahgiZKVbruJxGmsRcB2FYu8fEW6Uf3DZeOrEZGyjTxfCuaii1hqn7Y/7K
         VenYJQu498UgVIVyzTazxOL+Ta+dBFG6wLByOMxflSyDHZrmhKKnsVe02PKfVjnZS7ua
         PfqLl4qHSwLhZLhP4B3HdlNDxrN8R24/P2orlSzWglh+o3fczSuWcDmWh9aNc8OPySo4
         +mLB4Q8gaPT2y9zCbq59mgSRxTYYPWKPKcbTStgIe9a9k+FbwP9YpZ5nMs/ZwiHfORyR
         HGhFW/tyMOSMqXwTkxEEmDwG0jZTIPUye/p32XkO9UNloU4s52pdG7HjniIyJOlTRJtX
         R16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467824; x=1770072624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsU1GLIX0RR/n3pdl+FDNmWQXgtjeVq/SYufc3kBVeg=;
        b=vM3RVhs/GFGxFQ4dW5TyNbwDIcPmHmxV9lDyeu/MRPpJjjBPTLznZH5t7LpsDXUI1u
         q6fwxkMxqA9v8x1kFPf8rQSwGrL8KttGxWiPJ0HoAJRc4nOojvizhaZvKDhpRP9QnsKL
         pCoy3R2NUG+I3jhJLC9EsbkGLxP0/oGBP8PMLIPykhsOuLxG1pgucbaEs/qc5DoFWlh4
         g+YWxy4zsk6/whCj1n+jtpEWjDhCDrkXEe6aduL6EtgrFXXDBiDYip54FBnJ0GKueUSU
         RROCSiiXWKnpSwn/EsHuOfo4VgnSOiC7iDt5br8S1oOm8HWnz+ke+L82k6HcscjFn5hp
         rAgA==
X-Forwarded-Encrypted: i=1; AJvYcCVh9W+Yq3ZEaoBYrjSdZPBZs6WIgBRQDQj+39WG8g930qoT7/ejlIh8o590qbscEVCwcU7GoSH2gWua8KSWvIglYtf5AUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3vHAijxg5udAf3o1XsO5E6E2k+AQMmsnpB2S54jBDOtqvE9DK
	SP5+AA9ATQ1423b0yQ1CZ5W+1DZ5+PYsftIh9nDL7YGCy6n/MIYPzHhoY579CejMKm7/3PBC1Tz
	g5M+zwiP7UKbz/r7Ltag/pKGBAVIX87uSzYNeg+wQ
X-Gm-Gg: AZuq6aKhx0FzlqZ/paJnw8hBMRAxN9FAKHuQgVFgKFDR67rGNjFOcfwIRttnPhJjl4d
	7vifq11TJvuJ5+G0bcKW/ACAdto7af0GnYYDjzRDVhbPHDy1trNyCXflA9Igf+2Ar+NagjAK3Wj
	uC8F7kvkofQgvIHz3OQITCmiGY2vh/WQzkvgMxI/obATvPUseAvban6XNtY/A0AbbeqC2F+2b2/
	XW3TBA9sjIjp576b2O8LGuAJhGwVFKm6rSAOTLtPlJwyCOIQUffoJQ3ZuiioT9T9jgAj3Q=
X-Received: by 2002:a05:6a20:6a26:b0:37e:43b7:5213 with SMTP id
 adf61e73a8af0-38e9f26c766mr5402650637.79.1769467824278; Mon, 26 Jan 2026
 14:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122141303.241133-1-omosnace@redhat.com>
In-Reply-To: <20260122141303.241133-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:50:12 -0500
X-Gm-Features: AZwV_QirH6WxkkEtxB_THz4KRLLy86A_qAkPoOWcP6X4SLKJhhu3sJBRiZUB9J0
Message-ID: <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
To: Ondrej Mosnacek <omosnace@redhat.com>, Serge Hallyn <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:56=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The IPC sysctls implement the ctl_table_root::permissions hook and
> they override the file access mode based on the CAP_CHECKPOINT_RESTORE
> capability, which is being checked regardless of whether any access is
> actually denied or not, so if an LSM denies the capability, an audit
> record may be logged even when access is in fact granted.
>
> It wouldn't be viable to restructure the sysctl permission logic to only
> check the capability when the access would be actually denied if it's
> not granted. Thus, do the same as in net_ctl_permissions()
> (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
> so that the check never emits an audit record.
>
> Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysct=
ls at open time")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/capability.h | 6 ++++++
>  ipc/ipc_sysctl.c           | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

This change seems reasonable to me, but I would make sure Serge has a
chance to review/ACK this patch as it has a capability impact.

--=20
paul-moore.com
