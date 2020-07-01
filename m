Return-Path: <SRS0=4lEG=AM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B382C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 20:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91A12071A
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593635548;
	bh=Qu1PVZWZQB1pW5uORGG9JkdLLWLwrioSV8gFiogltGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vHdBe2u9bSPGWG28cV//4Tuw+QfDw3WHecp0ccgWd00/QgvfHYkuVYzH0DnMCk8KG
	 MdxOhuKJqlQQj0z2L6Os44ssvaqiEUcZ1ka7L6Z37PFrjMVulClx7Yr+Ndei2ZjqT2
	 M2BDJygUaQBZh+0Pd4ioSOuElj0co5Vihtlt9gfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGAUcX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgGAUcX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 16:32:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30BC08C5DC
        for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2020 13:32:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so28809941ljv.5
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2020 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQTuuRnTRD5guY+N3kjgnPLHXT6P3qZiYHrrKJ47r1w=;
        b=M5E2TfLcC3cfW8OMyrKhXxxtIvY0Y104cXmmv3Q4raTCa6ajB/XOROYaclyuBwWh+A
         QwyVYKRQgeqALuvdcW7sv0dw33dOl/5F5gCyZFcJBfQqk4HuU7lj0CC2aelEfwTDdC0Y
         4kjCbqfpjXn7jho9KN1KvD2s7uo+DH0VG6r6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQTuuRnTRD5guY+N3kjgnPLHXT6P3qZiYHrrKJ47r1w=;
        b=hmp1QObcCe5byXxEr+s3D+m0Au2IdGU7HA9qTZwIGN6gm6TEycdosB/nERrMBVLkmn
         xdmMq4Tlz5Cx8EikcsK94s2nJZ/OSMxL1J6BPuqzWenBE4kch8WEnfPn78gWKNkKaewE
         yjO+6q93ePfc0LATlJrt4t6OhMXHSWEIvocsKExyX43+F4s5Gbjv773ruMzcCqJ3wSgY
         +Nu8Ve3mIdHkU93iYomKSVt19CRHhP0RpCRGSZlFxO+bvfrCOgIQ4ThnYsgA3CaXKyBA
         KFo8+2UcjVST7SLfQHqKqL9evU8o6Ncsv4Z2gCBU+/nDG6NSHwikHX1dhvgVMjaSTU94
         NC3Q==
X-Gm-Message-State: AOAM530Yfk2XOWIhIBLlU4cjuh8vWPLbE/1fUqdJB0Z6xNeSKPi0IbKL
        j1lD/xpHhWy5/TdrfdhzH04g7QqUeQc=
X-Google-Smtp-Source: ABdhPJxPf9WWrb0hMMTH5HfhLBd92uSphnYXAbhJba4GhHqRemMz7JM462Of8L7J6ea1sMQv7aOuVw==
X-Received: by 2002:a2e:3c0d:: with SMTP id j13mr7162860lja.306.1593635540917;
        Wed, 01 Jul 2020 13:32:20 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p8sm1797169ljn.117.2020.07.01.13.32.19
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id g2so14508045lfb.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr16119813lfd.31.1593635539128;
 Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161335.1810359-14-hch@lst.de> <20200701091943.GC3874@shao2-debian>
 <20200701121344.GA14149@lst.de>
In-Reply-To: <20200701121344.GA14149@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 13:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYihRm0brAXPc0dFcsU2M+FA4VoOiwGGdVLC_sHT=M1g@mail.gmail.com>
Message-ID: <CAHk-=whYihRm0brAXPc0dFcsU2M+FA4VoOiwGGdVLC_sHT=M1g@mail.gmail.com>
Subject: Re: [fs] 140402bab8: stress-ng.splice.ops_per_sec -100.0% regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 1, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> FYI, this is because stress-nh tests splice using /dev/null.  Which
> happens to actually have the iter ops, but doesn't have explicit
> splice_read operation.

Heh. I guess a splice op for /dev/null should be fairly trivial to implement..

               Linus
