Return-Path: <SRS0=upjG=ZU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93412C432C0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Nov 2019 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7495721775
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Nov 2019 17:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1Rfe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:35:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfK1Rfd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Nov 2019 12:35:33 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iaNhU-00060J-2u
        for linux-security-module@vger.kernel.org; Thu, 28 Nov 2019 17:35:32 +0000
Received: by mail-il1-f197.google.com with SMTP id l63so22610344ili.17
        for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2019 09:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2cV6rw5OlnECFb4YEWUOQ5jV6J+4wJHZ7aPVBlSFkNI=;
        b=kdg/D3PVj6XsP+2e7cwEAyGC9rTU6sXoH+IGxUdH5Db9pD1kitQkQUpyK1WXKCxj3q
         hUs319VuxYOMTKLVS1y62ovm/VNdBwFfKP9SO+rkqpTJVfwlw1bUg7qz4DjPFTZn1aeT
         HBdgEhXyJ1/twL4ouDzYXgnl9/DfLshMHJxaiHLw8E+NNY564kwsPrRyALM4yiUu7Jgx
         znqZ/9Xtm5voigW/ro4Or1lVenAupsGyqoYtCVnEptO5K+/SI/OKtXZe/Z6mjVcE7dSj
         KGB69GdZ7TgoDvvxk5xzxP9nMA3XIFNo7KfbYwZes/Hb2Y4zNfN8Ht0+5yiqC6GGGP7f
         WM9Q==
X-Gm-Message-State: APjAAAWfU3lTSA7A2rjP6lhqgNcl2ke02xBmehl0OfeyNhWVU4XikOz1
        kKpFUlhWrFZIQUqL4dSm6xcoiBtU836tfFDCc1A6zB1QPHBG6UJKqoGQXwV/UTXiL8YvmN5IRtx
        w4HtAIeKyir4YA140mHeYjbfZrS9haUm5mIQQzwgVv68GwEREpRycvA==
X-Received: by 2002:a92:244d:: with SMTP id k74mr12668737ilk.155.1574962531081;
        Thu, 28 Nov 2019 09:35:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/azn/ZuTdrvaOB5i8j3uW2Vn9m1WYw92Yim0EREBABAnX1fgYL84d/VEnX4eJhocbd4w1Gw==
X-Received: by 2002:a92:244d:: with SMTP id k74mr12668707ilk.155.1574962530832;
        Thu, 28 Nov 2019 09:35:30 -0800 (PST)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id t3sm2922256ilf.53.2019.11.28.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 09:35:30 -0800 (PST)
Date:   Thu, 28 Nov 2019 10:35:29 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracefs splats in lockdown=confidentiality mode
Message-ID: <20191128173529.GA1082355@xps13.dannf>
References: <20191101210803.GA9841@xps13.dannf>
 <20191101181501.4beff81b@grimm.local.home>
 <2vtDIdkutRsBBbaiswjFZlGeQPSlDHF3et5ZxQ4YJ4zArOKo7-53A6d8SwpUtt7NCYdQEmmkeTADvrS7NCzw0Stw33n44vJC_qspqXgRPZQ=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vtDIdkutRsBBbaiswjFZlGeQPSlDHF3et5ZxQ4YJ4zArOKo7-53A6d8SwpUtt7NCYdQEmmkeTADvrS7NCzw0Stw33n44vJC_qspqXgRPZQ=@protonmail.ch>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 28, 2019 at 03:31:31PM +0000, Jordan Glover wrote:
> On Friday, November 1, 2019 10:15 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 1 Nov 2019 15:08:03 -0600
> > dann frazier dann.frazier@canonical.com wrote:
> >
> > > hey,
> > > fyi, I'm seeing a bunch of errors from tracefs when booting 5.4-rc5 in
> > > lockdown=confidentiality mode:
> > > [ 1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> > > [ 1.772332] Could not create tracefs 'available_events' entry
> > > [ 1.778633] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> > > [ 1.787095] Could not create tracefs 'set_event' entry
> > > [ 1.792412] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> > > (...)
> > > [ 2.899481] Could not create tracefs 'set_graph_notrace' entry
> > > [ 2.905671] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> > > [ 2.913934] ------------[ cut here ]------------
> > > [ 2.918435] Could not register function stat for cpu 0
> > > [ 2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc
> > > [ 2.933939] Modules linked in:
> > > [ 2.937290] CPU: 1 PID: 1 Comm:
> >
> > Looks to me that it's working as designed ;-)
> >
> > I'm guessing we could quiet these warnings for boot up though. :-/
> >
> > But there should be at least one message that states that the tracefs
> > files are not being created due to lockdown.
> >
> > -- Steve
> 
> Could you clarify what functionality is lost here and if it affects
> system stability?

None that I'm aware of.

> I agree that triggering WARNING on every boot with supported kernel
> configuration isn't optimal experience for users.

Yes, that's my concern.

 -dann
