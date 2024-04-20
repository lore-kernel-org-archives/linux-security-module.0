Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6A2E648
	for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713634479; cv=none; b=I3VICT+RF6+y7U5t0WpELw8+PuBbZMHtwLlUEdkxO/1ywlGsumFAK73ZpVwlyZsr+uLHgmCsZg3xv3qmPfqtmGlo+L5yjNeaeIUsEI11ODDbjL3GfHBLYZis8mMnj8DzzhwNFKEJsGelq9t/WEta5wbVOf34PFpMF9cFQjEEunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713634479; c=relaxed/simple;
	bh=FZui6/jAqpSCf4l3i1TeoGcFiXdATKG0xPtGvjtat9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVqQeVUL0Rx3vUbsmLLGXo5CskGfjqut2a6VbpGAlBQ2ioZzb9gXPWgZyO5rBQPP33f6WLF0xB6LN4d63mFHY2bKn3HjqsuG4NXqAiph8nyGN2Ga9TT6ZnPVf3Bp5uCC/jgVu2PzTzk5QvItV3+zWVExcKRaPCJ37oBnKkL8WMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W6hYVprZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W6hYVprZ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-345522f7c32so1335622f8f.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713634475; x=1714239275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azgKuVXWo1stoA6zH6ErzXlXBirYMEprw5yf7intLHQ=;
        b=W6hYVprZQ1Msy2EtH4FVgc6phK9xWnkp6I8XK40hIPj7AIZ3CAtUwOBZn99XOOJttT
         3fPqKfo/JyQec9bNJWKoE+vWTNbDF15fpcdXlecbHacj6XoFb/NtYYziqdhdHBkJtv08
         amLQWoLYld37W0WMmI7Zanb63jPiYm/L/NAVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713634475; x=1714239275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azgKuVXWo1stoA6zH6ErzXlXBirYMEprw5yf7intLHQ=;
        b=rObhLLGJsKW+5pFtCrBBhC92tQjLxj1SH3G1Ov5xmrtSlWOmc87EBpkO36vA7su7Kx
         qYEeoHcL8ASp0Mj1HppwXBP4lhqbtEvk+YI1Jcs/Ot4tnWnjxKymp6lX6jUGgrSgV3D8
         AoeksTcdmFBBwXHU4+9XWvXRdrBZ+PyOxJKO/JgeV0VB9ZUCz4Mt/GhKzd8P67IHr2ba
         B3+9p1SgairNes6WvuphnP86H6TbeUIjJH/FGSmLpsSZIJczQS1WBEEOCOB7ZCQL8J/j
         GPRVOfB47ZqimsxYy7FFc4PA08cVk4K4f2u1Bw2/amaZS9M9l4bRa3vrkSeTyfsb+xw9
         Otzg==
X-Forwarded-Encrypted: i=1; AJvYcCVGPBSZH7tiN3S43hjKvTvaQziXEL4GAR6XZ36ExDtoi4Di3JC7vaJagtgfqZ/T0xo8l708FmAdlLKBnC25R55qVyw7yn6GDUPrwQilw+s/ATRLZD+i
X-Gm-Message-State: AOJu0YxIPgMaqak/Y53rFUhnykBwYvywCXABVwZrEoaRAZ7yAey8vAZo
	BWWIr2QxyvvFQtwQMhNmq2tCbw7vWhVhYtf5Lf7+fnefz6hGObfI34XI4BMnRTcWMmLD++MtOGz
	0BGc=
X-Google-Smtp-Source: AGHT+IEdl23b+OtgKSSgJuOvprDbD9pJ7+G/+c6BNh3xmOrC9FElaA4AHnyCk2dKx05QyWbaL36E2g==
X-Received: by 2002:a5d:678e:0:b0:348:b435:273b with SMTP id v14-20020a5d678e000000b00348b435273bmr4088943wru.54.1713634475411;
        Sat, 20 Apr 2024 10:34:35 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709061ed000b00a51c0c0cb86sm3646845ejj.22.2024.04.20.10.34.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 10:34:34 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a55911bff66so128875466b.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Apr 2024 10:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjNSWIwcWcw1HfuhkNxmK41M4CmHvM5gTTO+GVfNvbymJCUR1Sqc3nij+3u5DNl0lGJUi9JkDyALl7wWM76wFyzJci2rVuLgtqWoMv1FJN8TFum6Ry
X-Received: by 2002:a17:906:c0c5:b0:a55:339d:bd20 with SMTP id
 bn5-20020a170906c0c500b00a55339dbd20mr3813061ejb.51.1713634473876; Sat, 20
 Apr 2024 10:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
In-Reply-To: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Apr 2024 10:34:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
Message-ID: <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 04:12, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since n_gsm is designed to be used for serial port [1], reject attaching to
> virtual consoles and PTY devices, by checking tty's device major/minor
> numbers at gsmld_open().

If we really just want to restrict it to serial devices, then do
something like, this:

   drivers/tty/n_gsm.c | 2 ++
   1 file changed, 2 insertions(+)

  diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
  index 4036566febcb..24425ef35b2b 100644
  --- a/drivers/tty/n_gsm.c
  +++ b/drivers/tty/n_gsm.c
  @@ -3629,6 +3629,8 @@ static int gsmld_open(struct tty_struct *tty)

        if (tty->ops->write == NULL)
                return -EINVAL;
  +     if (tty->ops->set_serial == NULL)
  +             return -EINVAL;

        /* Attach our ldisc data */
        gsm = gsm_alloc_mux();

which at least matches the current (largely useless) pattern of
checking for a write function.

I think all real serial sub-drivers already have that 'set_serial()'
function, and if there are some that don't, we could just add a dummy
for them. No?

Alternatively, we could go the opposite way, and have some flag in the
line discipline that says "I can be a console", and just check that in
tty_set_ldisc() for the console.

That would probably be a good idea regardless, but likely requires more effort.

But this kind of random major number testing seems wrong. It's trying
to deal with the _symptoms_, not some deeper truth.

                  Linus
