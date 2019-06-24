Return-Path: <SRS0=R8bZ=UX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90606C4646B
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jun 2019 21:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6814020673
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jun 2019 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zxf/1zMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFXVJ6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:09:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37266 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFXVJ6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jun 2019 17:09:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so7574655plb.4
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2019 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+M9GTKc889J/I4j8FdnQoUxnObw5B7R/lYgu2IzB7wI=;
        b=Zxf/1zMIOK7HgcBG8KOWwQkar56B+aG7cMOyPTymRHLLRUXd3T9MMnoGLayGq4hytU
         ll1sZ70yOCvNS0pqGnvw/bBA1Ujt25ThPVxNzTiL46lwGjVGdOGvZ2hfRfjh2B+vS8aH
         M38pT5k5eeEPZXsTdYQoErvBdaH7KeAYleN2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+M9GTKc889J/I4j8FdnQoUxnObw5B7R/lYgu2IzB7wI=;
        b=conpHDIKwErEqrGQytaMmAkBPx4EOXNG6C5ciMVt/tLldqlGNwZLCrTTfSYlmPE+5j
         c0NRZ4WbYxauzxd6IpwBmTKkqpy+nJ+yORJsC0vIr+MzT+Gf2qdkRrd9RDTMuiGRJM5v
         11PQu58EED5eeYp0nf+M7E5HX3Hn61C1I202/REGB3DkG/ewObgBdO8F+35q/ElYP+lW
         O3gKxXObTeVwLF2xlYC4IcGDcWxXhYzY534MCpq2e1BPVYKxGkpK6qPpO3DFg9rwglti
         jZdBkM78PTNmzBX2zwoCYANVX/rICgrJQB7Fg2yA+glVSqVnwuZGGDFzzHw73nExSefr
         mmyw==
X-Gm-Message-State: APjAAAXDsStp1VIcw825PzErq3VV2IeW4JmZ/CBFw6OUXY3l0U8bS+4e
        ocJtaZbT6TOkJ58fL8wZ/Fx+uw==
X-Google-Smtp-Source: APXvYqwPjIj377DrJtcVZCD2Ebl8o8MphZbpTJcSjhVVRx5WG/PMyImnCnAjQNOTzSq8HpQ6mo8vXw==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr13650915plt.176.1561410597791;
        Mon, 24 Jun 2019 14:09:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm13706719pfo.138.2019.06.24.14.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:09:56 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:09:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 10/24] Use lsmblob in security_ipc_getsecid
Message-ID: <201906241408.FE94F84A@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-11-casey@schaufler-ca.com>
 <201906221545.43D54F0F@keescook>
 <a70ad13e-bc69-ef03-1f9a-3378c38cae23@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70ad13e-bc69-ef03-1f9a-3378c38cae23@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 24, 2019 at 09:39:05AM -0700, Casey Schaufler wrote:
> On 6/22/2019 3:48 PM, Kees Cook wrote:
> > On Fri, Jun 21, 2019 at 11:52:19AM -0700, Casey Schaufler wrote:
> >> +	struct security_hook_list *hp;
> >> +
> >> +	lsmblob_init(blob, 0);
> >> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
> >> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
> > Just for sanity when using hp->slot, it might be good to do something
> > like this in the places it gets used. Like for here:
> >
> > 	if (!WARN_ON(hp->slot < 0 || hp->slot >= LSMBLOB_COUNT))
> > 		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->slot]);
> >
> > This _should_ be overkill, but since lists of hooks that trigger slot
> > assignment is hardcoded, it seems nice to cover any future problems or
> > mismatches.
> 
> How about a CONFIG_LSM_SLOT_CHECK around a function lsm_slot_check()?
> If configured, it does the WARN_ON, and if not it's a static inline
> true return. As you say, it's probably overkill, but it would be available
> for the paranoid/debug/bringup situation.

No, this doesn't need another CONFIG. The test is nearly free and WARN
means it's wrapped in an unlikely already. I think just adding it
outright would be fine.

-- 
Kees Cook
