Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2EDC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 17 May 2022 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbiEQT2M (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 17 May 2022 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352687AbiEQT2L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 May 2022 15:28:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F1E5046F
        for <linux-security-module@vger.kernel.org>; Tue, 17 May 2022 12:28:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ds11so6729609pjb.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 May 2022 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sRnxrATUFurY+xdKnn0z6Pv7TbtVcM0Bq4eah/DEREU=;
        b=JcsUddQn7mwi3Hs9+4T2lmrTBhkTURZOl+VlTxQkmcpmYim4U4ziDUuR9aUZ9PLDNq
         aZ9CRydRn53CuQ+S0m2vFy3wZqugRK7eiBqw+07aK3Gx5fgT3z3c5mHlKv5NqFnuVqsh
         CBwQT0NomHnxqzS3NbUSHfeVmZhTTWwqod3jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sRnxrATUFurY+xdKnn0z6Pv7TbtVcM0Bq4eah/DEREU=;
        b=ZEgwFu8hPIcHkVW1MkOBnUBIES3kZk/pUY/RszBd2nc+swCjFz+XlNJGBa+Ji5o4Ts
         B4bRj2U0G+vfTNw2Oc939zMhuu5nq625JbVXK8y02QV2GQ8b75tdJLvxs7lgF76sBZ1n
         RhN+abxZepDN61+WS0y+hOxpyS9NTq9LCY95VrFvtTtxbJPlqoxPb/YzJ+VYgukomJOX
         G04oUNiuhcnL6SJMtaDHIsagd5/MM0wxaTUg7B4hjatLO0E21QssFkovf0GW8NjhWTGY
         8EsvZWidu1pJNjGEKTH7cphUadC7iTHZvckgy4zAfSypfeJcWDeUpZdmtSgKVsgzJGTG
         cZpg==
X-Gm-Message-State: AOAM530M05uzFf7/3m5CImtVwqPEqHCYSCyNnfGCvexS6LCJH/9LoWIL
        kE+B28BLdBqoeNG95MshAosM7g==
X-Google-Smtp-Source: ABdhPJzb6NxCGOhL9QfuLNbvRAfqqVCHjnAogoMxMJEoG6YKx2Kx62sZPGUOs+pIjzwhzNyg+KiRSQ==
X-Received: by 2002:a17:90a:9914:b0:1db:d10f:1fcf with SMTP id b20-20020a17090a991400b001dbd10f1fcfmr37464999pjp.241.1652815689928;
        Tue, 17 May 2022 12:28:09 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:641e:de1c:873b:321e])
        by smtp.gmail.com with UTF8SMTPSA id k1-20020a170902694100b0015e8d4eb2bcsm9412366plt.262.2022.05.17.12.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 12:28:09 -0700 (PDT)
Date:   Tue, 17 May 2022 12:28:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YoP3SJ62uHI7nrXy@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
 <B7FB2BE6-DF1C-414A-B4C2-0C15FD1CBF75@chromium.org>
 <YoKVSEJyHvFg/V9+@google.com>
 <202205162038.B2D1BBAB3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202205162038.B2D1BBAB3@keescook>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 16, 2022 at 08:44:37PM -0700, Kees Cook wrote:
> On Mon, May 16, 2022 at 11:17:44AM -0700, Matthias Kaehlcke wrote:
> > On Fri, May 13, 2022 at 03:36:26PM -0700, Kees Cook wrote:
> > > 
> > > 
> > > On May 4, 2022 12:54:18 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >Extend LoadPin to allow loading of kernel files from trusted dm-verity [1]
> > > >devices.
> > > >
> > > >This change adds the concept of trusted verity devices to LoadPin. LoadPin
> > > >maintains a list of root digests of verity devices it considers trusted.
> > > >Userspace can populate this list through an ioctl on the new LoadPin
> > > >securityfs entry 'dm-verity'. The ioctl receives a file descriptor of
> > > >a file with verity digests as parameter. Verity reads the digests from
> > > >this file after confirming that the file is located on the pinned root.
> > > >The list of trusted digests can only be set up once, which is typically
> > > >done at boot time.
> > > >
> > > >When a kernel file is read LoadPin first checks (as usual) whether the file
> > > >is located on the pinned root, if so the file can be loaded. Otherwise, if
> > > >the verity extension is enabled, LoadPin determines whether the file is
> > > >located on a verity backed device and whether the root digest of that
> > > 
> > > I think this should be "... on an already trusted device ..."
> > 
> > It's not entirely clear which part you want me to substitute. 'an already
> > trusted device' makes me wonder whether you are thinking about reading the
> > list of digests, and not the general case of reading a kernel file, which
> > this paragraph intends to describe.
> 
> Sorry, I think I confused myself while reading what you'd written. I
> think it's fine as is. I think I had skipped around in my mind thinking
> about the trusted verity hashes file coming from the pinned root, but
> you basically already said that. :) Nevermind!
> 
> > > >+static int read_trusted_verity_root_digests(unsigned int fd)
> > > >+{
> > > >+	struct fd f;
> > > >+	void *data;
> > > 
> > > Probably easier if this is u8 *?
> > 
> > Maybe slightly, it would then require a cast when passing it to
> > kernel_read_file()
> 
> Oh, good point. That is a kinda weird API.
> 
> > 
> > > >+	int rc;
> > > >+	char *p, *d;
> > > >+
> > > >+	/* The list of trusted root digests can only be set up once */
> > > >+	if (!list_empty(&trusted_verity_root_digests))
> > > >+		return -EPERM;
> > > >+
> > > >+	f = fdget(fd);
> > > >+	if (!f.file)
> > > >+		return -EINVAL;
> > > >+
> > > >+	data = kzalloc(SZ_4K, GFP_KERNEL);
> > > >+	if (!data) {
> > > >+		rc = -ENOMEM;
> > > >+		goto err;
> > > >+	}
> > > >+
> > > >+	rc = kernel_read_file(f.file, 0, &data, SZ_4K - 1, NULL, READING_POLICY);
> > > >+	if (rc < 0)
> > > >+		goto err;
> 
> So maybe, here, you could do:
> 
> 	p = data;
> 	p[rc] '\0';
> 	p = strim(p);
> 
> etc... (the void * -> char * cast in the assignment should be accepted
> without warning?)

Yes, that would work, I'll change it accordingly, thanks!

> > > >+
> > > >+	((char *)data)[rc] = '\0';
> > > >+
> > > >+	p = strim(data);
> > > >+	while ((d = strsep(&p, ",")) != NULL) {
> > > 
> > > Maybe be flexible and add newline as a separator too?
> > 
> > Sure, I can add that. I'd also be fine with just allowing a newline as
> > separator, which seems a reasonable format for a sysfs file.
> 
> Yeah, that was my thinking too. And easier to parse for command line
> tools, etc. Not a requirement at all, but might make testing easier,
> etc.

Ok, I'll change it to use newline as the only separator.
