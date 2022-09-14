Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD14ECAAD3
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Sep 2022 11:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiINLni (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Sep 2022 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiINLn0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Sep 2022 07:43:26 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68527C777
        for <linux-security-module@vger.kernel.org>; Wed, 14 Sep 2022 04:43:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-127f5411b9cso40154677fac.4
        for <linux-security-module@vger.kernel.org>; Wed, 14 Sep 2022 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sOxHaoTJOjG90MRKGtH8xvRMhqWLDRTQda56XXmNdy8=;
        b=y8pxtjJNRTqsadlORjvQJVCQTL15Da9B3B4XK2cnOSKgXSz4dvHCVGs9GWBK1g11Te
         zLb907AFMy6DLmzbSzLELy7Wg3pmtdZ24bdHRiibV8V55ANh8wSOLq9T/ODJi1/m9hMK
         QYvMxHoTNNqBdGxuKG7W8YFFjZ8+HO3noGv4eSis4ADs0tNc8xwpjIZt+hn5c4O4XpIw
         PSh3B1pv8FZF3YGjEL7R34B1aHnhg4pEfCqs+BlWE5ndjB0awYt2hN87gsXQnqQcWdU4
         tpqXvSygnCNYxLSoOk+fHVEwybuIuwmKi2XiUJ9x2ZEceXZD+splDVJev18DTbZo2xTr
         5glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sOxHaoTJOjG90MRKGtH8xvRMhqWLDRTQda56XXmNdy8=;
        b=tIRLNTaA+G3rxdlyrCYR0Hh6BwrxlAv7X9LMR3f3ffr7VYom3Ob6tsYHsCwm12JPVm
         7AFwk468X9ugjrCsr9gWl9EyXLtCVzBFta/vVVc9bkDc5WnF3yHQQrPMQXmcT0xsso3W
         1/pySIW9zXmhj/enXfT5ffikGlZW31Tgx3jXkBNAXGgf6mWa56J4m2bls76wXaqRoA9T
         2QnWne755+bx7j3DQBsSdexHuF4VFg9rnzLXvBhOqZm41unOqM9XLrnE7RB43Y9tF31b
         abZ5Q0Sl2BVNTD3hjS7XYYK6GkecwsszPHJAT6tMkj268PMUINeucxAfWaFvjq4Q/fmV
         jBBg==
X-Gm-Message-State: ACgBeo3twKGFHXcCoxi6xnCv8q0SK+1UfAhXOHqp6xu3l1B3f3CLydH4
        ovuOoICm/CWuKqbptz4m/YsEBaoAvdt2KUCNw9M4
X-Google-Smtp-Source: AA6agR7y4dqEBaNmcp8pcuElIApVSoE1q6orBTPvGb4kFLPeQXKUJsJtIm/kt/5+Jok6lir6cKMkAL7UHd1ZT43cDos=
X-Received: by 2002:a05:6870:178b:b0:12b:c621:b7a9 with SMTP id
 r11-20020a056870178b00b0012bc621b7a9mr2106429oae.41.1663155804184; Wed, 14
 Sep 2022 04:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220908220222.267255-1-nathanl@linux.ibm.com> <CAHC9VhSWmgRxH_5yVfg=ujni_qpWd33NkXS9wKa+1n4fNMtZwA@mail.gmail.com>
In-Reply-To: <CAHC9VhSWmgRxH_5yVfg=ujni_qpWd33NkXS9wKa+1n4fNMtZwA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 07:43:13 -0400
Message-ID: <CAHC9VhSq_PNPHZkTiPr0L7gz9R3QM14e_W6FnYr=Y3eozzVnWg@mail.gmail.com>
Subject: Re: [PATCH] lockdown: ratelimit denial messages
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 9, 2022 at 10:05 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 8, 2022 at 6:02 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
> >
> > User space can flood the log with lockdown denial messages:
> >
> > [  662.555584] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.563237] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.571134] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.578668] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.586021] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.593398] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> >
> > Ratelimiting these shouldn't meaningfully degrade the quality of the
> > information logged.
> >
> > Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> > ---
> >  security/lockdown/lockdown.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems reasonable.  While the last visible lockdown message to the
> console might be incorrect/old, I think it would give the user a good
> indication that lockdown is being hit and hopefully preserve the start
> of the denial storm.  It is also worth noting that this does introduce
> a spinlock to this code path, but since it is only an issue on error I
> doubt it will have any significant impact.
>
> I'll leave this until next week to give people a chance to
> comment/object, but if there are no further comments I'll plan on
> merging this into lsm/next.

Now merged into lsm/next, thanks!

-- 
paul-moore.com
