Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C25C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Oct 2022 15:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJJP41 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJJP40 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Oct 2022 11:56:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE073939
        for <linux-security-module@vger.kernel.org>; Mon, 10 Oct 2022 08:56:25 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-131ea99262dso12911050fac.9
        for <linux-security-module@vger.kernel.org>; Mon, 10 Oct 2022 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBlJGaToZEu6D+RvSCyaxxmx/t2AwVYuPW5gPgMk1tk=;
        b=7tmLSoXRtJfH4Dbqoikvsfh+/gCulAYIx1NWrvmt1/bxZ67ZOUWZ5K/xrU2OfEpG1f
         Rgl678+XBpgr/SDRuN4IqJ/YhV4Xbe+LDX6unNVPmsuTisLqfNr7/LEOnRjKWgAhKMGI
         6R2S6gpT9InaefaMZ33djbJe3Oeg5sifZ2SNHzyNzDu4QrfRGS6GRuRjE4hQlZV04YIo
         sVRYmrFMPmaNs7QE6I9BRei46/v+FGizKrTFY2yTY+Wf3pS+MRFLuy43CuqDfFRxyCYr
         LJaDMo9Yerb9kPup/5YnxIs8AMcaFd6t1bQ6eiobj0LLGjE+kZDPShNKAi4F2s0bMIq0
         atjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBlJGaToZEu6D+RvSCyaxxmx/t2AwVYuPW5gPgMk1tk=;
        b=mz25cEzSyDoEMd4NYLWn1w9r5DII/CEJK71vHiZ26wMvF1j/MQLJ5Ya1ILUXRDFWjd
         4NJPPMTa8RcqJcxqXUP4R67iUd3VXikWSfbiB2IwYnl7XQLLZTfkVOkTRcBv1ifY0FAG
         vkK7w9+oI4nuyBD5oBRHjPir8nt8mhq4RoB06F9FHfc2USX5cTxCpPpYTV1Q/81nNdQW
         hlT5gCQK3JwSUhTD3qnRIBdur3dbDw5q32w0btY0JnYAsuZJx1hhYT3Kd/vJbZ1Ejdwj
         o6gc8PXkwjPZZv07y1PPr+g9420x+14iUsDTS4kXBJB6PFZpqBFUFfg/t8XRcII2pow2
         CzaQ==
X-Gm-Message-State: ACrzQf00vl7qNAxlDF+mtnCL14/fDwF5YXNAcoyRlRN3jst3EymFVNbk
        kEvE9REAXpSYFh3NQASsQXQWpVj3MxLHuplkdBFE
X-Google-Smtp-Source: AMsMyM7E58PKEIMT2pMlaK++ErltMfDSbBzoHG8lkSaC1jHVQXN22/TbjZ4o5ZhdmawyCSdC9gyK7IrpZVO6jOcWxRw=
X-Received: by 2002:a05:6870:9612:b0:136:66cc:6d5a with SMTP id
 d18-20020a056870961200b0013666cc6d5amr5406856oaq.172.1665417384952; Mon, 10
 Oct 2022 08:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
 <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com>
 <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
 <CAHC9VhRcr03ZCURFi=EJyPvB3sgi44_aC5ixazC43Zs2bNJiDw@mail.gmail.com>
 <CAADnVQJ5VgTNiEhEhOtESRrK0q3-pUSbZfAWL=tXv-s2GXqq8Q@mail.gmail.com>
 <df4df4eb70594d65b40865ca00ecad09@AcuMS.aculab.com> <CAHC9VhQRywim8vKGUM+=US0nq_fqZH7MShaV2tC14gw5xUrSDA@mail.gmail.com>
 <ffe2b21ce6e04b07891261641b4d1f5b@AcuMS.aculab.com>
In-Reply-To: <ffe2b21ce6e04b07891261641b4d1f5b@AcuMS.aculab.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 11:56:14 -0400
Message-ID: <CAHC9VhTBdLtK_spOS9axuYfHRb=zx3TFqKY2cvfy9tRd0ep-sg@mail.gmail.com>
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

On Mon, Oct 10, 2022 at 11:34 AM David Laight <David.Laight@aculab.com> wrote:
> From: Paul Moore
> > Sent: 10 October 2022 14:19
> ....
> > > It isn't really ideal for the buffer pointer either.
> > > That started as a single field (assuming the caller
> > > has verified the user/kernel status), then the is_kernel
> > > field was added for architectures where user/kernel
> > > addresses use the same values.
> > > Then a horrid bug (forgotten where) forced the is_kernel
> > > field be used everywhere.
> > > Again a structure with two pointers would be much safer.
> >
> > Any chance you have plans to work on this David?
>
> I'd only spend any significant time on it if there
> is a reasonable chance of the patches being accepted.
>
> My use would be an out-of-tree non-GPL module calling
> kernel_getsockopt().
> The main in-tree user is bpf - which seems to need an
> ever-increasing number of socket options, but support has
> been added one by one.
>
> While most getsockopt() calls just return set values, SCTP
> uses some to retrieve the result of values negotiated with
> the peer. The number of valid data streams is needed for
> even trivial SCTP applications.
> However I've a workaround for a bug in 5.1 to 5.8 that
> returned the wrong values (my tests didn't check negotiation)
> that also obtains the values on later kernels.
> So I'm not (yet) in a hurry!

It looks like it might still be a good idea to add hardening/support
for the LSM hook as your needs still seem a bit far off, but I
appreciate the background - thanks!

-- 
paul-moore.com
