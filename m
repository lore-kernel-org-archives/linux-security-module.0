Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22E2D6E5A
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jul 2026 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047708; cv=pass; b=HAjbwDImEqTtDygQVUKadiiQzEjDf0wvalsz00Lnl9zC/gBlzdQpRFfXyRCEwTkiOKXlwjRAFs4Fs3hYEgCoT7LG+JDz0i+wYJCUxkFtkmCUjI710onzNxIslejC3Ll3D31WwBiPNHu8ZnL2L9BR58n0H6W78bN88IlkfNM+dy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047708; c=relaxed/simple;
	bh=hivGL9AEjo2oQ+VmtRa/AUjK5mSGrBhvAddhpm5pdn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYHkjIFVgvxrwXnXJAsPAbb4ixcebnPQ36+tue4JFVJ6aBsl4lq5DdhwHLxXkd+9N8vtGWTsm9VHbCq0zyqC29d4a6vw6yDUmT+hMhe3QoYrP7lkXvydSiKbgyyGCFEeSfNP+q0PiFeldWZQkNFIClbL+pfV0PhZi+XFHuG/xPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrihwNDt; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrihwNDt"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6663b4fe293so82734d50.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 20:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783047705; cv=none;
        d=google.com; s=arc-20260327;
        b=qAJOTwAw14eY/mIKWb5YguTHLqFMVX2piBivmRmkQE77A6ic1WZpgOUYHSSOvq9teu
         aX8aYHeGXkyb+DJzCQ52d2Igr0SIcLiiXHrnCdUcIGLZTSUZXS/QVLC9n17/STe0Actf
         +2cYl7G4VM7eHRqImDTgaCbdd5lmq8QQZ0j1U1GG4azjY32Mq0TFeFw4WajJOoVjy3YZ
         cAQzGfc3L7KMyGMxc95SmqUg8lhA9/dHv90IPtmWJ0V3h8aZy1Tqr/2orJoQfWJRu5bD
         on1oLWm/kg5dnsLX2qg/eMkKt6dT9a/G7c1J5QBpy5j9xgNFVNXab+Rt6DnoJLG3J4VD
         Y3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pNTMkXqJHQWS/3hJYtcFCJwiq85VgF/d51n42Tox34=;
        fh=EUk/z/rL1i+ZA97LbfBZSL4XB8RzW+pkt15zRSYDM/w=;
        b=QUXF5RSiDOX4K8ezkfFdil9o+M5OEWNexW8arTMZmcWUDh/7HEZB3qR72oTAHLkYpe
         FGysQxudAH5mMEI7s/9K69J9n3weJs/XL/SA01a172R2uQyDTxsrUOU4TIxwp4m6Z0AX
         b4gJcVD5b/wp12XKOzz0VOspet0+5Rc2aaRhbnnK9BsImkS9DBpBaD/u0kmZl5JZBb3t
         LrPJszoaBrcz50Q5zPM8ZiwLZXxQoakBjARHVj+NBEev4A2syhEb4GNmlkT3H/I9gS37
         zjYPJEvkALy210TaQROPH65dV8ROArVwSyECgmubf1wE2l4eZzIRop0picSIs59cqMRV
         8XAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783047705; x=1783652505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pNTMkXqJHQWS/3hJYtcFCJwiq85VgF/d51n42Tox34=;
        b=JrihwNDtIxP+qKXqOKWiB5eVCobUpVroB+skxXYMg3byWxfvuTA6pflgRHHxWkzvAf
         iDDA6GXAP5zNQjZdJ2CMCOy8I3Mg/EVloZNo/5OPkMMqmLjPrw/XNVTWvLc1/KNpTRQg
         wz0YtVPPlWGFiHIqeUPewUbreTGXUFinBoBvI9JgmFt/zttQ4wWO4CNiWuMG81aKGfpU
         jE6oH18gJAa2yz0j8TCwAFbM2UCHzPVVgVkLSm66Th9n2EcLuiEDZw+B8AR2uOkkQpwZ
         6khgyrr2NF63lrMVZ03Pjctpru2oORGE1BfVX9ThP9qD9U3E50XEeEJVjr0ZdHcMvKNb
         BSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783047705; x=1783652505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pNTMkXqJHQWS/3hJYtcFCJwiq85VgF/d51n42Tox34=;
        b=fYJAqWQRa7ioBGNY+gv+BZxVba/9M/DqN0pkYWsk5/tIOlf3U0X29+BngCpn2fs+6U
         k5Ubpb7lsZdSmRqEKMWku+fguPQNHA6+M5MezRb/52x39SUWdS3CbN1HJLs4omdycSiM
         EKXR8dqaadyGaj6B0eA0rfl+EPceBHD4NVINEiMPvUpSJOMS4zejvVjYPd8lL+x/r6TZ
         kvENlWyBr0dfqQF5Rqm1eDbPKZkiuZwINHOa//nQ0ebjEdF4pzt7ZKyw0Rm2uKa3QYDh
         YUHmqdSx++irFWxrWx3aGKWx7eecIExZ6d6mn0Cbi0uMHP83KyrlDIq9/F+mq4+UOeXv
         5HTA==
X-Gm-Message-State: AOJu0Yy2Zq21/WMQ3yJQGVb/88+kOj89xPu8SNSoidCzerEbYsf1p+bT
	IHWqyGqUFIXS796kutJV+RpEpMvPC05FpJN3XF1bO1zI5fDYD2EMOOKkDlhv6x3vr6uIFwqyh+j
	8exh8C08fYmM+O1Fx6NJvNKDVq4o67xQ=
X-Gm-Gg: AfdE7cmxGU2dVoJegX6/q2SjJBIdrhDKHUvIC6nBpxqCxsD809zI41l62ZL9wLfIdGX
	bzuagkJ8W4ll/45MvBCtkRV/vETmJA9bL06g9Ikm1IAGdQh2f4OU7xw748kpqmJeFhQR5l6tpF+
	t4KX8LCz3+H6CNUWuPHiq/68WRco1x2ePxuIpEPT5p0nQGyU1zq1s3nNIxGn83aYFAlg54Zp5Nh
	oiBkti57Mbkw+RbKKrBiubDhoD2iLV5ZwaTSg4QI5WLgfC26H0On3Wa7CVrfwnKv6PTJq8=
X-Received: by 2002:a05:690e:4501:10b0:660:e9ea:17dd with SMTP id
 956f58d0204a3-66521a0f41fmr6219019d50.28.1783047705519; Thu, 02 Jul 2026
 20:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703025247.940055-1-wangyan01@kylinos.cn>
In-Reply-To: <20260703025247.940055-1-wangyan01@kylinos.cn>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 2 Jul 2026 22:01:34 -0500
X-Gm-Features: AVVi8CdJqLnqBKgtM-g-1LvQckP-amZ89lu1eWViecYCLlzrwaKA6-ak9naLr9c
Message-ID: <CAFftDdrDgoHCopx9byaupea8GB6P=qSAY==6QQoXSJcJgn_04w@mail.gmail.com>
Subject: Re: [PATCH] selftests/lsm: Fix memory leak in attr_lsm_count
To: Wang Yan <wangyan01@kylinos.cn>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:53=E2=80=AFPM Wang Yan <wangyan01@kylinos.cn> wrot=
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
>  tools/testing/selftests/lsm/common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftes=
ts/lsm/common.c
> index 9ad258912646..4fa8310750a0 100644
> --- a/tools/testing/selftests/lsm/common.c
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -76,6 +76,7 @@ int attr_lsm_count(void)
>                 return 0;
>
>         if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
> +               free(names);
>                 return 0;

Did you test this, let alone even compile it? All the C code after
this return is dead code.
Please ensure that you test and compile your patches checking for
warnings. Sending
untested patches is "spammy".

>
>         if (strstr(names, "selinux"))
> @@ -85,5 +86,6 @@ int attr_lsm_count(void)
>         if (strstr(names, "apparmor"))
>                 count++;
>
> +       free(names);

Do this instead:

         if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
             goto out;
         <existing code>
out:
           free(names);
>         return count;
>  }
> --
> 2.25.1
>
>
