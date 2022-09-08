Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E73C38145
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Sep 2022 16:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIHQOY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiIHQOG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 12:14:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD1E9009
        for <linux-security-module@vger.kernel.org>; Thu,  8 Sep 2022 09:13:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m3so7671500pjo.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Sep 2022 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ynlv/HlbjINH5vzgYf4TA8R4RfVi30O2jA5crDrStO0=;
        b=oYHv1zVyXadmL712N/OTN2ss+kfxkYYSZBY8SbeRcDbK5VRzMS9d5oRJiUpeOHaNnS
         y6U8mteu3RX3xSdL5vGrsFWmQ0rr4DrfFKLnopVfEAmi84XeZniDURw9fK6qKvxsWiTq
         0ZT0zNSgYguC3eYyLhWhzdiJaFpeL/WVVWjRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ynlv/HlbjINH5vzgYf4TA8R4RfVi30O2jA5crDrStO0=;
        b=1D1MRj1xVogV4XuCItu76y/tUx36DLSrnBW1P/SaP7xQo8AZrmhAsIqRQV8EJibNND
         2QGFPqgXY8cX9Xg+uSuJDhKtGpTWJQ/OkvFfTyBIu4fo7ShtBPD+Qi6AhG/GRumO4/mm
         Nsx+fyUuhSSbWO9j0ljU1GCAz9kYL+Zl28+Sil1u9ZxtqKrFv/iXVU50bg/UASOWD3wh
         TwDHmNp52cf8SEDiSbGnyRdvSQ9MmrvPNV9s73T6uJBPZ/DInUgEvTvmODecze0x0XRa
         5DemTYOO1HPMXMAYszpPhe47/bSvnzEkvm2LUvlunkSFXYjC/XvZxZF779aRyyWoRnUA
         el5Q==
X-Gm-Message-State: ACgBeo0moab6LtBMgQvYQeloFzdhZGvSq+/zraybvrY+zoosSrwJNab0
        k0mk9+c2fgwi4gSAWWQq2bNr7Q==
X-Google-Smtp-Source: AA6agR4b8HBqas+oT3K9pH3ycWp3TxRR1yMAxYD+7X/J4yLb8tb1538WM7cusSa+UKAv+3mrExLCmQ==
X-Received: by 2002:a17:90b:1bc8:b0:200:43c7:5940 with SMTP id oa8-20020a17090b1bc800b0020043c75940mr5071911pjb.46.1662653613370;
        Thu, 08 Sep 2022 09:13:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709027e0e00b0016be596c8afsm14773738plm.282.2022.09.08.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:13:32 -0700 (PDT)
Date:   Thu, 8 Sep 2022 09:13:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     agk@redhat.com, mka@chromium.org, dm-devel@redhat.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sarthakkukreti@chromium.org
Subject: Re: dm: verity-loadpin: Only trust verity targets with enforcement
Message-ID: <202209080912.00880AD6@keescook>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
 <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
 <YxoJcG5MN4OdaulL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxoJcG5MN4OdaulL@redhat.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 08, 2022 at 11:25:36AM -0400, Mike Snitzer wrote:
> On Wed, Sep 07 2022 at  6:34P -0400,
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> > > Verity targets can be configured to ignore corrupted data blocks.
> > > LoadPin must only trust verity targets that are configured to
> > > perform some kind of enforcement when data corruption is detected,
> > > like returning an error, restarting the system or triggering a
> > > panic.
> > > 
> > > 
> > > [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] dm: verity-loadpin: Only trust verity targets with enforcement
> >       https://git.kernel.org/kees/c/2e1875c05267
> 
> Does this mean you're intending to send this upstream?  I prefer to
> take all DM changes unless there is an external dependency.

Oh! Yeah, I added it to my tree since you'd asked me to take the
original verity-loadpin series and this was a fix. I'm happy either
way. Shall I drop this change from my tree?

-- 
Kees Cook
