Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75901C433E1
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB0E2078C
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590691417;
	bh=LYXtWfNqWbRlHIsJLxFEA9ZSQ83RZwJtt6Vuc/kRjK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WYiqu4Km7GLshkIY52S9RPxWh87u9Ev4h2lDLKWZ587tylPGL+urMUBGif2siQMo9
	 f3lLVrrBKi6oJxKEK2jWgld6dOIk9QwUFM5FhOPWmr4KyKh1mBw59xe5Y1TgIawBiP
	 PFI67Izy68BVglb59ogc6MHqFQMLU11cjzWDrqBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbgE1Snf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391499AbgE1Snd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 14:43:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F40C08C5C9
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 11:43:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so34665744ljm.10
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9I7snvnyR6f67pT5aVMg4qxsNA0F9Vag9hIROGL8vg=;
        b=P8nw8P71cxagqSPVUA9Kzi2wkC951thaYnOwz/e4kiPGKd2Zew+YultOwwJeyFp5h7
         zM7l8zOFEFg42p7pHhMVJLHi7CpftdQASS+eM/OM/B4nVtTeHsdqVgzMglyZy3GmUpst
         EXyW/r86HANnDshbNT+Vi8bmm9fl991ACFIhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9I7snvnyR6f67pT5aVMg4qxsNA0F9Vag9hIROGL8vg=;
        b=T9K9BNSx+XC7HXPAngQ/CJbeMD+36l1oigFpJhOTW1j+UR6t1Gf85e65WyskUMkyXS
         Iom83wB0hCImnH01wLkY07xMllY/8+6yYt7VjUGDmOJA0Viyt6hZZbXGojJG3kNFBOVg
         MiWPC2lDzi32kn1a5JEmnBP30IjOHWAMrLzLCQycZFeJ6tdIR4hoFEVJDXMEds+nGPwO
         fenqdaPg641mAdWjXnfjfYb5XlXGPZC+CsDHfJRh2+kcyUgTFL6J4q4zJHnCfbjckJSR
         igo/qYiod9QFz09nKYbyAxI23zDjyOiay7qdQEErwmhObK6MKekiPXldoGr8vG0r82Mm
         yc6Q==
X-Gm-Message-State: AOAM5331RfpjQKf6HG20jqOAd3UPCf36Svx3J6rWCPQQkTdaGbD0aCk9
        smGq1WUS2FuMXzTrdlGBP3nIrlGWJnc=
X-Google-Smtp-Source: ABdhPJxjeP49udSVLJ4G/lANRnnRNjBxYx2JRukdPS9rTQxOgXfAe82HjywiDjUkDiVR0puGNd0qfQ==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr2062240ljh.342.1590691410916;
        Thu, 28 May 2020 11:43:30 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a15sm1825646ljj.27.2020.05.28.11.43.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:43:30 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b6so34735376ljj.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 11:43:29 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr2040017ljm.70.1590691409213;
 Thu, 28 May 2020 11:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de> <20200528054043.621510-10-hch@lst.de>
In-Reply-To: <20200528054043.621510-10-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:43:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
Message-ID: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] fs: don't change the address limit for ->write_iter
 in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 27, 2020 at 10:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> +ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
> +               loff_t *pos)

Please don't do these kinds of pointless whitespace changes.

If you have an actual 80x25 vt100 sitting in a corner, it's not really
conducive to kernel development any more.

Yes, yes, we'd like to have shorter lines for new code, but no, don't
do silly line breaks that just makes old code look and grep worse.

             Linus
