Return-Path: <SRS0=p5JF=63=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B5C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F04A206A5
	for <linux-security-module@archiver.kernel.org>; Wed, 13 May 2020 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589399541;
	bh=yChfl6bW7pHHSbBVahran9Uag3HId9/L3hOJcUfAW9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rXcGWYlZiUt84ufk+a9gkzncggHH2gzLZhmX7kCEuD1ZvYYOTsqzy15xmnwFVRIgA
	 5IZVYdTFcMelWyAUKBS5Xv454lnW91HaWN/aarCK3aolc9s1wfWNcoerUOxlpQDRCr
	 XxBoqznGQgoMv8T5rRN4NrQ9BIITdkuxX4/rF27o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390607AbgEMTwT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 May 2020 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390158AbgEMTwT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 15:52:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30210C061A0C
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:52:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so898152lja.13
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imHJ5IQrcOcblMTfzv1B9XBBsSAMPE3kPxQA9myjXSo=;
        b=WQAwRDY0UxVZ0mZJR9kVnssScJrq1sN4tD98t4V9W35y8XGCwm/KxMQqToQil5ltO9
         GFUoMNp/kFEbFvuKrggepy5FbHzhYuRUmjv8amxmBrzK6q3yS0RJcPigPs+hBK67907L
         GVp+95DOu4oDEqAYtYvxlr8n8Tbt3B0dOxjF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imHJ5IQrcOcblMTfzv1B9XBBsSAMPE3kPxQA9myjXSo=;
        b=AX4tLmDh4oSR29srJ1ZexruNdEQmDiMACOwwOedy+FRHvVej7F14liZvHsCiyEv8uy
         WxdVjdoMtZgd9gMfaaNrVleKbFT7aSRdaS5/Iy/L50jzbJY4wWmiR4fGo6/O4xeCk0Jr
         27Ja7W5SGahVVYFmZE8fIkmvsJXvEpDDD2Q4EYE1lGhA/45uZmpjLrpNqDSSyH8csHrh
         0AlOyaEUugRS9ALomHFC24urz6rXmBQqhsKDLfsxBstDCfMnM5/GY1NX6yOstOylbO1v
         he7eAknvtMgTiJdy+j1AHnyiQL0kYst91MqNF5nTeHctt8Mjaa6CGxix9QttMz01g4vf
         k8zQ==
X-Gm-Message-State: AOAM532oOApyMMq8ZREb+kVG0/ERaJw8eI1vglgwSDS+AU370nwBgXH5
        +HumKBxkyt7MQFt9e6vKoUaOGR/wThg=
X-Google-Smtp-Source: ABdhPJyLQkExhVbDIIyuMONaJsViXLD5UT355o+jR4fxQg0ClZxrEucTdzDqd1AM+C/8OCeE5mbx1Q==
X-Received: by 2002:a2e:994a:: with SMTP id r10mr426676ljj.105.1589399536959;
        Wed, 13 May 2020 12:52:16 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id h18sm282612ljm.18.2020.05.13.12.52.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:52:16 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c21so583094lfb.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2020 12:52:15 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr699711lfk.192.1589399535404;
 Wed, 13 May 2020 12:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org> <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org> <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
 <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
In-Reply-To: <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:51:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgYDMabsEDW_W3iU0jD8RhndQAMhR2HSMkMZ3rTCQbVg@mail.gmail.com>
Message-ID: <CAHk-=wjgYDMabsEDW_W3iU0jD8RhndQAMhR2HSMkMZ3rTCQbVg@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Rob Landley <rob@landley.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 12, 2020 at 7:32 PM Rob Landley <rob@landley.net> wrote:
>
> On 5/12/20 7:20 PM, Linus Torvalds wrote:
> > Ack. I think the AT_EXECFD thing is a sign that this isn't internal to
> > binfmt_misc, but it also shouldn't be gating this issue. In reality,
> > ELF is the only real binary format that matters - the script/misc
> > binfmts are just indirection entries - and it supports AT_EXECFD, so
> > let's just ignore the theoretical case of "maybe nobody exposes it".
>
> Would this potentially make the re-exec-yourself case easier to do at some
> point? (Which nommu needs to do, and /proc/self/exe isn't always available.)

AT_EXECFD may be an ELF thing, but normal ELF binaries don't do that
"we have a fd". So it only triggers for binfmt_misc (and only when the
flag is set for "I want the fd").

So no, this wouldn't help re-exec-yourself in general.

Although I guess we could add an ELF section note that does that whole
"executable fd" thing for other things too.

Everything is possible in theory..

               Linus
