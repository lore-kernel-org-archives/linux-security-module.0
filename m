Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201E1EF1E
	for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713636190; cv=none; b=kI/umDGVnBrvjfXEjTHMw59BU+pMcY/PM7Yy4/Cl0nrPhhlamp8a1KzcKKMeoa9xvK6MTPJuwAjUWpmLlyI677cUVh/bgeROaUDk+lTOMX2ZW4flhBKE9fniTFwN7Xgfbt14TbDRtNq+0p98g4LyvpkWNBtrJjvDNhs6s2ZsLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713636190; c=relaxed/simple;
	bh=XD8kIuycNDgPcM0zNdB13KVRClY5a3l1yHaX8uhAPqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1iR4YcV6F5u0LuIZba0QCXL6Gd7jg90FNTKBD98RiebiL4BawazSXjgs0GKs79C7imnPnenbMjsMJgQrDQRGC/RbsSTBgpFELnFwuN+Np8kqxuFXY96n93DXcCyFFammahVcAEvJ0iXT1w46hoq/jUb7sKhZp/nPVtXirRe85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P2ezNuv1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P2ezNuv1"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a526d381d2fso724302266b.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713636186; x=1714240986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sqXoO3+h8rGnOZ9lr24FquhSup/PaoI+NzZzYVQGgdM=;
        b=P2ezNuv1z2gsBck//Cj3gPi+oyxMQHRKkHNoqx2wiIeuOflkn+k5qlVEXkAUQn7QeV
         UDst2+TFQBIQnpwDDKu51+3ogGs5/CWOOc8VkrYpBuGnVlgnVtGJNgcsaajc8A38hvoi
         A0mWkQqpG7/eJ4U779PDMQhKxpAuIY0aJIKA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713636186; x=1714240986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqXoO3+h8rGnOZ9lr24FquhSup/PaoI+NzZzYVQGgdM=;
        b=n/A1H3b3+3lUch+Ot4GGCKA+zMMv9br+sHKbAhRl4jvktJKju8tQq2hMpnyoOkFqCy
         +u4pZON6y8kesovoqGXT0PsSGSJFXIUzOKDE25i0glN+8/qzpR/b/PEaYfdvhxuBht5v
         xDdmy3m9jMF0Cbi+a8Zd9kErfmQMLSrvWiqNZbmqIzp9eRzefUxv120VCjvfs6l8A2jl
         cztOdI6JPC62OD8dHz2HGRFYHQUeWw+vOLAktgt4OIY0YES7RTTUrli4hetg/Wnx44cy
         9HDgo2unGTsFI4TCdLBy1entz83L7mVmRTJW7mZjAGIFg4C7iVGIEAf63nTxdeOZtPV8
         6ESg==
X-Forwarded-Encrypted: i=1; AJvYcCU3oHVJhXA7HowgphwCRaZAQoucf9s41ZPcsQZ7AcbsM6zdXMnedg4UVVT1VBUruHxOISkR/yVxsPOJ9ITzWxaaMS/oUMHVbMYrZ/1g3fStJh+VXbHl
X-Gm-Message-State: AOJu0Yw9VskCB4moZb/OT5OexN3P01a4qN9G5py+KVhYjtGl8JhCuNZ3
	tAn0TeSV93dyPPio9eidQeAPAen2QVkYH0xNvi2PbSseXy8Hz5Mn7DuLPUi0owIio3VdWQpShq5
	et68=
X-Google-Smtp-Source: AGHT+IFB4q+kJV3klHNwrdKUxa1+ZEyr6Gy53nVIWuTG6OM5recIWF3RtD1bvsOuUskpHYO9vHQgDQ==
X-Received: by 2002:a17:906:2c06:b0:a52:4246:be8d with SMTP id e6-20020a1709062c0600b00a524246be8dmr5576904ejh.18.1713636186418;
        Sat, 20 Apr 2024 11:03:06 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id cd9-20020a170906b34900b00a5264576138sm3638308ejb.35.2024.04.20.11.03.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 11:03:05 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so6608066a12.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 11:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQXccBhHTsev8izyamBzF0/FKerwPdBPv2q/FV1344CRH7VyV2CBHK5BCB62VWAL5nW4zUjWWKPjm1zx+kfYqTXCsJPFI9+e/qCRVzgIOkmWWj9OiP
X-Received: by 2002:a17:906:5d5:b0:a52:4bde:4999 with SMTP id
 t21-20020a17090605d500b00a524bde4999mr4978012ejt.31.1713636184639; Sat, 20
 Apr 2024 11:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp> <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Apr 2024 11:02:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
Message-ID: <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 10:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Alternatively, we could go the opposite way, and have some flag in the
> line discipline that says "I can be a console", and just check that in
> tty_set_ldisc() for the console.

Actually, I take that back. It's not /dev/console that is the problem,
that just happened to be the one oops I looked at.

Most other normal tty devices just expect ->write() to be called in
normal process context, so if we do a line discipline flag, it would
have to be something like "I'm ok with being called with interrupts
disabled", and then the n_gsm ->open function would just check that.

So it would end up being just another form of that

  +     if (tty->ops->set_serial == NULL)
  +             return -EINVAL;

check - but maybe more explicit and prettier.

Because a real serial driver might not be ok with it either, if it
uses a semaphore or something.

Whatever. I think the 'set_serial' test would at least be an improvement.

            Linus
