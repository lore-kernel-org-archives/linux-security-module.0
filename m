Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCEFC433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Nov 2022 13:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiKRNof (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiKRNoe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Nov 2022 08:44:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FBFCD9
        for <linux-security-module@vger.kernel.org>; Fri, 18 Nov 2022 05:44:33 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 136so5061039pga.1
        for <linux-security-module@vger.kernel.org>; Fri, 18 Nov 2022 05:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/kW/LvsRCoudJw36ESMmqSNR0Az8yW0/a/nizc4ptw=;
        b=JDT7hG7hCSGOXGQfHzp0tVmWhUqRqIrDsZ1/D/HWJyOelXHgcjjm8AQXsUwO4RMQvj
         l7AVYmwK0gDC33+491Z3LzS6MouXoTY5WMX47bzzv3/CYrpF1zyQDpr57XeIM5E7VL3O
         0bR3CEkCBzg4AFajY4dnahnEQ8wxwS5ibjOV9HLJ8zk9p74cEc/Xxt6ESOCJyom8V9R1
         bkWfKPpDMv9vt8efVYAy0Rgx6iIw743XKAzLkdoss+m4c6eSKTBow1DkcQ/Irf5SBBhb
         Ue+4Anj3Qh6cpv7pQHSvEBQARPlhdZjmL6D5xkLFSzknZb8cSxXes/B90Y3So6l0k7I0
         fC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/kW/LvsRCoudJw36ESMmqSNR0Az8yW0/a/nizc4ptw=;
        b=NCX7r3nT0icsrx9CyN9W2Lllbmb0cikl+Vt5mo4ofcZAcaU8aWu3MDPDSUY6es74e2
         XKcGdjEducpDW6hRffWMXW6vbew9We1HGvwUxDec+k8fmZ85ZngkL5ZTlbrNnV+U0qSO
         zG977qgNULXjwpPt81J0l2a6khSxqnasLlzS4cTIU+IDhH+M7hpJYJefX3cFE90OdkuJ
         ppQqtuD0+YJtiIpW1QgV3/1d2/OZ1Nh8KrIB95nl6D5rWBwTHwxLYk/C1d6QY830isG/
         8f2FVspAZRDwuduA9B2ojb1YhNlUPOXQpapvU0om0hLcOaC0vDWcE08kACNMq4lwFTSr
         qQWA==
X-Gm-Message-State: ANoB5pnTNflJDsbmzR5GL4KxgokU41uliF69Us+w9RKrQxDCsxqidi2+
        SJXOPU36kv7IdqFoyp7t4CVgezQ88Om+w2NER2LhXRlsDg==
X-Google-Smtp-Source: AA0mqf4N+tHMLkErc2xL6guhYyiJeJOUM8ZL6UfvJzUAiqq6Ex3AcjtStFVaYD2ZfCzxcvQokZDNo7R83rkgjTu4jeY=
X-Received: by 2002:a63:1f63:0:b0:460:ec46:3645 with SMTP id
 q35-20020a631f63000000b00460ec463645mr6857164pgm.92.1668779072496; Fri, 18
 Nov 2022 05:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20221110043614.802364-1-paul@paul-moore.com> <20221118015414.GA19423@mail.hallyn.com>
In-Reply-To: <20221118015414.GA19423@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Nov 2022 08:44:21 -0500
Message-ID: <CAHC9VhSNGSpdYWf_6if+Q+8BZvR-zYYxBMmoYhRNH9rWpn7=AA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 17, 2022 at 8:54 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Wed, Nov 09, 2022 at 11:36:14PM -0500, Paul Moore wrote:
> > The vfs_getxattr_alloc() function currently returns a ssize_t value
> > despite the fact that it only uses int values internally for return
> > values.  Fix this by converting vfs_getxattr_alloc() to return an
> > int type and adjust the callers as necessary.  As part of these
> > caller modifications, some of the callers are fixed to properly free
> > the xattr value buffer on both success and failure to ensure that
> > memory is not leaked in the failure case.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> Do I understand right that the change to process_measurement()
> will avoid an unnecessary call to krealloc() if the xattr has
> not changed size between the two calls to ima_read_xattr()?
> If something more than that is going on there, it might be
> worth pointing out in the commit message.

Yes, that was the intent, trying to avoid extra calls to krealloc().

Mimi, have you had a chance to look at this patch yet?  In addition to
cleaning up the vfs_getxattr_alloc() function it resolves some issues
with IMA (memory leaks), but as you're the IMA expert I really need
your review on this ...

-- 
paul-moore.com
