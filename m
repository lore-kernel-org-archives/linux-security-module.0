Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB922868B4
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jul 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783101431; cv=pass; b=Pbw0vmckPLiWnwlrfOcXnMUiFIc7FqHFzs082agYLjIdMPmVE3tWqVOZ37ctB+yNkZqV3AAPSotCK4TFuj/W27Khm5StegrU6ZGUBk5OYzfiPw5ROnFXu02FNb+OvEshB/zYnjh6QGN2pz0FAqd7nWHpquezChctDoG8ozn1znM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783101431; c=relaxed/simple;
	bh=jYcBMUsEf16lB1gSKJT1q30+H1rv8CvgUFQ3Cpw3r0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5W4DtMuEMCCqmILWePwFCkHPNfwdl/4+c2kapxfI4PxwwW6ja5II0jLBTC+R/7DkaRJN9IZrFy0hMYN9r7dZg3Sk6xKc1itM3VHdMMFgqGfr6RcQK7mpJKFmT1wNrlL0AoncpAw6FiykyhucdIStQh5lQRxHfsiKyUZRP1B6b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFlfiDqi; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFlfiDqi"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664b3831a20so1051700d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 03 Jul 2026 10:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783101429; cv=none;
        d=google.com; s=arc-20260327;
        b=TNotXzK7f/YWgzGXOIWq0p3KQUl4H6cmnnPqxOWRgaDSEEptLe7gAtAY1lMPvIOa+m
         JM13QD52uPgbV6zzeLPrtcBqnAnNf6p+kIb65vDyHQ5kD/J3ugj8g5Bmp+r04xBCMEWR
         92GD76iJ1QjVeXVFOop9lBbqTXlX7k5ZEFafBnTaYnwxVqbN057fUlTcqG3eci5TfDAs
         oLiZzPdcEKGPgwRvPlngf9NUkRPwrffQ0gLErbKV780IqSd+mGpBS3X+4f3DosqXsoAU
         YkajScD9f80D1/rNtbRls+vEiwNgQZm3qQepdLJZ3VIxMG0qgs4XPg+S6K4BzujPuP2d
         q6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+wCeRX4PM1cy9pj31y6w69soFSedp2CdjVACBoJy82Y=;
        fh=Mhr27nDHpRFqG50kz79T21ni0vot+uHqQ6VX3mZi1u0=;
        b=djflAHiL5otGovGZbH2krV8esp9O+jdBh+tofJVlNYEv10tWmNrcaOSLbw36fQg8xv
         pSrckP1Q3vzdsTjKAezcJyZPAXLvW/Mj2nJB4ERdIvopvU18n6t9cGb4fwJ3tRoqJVSC
         8RPZnPGroGfa5gQk2dBbtOpMmEU9+UF3mjavTjkPKJO/v5L0YeDQxLMtv1iJi28Wdpn2
         AbRuJWnJS0fCWBDzq8jYwd+OjhMo0o+TUZtnEd/DebzSXFLpiiKYVnoJlGAPCM5MZTl+
         z+D9a9isycqptn4w/gxbsxY7v68XFoFyxJW7GyjLeGBv0MSGOLL3FY6RgoLQq8BZCNnZ
         8x5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783101429; x=1783706229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wCeRX4PM1cy9pj31y6w69soFSedp2CdjVACBoJy82Y=;
        b=oFlfiDqiyIycyNGH+cVcbvmFX/RmhjrH5sPMfRT7k1kn8A/WOwoJgAfGBdX2peGT+F
         Cwgapy48tixM3/WTyQjHJ9PNKAhiiz1IlBQmwArtP8AHYu7Kacv7j0gw1AFvaYsKiJmf
         0Csd6PfCuMih79MkIIjVPS3xziiqXSQPxCgczadAOPlrt4XprBXwa9bn9LNy4UuzIpjX
         GvUkTyMoxaoCUIz4JHZkDvYgu5FJdUfiLNCYIW1UQusCA2K+3Nk9+8DSdT5LsYyEC9NK
         LrJPrHxNmyT3jLDBM+sLnXQiSESI1I9fMGWPcz0hzQQasGGzujIgLGSWRjq0H8fN1Vf5
         xbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783101429; x=1783706229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wCeRX4PM1cy9pj31y6w69soFSedp2CdjVACBoJy82Y=;
        b=PF+tuUEfMevUaht88B7dPDs/lo6ncVgOIkFGnoSLWmIjpSaYyoJKM8w0tA+fHt0f6D
         Z0PYMFqpj3zRQxWeJ3KpUMMKrwS7nXAY210W3bwDBJnddDUYZvyZMJtH2sgC1rpMeetK
         x+KPs4zDb2+2Bep0CqfcOpPmgGAwWT7rM3UDoLxewgl1F3d+eTg2QqP8JLtoUilzBFXi
         SBrR8AgbywyfaYJO0noqtqB0vsmtydV0b74s1OtOA3OQa729op78Q/a1eVIsKk0kI0q5
         b3fWnwNihDxSmlWG7fs5mP4ELgV8SCq5EKDwIPrG+hA5IdOuZKDGP2QVqRD8IQoCSBKT
         yN8Q==
X-Forwarded-Encrypted: i=1; AHgh+RovQU572vivlvNtSeXW+dMN2GnJHzU9TM+GuDGdcNZpAp3TzdMpIL9MHa+rcaQ49M+Q29DNwZgQ1MR8Nhl841b0w+nyLH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIKp4nKdy/5+9EsL9+4U3mh6Qo5CuVUdLTEpIhzgo2Ac7Oazg
	G/xMAYeHm0asrI/Aj/DIkAg0J6VsYhYhpnx1lmf3q/k76ce0nzpdvNb7WFCkQZutQVVYyCB/zbl
	PeOtYrDh4ZJp+DBTTZQjUdS4JFtCSlKM=
X-Gm-Gg: AfdE7cnAZbZ8AIcwPbH48bHncCxWieCdC6Ns1ImSdd3vI55UtprQkn0nUiuV3RR2wOC
	pkvUw9ocBWv9IZRuy9z4DS2ZsrdrBqVWE/IwMU7ghyvNcisBSw94Waj60qxQ62SqtabmNohkFKY
	pISMAg6Zo1IfomBZE65Koh+pA0NN9sbFnFiNVfPAO+wS6TlDqdx/Wz10JPF7tFofmPQ7Y+F8XEZ
	rsiIPRrxtGBmPSaNoyO+399RNcJNHVvMAy3wdup/JIrG+vNYn7f4J6JfMOwCXWlkYayG8L9
X-Received: by 2002:a05:690e:14c6:b0:664:8376:fd42 with SMTP id
 956f58d0204a3-66652ea1109mr98370d50.39.1783101428823; Fri, 03 Jul 2026
 10:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrDgoHCopx9byaupea8GB6P=qSAY==6QQoXSJcJgn_04w@mail.gmail.com>
 <20260703120951.1622491-1-wangyan01@kylinos.cn>
In-Reply-To: <20260703120951.1622491-1-wangyan01@kylinos.cn>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 3 Jul 2026 12:56:58 -0500
X-Gm-Features: AVVi8CdSPVEbVI_H4mhzLOXB7QTVgXg_PLL4YqyXE43yr2FhcrPKm3ONR_hrQhI
Message-ID: <CAFftDdp9TF3Jp+4yff9aJLnKBbzSzy6BK=og6+m+CXG9wO=OsQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/lsm: Fix memory leak in attr_lsm_count
To: Wang Yan <wangyan01@kylinos.cn>
Cc: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mic@digikod.net, paul@paul-moore.com, serge@hallyn.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 7:10=E2=80=AFAM Wang Yan <wangyan01@kylinos.cn> wrot=
e:
>
> The calloc-allocated buffer in attr_lsm_count() is never released on
> any exit path, including both the normal return path and the early
> return when read_sysfs_lsms fails, resulting in a heap memory leak.
>
> Add free() for the buffer on all return branches to fix the leak.
>
> Fixes: d3d929a8b0cd ("LSM: selftests for Linux Security Module syscalls")
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> ---
>  tools/testing/selftests/lsm/common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftes=
ts/lsm/common.c
> index 9ad258912646..927dce4f04cb 100644
> --- a/tools/testing/selftests/lsm/common.c
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -76,7 +76,7 @@ int attr_lsm_count(void)
>                 return 0;
>
>         if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
> -               return 0;
> +               goto out;
>
>         if (strstr(names, "selinux"))
>                 count++;
> @@ -85,5 +85,7 @@ int attr_lsm_count(void)
>         if (strstr(names, "apparmor"))
>                 count++;
>
> +out:
> +       free(names);
>         return count;
>  }
> --
> 2.25.1
>

Reviewed-by: William Roberts <bill.c.roberts@gmail.com>
Tested-by: William Roberts <bill.c.roberts@gmail.com>
