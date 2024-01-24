Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BB7E561
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114782; cv=none; b=XN6QRD+0QouN6VP1ehnOmX5GDkhsxjIzhwZtDM0GuH8jVGMgG8FjH77GgRvXycNKmV1c93uh4j+7azyBpV5b4cmPLgtuyQM2ykbgZwXdp32fPu8y3ytrLnzLKfph8zIntrz2bmwf/obzMvFXU86HM0erFZJpH4rhC4eTqXZn4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114782; c=relaxed/simple;
	bh=2p6qpEQ0FQqgHQ9MZJ6hGygl88/GlnO048hMSuetf9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJPh2Opgloi/Mtkk0KvhG/xU08J2J7e08j2C6Vfk6pW2WfaHFsx79fneMF4bkGH6FkNqq7+hSQfEAvo3GUlqBuu6d6lTB95V9VI7l0TBJboAMxwThh1t1nvZzeIcleENoXcU+PRoB54G/f3DA/fy/WZvP8XX4eQQMn38gQUUrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ed5XcKxR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ed5XcKxR"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30e445602cso253057466b.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706114778; x=1706719578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAV9hUjIFjsOqBZPLiRvCMjNyiBrTHJa47CjdZfZGyc=;
        b=Ed5XcKxRANEFyjUxjVjM+3EXeg433iIdKQ+NHDBO13fP02ova6nbaTF5/mIECUYlcC
         oXqTqFqOKVJSU//AI1yKMDVsZo2EU//OFwcHjf/BQTPjZ5k1gJqueUPRHoZt16kiA4OD
         B8HhzlYJYM3GkFggqr5BhGgp38ODjMzMEJ35o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114778; x=1706719578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAV9hUjIFjsOqBZPLiRvCMjNyiBrTHJa47CjdZfZGyc=;
        b=CUYkU0IJXbMsFOJVuvCbaa99pnhuUPgtXH9yPcLQd28BwN7cGDbm55kkcTxyWsAsZ8
         82XqqIaw3cfph3uDXOJhWEihjO407kqL42ZD8MZlPhVKjasJjAAsKbQ29GRN48UMbPuO
         2t+Blo0A2M2WxvBOm8nytDarSY4/c/pWmtudi3KNNENazWfl1Q6Klv8/gtdw6RGtKs5h
         QUpL+moUpfDI8HgUBRAU6AoFxS4nwK5B61bupc2a8h751Ngm+tjoM+mvuWNQmEByvZ7b
         uluANdJejZxodg3EQdfgalAPusG4LIKWSkXf7dbxJpOJ0aAjXfniSPQQyzG1iMZDwuwb
         xMcw==
X-Gm-Message-State: AOJu0YzlffAF+FA3uOBhr3ZqnUBVe3IFj8ab59FOPUA44atBf7ovuYVc
	O/KUq2ci+L7WjGVo9RV9msoEQSBBg5rHWWihY0w+ylZkeLtNTdPii4YAXND+Qc/qRDl/2GLcK1m
	o42kvXg==
X-Google-Smtp-Source: AGHT+IHYGniQEoucMjvobjlkx2tG8OfMqR3Dcawcsi7n4gLnuUcftsNfDLsWC0PYDK19zt0D8sAmAA==
X-Received: by 2002:a17:906:4f17:b0:a28:c04e:315b with SMTP id t23-20020a1709064f1700b00a28c04e315bmr1504412eju.13.1706114778626;
        Wed, 24 Jan 2024 08:46:18 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906840d00b00a2a61b9c166sm66634ejx.33.2024.01.24.08.46.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:46:17 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so7417766a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 08:46:17 -0800 (PST)
X-Received: by 2002:aa7:d44a:0:b0:55c:c7f5:4ce3 with SMTP id
 q10-20020aa7d44a000000b0055cc7f54ce3mr1287114edr.5.1706114777365; Wed, 24 Jan
 2024 08:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
In-Reply-To: <202401240832.02940B1A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 08:46:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
Message-ID: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:35, Kees Cook <keescook@chromium.org> wrote:
>
> Oh, yikes. This means the LSM lost the knowledge that this open is an
> _exec_, not a _read_.
>
> I will starting looking at this. John might be able to point me in the
> right direction more quickly, though.

One obvious change in -rc1 is that the exec open was moved much
earlier: commit 978ffcbf00d8 ("execve: open the executable file before
doing anything else").

If the code ends up deciding "is this an exec" based on some state
flag that hasn't been set, that would explain it.

Something like "current->in_execve", perhaps?

               Linus
