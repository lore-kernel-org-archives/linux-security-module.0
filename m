Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC2C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 18 May 2022 19:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiERTni (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 May 2022 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiERTnb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 May 2022 15:43:31 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D6205278
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 12:43:29 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id c1so2261640qkf.13
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 12:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWE/Csrg3TFZq52PFagCnd5ycCPpe2W/G6e1YggcD68=;
        b=3bE5RLq3puWYtITL8ga/GKZNRhPObr6uszSWF93g5JOL+YGwfuXWEiKABJIbjjF0lt
         gaJgLTKRGw2dYdG1qeuamMmeq4APzjmRkX3ddggvViBtwA13p80dnATTx3wrmhfCVmxk
         GlKj+1T6TV7BoIQaMoAx19tWzS4Svil8wyeQjAa1fxhZcxbBxdBR1eLMieSbY5oEbdZD
         hMIcY+go4AokEQyBzSW6eWusselFfN0Mr1gwb9Lg368QQxyShqdgkz9dTBVLVgR8ZrDB
         hG/8xKvpl3G6lfJYEFBcIMuvA60pesBlweqAVaa7d/RHoYIzsjo42jC7JM5XYE+ptoH6
         ptfA==
X-Gm-Message-State: AOAM531bFgz0Y6QmVNDC09kyrNRwvo4xCGBqT12A9h4zSCk9H5sY3CSx
        GPWzWY6MVEva92bY+AkBXHsn
X-Google-Smtp-Source: ABdhPJxwDfvRn/dtBw/nu2UWuqr/QIeIsuEtWlURFwHEFgLeTC0TWbkdZvRu40tYPgyyOvUl6VbGrQ==
X-Received: by 2002:ae9:e90d:0:b0:6a3:28eb:1a4f with SMTP id x13-20020ae9e90d000000b006a328eb1a4fmr815862qkf.21.1652903009028;
        Wed, 18 May 2022 12:43:29 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b002f39b99f679sm83146qtn.19.2022.05.18.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:43:28 -0700 (PDT)
Date:   Wed, 18 May 2022 15:43:27 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YoVMX4pDDIN1vmH8@redhat.com>
References: <20220517233457.1123309-1-mka@chromium.org>
 <202205181221.F02CF5A9D2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205181221.F02CF5A9D2@keescook>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 18 2022 at  3:23P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Tue, May 17, 2022 at 04:34:54PM -0700, Matthias Kaehlcke wrote:
> > As of now LoadPin restricts loading of kernel files to a single pinned
> > filesystem, typically the rootfs. This works for many systems, however it
> > can result in a bloated rootfs (and OTA updates) on platforms where
> > multiple boards with different hardware configurations use the same rootfs
> > image. Especially when 'optional' files are large it may be preferable to
> > download/install them only when they are actually needed by a given board.
> > Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> > at runtime. As an example a DLC package could contain firmware for a
> > peripheral that is not present on all boards. DLCs use dm-verity [2] to
> > verify the integrity of the DLC content.
> 
> For the coming v5 (which will fix the 0-day reports), if I can get some
> Acks from the dm folks, I can carry this with other loadpin changes in
> my tree. Though I'm fine with this going via the dm tree, too:
> 
> Acked-by: Kees Cook <keescook@chromium.org>

I'll review it once it's posted.

But I'm going to reply to v4's 1/3 now.

