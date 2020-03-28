Return-Path: <SRS0=+cyb=5N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C408C2D0ED
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Mar 2020 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D0B20732
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Mar 2020 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alfNoYU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgC1Vx4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:53:56 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39939 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgC1Vxx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 17:53:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so5479915pjb.5
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ovk2bmmHiHq0822krEgDFQkSPYt5Bktnb17JLm/lkJA=;
        b=alfNoYU8g+4LyDehhJH9iGwAtea55N/Xy8WHF5I5hMwcVa8EuZTEWAbZ7eeEAtCAjD
         1YoFtSlC3h2vBfbE0MPFBAhCW1HFfaZquUMB005WQh05V1HgCf9MnCioH/P0sUd516+4
         DI0bMW4XCbsmAoMIv05h5N0yfwlGhX5+NtqUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovk2bmmHiHq0822krEgDFQkSPYt5Bktnb17JLm/lkJA=;
        b=hax57WZmroAXHJHsMt/yHIShwpwpGZWBwDk5a7kLoNL4/zyGn6PQMAboUKemekbZ68
         7/dmuVp7miIc6C2C7HTy1klWh8HYQYZP/OxIlGAq7n8dkWRXTDGh7rKG6fDfTZoyeT+3
         F97J62aIKF4WBB1cm6bHVFPw19peSDrmntsk1Iu5oqD7SCFN4+6JzOX46Bn95tnGWsWP
         c8EK9Rnb63eSZIrGL4ANXfXclpWKMqFTctRFS1ZVVB+63E/UqfLTaE2k5M6E6jgAGPvI
         3PZ6K6lDwuwB641Z9hHxnmneec+3t3BlMR9tMG6P9gih37XwK4ht5Hz3Hdu9woCgSeWw
         GU0A==
X-Gm-Message-State: ANhLgQ1veJH4R5eD4shy/kvzSfukNvY+mE4YdQO1D8eqW/eySzLauA4p
        J5crVfqH1+TNdV+s2ovlmjotxw==
X-Google-Smtp-Source: ADFU+vsfxLWSgTsJUgK14r0bXgUXWbEfwzw64SCYCXUXpSNDoac/nQTFCQ7zeikniIjgJ9mfpfaHkA==
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr7121093pjb.41.1585432431548;
        Sat, 28 Mar 2020 14:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hg20sm6550839pjb.3.2020.03.28.14.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:53:50 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:53:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 7/9] proc: move hidepid values to uapi as they are
 user interface to mount
Message-ID: <202003281453.CED94974@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
 <202003281340.B73225DCC9@keescook>
 <20200328212547.xxiqxqhxzwp6w5n5@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328212547.xxiqxqhxzwp6w5n5@comp-core-i7-2640m-0182e6>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Mar 28, 2020 at 10:25:47PM +0100, Alexey Gladkov wrote:
> On Sat, Mar 28, 2020 at 01:41:02PM -0700, Kees Cook wrote:
>  > diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
> > > new file mode 100644
> > > index 000000000000..dc6d717aa6ec
> > > --- /dev/null
> > > +++ b/include/uapi/linux/proc_fs.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#ifndef _UAPI_PROC_FS_H
> > > +#define _UAPI_PROC_FS_H
> > > +
> > > +/* definitions for hide_pid field */
> > > +enum {
> > > +	HIDEPID_OFF            = 0,
> > > +	HIDEPID_NO_ACCESS      = 1,
> > > +	HIDEPID_INVISIBLE      = 2,
> > > +	HIDEPID_NOT_PTRACEABLE = 4,
> > > +};
> > > +
> > > +#endif
> > > -- 
> > > 2.25.2
> > > 
> > 
> > Should the numeric values still be UAPI if there is string parsing now?
> 
> I think yes, because these are still valid hidepid= values.

But if we don't expose the values, we can do whatever we like with
future numbers (e.g. the "is this a value or a bit field?" question).

-- 
Kees Cook
