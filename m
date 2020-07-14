Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09012C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D580E206D9
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OfmVSBDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGNVt0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGNVtZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 17:49:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2800C061755
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:49:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so33784pjb.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/2Da3iNyWh0eVa9re/PxqTbl8E4lNL39Wvo8BQa5Jk=;
        b=OfmVSBDsHc9Rmasjt6KXSUQdd+K+htfdnDGZNH60suyaUxoZ6TXC2sZQyckRFbNtVW
         eCczQAunkP9IdML7SUT1mKGAgRCYJZ2JU2BzFii89fLlf5/fb6WZmg8/bak5hryNE5Y3
         stsrls1AUgm02a5MgTkAsfCOzaG5T8ZvxZN3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z/2Da3iNyWh0eVa9re/PxqTbl8E4lNL39Wvo8BQa5Jk=;
        b=Nw3RFvTS75oOpWUadrNG1+gXDbTDA55QbL9T2pG1kPYvDB2kh1QOyTb9sJABGGY6yT
         eIzaOy/R+wSoznaJlrubDKBTn1OQdqTctNQflayz1j5B/yUGgLbqDqv6c4TF3n7sUpNL
         r0H019eyNdLqnpBLf4djaEYOei2ArGfyXhgfBFCM6GWx9Qu4VKDHYZ9VBmOlm+BvBSby
         mQP+pwNgiV+7blV3cC4O5wsnAcSySeq8iWJSv7szCj52sfuVNyohBd2za63iUz6xrAcE
         EQmtJ3tkGkARjx6F2BJQ/jGUofmWz3wZjHHENGbm81DjlVoDCwlktawciG/jGZrg2aW9
         cxSw==
X-Gm-Message-State: AOAM530sAti/Rs/hzlxdoUZ4PmITWMXuKYjc+j+Dgrzo+hUTpCRvsrwg
        hu1QVoIXjvGGjfg/o8zRC9jZRw==
X-Google-Smtp-Source: ABdhPJyfHN6nndxTZkr0qhDNx67iZO+T5mcaIl+et4AYLVpGCPX9K8cfoszp9wO2zi7jQoRkZbuhYA==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr7042196pje.225.1594763365288;
        Tue, 14 Jul 2020 14:49:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br9sm48405pjb.56.2020.07.14.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:49:24 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:49:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <202007141446.A72A4437C@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo365ikj.fsf@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> +static int count_strings_kernel(const char *const *argv)
> +{
> +	int i;
> +
> +	if (!argv)
> +		return 0;
> +
> +	for (i = 0; argv[i]; ++i) {
> +		if (i >= MAX_ARG_STRINGS)
> +			return -E2BIG;
> +		if (fatal_signal_pending(current))
> +			return -ERESTARTNOHAND;
> +		cond_resched();
> +	}
> +	return i;
> +}

I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
refactor that too? (And maybe rename it to count_strings_user()?)

Otherwise, looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
