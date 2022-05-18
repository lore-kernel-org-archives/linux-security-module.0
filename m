Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D748C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 18 May 2022 19:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiERTXP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 May 2022 15:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiERTXO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 May 2022 15:23:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877A230221
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 12:23:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so6540460pjb.5
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=azN0WpbB56teBoeHRiX8ZF8theRa9wuUdenPzDm2W0A=;
        b=Rn4CYF1ACF2cOUsSFeF5ggKBSZkleVil0ZiQ9WxVlhUOV+db6WXvI9Zi6EGX8zOZZq
         58JBNUW6nh58qGonn1ZzSL+Rw3U7Y8oYTpnAZAyS8ri/tz45+BP4VpH/V1BYQVobDRCc
         IB4ZRG892jsRkd1WR7/H+ZAt+ibPl6VGuvX4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azN0WpbB56teBoeHRiX8ZF8theRa9wuUdenPzDm2W0A=;
        b=q36RobSJlbmTpkgIFDSazzH068NR9xhylj8HbeUtUqdIVzAvkmg1K2HJOzFGJ1fUa8
         3HrtpD9kx96psrzsnsXt+xGjzLi8ZkCAxzwydOs60FstazP6qjgFdyGIRHXh86XPXXSt
         KEI5C+BQAQI4O3vXQP6d3aYoVuJENGT0TwS0mZa6IwyxGubOMOLFC2w0/teLRYtzQE75
         TIyEnl7q5RAAS2cMnb00EqWSrgKXxoLreDy5KPigQ16MPd1auCzJlmEIuSW2wSArdKY0
         vbo0THdAANxwCZNLHbCSOIqrpCoCM47ym3SvN9+jLLsjhkkvamNri8Q/nGfXbMaJ7aCn
         pcRQ==
X-Gm-Message-State: AOAM533Ju4nr4XdnCZzPAvdV8D5X2B2FGL9uCBSbyMf6vYIOC4thY0qr
        Ffgn20S83ZfAFslKC1ebEjZaTw==
X-Google-Smtp-Source: ABdhPJxxZN/NR10p8Wr/541BkyIcKrJcnoJoUiHqQDum/hfEMTs1nrTf898+1jlCrtMSQOkhw1YXoA==
X-Received: by 2002:a17:90b:4f86:b0:1df:28c5:e89a with SMTP id qe6-20020a17090b4f8600b001df28c5e89amr1016434pjb.66.1652901791534;
        Wed, 18 May 2022 12:23:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b0016168e90f2dsm2055410pll.219.2022.05.18.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:23:11 -0700 (PDT)
Date:   Wed, 18 May 2022 12:23:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202205181221.F02CF5A9D2@keescook>
References: <20220517233457.1123309-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517233457.1123309-1-mka@chromium.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 17, 2022 at 04:34:54PM -0700, Matthias Kaehlcke wrote:
> As of now LoadPin restricts loading of kernel files to a single pinned
> filesystem, typically the rootfs. This works for many systems, however it
> can result in a bloated rootfs (and OTA updates) on platforms where
> multiple boards with different hardware configurations use the same rootfs
> image. Especially when 'optional' files are large it may be preferable to
> download/install them only when they are actually needed by a given board.
> Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> at runtime. As an example a DLC package could contain firmware for a
> peripheral that is not present on all boards. DLCs use dm-verity [2] to
> verify the integrity of the DLC content.

For the coming v5 (which will fix the 0-day reports), if I can get some
Acks from the dm folks, I can carry this with other loadpin changes in
my tree. Though I'm fine with this going via the dm tree, too:

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
