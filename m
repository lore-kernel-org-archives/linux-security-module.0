Return-Path: <SRS0=cuGm=PQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD90EC43387
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 01:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9122070B
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 01:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ed5Qgup3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAHB3h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:29:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44176 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfAHB3h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jan 2019 20:29:37 -0500
Received: by mail-vs1-f66.google.com with SMTP id z23so1479557vsj.11
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jan 2019 17:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTdBtTEZCH/4iLJe/wIuUIn2iqxr4uAZKAK+z38oRWo=;
        b=ed5Qgup3bl3nLcXUfRsdaHxDIHgv0UGGfg13G694FdL30YmQZTKYrWx1Mxcpo0P7Nj
         rgF6F8IR0SRhpRCy7RIciGWGpNb74NNdQ5dvKg7E0ncvussiYxVlZazzYN9kx0wUWTK3
         qfDC6G91dqkfO630DzyjXfDSllYU4GhBEsJPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTdBtTEZCH/4iLJe/wIuUIn2iqxr4uAZKAK+z38oRWo=;
        b=TWF28JnBB9LRgun4l6kTlHsbqf08sp2fRFphzjXsxA5UeIJM/Y14vLRcmw3uUEOEBL
         OXlfi66ccr3FNJYdTRpTCHJ+NMjkpiwdurtUaMnuU0U0FPMjFFxGp2tIL3rIdUIOHv9H
         BFa1+HinSNO/nvLLWbAuKOALnRglcdQv0HZnBCfq5ZsvbZL/SXA1LPnqqpkgpdm/n0p8
         5s567P0yny4MeSIMcmE+b9bPQDRzNr2BteyL+F3/U/MFFlMG/XSN7VQyT3JIZ7SoL4ph
         0ZKpiVfxqZ1t0RRzswBu5DakV++P5V3YJ+GBlHbRafTbI4w2XTCM7HGIbm+TVYX8Wxmp
         kjGQ==
X-Gm-Message-State: AA+aEWbkVScfEDeL2INq3qruOaX9uWBB5ObsGId9eTuPWXC04KmWx7IC
        8MoT1w262CA7PsttvR1eAJHB9dEFbeQ=
X-Google-Smtp-Source: AFSGD/UQW0p1a7NTRlas1HPsBxMSy3znqECJdeb/HjfunZQ5MRnzJwwrsA9uZGqa+4hZQkCKLVuDSw==
X-Received: by 2002:a67:3144:: with SMTP id x65mr26675497vsx.186.1546910975875;
        Mon, 07 Jan 2019 17:29:35 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id k200sm22978566vke.9.2019.01.07.17.29.34
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:29:34 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id h78so1496552vsi.6
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jan 2019 17:29:34 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr24442833vss.172.1546910974212;
 Mon, 07 Jan 2019 17:29:34 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
 <alpine.LRH.2.21.1812120556040.11653@namei.org> <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
In-Reply-To: <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 17:29:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
Message-ID: <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
> >
> > On Tue, 4 Dec 2018, Kees Cook wrote:
> >
> > > On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > v5: Include Kees Cook's rework of the lsm command
> > > >     line interface. Stacking is not conditional.
> > >
> > > Can you resend this series with corrected "From:" lines in the body, etc?
> > >
> > > Beyond that, I obviously like it. James, what's needed for this to move forward?
> >
> > If there are no outstanding issues, I plan to merge this for 4.21.
>
> Yeah, it looks good to me. (Excepting getting the authorship sorted.)

I didn't see this actually get merged? Was there something that needed
fixing? Should I send you a direct pull request for v5.1?

-- 
Kees Cook
