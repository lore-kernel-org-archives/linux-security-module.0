Return-Path: <SRS0=8Njt=PS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F26C43387
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 03:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A722075C
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 03:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="OoCKftlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfAJDSp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:18:45 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46700 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfAJDSp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Jan 2019 22:18:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id t13so3832362ywe.13
        for <linux-security-module@vger.kernel.org>; Wed, 09 Jan 2019 19:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HA5zyPOtM4vpmUe/kE+QiX1RJ0sEYJCbfLsl40THKV8=;
        b=OoCKftlDJzygWNgvYBaP3buuWxH7z7kBCjggWEKlvmRng4H5xLHD8HA8NApLxHswsU
         rNULTiMYdDNtIRKWJgWAf1J1OI3mGHNEECJiUXn8Y3s4NvJLUnjI5yIqFEmvtlX2IdVN
         CtE3TmImFz/bJlwavFuVkB40oCBFiv+hL5pE/1Uq/ktn2I4Yk7wo+te+vSwZFtSG9YPt
         vOy2xjHbe/dTou4DiQAWBz3A0G1TdAtmYCQPF4oL97FHz0scuHJhYXAzz7ZqedEnDWi6
         Ae2srZWRUaciv+sbM0vvcs1VWFofrF+O6rfO0a1drTj34VxnenJeRvIYuLaOs+zFUgLO
         tOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HA5zyPOtM4vpmUe/kE+QiX1RJ0sEYJCbfLsl40THKV8=;
        b=Kwt46+Bazv4s3R2UWFqVc824FC+Qm4ZavVCMBr/M3HDtgI/BU9jxUYVfpa/wRY1WqX
         SvQ6Fbk72rYy2kdCnwUwGVlFWpOg1cuVoLHxHYD9VTTZQXGrEtaR+B7ENDq1UKM3J4Yg
         jADCclCES4MNvmGEiTM+e2xIiyko4a0npJnFP0nrGLNIjHF96dWjeZRxV9uoJ7mt50Q3
         0mKnaGrWkBe4XoTXi1jQRkm6EZjumnqWYLh9cWAJP5kRENMHXLuy5L0uDG9YuIAZcLie
         P5Oou2k1rYnaWOLjdJlYI5lB+ZT7eLznZdSwZlnUvbj3hOCgibnBe7JqE4BeTQPyXGcE
         zFtA==
X-Gm-Message-State: AJcUukfvjzzTJ7A5eIxYFg4NbPW05Mp1fmay1PTAv8S5sTqF8hFf9GeZ
        37kzRdkD/BB3+WPgFTJJbo9rDw==
X-Google-Smtp-Source: ALg8bN4VVPykalmlELDvfKbxQSHq+dg6kMh8zXnKySaMCMixApNQXY9r4fmQa9Hj8RvGTkkQ71IzsA==
X-Received: by 2002:a81:320e:: with SMTP id y14mr8300727ywy.49.1547090323838;
        Wed, 09 Jan 2019 19:18:43 -0800 (PST)
Received: from cisco ([128.107.241.175])
        by smtp.gmail.com with ESMTPSA id g84sm34846911ywg.9.2019.01.09.19.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 19:18:42 -0800 (PST)
Date:   Wed, 9 Jan 2019 20:18:39 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] seccomp: build fix for v5.0-rc2
Message-ID: <20190110031839.GD28330@cisco>
References: <alpine.LRH.2.21.1901090803120.24546@namei.org>
 <CAGXu5j+wvi9t-oHf4cX999aYWMhmTJ1zA1mKuNQEB_n5ixiC5w@mail.gmail.com>
 <20190109065916.GA29753@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109065916.GA29753@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 09, 2019 at 07:59:16AM +0100, Ingo Molnar wrote:
> 
> * Kees Cook <keescook@chromium.org> wrote:
> 
> > This was already picked up by x86-urgent...
> > 
> > -Kees
> 
> I'm fine with both routes - if Linus pulls this I'll zap the x86/urgent 
> one.

The patches are different actually. I've confirmed the one in
x86/urgent is correct, and this one is from the initial thread where I
was just guessing. The difference is HOSTCFLAGS vs. HOSTLDFLAGS for .o
files. So I think we should drop this and just keep the one in
x86/urgent.

Thanks,

Tycho
