Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979714;
	b=jOx9MN8X8ry3Y94t6xQA6HNxaION+9ziOE4unJDaFfKUhN8x6oF+oCvkU6mGpXNTegnR
	 6fuUAZxjFYebPrHbIRcmkqeJKRaIVYlYWgZGsm0Wo4WJNge8klxcACQ7fYwA5pBMLuxNw
	 7e/S33hIhSSY54rEHFSei7wLSMHnKx6UBbZ9Ui9Po6zOyXoz7fPQGe+sBD9Zt+Lli+rjm
	 XIHIpOXErzEK6IX6YF1jHB7AexraPzL0lySH4p2HwVfqGnUJUZ4//wT86/G1qoe/fdRO6
	 mmD6uDD/vNzjhOpGG8202Dgj+BQBxrQO45lUocydUag+294hbb/3/yBPuUQca+CItGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
	b=DB5HQhqcOUAE4ahAzSbrnL7zAdY09Z9lqiKR14LW0RIaKqKdCPWNxRJni1exZiOZY3Ky
	 VFFbbYaLEmnT+z4GYmm2eMsZqnWQh3ZYMOSvf5tN8IfeqRy3/C88msmiGY6beB6NNcFNF
	 N9HoSW5HC3JCG771uaia0irB0tMxecPSC60IATudIea4M+EqIW3XSRaZRB6ml8prrbKuG
	 fEQzd0EEPKmqRNY8gOEELvwFZMiR2NrqNFKOcTnZinOgNkWDVj2nSNfUdTjVmtmEeKjce
	 NDMU4MVWikwXzb3xf8Q667sv35ZqDmy6EGKaZscOJOkM9OU+QoR6tgKRa3FkZ0aO9aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YzzkId+7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131E606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 15:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E131E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YzzkId+7
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so652351a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 07:41:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979713; cv=none;
        d=google.com; s=arc-20260327;
        b=jFnStQVVI8rBEdJkA2sAYnwL1GOnGyvfDO/UO/4kMYPj2Tq84hn9dUY+3cFtaKBRX3
         iTW0rwK1s9gA2a4/Uq7IFVzCpLhNCVGcAfceU+5OHHMY3DTb6gXCDurMOSGPvCM8HarJ
         1MJMnnk5tRYyGTnCErCV1mZ16BHwVIExyHpPosx2SCK2cyQuNRoUtez3DRTEYSsbTsk9
         +GjNlw1ntWIaUBCOxYMAO6dluvakJueMwS3WL6nDzsr/Xf4UESgoUwn4JCJ69k5H0SYd
         zSgryp58AH+HJb1ujKg9koOFqVZcaMJZe3DJqYPXk9e0z8V8VCMcepn3TzOEcvrqUjdF
         o+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
        fh=VoSqqCt1qu83owaXRxbe9rJPRijAAplitilMesLv8wk=;
        b=jAr/cKSA0Op2KCgPsdNTIvS6lU2HWKpR9me11uDhpGSXYq8waDNgBQcYOyERPWifes
         LE4l18aIecOXwtY1HpUIG/qFRVujZqq//hSIN1P/oA3Dtt98BdCInu5/+1+FGI7aWvVP
         S9TLn9/Ba8KWXbLFMwTrEtdR4vesA3MIVIDltdc+9MeHP2g2ZWaUywRnRGVBDQjgS0NR
         Ca+DogpieeNPLpo2SJ2IlyNXd+YZrSf9yaGmpWMrFXxE1AcNzdkOVVxE0L22MLQMTGax
         Hvvq2hl18rdSLREuclYu5LWHKPo1SzuIrgW2WgDy9jH54XFsLKnIecu5n4VM8y49X6a5
         vcXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793979713; x=1794584513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
        b=YzzkId+7qJWBrdgBc3KwfkNFPjAIr2flDfLUmoyshQtncc+Ndvd9sON1MwFGvz3rBp
         VhUf+70b8rH9KxwVnJgIiQ/o3uPTubnnQg4/6C9PTyoSOFCHY23cuoI6OZcK+UoSUnVD
         XtPEQzgxzHkAgFXXLZHstTRu7Q0W5sZ4WrnTsJlkN+k76PtkLxv2iUv4JboT/5HiggmU
         cd0o63pDvyV1UoBwxLbT3ijZr2Dxspu/UqNmNP0P8Bx1TbBSh4+hMra38mZz1yWkEPNG
         X05TDXL5cHFzv6snJstidZle4eSSYbEyRHSCA/H/ky8GhV+s8vXINgjx3rQ0Y0F3UC0T
         BY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793979713; x=1794584513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
        b=NW3sK+KcNDpoc4nQ5SXiT5iYNlWcwmOqxJtQqBit6N0jmfH7+ceY7zrgRvK5Uzb7jo
         3XpSh880Gf6Z8mMHxP4uxNfNzkEycUajMm3gILXmmXNJOpW5ZAabqXnQZyLPGh9oIZYw
         Flb3dZdLj6Jgygdt0ERWW0UroMniKs4aeFcNj1GmdvlSDYLNlHnRe5euBrrHJG+oEfHC
         bjxabEj4aSO69adVHgJrcogMRkfDdLfPhVLCa9ydlmTBok60MrUkZ6Ce3ua/FF+qyktz
         91lGgAyjqFJ8zFuw0fIGiXLqYxEbRotYPfxQrUHR9yI8b+ccjfC4M4WyzUG0SAKmbCQk
         LLBA==
X-Forwarded-Encrypted: i=1; AL+hErGkEh0zphEie9DZeXXnJGG262Vf5n2cqBcGblhshBWgaL0oNZXwvDD56+tqYwqm85275XBFZGj4eAa8YpE6OgoNjupydGk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4D62Szib3IGLVsE5eypxgGfJgl/rBxJhf3n7XOfweSO38kfQD
	LOiUnlyFyzYJdSbEcdWRV6NELnpZNgw/hBPTBu7a53MpTZJqjVG465S3caagbhPZyadUs8ZxptP
	TXmK8J4IhrNOsuXNo8UQzDUYNcQFUqzj5KaMoHeXE
X-Gm-Gg: AYBFou2sJhWKO/IDBYdjXmmy4ZJYOFxWnfg+xfJZn2YODEArjIUJY+xXfkodp/VTuGs
	bGjkVTToxwFL1czGZe0ue3t51unEOLcOrz9Jl1v6VtOcbMpC+6N32XcUYu4dMMq4ysizA5bPd1q
	4zrVM9I4W8Xwr7JJEugAuxDRaszE76ocjGbx7VNIAkMVYEWy3eW4li8JfMfS6X3hUTVVOK0xoYB
	5WrwYUmWb4WALRb+x7io5SPFIDs/mve6VIjJzQ+7SjYc0GbF+1stFnGUTC7pHc5PVzvoBAOHlkt
	B/L8ZI2/ewBxmfFy/QwLRRYKGkFwxvBo5BelI4zK5Y6aRsN+DnIIwRdVWFxCJUw4Dbvjm6dkQWf
	sBI6tXhDoY4qbY6nNX9292kRQmmwFbb8+yYyrPyZukdYTzggqTZ+i7sXxDvpBiOIEZscz
X-Received: by 2002:a17:90a:e7cb:b0:3a8:bd51:205b with SMTP id
 98e67ed59e1d1-3b0db6dc4d1mr3040927a91.37.1793979713085; Fri, 06 Nov 2026
 07:41:53 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com> <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
In-Reply-To: <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Nov 2026 10:41:40 -0500
X-Gm-Features: AclHuK_vNxeGvLMu2q-_O9-3vD4QrJi4Z55I0p-SIXPf7gkTSj9ZotO9tBGrYyA
Message-ID: <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: roblabla <linux@roblab.la>
Cc: Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:39=E2=80=AFAM roblabla <linux@roblab.la> wrote:
>
> Hello,
> First of all, I'm sorry if I'm sending this email to the wrong mailing li=
sts, it's my first time reporting a linux issue ^^'.

Hi,

It looks like you sent this email to the right people/lists, well done
on the first hurdle :)

> In commit 16959c469f232f5c76cfb628297cafbf6dbdba79 (lsm: expose mount idm=
aps to inode hooks), merged in 7.4-rc1, a new argument was added in positio=
n 0 of various inode-related `security_` functions. Specifically, it added =
this argument to inode_create, inode_link, inode_symlink, inode_mkdir, inod=
e_mknod and inode_permission.
>
> This has the immediate effect of breaking eBPF LSM programs relying on th=
ese hooks that were compiled with BPF CO-RE and using BPF_CORE_READ.

...

> Now, I'm not sure how the Linux Kernel treats eBPF LSM hooks - if they're=
 considered part of the userspace that shouldn't be broken. My understandin=
g is that kprobes are not part of the Linux Kernel stability guarantees, fo=
r rather obvious reasons (they allow watching the internals of the kernel) =
- but I'm not sure if this extends to the LSM Hooks. I assume not. Still, t=
his kind of breakage is really painful for us, and I hope we can find a sol=
ution.

Like kprobes, the LSM hooks are intentionally not part of any stable
API promise.  While we try not to needlessly churn the LSM hooks, we
reserve the right to modify parameters, the LSM callbacks associated
with a hook, and even the basic hook semantics from one kernel release
to another.  The reasoning is very similar to that of kprobes: the LSM
hooks are linked to kernel internals and thus need the ability to
change as the kernel changes.

LSMs that need to provide a stable API must provide an abstraction
layer between the LSM hook callbacks and their stable API.  The LSM
framework is not responsible for the stability of individual LSM APIs.

> Could we fix this type of breakage by making sure new arguments are only =
added at the _end_ of the LSM hooks signatures,

I'm sorry, but I can't make that promise at the LSM framework layer.
It is impossible to predict how the kernel internals will continue to
evolve and thus I can't promise how the LSM hooks and callbacks will
need to change as a result.

Regarding the specifics of how the BPF LSM has dealt with this in the
past, and any plans for the future, I'll let others speak to that;
hopefully they will have some tricks you can use to make these
transitions easier.

--
paul-moore.com
