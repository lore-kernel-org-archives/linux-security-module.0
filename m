Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A812C554
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967478; cv=none; b=IHWpYXrfFGHlGRMvf+qFmWZNjfwB3B/WDesHeXjnjwx+uXa04PodG4mU6w/JopuGYItePS4J6ZeThhrqHtzzGdbq4nRlUtKM/TEit76ffQkwQdoyRsPViTGtRXnBj/bZtHQa8RlDG4JiOJmsnrf05ay8c5Xv92SjjXRrPT+soVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967478; c=relaxed/simple;
	bh=Yt1iK6ApoRRAwYIAF8J0XZzIcb/oxLGRDCMiADPPzcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/oRzAmR/rvpkvKHKC3i5KsYBHKoG9KgvAHxElv5jF37hp0mFHxdlM7ppmJtkqNiSrOnJZawIEgYQHAzqDajpgEc0hTDHo3ZZm43CiBpjp85+LVw+G2uovXGKhNG8+W3QWbqYbhNJUtTKnXtl7aHgtzDnZMdH8xEYAwr6C5rg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cRZGNXUg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cRZGNXUg"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512fd840142so1462411e87.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708967472; x=1709572272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOKxowLRXopwaSUBXoFBP7qAPcPHaHQRznoK8vOmNBg=;
        b=cRZGNXUg7tMrDIy/Trs+pcRxxdWR4fXE549Zjdszpu1xsb1bXRsUCtbM5E7WiJL85k
         rTgwTYNeAh5fTsFM4HUvr+t45+SJUdgFfsY05PVp07ATrKKPrXCgI+2gTpuM8cszSbXv
         akWHvy7Dtc7dWU4yLBmPGT49QxCTIe9258MiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967472; x=1709572272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOKxowLRXopwaSUBXoFBP7qAPcPHaHQRznoK8vOmNBg=;
        b=RSMTcaIuPM/S96EkwFAb/whtNbWOa0js92dWpy9fUMjmVSv9sz2xbMLlwlV/4mLEvB
         wRKrSalUpJ4XCXhZYs89PqJEE+edF0aMKVJ9Lr6cV74kFVJcFrmkiXtM/xjQZF0Mp8Tc
         P8uTJfKvB6g2qwP9sshswhKv7Xp9dVd0rMcWecNeHa7jTssg+qGSlADtkIeWa1pI5KRy
         UVu0kUC+Ne24nAQrpbCF6/s+jAVb01jGBDxhPfLQb1mpFZkyVd9PwWvSaRPzFQM0VZ+H
         P3BwcuGQzcaBXj3c8PyXv9EPXqnfs8y5llZxat0zB2f4Rt8lzhqR5LRUJv1oJfLESjqU
         /xyg==
X-Gm-Message-State: AOJu0YytpsM9rL8njT4DvIaOAdm0AcgHNiJLQ0f9bHK8wb1Qw52wVat5
	gXhD40Fey729MTeC1WX7cnF7ud2o2AIjW6R8KTHyz3lLELfEecbRUJK41LiaUH3E1hnnzeoJWHu
	jU9vC
X-Google-Smtp-Source: AGHT+IEAwqWPJxNGlnhLC5c9CD77iOS4ALFETgr7VUAsdDISuZU1I8jL09IOf95Nsnb6+3VMPM2hXQ==
X-Received: by 2002:a05:6512:234d:b0:512:dd4a:9e8d with SMTP id p13-20020a056512234d00b00512dd4a9e8dmr5758810lfu.7.1708967472506;
        Mon, 26 Feb 2024 09:11:12 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id md16-20020a170906ae9000b00a3f20a8d2f6sm2597510ejb.112.2024.02.26.09.11.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:11:12 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so71425e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 09:11:11 -0800 (PST)
X-Received: by 2002:a05:600c:5007:b0:412:a9ce:5f68 with SMTP id
 n7-20020a05600c500700b00412a9ce5f68mr40767wmr.2.1708967471006; Mon, 26 Feb
 2024 09:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240221210626.155534-1-adrian.ratiu@collabora.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 09:10:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
Message-ID: <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>, Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> after which it got allowed in commit 198214a7ee50 ("proc: enable
> writing to /proc/pid/mem"). Famous last words from that patch:
> "no longer a security hazard". :)
>
> Afterwards exploits appeared started causing drama like [1]. The
> /proc/*/mem exploits can be rather sophisticated like [2] which
> installed an arbitrary payload from noexec storage into a running
> process then exec'd it, which itself could include an ELF loader
> to run arbitrary code off noexec storage.
>
> As part of hardening against these types of attacks, distrbutions
> can restrict /proc/*/mem to only allow writes when they makes sense,
> like in case of debuggers which have ptrace permissions, as they
> are able to access memory anyway via PTRACE_POKEDATA and friends.
>
> Dropping the mode bits disables write access for non-root users.
> Trying to `chmod` the paths back fails as the kernel rejects it.
>
> For users with CAP_DAC_OVERRIDE (usually just root) we have to
> disable the mem_write callback to avoid bypassing the mode bits.
>
> Writes can be used to bypass permissions on memory maps, even if a
> memory region is mapped r-x (as is a program's executable pages),
> the process can open its own /proc/self/mem file and write to the
> pages directly.
>
> Even if seccomp filters block mmap/mprotect calls with W|X perms,
> they often cannot block open calls as daemons want to read/write
> their own runtime state and seccomp filters cannot check file paths.
> Write calls also can't be blocked in general via seccomp.
>
> Since the mem file is part of the dynamic /proc/<pid>/ space, we
> can't run chmod once at boot to restrict it (and trying to react
> to every process and run chmod doesn't scale, and the kernel no
> longer allows chmod on any of these paths).
>
> SELinux could be used with a rule to cover all /proc/*/mem files,
> but even then having multiple ways to deny an attack is useful in
> case on layer fails.
>
> [1] https://lwn.net/Articles/476947/
> [2] https://issues.chromium.org/issues/40089045
>
> Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mike Frysinger <vapier@chromium.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Tested on next-20240220.
>
> I would really like to avoid depending on CONFIG_MEMCG which is
> required for the struct mm_stryct "owner" pointer.
>
> Any suggestions how check the ptrace owner without MEMCG?
> ---
>  fs/proc/base.c   | 26 ++++++++++++++++++++++++--
>  security/Kconfig | 13 +++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)

Thanks for posting this! This looks reasonable to me, but I'm nowhere
near an expert on this so I won't add a Reviewed-by tag.

This feels like the kind of thing that Kees might be interested in
reviewing, so adding him to the "To" list.
