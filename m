Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1216CD1C
	for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739889; cv=none; b=Jg39KN71Bh+NQWTR6IkCSIdVnIUKt187HtcUCDA+KU8TaoLdYXMQ3SbbAUFXH8/0GXdKkKcrze9Iu6h5nvdGQVSExZzpYBgDSwj83lRdff+WSx0uEADrRt+HGoWbaKGdzvhImumhR5CCYzx2jZ+H2GCr8P+a6qmt72r7HMuBS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739889; c=relaxed/simple;
	bh=VN547w+VN5o5DE8HvJwoLrfKRWnxFAxA+jTsnbyfBGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaTNYWNBZpKFgPPmWzKV3jfQGXWIHjM5mZXQCbRf1ATdjBuwWSdF3YghJ94l+6vEsYq+n3Gy3PH98ER+LD6FXIPdwLyGS3/uteis/R0lnBbKqcsLgxf/kuelz5B69d2U2ZzeTla4vaxBNJOQzYtGKZOxvLyYEagOLWkuhAW0Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FSocZMz8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FSocZMz8"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6327e303739so44113087b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2024 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718739886; x=1719344686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM17wTy9/rRfZ8ThkdkO+gn1FlG9OhXzhFhng4YH2g0=;
        b=FSocZMz8jCkpT5aT5sI3sOfzvvkR1PEDcsAdE9qFY04j+ZRXsqMhcukEg2JQ8zs5la
         924yAUg0DyGmqCI2J6p8dy0CLoUH2nP1FoW4etBYpA0TE19plvFeMRlegOHUUllpe0/u
         JgvY+vJa+iM9oCAJzZIOa70sKAP7eHOeQqXUnS69QgszfwSr8lNH7S0znUTTynWKlk7K
         aUvVWNLFavkBflI79gP0N0bTGFkRV1OoZb5+EXumi/2X8DfhYGHboAswptLtldI7ezde
         0ibM1S2GlMyCw+bWTeYa7Yfiw7DY9ClG1YfhcqAXFS3HN8XOVBkttXRLw1wpQYI+L3nL
         dE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718739886; x=1719344686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM17wTy9/rRfZ8ThkdkO+gn1FlG9OhXzhFhng4YH2g0=;
        b=GI5GYkt0LJ7Si/HyiXQa4Lkag5CweQ7HmM1ifF9ThWOGhmT4jwvA4sKG3pRPiG8Lgq
         o6GBv/4c2A9jcwO7CSzTR6Zi8XoPJyziR4K7cftgc4vUJJr3V+gx3SRmUHRKahWNQYb7
         l/pEnVfgIw6gNerBiQk+3DwsRtFXCOjbw0jGrXWM+P0NCH2Kzf1PiBc97puoMh+KDcqC
         wiSOFQDuNAYAqNTXA1B44PbCBROPWLlr6IiMenCvbcf1Vd/iSY0/OJxRQPq0Bx6cm/Q/
         ld19NU0aPYrGCd7DpFtxt2y3DbdCS3HaPTX9S8j10c9tKOJJzOJl/TBNYoQIa+oXxbbJ
         m+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTO6LKROJjoYrsdDJ2UzUW0H4WyNzaSwibQHlHbvJP115mkT0qDJowVa3/OY9rzrjNrLZpPjHZpqsATXNRCc7CGaqtzsJf3eDEKV0xTJPmuKzQQnee
X-Gm-Message-State: AOJu0YyY8/26Mssr0WZRn05iDhhEPnAxHdDpin4DPWkFUiSFvV+/PzdF
	CAD/eXqIwtfwsec9onJzWwiEY2JpzSBbTotXrst8CwpMMWaQkHy35Ws+T4HPei1d/JGEIrxiaG7
	H7RSFnZ0GVNs5REuHu2vMd/Td9Cj224D3MkLA
X-Google-Smtp-Source: AGHT+IEK8Dtm/LMdflWvORsofjcPiKC+teg8B3fl6iBIXLr9a2xcHWfRb0owhtf0/w3ajHDDj/VarFLrnIWOR7HVMfk=
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-63a8db105efmr8814347b3.16.1718739885749; Tue, 18 Jun 2024
 12:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618192923.379852-1-mattbobrowski@google.com>
In-Reply-To: <20240618192923.379852-1-mattbobrowski@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Jun 2024 15:44:35 -0400
Message-ID: <CAHC9VhTMmPC47A91NqazrR=RKwt4JxBMRbpsPowTqxQ06ZjgZA@mail.gmail.com>
Subject: Re: [PATCH] bpf: add security_file_post_open() LSM hook to sleepable_lsm_hooks
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:29=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> The new generic LSM hook security_file_post_open() was recently added
> to the LSM framework in commit 8f46ff5767b0b ("security: Introduce
> file_post_open hook"). Let's proactively add this generic LSM hook to
> the sleepable_lsm_hooks BTF ID set, because I can't see there being
> any strong reasons not to, and it's only a matter of time before
> someone else comes around and asks for it to be there.
>
> security_file_post_open() is inherently sleepable as it's purposely
> situated in the kernel that allows LSMs to directly read out the
> contents of the backing file if need be. Additionally, it's called
> directly after securuty_file_open(), and that LSM hook in itself

*cough*

"security_file_open()"

*cough*

> already exists in the sleepable_lsm_hooks BTF ID set.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  kernel/bpf/bpf_lsm.c | 1 +
>  1 file changed, 1 insertion(+)

--=20
paul-moore.com
