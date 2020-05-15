Return-Path: <SRS0=nEb1=65=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D6AC433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 15 May 2020 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96145205CB
	for <linux-security-module@archiver.kernel.org>; Fri, 15 May 2020 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKBBB6TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgEOIBg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 May 2020 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbgEOIBf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 May 2020 04:01:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1AC05BD0B
        for <linux-security-module@vger.kernel.org>; Fri, 15 May 2020 01:01:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so604751pfx.7
        for <linux-security-module@vger.kernel.org>; Fri, 15 May 2020 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ur+hb+yciYy1xQ68pS5XyzW31c915My4tqJ2beLm4bQ=;
        b=lKBBB6TBcN0o1HU4UgdMxAG6vhpa1qK6VNim7Q3I07ra18sLY43itwc35OZNGOPACS
         ymYWlFxO9PvwCf0zrIQ1pxa6GzHHGDHo1jgwyp6aBR8wZKa0Hx5uKMGpHEAZGyjeZ8iK
         mxsL/SfdN7bkAODR1xFfclPFJE9UsG7Mt5GjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ur+hb+yciYy1xQ68pS5XyzW31c915My4tqJ2beLm4bQ=;
        b=qnStmdmj25yjE3L+A4OVPHcYU3IfFk12KgQES8rD7+FbB/wua7rafBETk2v4S7HuiC
         sqJe5MeUm2PR3xK/UNMwOZtCpd+A/HvtqD7JuJ/c8EcFQqvOtA4zkjqWNtPYJQBQe2Zr
         JnkBwOIBd7qWHa4jbzc3PRNMOKpeYGjSVaknaXU9//D6FaT0ORp8Tb1P06HDU9gSViyN
         Fjm2iOqkFZIJquL1dRSKmLP0mvU7W4rRueY49MwadoGmXy2lS4NluLco1qCM5N5nteK/
         udrTze1Zdqlz7j5By33oMU7ci93W5wvDNzayMzf42Uy5qT/PiwMrrrMxw5qnLy3oNINx
         mrMw==
X-Gm-Message-State: AOAM531RZvdyhf6wzLL4Ezrdi50m/rQ1zIvpMc+vRVftruTF9RUGzWMa
        g6jrIqgZm8NHZbJC3gJbJSyeWg==
X-Google-Smtp-Source: ABdhPJyd7lafomptCZ7ujKP5O758shT8BUso0xPAsVuMxJDi6WBMT/SqJQvpseht52t2m4Hfz/w/2Q==
X-Received: by 2002:a63:f958:: with SMTP id q24mr1977355pgk.338.1589529694841;
        Fri, 15 May 2020 01:01:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7sm1178366pgs.35.2020.05.15.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:01:33 -0700 (PDT)
Date:   Fri, 15 May 2020 01:01:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to enforce
 noexec mounts or file exec through O_MAYEXEC)
Message-ID: <202005142343.D580850@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook>
 <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 14, 2020 at 09:16:13PM +0200, Mickaël Salaün wrote:
> On 14/05/2020 18:10, Stephen Smalley wrote:
> > On Thu, May 14, 2020 at 11:45 AM Kees Cook <keescook@chromium.org> wrote:
> >> So, it looks like adding FMODE_EXEC into f_flags in do_open() is needed in
> >> addition to injecting MAY_EXEC into acc_mode in do_open()? Hmmm
> > 
> > Just do both in build_open_flags() and be done with it? Looks like he
> > was already setting FMODE_EXEC in patch 1 so we just need to teach
> > AppArmor/TOMOYO to check for it and perform file execute checking in
> > that case if !current->in_execve?
> 
> I can postpone the file permission check for another series to make this
> one simpler (i.e. mount noexec only). Because it depends on the sysctl
> setting, it is OK to add this check later, if needed. In the meantime,
> AppArmor and Tomoyo could be getting ready for this.

So, after playing around with this series, investigating Stephen's
comments, digging through the existing FMODE_EXEC uses, and spending a
bit more time thinking about Lev and Aleksa's dislike of the sysctls, I've
got a much more radically simplified solution that I think could work.

Maybe I've missed some earlier discussion that ruled this out, but I
couldn't find it: let's just add O_EXEC and be done with it. It actually
makes the execve() path more like openat2() and is much cleaner after
a little refactoring. Here are the results, though I haven't emailed it
yet since I still want to do some more testing:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1

I look forward to flames! ;)

-- 
Kees Cook
