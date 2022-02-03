Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225AC433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Feb 2022 03:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbiBCDSG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Feb 2022 22:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiBCDSG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Feb 2022 22:18:06 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAF9C06173D
        for <linux-security-module@vger.kernel.org>; Wed,  2 Feb 2022 19:18:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u130so1072729pfc.2
        for <linux-security-module@vger.kernel.org>; Wed, 02 Feb 2022 19:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4QtPGJsJdjtleT4SCvDltRv0MUxS6HLkC+/jHaWkak0=;
        b=JGtI0UZ6Ck0rSbexL4Ad25l0q5f+gKaACzYjSkD65cN3hv2n7lC8GRTPAt3pmfHCyb
         Wf9YGN1zv874GvRTML77HPoG8fJ5LM0e8i2CXvMNyXiPrydyVDfkVz0S+AVM/LzWWTLX
         o4bOgZ8bo/WHDcNzDyY5pA/pQtGAfaasgfirU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4QtPGJsJdjtleT4SCvDltRv0MUxS6HLkC+/jHaWkak0=;
        b=UKQHAKKihCt5WjswXkBHTA/9hSe+zHUi50UIyOr26BxV3PLVUxsQYPD2RCjBXnFh2S
         DVkNlfH3ZOi45+U9nFPiE64Cfj7frjnGNh1mG5XD/X/tBnnnkQcUo5+gi7HGD2b5eVeY
         aZRlBubmYBe4JstXypCR8icnhrESxomSP6yHYkPjCdN00NgTwvnFLQbT4Ld9QQfFReA1
         MbQ7r/kG3F4GwYo7G4PGOoyqrdKBRf5IznHTEEf7Bw+xCG1bK2gY8LFiYvrTpA9x1b87
         bLKj3uJgCr9vTk+/xaOmzUhoL9fEswSJwJ/QJINWyxBoap/+d1kXaHPATnhJgBrIGDCQ
         szxA==
X-Gm-Message-State: AOAM531RoWyQrvbz+BbMvI5U7jOnfv/hqW6oo5M6/nPHp+LcYqMSgDbO
        Qqjl5OWCoNWnSXwBlWh3BM3TMQ==
X-Google-Smtp-Source: ABdhPJw6xMNyvSowwi3MnsmqNRcX44gydSmfXvKKmKbpkqwqzSvA7MVZmoUU5NQNycnkiWAt/5IKCQ==
X-Received: by 2002:a65:6d89:: with SMTP id bc9mr26747916pgb.260.1643858285384;
        Wed, 02 Feb 2022 19:18:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm27170877pff.39.2022.02.02.19.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 19:18:05 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:18:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
Message-ID: <202202021916.9606A43C88@keescook>
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-5-keescook@chromium.org>
 <CAKwvOd=icTwyFb39U3OO5i_2YNJMiCMteeNTrVe-Q0tcmmnBJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=icTwyFb39U3OO5i_2YNJMiCMteeNTrVe-Q0tcmmnBJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 02, 2022 at 01:27:11PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > +#define BOS    const __pass_object_size(1)
> > +#define BOS0   const __pass_object_size(0)
> 
> A dumb bikeshed, but would you mind naming these BOS1 and BOS0, and
> perhaps consider adding a comment or pointer or link to something that
> describes why we use the two different modes?  I recognize that the
> code already uses the two different modes already without comments,
> but this might be a nice place to point folks like myself to so that
> in a month or so when I forget what the difference is between modes
> (again), we have a shorter trail of breadcrumbs.

Sure, I can do that. My expectation was to entirely eliminate mode 0
usage in the future.

Though now that things are so close, I'll just do some builds with the
last few users switched over. But maybe memcmp() was a pain? I'll go
check...

-- 
Kees Cook
