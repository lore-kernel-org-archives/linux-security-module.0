Return-Path: <SRS0=i+Ac=C6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97FC43465
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Sep 2020 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D4D2396D
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Sep 2020 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600705672;
	bh=uFDgyyukrQbl05vlN9uB7HNcr+JyihlyDL4uvBboqo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YFfkUCGuw+gLRmYzqPbfW7wHwFFuBahngZTTTO+mtXTQnRAehxiO80MzrZr11pd58
	 RCafIFLKO5VvEwAOJNoGj3Q1z4QvTtiWsPdnEl0ijYxQkS88DSnG4vquHaa3cvLeyt
	 d1zfX70BNxWd9WBwuNBaK/cXkCg3I3KO0PrChiP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIUQ1v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUQ1v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Sep 2020 12:27:51 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E260C0613CF
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2020 09:27:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w11so14745591lfn.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2020 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkGkb2MrNjid2t2xzsw7KGRSA+5X+/NXfaXYAD63JOQ=;
        b=EbVfWiD/0FwOHmGlMRJzyDefmvEBHwjopQdM0INnp7+G7ymRce/nckc8fZ1BbNObaM
         KYhup5K4TfBuWWI2zp87w7I1NNRFlriw8hPLX5GDXo97vLAs9GvUo9Ux3NCkR0mEYh0d
         B6njjsxpj84PDzjqVDsZyzxBpabTZjipn+vS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkGkb2MrNjid2t2xzsw7KGRSA+5X+/NXfaXYAD63JOQ=;
        b=rCHW5eWa7C8UCBt3Ph5KWSiItjj4TQIHZRRcD9n066lCk19zqIfKESjlxU25lxEUcR
         yRVEVEphAkNAZybPtmjFZL2JSm4GodS6DEPFRDuYDU6uaez7AvL84BIsX8i5IbT9/91K
         dCtuXvnEvFufua4s6WlwAdipRcmum0Hm2BjGv7rw5mZGxUhN/qWvNSXyforLn+g+BkzX
         mtPc56I8MhTU1+T2ap9AlSuAexUXLW3TJoWjpxqjuNEsO9QqaCZDIA2BUWFFVk0E4mGk
         N6yPqEwHx8PJeKQslqiVpQl4mvm+xFB3ThdtsTJmLko1f4jdIuuJ5eLu2Oz/irAD+nmT
         /3Aw==
X-Gm-Message-State: AOAM533oiE+eH6pMLFS5ug+7iScNl8XdNk4czbAeD9tL4lGMD3eZUNvg
        TYI1aOiJR9gQltxywTcFJ+Uu+BWpqYBxyw==
X-Google-Smtp-Source: ABdhPJxsc8SAdzupDjvW8vIBLCOdAsaRFR+UmlMEJS0hANB3G5/cwsYonN6Auu4IezVJIPLnLsvJKg==
X-Received: by 2002:a19:3847:: with SMTP id d7mr214771lfj.507.1600705669309;
        Mon, 21 Sep 2020 09:27:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e9sm2675143lfn.237.2020.09.21.09.27.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:27:48 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a15so11649214ljk.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2020 09:27:48 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr156761ljh.70.1600705667861;
 Mon, 21 Sep 2020 09:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de>
In-Reply-To: <20200921160922.GA23870@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 09:27:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTz9h-WCtkEcByebaqv3arZWuUQ7TzfHejo10=bztZeA@mail.gmail.com>
Message-ID: <CAHk-=wgTz9h-WCtkEcByebaqv3arZWuUQ7TzfHejo10=bztZeA@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, Ian Kent <raven@themaw.net>,
        autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 21, 2020 at 9:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> So we obviously should not break existing user space and need to fix
> this ASAP.  The trivial "fix" would be to export __kernel_write again
> and switch autofs to use it.  The other option would be a FMODE flag
> to bypass security checks, only to be set if the callers ensures
> they've been valided (i.e. in autofs_prepare_pipe).
>
> Any opinions?

I'd much rather do the former than add a new dynamic flag that we then
have to worry about somebody being able to set thanks to a bug.

Static behavior is a lot easier to verify and document (ie just a
comment in the code explaining why autofs cannot use the regular
kernel_write()). There's no chance of that static behavior then
leaking to other call sites.

                   Linus
