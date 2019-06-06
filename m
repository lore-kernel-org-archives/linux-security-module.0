Return-Path: <SRS0=Ewgb=UF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A4DC28EB4
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jun 2019 20:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BE9208CA
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jun 2019 20:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h58DufOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFFUxw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:53:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33313 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFFUxw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jun 2019 16:53:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so1402005plq.0
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2019 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GDh4x9nn5FphHEoxgu7T7zZCh4Ruw+RsygHDv/0DLDA=;
        b=h58DufOaV8U71szs11xZaxKosh69vvIP8WRtrCPGE/BNXAvJ0dP6I6HICiSuwjrRbI
         XgTWjFEG+xdwo9XbjQZ5qmfm/izmBwzPe8w9eB6Hs+YjqFZpAU0gx4wql+sOvDz3wKwo
         yAtjXfFpAKY6iS2iGaFmAM2yQYa78Jnfi4LK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GDh4x9nn5FphHEoxgu7T7zZCh4Ruw+RsygHDv/0DLDA=;
        b=bPadCcyhN81/GX3bW2RBfRSNCDp8g/xjdGKltmI7kBmqmj9zdDAOfMfi7XuDbfXZid
         yWYnH1RQe1HdsQagni4bYosTRxpKxBkp/ZWh/G1bnXfWdLFtFBrtKk6JNk3Fd/59Cgba
         CAbyOx3ZBKdUf0prnixmh4ETYkqHtFhRCbgz1fYoEbq6ChZtEG0juKtIq90r7K+T5D5f
         Sh9q++dPVsQeDFTr1HT2U7KoUJRg324bMCDEcPyD2iJeFrgFNX+8xYLe9BaHIPU/IOvk
         DURb7r+e3N+qOCVJd28Gz87N9Dg8AQA5YwsgwCpHFRVvRt8Cw6AAjZuRsAkgrqgkYUBw
         ra6A==
X-Gm-Message-State: APjAAAXeO4DsYFxD/RggssU6WA9J/xfrCE0MqQTp6cYTpDMdE5Glr5Gx
        qePr2SZ5CJ+abPWGbSB6wtOgXg==
X-Google-Smtp-Source: APXvYqwv35cOEhL/OhIWRYrUmtG1iz3glBmPub+5l9te2aqVcRgCEax71tYFu1PS6zcJeRdV8kbpzQ==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr48709900plo.252.1559854431685;
        Thu, 06 Jun 2019 13:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r77sm54630pgr.93.2019.06.06.13.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 13:53:49 -0700 (PDT)
Date:   Thu, 6 Jun 2019 13:53:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Message-ID: <201906061351.B12D10D5D@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
 <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
 <201906061138.BFE4CFEE@keescook>
 <dbafd99d-aab7-c497-fbe9-fe467b0c237a@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbafd99d-aab7-c497-fbe9-fe467b0c237a@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 06, 2019 at 12:17:42PM -0700, Casey Schaufler wrote:
> On 6/6/2019 11:41 AM, Kees Cook wrote:
> > On Mon, Jun 03, 2019 at 03:23:07PM -0700, Casey Schaufler wrote:
> >> Maybe lsm_export_is_interesting()?
> >> I'd love to discover there's a convention I could adhere to.
> > I'd agree "lsm_data" seems meaningless. lsm_export does seem a better
> > name, though it has the "export is also a verb" issue. Would "lsm_context"
> > or "lsm_ctx"?
> > be better?
> >
> > then we get lsm_ctx_is_interesting() and lsm_ctx_to_secid() ?
> 
> Fiddling around with this led me to think "struct lsmdata"
> would work, although maybe "struct lsmblob", in keeping with
> the notion it is opaque. Leaving out the "_" helps with the
> verb issue, I think. I think ctx or context is right out, as
> secctx is the string representation, and it would really confuse
> things.

Ah yeah, good point on "context". Does "blob" conflict with the existing
"blob" stuff? If it's always going to be u32 data, do we want it to be
lsm_u32 ? Or, since it's a multiplexor, lsmmux ?


-- 
Kees Cook
