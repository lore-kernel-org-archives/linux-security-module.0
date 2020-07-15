Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CBC433E4
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2130320658
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPq8RT5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOPJN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgGOPJN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jul 2020 11:09:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F571C08C5DD
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2020 08:09:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so3191995pgm.11
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2020 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fybQni4P+/tPCeHBDEDCYYjDWdheeG5LlXlJ09TDVKE=;
        b=cPq8RT5nNYj9fhy76nHm9PB3+73ArhJb3kArGg4eBmKJVu4C6hP7+2k48MdzzIPVyt
         zg81i3TE2aG4nTFMgkVcwWFfu2WEWsydSlPQkWSOhr6OqN60cfdLcUhQeU9eglxEfgGA
         Deb3MqATlGhpL9T+cygNyeoXoBBJ1VnHqxk2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fybQni4P+/tPCeHBDEDCYYjDWdheeG5LlXlJ09TDVKE=;
        b=Ti7aXJCuapEWnKvg/qIpglSjWz0WovbDAAOjCppQA+6ze6LKDVNAgaNacXPcvhfHHm
         CO4IP1uFuRxXsD+CfDPm2nTA0K5Ii1fkYb1sDryrveIwfbysJWpaRfATVB61ZWQxPZ81
         O7EZHVuucUcxG69sXsPlfIyNOlHSuqtn9Wik8SSrsOCFGwhNAeqNhZuAw6rN08AilRHp
         VnCKDwO+Wh9k61GcGA/jUMUoc0Cwhw/T1ITboNiLyNIENNbcEo920dL8eMUTZ43YUSZX
         FzeTAh0thvW70YwIzMMZOk1NZINbo0U7tKgXbI8IHN8woJs0msCFqIbtQXwWC/M+KoaL
         t7aw==
X-Gm-Message-State: AOAM531ZNLIILEvtKgogxFgHg4Ll3aIbE1hPyywoxH9/26QtCkLFgBxT
        J8iv2XAMgQlxxGtId2uMhZ16ug==
X-Google-Smtp-Source: ABdhPJyDv+gR301L1/l3fOIRrWF6W77CkdXx9PR9MUdMZexizgTDHor2MnSy/OKJHHuw6nto+bdqYA==
X-Received: by 2002:a63:3151:: with SMTP id x78mr167358pgx.210.1594825752569;
        Wed, 15 Jul 2020 08:09:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10sm13262pjf.3.2020.07.15.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:09:11 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:09:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <202007150801.27B6690@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
 <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
 <d6d204c4427b49f6b24ac24bf1082fa4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d204c4427b49f6b24ac24bf1082fa4@AcuMS.aculab.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 15, 2020 at 02:55:50PM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 15 July 2020 07:43
> > Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
> > 
> > On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> > > On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > > > +static int count_strings_kernel(const char *const *argv)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	if (!argv)
> > > > +		return 0;
> > > > +
> > > > +	for (i = 0; argv[i]; ++i) {
> > > > +		if (i >= MAX_ARG_STRINGS)
> > > > +			return -E2BIG;
> > > > +		if (fatal_signal_pending(current))
> > > > +			return -ERESTARTNOHAND;
> > > > +		cond_resched();
> > > > +	}
> > > > +	return i;
> > > > +}
> > >
> > > I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> > > refactor that too? (And maybe rename it to count_strings_user()?)
> 
> Thinks....
> If you setup env[] and argv[] on the new user stack early in exec processing
> then you may not need any limits at all - except the size of the user stack.
> Even the get_user() loop will hit an invalid address before the counter
> wraps (provided it is unsigned long).

*grumpy noises* Yes, but not in practice (if I'm understanding what you
mean). The expectations of a number of execution environments can be
really odd-ball. I've tried to collect the notes from over the years in
prepare_arg_pages()'s comments, and it mostly boils down to "there has
to be enough room for the exec to start" otherwise the exec ends up in a
hard-to-debug failure state (i.e. past the "point of no return", where you
get no useful information about the cause of the SEGV). So the point has
been to move as many of the setup checks as early as possible and report
about them if they fail. The argv processing is already very early, but
it needs to do the limit checks otherwise it'll just break after the exec
is underway and the process will just SEGV. (And ... some environments
will attempt to dynamically check the size of the argv space by growing
until it sees E2BIG, so we can't just remove it and let those hit SEGV.)

-- 
Kees Cook
