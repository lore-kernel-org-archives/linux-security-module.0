Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDCFC433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Oct 2022 13:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJJNTo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJJNTk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Oct 2022 09:19:40 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEEE98
        for <linux-security-module@vger.kernel.org>; Mon, 10 Oct 2022 06:19:39 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1324e7a1284so12409650fac.10
        for <linux-security-module@vger.kernel.org>; Mon, 10 Oct 2022 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ElFZdwWFu/6S3XkLX3CTGFQ16KWpQJXO6RCVrOcV5c=;
        b=Lh3pTx2cU2pFUru1KHkuwGd6QDSu7dv1JxT+fUL1XyW4Pl/rZqXVIC+0W+TwuD0tnF
         /UzptMzh3N50czivsSJByp01PyE8j0NjIrandssAnrIk9v92ZhOoZVDKCAj6zuvy/U2P
         yVYG/Q24u07xmdKG6IfLe5Gzc1agfFyTz3PFWxYHcC9u5iea8W8eK4jcFFnxTJqbTL6K
         G4SOsDSr4HBGeid9OA6eUirjAw1IGOB6bBaW/tIqPogQsyzf46tNEPMIc3R9063KLs8e
         xrVjy1MZD6TISrOzdb+5up8M1/nQ6zHbg7efnmN2JS193W5HDyj81rk8d0L0Ase/ms2k
         c8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ElFZdwWFu/6S3XkLX3CTGFQ16KWpQJXO6RCVrOcV5c=;
        b=5prEZuDWOMyb2i1A6Gl5yL1mQGjrCF9AVMKMv/YCcrkwJsin0D+lds31HJPwb3ICmy
         WcfamxXWpz3mLrV38Pr5WQXtQcnp8dq6TDIrWhRLswC9+/E5LgAHLY/gwMLbL2dxaxqu
         GGNqDc0J+5tbLWSAqhvd4LiIZ5REZiLGHYdzGcGSpA84sx7kEz244PTOSq8vOl2eKCWQ
         OsVpoW9tI3DPNJf34Kaj8mKj1p8J/Y+I3QqWnxcYKyuMDWyHidW+M/tX4h5nB3Og25+Y
         gnCtiIAMuDtBQctyIRgz5fh8zGUEE23dCTPCWLi5AInCuwb9sz6qfj/aLx5stj18mr+I
         wZ4w==
X-Gm-Message-State: ACrzQf0QOQiq1jWeo/33GQq/VongOhNqm3Me6kGMBw6EnfrlcL8LOJrN
        qIY/1W041xAqHUADFpZRPzvGbugsQh+Xk0mtAPFG
X-Google-Smtp-Source: AMsMyM4H/2qrz4TmHeWAOhhUYMI5/EmNCvUNzLMtMX8Vc9ozSYRF3abxt24AkFTZGzVPKrT3H89145uv/ujsH6K2/+U=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr15490250oac.51.1665407979148; Mon, 10
 Oct 2022 06:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
 <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com>
 <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
 <CAHC9VhRcr03ZCURFi=EJyPvB3sgi44_aC5ixazC43Zs2bNJiDw@mail.gmail.com>
 <CAADnVQJ5VgTNiEhEhOtESRrK0q3-pUSbZfAWL=tXv-s2GXqq8Q@mail.gmail.com> <df4df4eb70594d65b40865ca00ecad09@AcuMS.aculab.com>
In-Reply-To: <df4df4eb70594d65b40865ca00ecad09@AcuMS.aculab.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 09:19:28 -0400
Message-ID: <CAHC9VhQRywim8vKGUM+=US0nq_fqZH7MShaV2tC14gw5xUrSDA@mail.gmail.com>
Subject: Re: SO_PEERSEC protections in sk_getsockopt()?
To:     David Laight <David.Laight@aculab.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 10, 2022 at 8:54 AM David Laight <David.Laight@aculab.com> wrote:
> From: Alexei Starovoitov
> > Sent: 07 October 2022 22:55
> ....
> > Not easy at all.
> > There is only way place in the whole kernel that does:
> >                 return sk_getsockopt(sk, SOL_SOCKET, optname,
> >                                      KERNEL_SOCKPTR(optval),
> >                                      KERNEL_SOCKPTR(optlen));
>
> Until I add change my out of tree driver to work with
> the new code.
> (Although it actually needs to do a getsockopt into SCTP.)
>
> I didn't spot the change to sk_getsockopt() going though.
> But KERNEL_SOCKPTR() is really the wrong function/type
> for the length.
> It would be much safer to have a struct with two members,
> one an __user pointer and one a kernel pointer both to
> socklen_t.

Yes, agreed.

> It isn't really ideal for the buffer pointer either.
> That started as a single field (assuming the caller
> has verified the user/kernel status), then the is_kernel
> field was added for architectures where user/kernel
> addresses use the same values.
> Then a horrid bug (forgotten where) forced the is_kernel
> field be used everywhere.
> Again a structure with two pointers would be much safer.

Any chance you have plans to work on this David?

-- 
paul-moore.com
