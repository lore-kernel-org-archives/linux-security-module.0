Return-Path: <SRS0=883h=YE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD6EECE58D
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Oct 2019 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672AF222BE
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Oct 2019 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570826795;
	bh=ykWXAll2XTEdbRIij34cgkoy34QiWjJs5wJDL67vMig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cdZvNLCa7+xhSWup7dkvj1SJqnevyj5KBnPokd1mY6aKhgq08ofTGqtJnDXZcsiBl
	 1fk9yvpZo1g75iV75PVai1IzFX+WLIecZ+zZlbKKXHzIyrMDVIgVJc2bBwo8BGZCzX
	 IZytKnW89Y1tPIc3LL3JbA9g6PHjw6+sjLVArEqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJKUqe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:46:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36217 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJKUqe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Oct 2019 16:46:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so11098360ljj.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNABcTciGmLPgzKCUlHZRBRsyOpw5zPeOkeqEXDcIFc=;
        b=hiusd5bTKbuf8Io1VHhHhrY3WPkC8HiE+LZAmpWF8M5eNj+z1KEhXR6703FdJnh6Fn
         mco4+ZkYzjQTqICNRn9LKyFFsCB9Owxm8mZcigV5i+SgI22JVStBEVyyBrw4SLHSEXt2
         n8BsJjHPsRARgvmaaSQ1mbnYPbUvUTven4vcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNABcTciGmLPgzKCUlHZRBRsyOpw5zPeOkeqEXDcIFc=;
        b=lZTc9mo9IhIjXaDPUpyJ2sjK5Co5T+yg/XHv2KePVrBG3H/T6Yggk9/lbdzsoWpfiY
         chHyqzftShies30v2EKKcFUHky8KwYjqgcbgD1dRl4VVzIfyvwG2h2foNE7r0qzUdXX9
         meRN6hSgjrDcTqEfaeDFcWSVvGVGme6aHY+DStjrY+1rKRMxLFBURqK/c6xROcam8xIc
         2OQY7Fi4supX+5Xw7PswCH8o93J4G9yi7R+GeR+/C+wY4AnZQeSNpTXGIfvNY7jO5ivJ
         rAY0RHvob4XjYQE0dfB8Iz9gD3IlDgsbNlPYIeryJCQ4QNkxxVZZedqpip6bWDtr3EPc
         QtGg==
X-Gm-Message-State: APjAAAUzjnimQrSltEYnQUpwUGqYwsGKIUKUxwdXRopEzwL9m+nYfVcr
        z1tkIjh5M394I+uXPDgebTf+sYrVtX0=
X-Google-Smtp-Source: APXvYqz5nZcGMXDQb/gyfIxisVvEez36wYuVCc75ioQ/eI5dRTteCsPSoKaeO7tM1dgcm3t+YQOCyQ==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr10401336ljc.224.1570826790094;
        Fri, 11 Oct 2019 13:46:30 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h3sm2155518lfc.26.2019.10.11.13.46.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n14so11056412ljj.10
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr10481233ljr.1.1570826788212;
 Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011162518.2f8c99ca@gandalf.local.home>
In-Reply-To: <20191011162518.2f8c99ca@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 13:46:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
Message-ID: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 11, 2019 at 1:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> OK, so I tried this approach, and there's a bit more than just a "few"
> extra cases that use tracing_open_generic().

Yeah, that's more than I would have expected.

That said, you also did what I consider a somewhat over-done conversion.

Just do

   static inline bool tracefs_lockdown_or_disabled(void)
   { return tracing_disabled || security_locked_down(LOCKDOWN_TRACEFS); }

and ignore the pointless return value (we know it's EPERM, and we
really don't care).

And then several of those conversions just turn into oneliner

-       if (tracing_disabled)
+       if (tracefs_lockdown_or_disabled())
                 return -ENODEV;

patches instead.

I'm also not sure why you bothered with a lot of the files that don't
currently even have that "tracing_disabled" logic at all. Yeah, they
show pre-existing tracing info, but even if you locked down _after_
starting some tracing, that's probably what you want. You just don't
want people to be able to add new trace events.

For example, maybe you want to have lockdown after you've booted, but
still show boot time traces?

I dunno. I feel like you re-did the original patch, and the original
patch was designed for "least line impact" rather than for anything
else.

I also suspect that if you *actually* do lockdown at early boot (which
is presumably one common case), then all you need is to do

    --- a/fs/tracefs/inode.c
    +++ b/fs/tracefs/inode.c
    @@ -418,6 +418,9 @@ struct dentry *tracefs_create_file(
        struct dentry *dentry;
        struct inode *inode;

    +   if (security_locked_down(LOCKDOWN_TRACEFS))
    +           return NULL;
    +
        if (!(mode & S_IFMT))
                mode |= S_IFREG;
        BUG_ON(!S_ISREG(mode));

and the "open-time check" is purely for "we did lockdown _after_ boot,
but then you might well want to be able to read the existing trace
information that you did before you locked down.

Again - I think trying to emulate exactly what that broken lockdown
patch did is not really what you should aim for.

That patch was not only buggy, it really wasn't about what people
really necessarily _want_, as about "we don't want to deal with
tracing, so here's a minimal patch that doesn't even work".

          Linus
