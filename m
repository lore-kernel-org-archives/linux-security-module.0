Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B061350F0
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987070; cv=none; b=iwGHj3BEAyHGYH1cj30ukcOI4xwq+z1rM/U1tdBP7EpzdGUtnzW7Bk/jxXwSwNMVFAnUcnLm8LzUbskgli3bIzhM7pSeb7KruFcF4lJ5z+7gEcKZQyox0VtlCeVpScqTmVX5xpCIfnrp/nRxBAQ98LhrkYQIkNWj6mQMx1McmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987070; c=relaxed/simple;
	bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAthvQ/bwkwX2CJtntqukJNYxyskOrlJYVKfNWhp6ZoAEKyFpTSnt8fNpCAWX0l+i+4+dnFaQlxYAUCBaNg/lmdDxTRt72CNqa+7oG4sHBTYdIIFkpHXEgOlk77aMDIduNgWYfAhrLiZDohK0kx7aNJ16HSkHlK2kkro505tCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=URxK7Ovq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="URxK7Ovq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so359617066b.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 14:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708987066; x=1709591866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=URxK7Ovq6mgCNT0pAEqBb/3M/wjnmM/LSxXpmCakoJ1ePWBWfexAdkcuSxDKu8qmrw
         wnZfWZ5v8j38ev4wD9Zz2QxRZsrZveUstPE5T2J+pr21rnoxIcx01LeSJWlF8Wyq8amw
         5pNEpFVJPmJG9/uQTS6blToY7w/7Uk2TQ949U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987066; x=1709591866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=aki4G0HGcW/F+a/WJjmRxEu0cEbizUZJqMHUpiQtXEp+Efvw3fhndBfN8RYVrlEdI1
         t/Le6FZTL6VR7iQvDO8UT7VT6qsew9M18d2ni8UjcXu2KVxNJUe0mjPkKPMmSmVTsCAm
         qP7qwjIQ3K++HgED+5ws02nNuJV3vjLa1kk17+p1aHwssNeQzrMlybOpp3wISFFLnR0o
         HygbVVnf7wsgaSZcXSJKkK0frnJnZVsKxc8IVeA1rX8Hx9fYnRr0hK6xILs/Cqyl4S1N
         V+N+0RWaTeeuD6en9oILaCGDhiR6/93SJ/NyOwcwKldwyZcEsMI0m1wLuj3DzC6aIriZ
         Zm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI76sHb/uI5hLRPbenDQZAoN5NWgrzKzyRgDrzAxi5PljFe55J/j76x3E+fbyS9xE6dEDu3A0LIVB5GySfektd6KVwFljNWBo2/4DJHz2bL3rimrNr
X-Gm-Message-State: AOJu0YxcJ7vMP0s3sN1Pd9bA7D5Otm+uRhj3yOhxal+wUSKpWDkbWWNV
	akKaqGCp1sVrMS2zQo9aqDrkKjwU2PB7MUvQd2eWHMSyd9qyUJWnZXAmZIkhHRM8yfexqHkSlEB
	2Ms2F
X-Google-Smtp-Source: AGHT+IFXz+B+p87MSPqyOW54vKiolNjQGLME/Gr5RpuDmaz4AErI0GSZJkvF8TCRz0W3NirM3Ydqwg==
X-Received: by 2002:a17:906:3e4b:b0:a3f:6513:1489 with SMTP id t11-20020a1709063e4b00b00a3f65131489mr4744119eji.55.1708987066400;
        Mon, 26 Feb 2024 14:37:46 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id st14-20020a170907c08e00b00a3f5c39bf2asm170437ejc.0.2024.02.26.14.37.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:37:45 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so15775e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 14:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFj5FBgibjJWMbuv06C+qj6IFTPU5ymCYVWyh4H671lxYCXdjWCs2Dr8uxeGlB+XYfNivjnK+LLQ/Rt6XjETvSV16fLWpo55yv/YuRhfwGd898eGzU
X-Received: by 2002:a05:600c:1d8b:b0:412:a80e:a5cc with SMTP id
 p11-20020a05600c1d8b00b00412a80ea5ccmr30242wms.1.1708987065108; Mon, 26 Feb
 2024 14:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook> <1405e4-65dd1180-3-7a785380@32026879>
In-Reply-To: <1405e4-65dd1180-3-7a785380@32026879>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 14:37:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Kees Cook <keescook@chromium.org>, jannh@google.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 2:33=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> > > [...]
> > > +config SECURITY_PROC_MEM_RESTRICT_WRITES
> >
> > Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> > sysctl, but that's be harder given the perms). That this is selectable
> > by distro users, etc, and they don't need to rebuild their kernel to
> > benefit from it.
>
> Ack, I'll implement a cmdline arg in v2.

Any objections to doing both? Have a CONFIG option for a default and a
cmdline to override it? This way if a distro wants to restrict writes
by default then don't need to jam more stuff into the kernel command
line.

-Doug
