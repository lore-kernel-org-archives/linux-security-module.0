Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548921576C;
	Wed, 22 Jan 2025 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571280; cv=none; b=CaFn3RN2KRheEeGggN+CJsmZP8qe4ga+ULOJC5F6vx+hY9TIhgiltsDI7Lr6xDwA74g/m+iEjLD2GBErZQAyJdN1RgNtTpLh8wiWH6+iQgJq48z99XJxzUNoWWy2UPnyUdA28KA0sJ4JmiFKv73vK/IurYhiwXQ67ka32qlZrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571280; c=relaxed/simple;
	bh=B4/+U/Ou/tjBGutEBQzXHi8NWKYYlh4/2x9CI2HcJvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSYlug3oKHEeVd2XMy0qMRkPHjOK89Qx7oOj1kFISyHYpxaSNPoFA6Fl+M8lp6FvmhGuvLM7oeJmJi68Mfdz/NOxSsF0sODfwFQG9ekbcUX/k6oQW0Ew2PQSqVcHFEQwtqS/TwMJ79gKCftdtQdl47MtmY8LegAhaYwygzf+yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ9G2Kcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ9G2Kcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD3C4CEE4;
	Wed, 22 Jan 2025 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737571279;
	bh=B4/+U/Ou/tjBGutEBQzXHi8NWKYYlh4/2x9CI2HcJvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gJ9G2KcsgpSKWL5u2+VkDoqb6IEfXlvY6URDikqH2W0zvw49vksktxGQzWw8X+Ek5
	 ec4QxsD6xwut9xZo6X78zmItjiWrcBbOTroUgwLSklm1343Gy3lwIMTEK3EiXjvDT7
	 lUENA/T06cDtUIZtyKB2JxZlQyD9mQ13bRoR68HEZ4REOAlPTJZ4Lln7LTG6waYKor
	 /rddOWScm0RotIVxYtW2FQIZLLYkPO+QRNacMAeHvCyQsiMFICos5oqZooToPwiEJv
	 EogiqNoCvt1hoqs7I8jev8ztkXERln+8QzFcp4FcX95gQaoQpv2RewnkEFQRASoIgd
	 N6ppzQPBDiWHA==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so78894276.3;
        Wed, 22 Jan 2025 10:41:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyWDn8eFHVDU3yLNijQR06hulZ+tSzsOoLUfNNufuYL47D00pkgsJYtE+v+xKz6AS1Qtp4hWK3ZxycOJs=@vger.kernel.org, AJvYcCUzSFxJnGDrQyjP4WVyeN33R0y49OAov705KdiyysdSEg0Rl9UDTZmYxE4PMO4gWNfoujdcrloh3c7lXX/WPFD0Ow1hm/kR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FA2cNEGYF9DH/WaqTuVKlhVoR+05IvVgzYFz7HtgfiTm5hLG
	84aKkk1cTnNmxX5hrsUxxKlOu/EWvWRjemZ5opvhrMcwBZuGEGt5YIStiPa6oY45mrfd89VSA2/
	+3UT4LjFr7kaDs806eRtbpFiA9/Y=
X-Google-Smtp-Source: AGHT+IGw8XPJ+ezXlcnmzan5Sds1EJuMAOnlXv0+afbfRCer8nAJDYLJIiJ9woh5TeDj09ETaH1knUypfdYeukDO+cg=
X-Received: by 2002:a05:690c:498a:b0:6ef:75af:6155 with SMTP id
 00721157ae682-6f6eb9323c5mr184378937b3.32.1737571278671; Wed, 22 Jan 2025
 10:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122065740.545042-1-code@tyhicks.com>
In-Reply-To: <20250122065740.545042-1-code@tyhicks.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 22 Jan 2025 10:41:07 -0800
X-Gmail-Original-Message-ID: <CAKtyLkG75o=+9UtskB6Qn2ZvzDrzQPi6gBoAYXvio__46Mds8Q@mail.gmail.com>
X-Gm-Features: AWEUYZkZe1-bVhzraw1NtzVH4aRq4zESuBN8sdj5SlSD19NxU3QlOFX4wevij0k
Message-ID: <CAKtyLkG75o=+9UtskB6Qn2ZvzDrzQPi6gBoAYXvio__46Mds8Q@mail.gmail.com>
Subject: Re: [PATCH] ipe: Search for the boot policy file in the source tree
To: Tyler Hicks <code@tyhicks.com>
Cc: Fan Wu <wufan@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Deven Bowers <deven.desai@linux.microsoft.com>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix.

My only concern here is the use of wildcard. I'm not sure but if
$(CONFIG_IPE_BOOT_POLICY) is a glob pattern it could match multiple
files?

Other than that I think the doc of security/ipe/Kconfig needs to be
updated as well to reflect the makefile change.

-Fan

On Tue, Jan 21, 2025 at 10:58=E2=80=AFPM Tyler Hicks <code@tyhicks.com> wro=
te:
>
> Resolve CONFIG_IPE_BOOT_POLICY relative file paths in the source tree if
> the file was not found within the object tree and is not an absolute path=
.
>
> This fixes an IPE build failure that occurs when using an output director=
y,
> such as with the `O=3D/tmp/build` make option, during a build with the
> CONFIG_IPE_BOOT_POLICY option set to a path that's relative to the kernel
> source tree. For example,
>
>   $ grep CONFIG_IPE_BOOT_POLICY /tmp/build/.config
>   CONFIG_IPE_BOOT_POLICY=3D"ipe-boot-policy"
>   $ touch ipe-boot-policy
>   $ make O=3D/tmp/build
>   make[1]: Entering directory '/tmp/build'
>     GEN     Makefile
>     UPD     include/config/kernel.release
>     UPD     include/generated/utsrelease.h
>     CALL    scripts/checksyscalls.sh
>     CC      init/version.o
>     AR      init/built-in.a
>     CC      kernel/sys.o
>     AR      kernel/built-in.a
>     IPE_POL ipe-boot-policy
>   An error occurred during policy conversion: : No such file or directory
>   make[5]: *** [security/ipe/Makefile:14: security/ipe/boot_policy.c] Err=
or 2
>   make[4]: *** [scripts/Makefile.build:440: security/ipe] Error 2
>   make[3]: *** [scripts/Makefile.build:440: security] Error 2
>   make[2]: *** [Makefile:1989: .] Error 2
>   make[1]: *** [Makefile:251: __sub-make] Error 2
>   make[1]: Leaving directory '/tmp/build'
>   make: *** [Makefile:251: __sub-make] Error 2
>
> Fixes: ba199dc909a2 ("scripts: add boot policy generation program")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Hicks <code@tyhicks.com>
> ---
>  security/ipe/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> index 2ffabfa63fe9..b54d7b7c9e6d 100644
> --- a/security/ipe/Makefile
> +++ b/security/ipe/Makefile
> @@ -10,8 +10,10 @@ quiet_cmd_polgen =3D IPE_POL $(2)
>
>  targets +=3D boot_policy.c
>
> -$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(CONFIG_IPE_BOOT_POLICY=
) FORCE
> -       $(call if_changed,polgen,$(CONFIG_IPE_BOOT_POLICY))
> +boot-pol :=3D $(if $(wildcard $(CONFIG_IPE_BOOT_POLICY)),,$(srctree)/)$(=
CONFIG_IPE_BOOT_POLICY)
> +
> +$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(boot-pol) FORCE
> +       $(call if_changed,polgen,$(boot-pol))
>
>  obj-$(CONFIG_SECURITY_IPE) +=3D \
>         boot_policy.o \
> --
> 2.34.1
>
