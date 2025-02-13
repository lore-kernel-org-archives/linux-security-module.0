Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4A20E715
	for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485960; cv=none; b=PN1Ycn/cFw/jtxeQJCXDk+1UhQHzlS8t4rR4Ixj9bFCj1C4iezy8aojkXETfy9zYye7wUyWbxU2aD0FifAcEcEcmC47W0NdOPaVM+n05sgDrU/Ikv8EqNrjC8UjLC4TkgYQIWvwFXPOaBMeblBC40Ao1C7EpBVg2f+qx00KpSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485960; c=relaxed/simple;
	bh=3nmRFiQ7uT3udcLq+A3quQ3bTH5Y6oSwIuTOQBLYsb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGJm33fomVcX6sjnGal03EABOvDchZHKO0t2HQBYl5vRbaaNb4eRfoN1nFQuPK/nGlrAoS3iw2flYPkpydXV3QjKNvGMFU+jyhLAVkVlRmLv1Df265vFNmPPcy8uMpLndtPY4xqH2yWnByV4mD0baxaY3zx8wKJ+g5VjQRPK+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nw3gtonJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nw3gtonJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d27d490dso3684115ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2025 14:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739485957; x=1740090757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8EXaFBxLNwE01bf56vbVzMOssj4GtKhR3eMZAm/1Sk=;
        b=nw3gtonJAoNBfnTSm1t+HGjCD2qwo0tcSc0QKX50PtjKDoWeibbTUUL06YhcwoKwH2
         nlB6tMF3UxVojHYeG3Vb06u9YVXo0J5JpWrtf+y7wRZGWDwBKxgxKg27l2ym4HtmqxRZ
         RJ+0CPkcdMOOe4A90DRKVfMopHSa49u8xlyko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485957; x=1740090757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8EXaFBxLNwE01bf56vbVzMOssj4GtKhR3eMZAm/1Sk=;
        b=Bmxh1Wf3IkNXOTUEaubBMFQoBPrMOtx+NtUmZT01sKOHtEhtti4ujtY2Jk3x6NqWnJ
         zHOsoIe2PMqfLQtjCFu7CvIrnW1RXP99bu2paIj+Ini+Z5ntHWetAHA3wgiWvhAt6MgM
         7I1ULLdLZaqgwVGkRKkMeJ9qxqFj9p6a7gM6/wpI8NJC2Y00wNzFQjBTCEDmi/XSJGPI
         FveFUhNarqvLZr3RpQWta3WZoGmls7JNA9WfYoRCTxgmib88IOOOLSDrnQ10vzb1AqzG
         IayLlOdRnr9GUM3+kYz6msLG6J7S462pfbITbpSN6YXnmOQzaZrVTCXA3Jff468ov4LS
         ilZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4/FbDn7dxL4Cnyt6yEvLg9fvYvcn++MhAi/P4s58Nzx6kgI+NGc7ydf0eUtR1Qynd3flfINWmdjuacz7h19QOT4ueyWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOsow9a1+sJkiZgVZGXFW02rd6iYcDFMY7PbQrmsp7KnhdKCj
	mUu52TvFoICmdF9o6smekzpMah3qNmJYaBrAwsDnkxVqzomKDsmjuvaITJ3COlgsKHr2V4wflIC
	jQkvixa7hQOVwbk2WAIkV2ZlfJRe8PkfTSPlvwtAGM0kZN+nifRG5
X-Gm-Gg: ASbGncsz5ZCp1ZOVuwhhveTKt/cBms+I1yEplD4SXJWFBwcOVBiZ/wL3GGaFTW6wwf2
	Uvn7BiLr4Sfn3D7e1Mw4cP8HLWXS6XjnQ21kZ7If5VyGlIHgbgzq4cSaM4Tas0WdCELPPOsDkRd
	xRsgzMKYfXAQJXC5a8xQzSDtbQLw==
X-Google-Smtp-Source: AGHT+IF1OsZN6y8LH5UFbbLgIRQzGQDhYmY9iWe1VIWAc/mhKTx2qLrVd/uziGv/I7jl7tP3DIW1vJlEqePyBZ4ldYU=
X-Received: by 2002:a17:902:e842:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-220ecd267bamr4086825ad.10.1739485957623; Thu, 13 Feb 2025
 14:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211132531.1625566-1-mic@digikod.net>
In-Reply-To: <20250211132531.1625566-1-mic@digikod.net>
From: Florent Revest <revest@chromium.org>
Date: Thu, 13 Feb 2025 23:32:26 +0100
X-Gm-Features: AWEUYZlJRhpZB56_aH4q9zf3m-yAA_hSq9j-t_OOEGxjuX863x3ZmA-WZyxJpVA
Message-ID: <CABRcYmJzKdU0H0zXA5QSwD=qF_dnPyGTaXGFFyqiYMF6HZ0OeA@mail.gmail.com>
Subject: Re: [PATCH v1] selftests/landlock: Enable the new CONFIG_AF_UNIX_OOB
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:26=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Since commit 5155cbcdbf03 ("af_unix: Add a prompt to
> CONFIG_AF_UNIX_OOB"), the Landlock selftests's configuration is not
> enough to build a minimal kernel.  Because scoped_signal_test checks
> with the MSG_OOB flag, we need to enable CONFIG_AF_UNIX_OOB for tests:

Makes sense. Thank you!

Acked-by: Florent Revest <revest@chromium.org>

>  #  RUN           fown.no_sandbox.sigurg_socket ...
>  # scoped_signal_test.c:420:sigurg_socket:Expected 1 (1) =3D=3D send(clie=
nt_socket, ".", 1, MSG_OOB) (-1)
>  # sigurg_socket: Test terminated by assertion
>  #          FAIL  fown.no_sandbox.sigurg_socket
>  ...
>
> Cc: Florent Revest <revest@chromium.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/landlock/config b/tools/testing/self=
tests/landlock/config
> index 29af19c4e9f9..361f94f8cb0d 100644
> --- a/tools/testing/selftests/landlock/config
> +++ b/tools/testing/selftests/landlock/config
> @@ -1,3 +1,4 @@
> +CONFIG_AF_UNIX_OOB=3Dy
>  CONFIG_CGROUPS=3Dy
>  CONFIG_CGROUP_SCHED=3Dy
>  CONFIG_INET=3Dy
> --
> 2.48.1
>
