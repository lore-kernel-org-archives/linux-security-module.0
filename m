Return-Path: <SRS0=883h=YE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B97ECE58D
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Oct 2019 21:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D0C2084C
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Oct 2019 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570827673;
	bh=knd0f8yCPR6Ky+R1X+NQQa8VVFtwb+8x5S62C5Kz22U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oVTdkbuDjSy4Ze8CVEiY/qQjG98B4CqMORj95LOxWrgroqOKbTX4I+RICKKjWeAlA
	 uXa6IOOXUH4djacKEyOSkL46pY5GO8oR1QYh0PZQzvC937C/6Cu8ct9CjUUHDVj9NB
	 qhSgHCDxOWgVfRR6H4s+BsSAQ8NJ7jqhXzQkrdCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfJKVBM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:01:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32999 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfJKVBM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Oct 2019 17:01:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so11147145ljd.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKr4WHC3iR8iedd+96HoEDT1mA0iwz01QLINNBDqvTA=;
        b=AjD32CNEE5D2mrL1SxTGTAcIg8rDu5TsWXuC3JWTpw/d7RSutnwDdzYzC2ZDXXNEQs
         xbRUdI2G9Bdey7J+lF7C19PmyyR/h7paQAvoZ3B7DeLBGHQM7JosujRghPkyJaObtcaK
         WflPEvqjO32pHzc6ziczhzVrcfZHPdGY8qVxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKr4WHC3iR8iedd+96HoEDT1mA0iwz01QLINNBDqvTA=;
        b=mRWyui2J2TiBxt+aRSKiCgQpmBaJABm41Hk13/9C1O8Rch2y9GzrAUxhDmlXFU4Bk7
         Pa9dQrTcs0KldrCoKKGHKbThH5vvQrbYgEyay3TwKmYs76yciVlbGMhzxGAVvXbAhcuc
         MwL/KU/AcmTHj5GOgBV45QRzNNFYzOHfELAqXGN6jSMhjT19N2+eT8n4Ir7IhmNe5Hng
         9oGkLbHGyuLT9sI9DmHQU3Gw456kx7OMiuNW/diHKojEEdW+7moC6gGAYqN+mFpGETsC
         amAvaBdSrJ6zWpprzPzMvmBRf08Vc7yesapv6murDAd8ieXvnVW2SWIXJzpQOkPTL75t
         Zqjw==
X-Gm-Message-State: APjAAAUo0f84yQ9sHgJoPD/3SNLskeYpSkRXj4us3iqsqs4+MVilLbxP
        MDTjh4QYs+lbMEqYdWA2Z+fiVQnnyfM=
X-Google-Smtp-Source: APXvYqwLz6ONJspwgb1XUDp3tK8zjo+ba4gptDTGYacB6cn9AY1yRUTj7j4Kn8RiB2YveMi5MkWklg==
X-Received: by 2002:a2e:9bcb:: with SMTP id w11mr10091867ljj.11.1570827668425;
        Fri, 11 Oct 2019 14:01:08 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q14sm2180161ljc.7.2019.10.11.14.01.07
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 14:01:07 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r22so7979076lfm.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 14:01:07 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr9785397lfi.29.1570827666846;
 Fri, 11 Oct 2019 14:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011162518.2f8c99ca@gandalf.local.home> <20191011165455.32666d53@gandalf.local.home>
In-Reply-To: <20191011165455.32666d53@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 14:00:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
Message-ID: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 1:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I guess I can keep it this way. Thoughts?

That looks fine to me. I'm still not sure you actually need to do all
this, but it doesn't look _wrong_.

That said, I still do think that if things are locked down from the
very get-go, tracefs_create_file() shouldn't even create the files.

That's mostly an independent thing from the "what about if they exists
and things got locked down afterwards", though.

I do wonder about the whole "well, if you started tracing before
locking things down, don't you want to see the end results"?

             Linus
