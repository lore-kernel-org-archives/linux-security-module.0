Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4636C43217
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Oct 2022 18:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJSS2y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Oct 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJSS2x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Oct 2022 14:28:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD621C5E17
        for <linux-security-module@vger.kernel.org>; Wed, 19 Oct 2022 11:28:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y8so17989396pfp.13
        for <linux-security-module@vger.kernel.org>; Wed, 19 Oct 2022 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2hPps6n+imJEzUNlW/VzlKPcj20qPrXntNfgwGKzuY=;
        b=j+hygSwcxDFsiLQtsX8B8yHklZpdfRny6e8dmyZIbRCaw5sykqsyuUG14hULFoAgqw
         9VzbgFATA1wcIkrzNv4rDxOIq3AtbvHiBWS+tcVal2ZZ5abyF79gSZ6IxPvNkito6sjd
         Ts+tURTA+hvKiPKW94XkQWheSW1wRmHyM6jkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2hPps6n+imJEzUNlW/VzlKPcj20qPrXntNfgwGKzuY=;
        b=kuEGxxi8aWCCfyJbJgzH065PdohAKJzbuxc0EudrqpDF+aM4s41VEuseO4TmY8y/I1
         qXLtCtbCqQsmifLYkKIebvsg8fUZhANEhmWcJnAgvbKoFHDqN6QV6jpKc/Gu3YEs4/DH
         CCEF3/m1cGcot8xSxKLpSxkvyNhZ+QtkRGRb2bcz+279cUZ94Nigt31AAigF0JxOtUSa
         VmZkcX/xdE4daf6HrR+3NnBFVuaIvl+mnqWgMoOmPgZV4UVNoS2BkUU1h7/uSEHPfnO5
         sRavOzzNXJ76CLwulypw7V7UkjUmHwRd5Ic4N4ExUSQ88LmLIceC3KUGat4v/tPByVsc
         HYvw==
X-Gm-Message-State: ACrzQf2BSnU4O959JS2xcp210LCwQmEeUr1IENaB8mrAHApgYr6QmDDY
        0bqNWUn/e91DjUnV/gQmuM0Eqw==
X-Google-Smtp-Source: AMsMyM5Tsdbs1rfhpPqYMhH++zf6I2sJgAtJQ0mlvySZTLPWLkPK5emZnVoul9O4mTUM7CIDrTKy5w==
X-Received: by 2002:a63:ce54:0:b0:46a:e2a9:c7f6 with SMTP id r20-20020a63ce54000000b0046ae2a9c7f6mr8152760pgi.264.1666204131734;
        Wed, 19 Oct 2022 11:28:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b0017e232b6724sm566869plg.69.2022.10.19.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:28:50 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:28:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Message-ID: <202210191114.C64D8ED68B@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <dd90cbafa0ba59be135a878bc7abcf4d322d43a1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd90cbafa0ba59be135a878bc7abcf4d322d43a1.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 19, 2022 at 10:34:08AM -0400, Mimi Zohar wrote:
> On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> > Move "integrity" LSM to the end of the Kconfig list and prepare for
> > having ima and evm LSM initialization called from the top-level
> > "integrity" LSM.
> 
> The securityfs integrity directory and the "iint_cache" are shared
> IMA/EVM resources.  Just because the "iint_cache" was on an LSM hook,
> it should never have been treated as an LSM on its own.  IMA maintains
> and verifies file data integrity, while EVM maintains and verifies file
> metadata integrity.  IMA and EVM may both be configured and enabled, or
> independently of each other.   However, only if either IMA or EVM are
> configured and enabled, should the iint_cache be created.  There is
> absolutely no need for an independent "integrity" LSM.

The purpose of this patch was to tie ima and evm into integrity, since
the iint_cache is used by both. It's been true since 4.20 that using
ima and evm requires that the LSM named "integrity" has been initialized.
Since ima and evm have separate indicators for "am I active?" (much like
apparmor, etc), it seemed sensible to make ima and evm part of the LSM
named "integrity". Other solutions are totally fine!

I do note, however, this patch needs to be tweaked for the case where
CONFIG_IMA or CONFIG_EVM are not set.

-- 
Kees Cook
