Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71425C433FF
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C4B21874
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CxEo1g7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfHHVjN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:39:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38925 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733295AbfHHVjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Aug 2019 17:39:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so44727943pgi.6
        for <linux-security-module@vger.kernel.org>; Thu, 08 Aug 2019 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31tmtWY4ESozk+Kl+P59HYPCppsOo+/5pMO1fsb++Ac=;
        b=CxEo1g7hd+jFmrRvAk4nXhk0VhsH1E1BhseVdRuthfYyLDjVLAVZpzSIgie8X6doum
         2HbT2fa9psRoJ5iOohLUm95dhASmCuw6ZHF/Gz9fvKNXkvvSZ/XpnxWtSRBNKQkBehSc
         cSyLEUWouwc0FliTGKRk9Ti/l1uCeVr2chdlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31tmtWY4ESozk+Kl+P59HYPCppsOo+/5pMO1fsb++Ac=;
        b=IA4CXIRXOqlyMQNeXkdodASQ042p+Gz770MAGiUdHbpM6StRHFqzslxaqavj8AfhwR
         xMHNiME3l+ChTZrlC/OnU50MgovZCGDf7Xxby4lM5MZAfUBJm1Zq6MbnSBP4xbQBWEdt
         MpP6AuwJV9vH/UZupQBt9GtFArSgspSLzZyfyDhxVw/wlX5YIunINEvWWzf3h73vgim2
         Fs1mM1Ecn7NkGEDdZ4K1xtZL0pyXSNTmBvrcGEDuqxFpnEKk76Ul23AHx0X0erUETs7l
         NGl7CvFc6QUE5skx/afho3FX6LPsql78iy5UIA1BxzW1Y1MlyOYVkJhyjakFKG0sFoEm
         2f3Q==
X-Gm-Message-State: APjAAAUaNGZpLhWo+psZv31F3yprnIKJr8gy1s5BUR8G3yEi7/YyKV+X
        lTpwxw6L3PIEc7JZN70RfdpfcWOntrc=
X-Google-Smtp-Source: APXvYqyiyuEV53cHm2r8e0m4GKkXDG7BNSl22J7VW/dcAvhjJOiWQiAGA7lykhRnFGNLLBsztRtEoQ==
X-Received: by 2002:a65:6546:: with SMTP id a6mr15076642pgw.220.1565300352564;
        Thu, 08 Aug 2019 14:39:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i126sm114742789pfb.32.2019.08.08.14.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 14:39:11 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:39:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v7 15/28] LSM: Specify which LSM to display
Message-ID: <201908081424.21002A3@keescook>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-16-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807194410.9762-16-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 07, 2019 at 12:43:57PM -0700, Casey Schaufler wrote:
> @@ -1980,10 +2033,48 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
>  	struct security_hook_list *hp;
> +	char *term;
> +	char *cp;
> +	int *display = current->security;

So I went down a rat hole looking at setprocattr vs current. It looks
like everything ignores the $pid part of /proc/$pid/attr/$name and only
ever operates on "current". Is that the expected interface here?

> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0 || size == 0)
> +			return -EINVAL;

...

> +		cp = kzalloc(size + 1, GFP_KERNEL);
> +		if (cp == NULL)
> +			return -ENOMEM;
> +		memcpy(cp, value, size);

Saving one line, the above can be:

		cp = kmemdup_nul(value, size, GFP_KERNEL);
		if (cp == NULL)
			return -ENOMEM;

> +		term = strchr(cp, ' ');
> +		if (term == NULL)
> +			term = strchr(cp, '\n');

"foo\n " will result in "foo\n". I think you want strsep() instead of
the above three lines:

		term = strsep(cp, " \n");

> +		if (term != NULL)
> +			*term = '\0';
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
> +				*display = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(cp);
> +		return rc;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
>  	return -EINVAL;

Otherwise, yeah, seems good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
