Return-Path: <SRS0=bMKJ=YF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3907C10F14
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Oct 2019 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB188206CD
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Oct 2019 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570920997;
	bh=51dVFGUk6fsmF81ho7yMnCd3IY86zSZtQ556DfabKlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gITak5HxPi+wj6wN/gAexEgJnPcGfSRCW5PoTyQERuKXwTooj6ogCeSfHzOmk7WKz
	 0NM8tnreWX3RpW4J/sTZwLQV3nTYFxC5xCMMZfEB6w3RqQedQgt6OYZBla0Bisyisg
	 bGL7NRay/2k091w+pCkUFCi/vwC1CYLRdBUTGmRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfJLW4h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:56:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44886 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfJLW4g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 12 Oct 2019 18:56:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so13079731ljj.11
        for <linux-security-module@vger.kernel.org>; Sat, 12 Oct 2019 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DS67+YtCVu11SuWVZgu6Ket3y4/O2UgURNPso78w8e8=;
        b=Z8HBphVPrHzEotVK6GhCCdwuVASP2gvXWc76WJqSndGHM9/B/9mi8kNS+A5t2InmtF
         MSVj/sXqsezE6utbTZrIaBDDElGeUbMDMKgEzYvCnBg0wzL77Air9Ng/uDpX3dFDH/M6
         +8ki0dUOVg8W1BriNCEuKJeWIJUE+8QWI0I6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DS67+YtCVu11SuWVZgu6Ket3y4/O2UgURNPso78w8e8=;
        b=oRABKs3K/XnfUCiqmsdlWHn4wnXvWHz7fjK9B/2o1T5ktPKYcugD77VvQYWCjDTtDS
         KVXd7NoqU+ST9gtvQGSvdxc82B5riE+ATI0DTGyUKF1HgzkvrtGHwjuu49BMVIZN7WeL
         SAeE0WV48SHZggIBPdS2OjOGhXFtYANyX2sYBdRYNWdGA0y5+ORpFsX90UJNu/FBLgcX
         zlHHqZ+UcXW5Ax9nCI2lTGpCZb7vctIzQPqyEOJ65qWC7plhb237gQDt97GKLpUpHiah
         S1FQFjZjlFjog8Lr9HIVZFf+QMQIq72GHYbG2C96Mr0jqJ/pGcgjUj3fL/kXbFoVjUQ6
         i+eQ==
X-Gm-Message-State: APjAAAVkVVkCQHErEPiesxL3P1AXP1hihcHMK5vsu4SphbUQGutUZrPP
        RADhIEImxiLuNiGj79mRG2yZTnrjl9o=
X-Google-Smtp-Source: APXvYqxOlasy/q/Trkh2ny49JrwHqB+UcruJWJZUlD0A9oiDTLeFZ3aUbzMZWu9A538KH3S+wTvfOA==
X-Received: by 2002:a2e:481a:: with SMTP id v26mr6332707lja.41.1570920994048;
        Sat, 12 Oct 2019 15:56:34 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v1sm3058646lfq.89.2019.10.12.15.56.31
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 15:56:32 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y127so9389095lfc.0
        for <linux-security-module@vger.kernel.org>; Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr12727917lfc.79.1570920991283;
 Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191012005747.210722465@goodmis.org> <20191012005920.630331484@goodmis.org>
In-Reply-To: <20191012005920.630331484@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Oct 2019 15:56:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
Message-ID: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
Subject: Re: [PATCH 1/7 v2] tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict
 tracefs when the kernel is locked down")
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 11, 2019 at 5:59 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> I bisected this down to the addition of the proxy_ops into tracefs for
> lockdown. It appears that the allocation of the proxy_ops and then freeing
> it in the destroy_inode callback, is causing havoc with the memory system.
> Reading the documentation about destroy_inode and talking with Linus about
> this, this is buggy and wrong.

Can you still add the explanation about the inode memory leak to this message?

Right now it just says "it's buggy and wrong". True. But doesn't
explain _why_ it is buggy and wrong.

          Linus
