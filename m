Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697564;
	b=WwFs4E2Jni4Kt/iZYlP1KUDBAyOJIbtNBwPeOhhnCH3YkX/uWukT3bwmw9cnbg3nm9Ny
	 uryqskqyyOL9Q5KnnlYWrQ37aPzPBQFfSc03XEeJctby6IDcUIHma0NmcMRZUSdc0XMc4
	 +Gk/Ax2v0RZs0cEjBa/d4XxmKSV177NU0kc+7IWkhvNdYdxqu+C1l/yA2hCL4fYP7G7oL
	 xJbw05lQy8yZb3QT0kmzBPa93J7H+c/PX0lNS4+vfCpSFRM+wy6r9rO4c783G4+ZERH0d
	 14CMPaJ0H288uXXgweGmGkVdCJNDRiKe5mTOwAfysGQ2bimxwkI16zyC+AeydH2xVAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+I5XcSrnP8TgJZUCankF3qECrXYmR/61VulC5nacIOI=;
	b=qh75bwHMLxa0tUqK/J3B7GaMB0kNKgfotoaXxXnUEDgfZK1K/dFdQg3O+fKs/iQCA7b+
	 GDhopMXwJQAV8CKBIUE0lL9qAakkAF+yooVJJgc8hAcjDGE+ISZHBV6iliDPOvZlRX3CC
	 /h9M0NmB7EHEdnqsMOdKhtfc+AK9hsby9OTmMCSrp0LPfJey6VZRno1bFpzb46TZrSY9y
	 dVQO2vf9kQHY0PwMFw1kByfON8M42m/Wkt3Ce5rdX4HrS/ZV6bpogI0Y5nkP3Dx+PgIJW
	 szkMNrz07PErCKqHztuxwztV5yrFg0VhoVUDqUr42g/BjnKV80edIr61p/JHpPZMBqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRogLsTq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6A606A31C;
	Thu, 26 Nov 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRogLsTq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5341F000CA;
	Thu, 26 Nov 2026 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697563;
	bh=+I5XcSrnP8TgJZUCankF3qECrXYmR/61VulC5nacIOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZRogLsTqTrtfUgCMPsM4cP6jekpIS1U1DFKsmCZAjxSF7Om8j2+1lXgUCUvd72kJA
	 7fVOUzq0O/893Jt1u6tAJ+7I6WbEk7WcKhF//exEnE9wNuwT8CwMVdkfeEGPocvRyD
	 mlCrWADD2lGebtgMtjuFqdP73YcFZm6BxaCgqzgfEArTy0J0lDNkTtcWhy+WvFMJll
	 WAeD1IXXhKO4vCZ+IeIQPQGm1K6kGaVHagk1qBNT+iDjCNndlShcBHabTv+Itv4Faj
	 25caGxcY62YbHfaVz1V4JL3xEpShYoj1/YW4whRbpLV5YU5XU1kZb65D0pGzIqR9yi
	 JZBY+vdLGPYVA==
Message-ID: <sashiko-outbox-235539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] lockdown: bound the status string with scnprintf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126131315.1256553-7-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
 <20261126131315.1256553-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:52:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] lockdown: status string truncation in lockdown_read() on
  concurrent write
--

commit 66eac39b9c466fbdeff2afcfbf4a18a53ab7e3f1
Author: Cai Xinchen <caixinchen1@huawei.com>

lockdown: bound the status string with scnprintf

This commit replaces sprintf() with scnprintf() in lockdown_read() and
sizes the status buffer to the exact length of the three level labels with
one bracketed active level.

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 84efd533fe5a6..239dbcdbabb40 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -14,13 +14,28 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
> =20
> +static const char lockdown_label_none[] =3D "none";
> +static const char lockdown_label_integrity[] =3D "integrity";
> +static const char lockdown_label_confidentiality[] =3D "confidentiality";
> +
> +/*
> + * The size of the lockdown status string: all three level labels
> + * with their trailing spaces, the brackets around the active one,
> + * and the terminating NUL.  Whichever level is active, the string
> + * has the same length.  The label sizeof() values include their
> + * own NULs, so only three more bytes are needed.
> + */
> +#define LOCKDOWN_STATUS_LEN	(sizeof(lockdown_label_none) +		\
> +				 sizeof(lockdown_label_integrity) +	\
> +				 sizeof(lockdown_label_confidentiality) + 3)

[ ... ]

> @@ -134,7 +149,7 @@ static int __init lockdown_lsm_init(void)
>  static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t=
 count,
>  			     loff_t *ppos)
>  {
> -	char temp[80] =3D "";
> +	char temp[LOCKDOWN_STATUS_LEN] =3D "";
>  	int i, offset =3D 0;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(lockdown_levels); i++) {
> @@ -144,9 +159,13 @@ static ssize_t lockdown_read(struct file *filp, char=
 __user *buf, size_t count,
>  			const char *label =3D lockdown_reasons[level];
> =20
>  			if (kernel_locked_down =3D=3D level)
> -				offset +=3D sprintf(temp+offset, "[%s] ", label);
> +				offset +=3D scnprintf(temp + offset,
> +						    sizeof(temp) - offset,
> +						    "[%s] ", label);
>  			else
> -				offset +=3D sprintf(temp+offset, "%s ", label);
> +				offset +=3D scnprintf(temp + offset,
> +						    sizeof(temp) - offset,
> +						    "%s ", label);
>  		}
>  	}

[Severity: Low]
Can a concurrent lockdown_write() cause lockdown_read() to truncate the
status string in temp[]?

LOCKDOWN_STATUS_LEN (34 bytes) only leaves room for one pair of brackets,
and kernel_locked_down is re-read on each iteration of the loop:

CPU0                              CPU1
lockdown_read()
  i =3D 0 (LOCKDOWN_NONE):
    kernel_locked_down =3D=3D level
    scnprintf(..., "[none] ")
                                  lockdown_write()
                                    lock_kernel_down(...,
                                      LOCKDOWN_INTEGRITY_MAX)
  i =3D 1 (LOCKDOWN_INTEGRITY_MAX):
    kernel_locked_down =3D=3D level
    scnprintf(..., "[integrity] ")
  i =3D 2 (LOCKDOWN_CONFIDENTIALITY_MAX):
    scnprintf(..., "confidentiality ")
      <-- truncated to "confidentialit"

temp[offset - 1] =3D '\n' then overwrites the last character of the label,
returning "[none] [integrity] confidentiali\n" to userspace.  Reading
kernel_locked_down once with READ_ONCE() before the loop would avoid
matching more than one level.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126131315.1256=
553-1-caixinchen1@huawei.com?part=3D6
