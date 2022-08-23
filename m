Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CE5C32789
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Aug 2022 18:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiHWS2Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiHWS1g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Aug 2022 14:27:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F18923E9
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 09:48:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o204so9207840oia.12
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SaVACCZwH8xQotDN92IFUrhdTD0EHmA54lklXB94n+E=;
        b=1Ok/wOesKzu5P/GWM9TLt92fPx47XR2jb6Bs1/YwT6s+aE3yjQT8rK6fg3W4gaMZHY
         mQo3ryfYq8vuTjmZQdmtbQFq/ztnDvKE2xVNpd1/ySE9vpgsf1lnEY4KGhMlMSPhRJOJ
         bsyrvWXn/fvwz/FlSXYczk5JGhN5CyCqvnNKzhX1UajRcoKEjeA6nBMngjWuNoZtqMwf
         pdHj0fbraSiaUe603p8b0m6b6TcOb+Jb+YN7pCuBwaR1frNMrBQDlHEQFhyGqw1QnLNu
         VybTy0xxYsUD4eZ5h7uJMlN0EtP7nJ51xAsCHwyt9gQRPFURU9QW0Wm/l8SaS1N1LmZa
         KBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SaVACCZwH8xQotDN92IFUrhdTD0EHmA54lklXB94n+E=;
        b=T3rpeeK6obFNuMdIVqj7Vy7VAEfI277n9cBkyqSW+6w6FLEzKbohg1KQ57ho2dKAt1
         m+lAnuT7x11Vop6ywKKrTPii3xFaE9KBGbm6tSo5azuSjq/iEJo34zW/wN5y5jXkfzY6
         ryB42tyWcngmhTdJPHxLcj9wiarn1vGSCgyOrMoUUsPWI2buTntMU1XPkunkthbtfVtA
         gcAYmnC0A1awQBcC3G4gl07mkUrIkEyguG0Htv3Niz1YPxW2ObB8MrLUzAoOZvHhGbVx
         weyYGz1P4fHaQcmapx0gX0KgnGiz5kkc+frJNRnRpeucSdGPczt6RHW5EiYDwadYAgOk
         BMRw==
X-Gm-Message-State: ACgBeo028sfDOaA/HzV3P+3tYWkQHlIAdcffz3j2iKYD4y7rtgIMOWfm
        Zr+ovKLawpRAv8XnO/a+EnjxDWcEH7C1nCR4kAs6
X-Google-Smtp-Source: AA6agR5r+WBH3Du54udJhIAVwDMynlMf9eKtVs3NIk9gYWmdmJqIMsAFjS7fy70yrHHRQNjEDLIJRAmJIyXSoSfZ5wA=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr1691234oif.136.1661273321128; Tue, 23
 Aug 2022 09:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120326788.369593.18304806499678048620.stgit@olly> <YwR5fDR0Whp0W3sG@kroah.com>
In-Reply-To: <YwR5fDR0Whp0W3sG@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 12:48:30 -0400
Message-ID: <CAHC9VhSkmJCXbKBOLDJjnap1+pYYnSVt2CzO3iQXmV7TZ+17SA@mail.gmail.com>
Subject: Re: [PATCH 1/3] lsm,io_uring: add LSM hooks for the new uring_cmd
 file op
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 23, 2022 at 2:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Aug 22, 2022 at 05:21:07PM -0400, Paul Moore wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> >
> > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd"), this extended the struct
> > file_operations to allow a new command which each subsystem can use
> > to enable command passthrough. Add an LSM specific for the command
> > passthrough which enables LSMs to inspect the command details.
> >
> > This was discussed long ago without no clear pointer for something
> > conclusive, so this enables LSMs to at least reject this new file
> > operation.
> >
> > [0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com
> >
> > Fixes: ee692a21e9bf ("fs,io_uring: add infrastructure for uring-cmd")
>
> You are not "fixing" anything, you are adding new functionality.
> Careful with using "Fixes:" for something like this, you will trigger
> the bug-detection scripts and have to fend off stable bot emails for a
> long time for stuff that should not be backported to stable trees.

This patch, as well as the SELinux and (soon to come) Smack hook
implementations, fix a LSM access control regression that occured when
the IORING_OP_URING_CMD functionality was merged in v5.19.  You may
disagree about this being a regression Greg, but there are at least
three people with their name on this patch that believe it is
important: Luis (patch author), Jens (io_uring maintainer), and myself
(LSM, SELinux maintainer).

--
paul-moore.com
