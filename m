Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71EDC636D7
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Feb 2023 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjBUQvb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjBUQva (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Feb 2023 11:51:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC62A140;
        Tue, 21 Feb 2023 08:51:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l25so4753974wrb.3;
        Tue, 21 Feb 2023 08:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D08MB0A+qBNVeOH6aq7XN8nQRa4U2c9RkXpOy8QFNCM=;
        b=ZQzPyzVfCM1VDrOg7jld8kTbJjJJXvVy2RJNNMM27fEwFpiO2fAQ/J44ymaTYK4QHy
         Oa3TwEgrqDz8s6YdH5foMHs/gsnQEzUIUpScLYjFkeHNvHRWtGh4C4jeqe4ZK2+mNNUh
         5naT5PPifD9Nj2i/tEdmGbZC5fCGiPhDw3TMs52EGgqhZt7R6DOI2l2iPYkPvOORgTrn
         RVDwHlFi1W2LSpiV0NAtBZVv9/icrES7dVprz54xRtvlweqVhFvJkb5SRNDJiFk0GN+I
         mYgGWIm2cvEk6nQB1qh4N67EVf6ZO5pzbEZw0SZBHinqfla75A11UQBWL/lauIGP7scC
         FBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D08MB0A+qBNVeOH6aq7XN8nQRa4U2c9RkXpOy8QFNCM=;
        b=DkfK7UnRsYdltOst4Eao2z48FfteC3Q9y7zvXzdwhmJPr2YQ8vbFd6RIVlShBQ8DZg
         xj1kLGGU5SD1Wq7MxTHwNIhO6NLqzED4rpAWqblCVezFyVZznpUBdnmNLVPk42kr1PPG
         3mqvz9teskiYOnOMlb4CfK/CIiX6E1V1G3JvJRdgZNUmlqnBYKpRbQWpz8FLA/YG0yZ5
         jQig1HQjIadlKZYKkcKK6hpKNwYl8YhDXnow/Q5+iUU1sAeeu6DD9UiYAsamMyD9q4V9
         HWr1QLaeoXtbe3blBVJnmnczT2ULnzOsGkyLBRdO+18tf8xuRa3E0M/+wdDCgr+ncae2
         TUCQ==
X-Gm-Message-State: AO0yUKXJ+rDgHFQwZLAEYKACBuffeDolZUumrCJ3mlYduzu1rWMcr44j
        7WkLKb2r6wiPYQSAtATyHew=
X-Google-Smtp-Source: AK7set+V1xqMb77oQA3kb/X190XD26WIfW0xI5M2lOf3qRoxH31ILZVVkTzmFbEIjumUbN63FW/8EQ==
X-Received: by 2002:a5d:6105:0:b0:2c5:588c:84a8 with SMTP id v5-20020a5d6105000000b002c5588c84a8mr4155968wrt.19.1676998287698;
        Tue, 21 Feb 2023 08:51:27 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b002c5706f7c6dsm1937580wrx.94.2023.02.21.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:51:27 -0800 (PST)
Date:   Tue, 21 Feb 2023 17:51:25 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Message-ID: <Y/T2jcoFcjYO8LZj@galopp>
References: <20230216200729.12438-1-gnoack3000@gmail.com>
 <0e5bf1f7-47b5-382e-ae56-4556980a908b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e5bf1f7-47b5-382e-ae56-4556980a908b@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 17, 2023 at 08:28:41PM +0100, Mickaël Salaün wrote:
> On 16/02/2023 21:07, Günther Noack wrote:
> > Clarify the "refer" documentation by splitting up a big paragraph of text.
> > 
> > - Call out specifically that the denial by default applies to ABI v1 as well.
> > - Turn the three additional constraints for link/rename operations
> >    into bullet points, to give it more structure.
> > 
> > Includes wording and semantics corrections by Mickaël Salaün.
> 
> No need to add this line, It's part of the maintainer job. ;)

OK, removed for V4.

> Some of my suggestions are about style, so feel free to ignore them if you
> think the original is better. Anyway, I'm not a native english speaker
> either, so there are good chances I'm not correct on some suggestions. What
> about that?:
> 
> This is the only access right implicitly handled by any ruleset, even if
> this right is not specified at ruleset creation time. Reparenting files will
> then always be denied by default. Given that %LANDLOCK_ACCESS_FS_REFER is
> available since the second Landlock ABI version, using the first Landlock
> ABI version will always forbid file reparenting.
> 
> For these kind of link or rename actions to be possible, one or two rules
> must explicitly allow %LANDLOCK_ACCESS_FS_REFER on the source and the
> destination hierarchies. In addition, the following constraints must be met:

I reworded it again, it's meeting somewhere in the middle I hope. It
should be a bit better now. (Sending another version.)

Documentation is hard... it's difficult to find an objective best wording.

–-Günther
