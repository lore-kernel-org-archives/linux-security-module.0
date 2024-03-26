Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFC13CA8C
	for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479148; cv=none; b=WTAOJkeaNXhcY0vCJNOKzw0AMqH/HAXD3irsj1DXO04xTwByHU2PwwzsFVXHNn9pBmTXTOU95xBhHsH8KPn5NoFzHPSyW2FKMJhg0jBPkrS6EcGUHGxsT8EwFf+dYRX8w6lsXZqhlEQGeG1YTnAzB6RsMGb5A52w6alGGbhQ1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479148; c=relaxed/simple;
	bh=gVGL9JKWsT+/jWsd/FheyCcz8K4hp3FIwzMKWZrzr6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaUoGVSk+DWC+UiMeN1/ISFRhpr5LuPilOlKrI+G5h9drADqrzDHjZqs3VT0V66DVkMFdWbynq75RZNmPSrr2hbSZwPBCZAO8RRblj7H16h6GVRo+bOr27QyXrJ7u9HGLUrL5h1ZpsbHKXT5NgBmuqVH4PjyfjGnFcx/RWyYzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RVSIHSq9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RVSIHSq9"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f1f97864so67346747b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711479144; x=1712083944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzSSnt/1tuqFAqk72WO9Yx92dcNUcT/slEGP7/aoLdQ=;
        b=RVSIHSq9ryDRSaY85pv34d9aEzHjPlrYPDOqiZqos5fty8gX8MCkRRjnrAMHYEnnXE
         TeuuP3w2YtuU2xAcA5rSHvxlqGLddlc6JTUfUMNA+znAY7/ubMX+4UFWwi7wjw7EZgSE
         OVhgyqr8Af9zEA1qXIpsyl9pWuNCDC3uHmIFsQuUDplbx5TZuI1unE+TBLbpuX0zZta5
         uuBh1w7sb4hSOqAiJ0XqdDm7tyNdjm0r2uaHITXv4HPI5rN4pUQ2doSLlbNZzQ2gvbE4
         pUtf2WLC9fBdahPF/fM8spyM8kERhNSUDjWdk/uv6ygVrL1NguS/vQRUKf9eRlK6Eol1
         07eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479144; x=1712083944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzSSnt/1tuqFAqk72WO9Yx92dcNUcT/slEGP7/aoLdQ=;
        b=Jqw+B+1AlqvlnbjFbYhV9y8SQJoGzGStXo38LhDksEL7AVlphoji8cbhiHBr943m8k
         7EwJQ0nujL8QbMvF2+bFBnrfTNPEgCPEyHHq31Fhi4nxQ+bN/X8n6tbL7Hts1lbjQr/F
         09lH58QGGhgIKW4iQQXDAldYkyjh+US2L4TCNLp31xublE4cnLYD+25/ZOX82ngNV/dN
         s+qcwil+wkmbIeHE5aEmF7yCM2XIDmdjIs2j2CpLkH5GxEjJerikwDrvUxgWqAs1L3FW
         2HuJN1dCnqFc8cfv1GAf2FQ0pLxqvhyk6cQkqrMlGhERNUnKlq6rVPUdPLcEDHtTWOcc
         oV1g==
X-Gm-Message-State: AOJu0Yw5GaWhmlNSKabsvdLXPQOBIGe9kp+smzKHJ3yvwBiNCM1A2Llz
	flwUykE4c/btNDBmUfpIEt5jPiZ0UKPPBYmANRIQfCF7BHGlIL61dWPqNJglyykhw6E6cUgQGSE
	1wvLHzN5VybpDyn5LY948/d5bL8PxPfKi0r/r
X-Google-Smtp-Source: AGHT+IHqdyqNSAGGvJ3X0kEfA8lHzuIhyBNUZQgGjd2oGp2RW2WNuYuDp28MTzBqvtIcA8x9MrW/yUrTte2tCqt9XtY=
X-Received: by 2002:a81:49c1:0:b0:611:6be5:4fca with SMTP id
 w184-20020a8149c1000000b006116be54fcamr6905198ywa.6.1711479142547; Tue, 26
 Mar 2024 11:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com> <20240325134004.4074874-2-gnoack@google.com>
In-Reply-To: <20240325134004.4074874-2-gnoack@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 14:52:11 -0400
Message-ID: <CAHC9VhQJFWYeheR-EqqdfCq0YpvcQX5Scjfgcz1q+jrWg8YsdA@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:40=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
>
> If security_file_ioctl or security_file_ioctl_compat return
> ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOCTL
> command, but only as long as the IOCTL command is implemented directly
> in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
> f_ops->compat_ioctl operations, which are defined by the given file.
>
> The possible return values for security_file_ioctl and
> security_file_ioctl_compat are now:
>
>  * 0 - to permit the IOCTL
>  * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to fall
>    back to the file implementation.
>  * any other error - to forbid the IOCTL and return that error

At this point I think this thread has resolved itself, but I wanted to
add a quick comment for those who may stumble across this in the
future ... I want to discourage magic return values in the LSM hooks
as much as possible; they have caused issues in the past and I suspect
they will continue to do so in the future (although now that we have
proper function header comments the risk may be slightly lower).  If
there is absolutely no way around it, then that's okay, but if
possible I would prefer we stick with the 0:allowed, !0:rejected model
for the LSM hook return values.

> This is an alternative to the previously discussed approaches [1] and [2]=
,
> and implements the proposal from [3].
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20240309075320.160128-2-gnoack@google.com=
 [1]
> Link: https://lore.kernel.org/r/20240322151002.3653639-2-gnoack@google.co=
m/ [2]
> Link: https://lore.kernel.org/r/32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.=
fastmail.com/ [3]
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> ---
>  fs/ioctl.c               | 25 ++++++++++++++++++++-----
>  include/linux/security.h |  6 ++++++
>  security/security.c      | 10 ++++++++--
>  3 files changed, 34 insertions(+), 7 deletions(-)

--=20
paul-moore.com
