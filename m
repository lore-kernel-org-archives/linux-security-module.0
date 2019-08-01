Return-Path: <SRS0=AbGf=V5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B1C19759
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C63420665
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Aug 2019 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564665960;
	bh=o84hDh3hwjL6t8ptSiw35wgSF/zfVCYYjL1H/pzZd8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G5L+RkI4tR9WaCBkxm2h+NHlv9m0+68FJB9MKtBWp1HzZznc5/alZDjygKSKkCLYg
	 bpJ1YcRH65PLpVD1JcQ0vaiJFcIKWDg/3mxP0pa6Vs6SZg2ydEVLJ7eeeTs1T+fzdG
	 07qYRXHoEdThekmrVzF42cnGa5K5t6PYb5YiEgd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfHANZ7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:25:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43066 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbfHANZz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Aug 2019 09:25:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so50240735lfm.10
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2019 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iedXLBO81OU3hcXhff2G+cwDQH73BKJzI4/klgD8xJA=;
        b=gDYeHq/ogPb75MyGO6PFbzPmjAEdLAChmOzpYR6uroQtyUCboqkM2/HMUiu+CaiXyA
         Jp/Vss+HnXIkGQNgBuT3Ja2d4Y+/0xtq2/Syo4cVzXdHfgHvVXRf4qVVkCNi5iTFa2oY
         3tRPr0FtC36H9KKtz9IsTelh6TKdBlg/KppPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iedXLBO81OU3hcXhff2G+cwDQH73BKJzI4/klgD8xJA=;
        b=gJbRXlm/5zyAQBSiosCGI0IxwXO6FTc9vcYxY4mgn2R7sZYjX4QZQe82Vp03MDF9QZ
         KCPpOdco9y6AtN0Et0Rxctk7ORGL34H5/3S0ontwwyfj4k/TaWvaJcd2LrGQpyZHB5Rn
         ZM0uxpyJdplATnVGIcnNSbGW0ZcqbMaBkTiedbHlkEdAzTQ42ohNg1pikExFPHR/8MDM
         7dOGDHOTVVPeCzkXkVp70pzEV5B09cFoe3rTPQk5GsH0eXWsxdqBMVO72WFcXp6C//3V
         gODEVI1qKXB/fw72F+9HcAdlya6rowU6MJSXMVJAfT/1/LAXp6iPcoOPD+s26NzIKEEN
         mL3A==
X-Gm-Message-State: APjAAAWBPd4LbrHecsKlqbJe6U6Z+34ocd2L2upXQDV4yR82evmZHrMe
        UDhb1UHwDxPuf2JlbUgclJfbxHPRJcM=
X-Google-Smtp-Source: APXvYqzBqWigwwT9kYChNEA35u2OXmAjShGqvhBg72q8FpSF18N5yeynDL5SdE4j9IreSIV6JUoNMQ==
X-Received: by 2002:ac2:455a:: with SMTP id j26mr10756978lfm.18.1564665952809;
        Thu, 01 Aug 2019 06:25:52 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w1sm16816968ljm.81.2019.08.01.06.25.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 06:25:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v85so50206112lfa.6
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2019 06:25:51 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr20711108lfd.106.1564665951390;
 Thu, 01 Aug 2019 06:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
In-Reply-To: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Aug 2019 06:25:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
Message-ID: <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 31, 2019 at 2:30 PM Micah Morton <mortonm@chromium.org> wrote:
>
> You mentioned a couple weeks ago it would be good if I added myself to
> the MAINTAINERS file for the SafeSetID LSM. Here's the pull request
> for v5.3.

There's a lot more than the maintainer ID in there. You've rebased old
patches that I already had etc:

  Jann Horn (10):
      LSM: SafeSetID: fix pr_warn() to include newline
      LSM: SafeSetID: fix check for setresuid(new1, new2, new3)
      LSM: SafeSetID: refactor policy hash table
      LSM: SafeSetID: refactor safesetid_security_capable()
      LSM: SafeSetID: refactor policy parsing
      LSM: SafeSetID: fix userns handling in securityfs
      LSM: SafeSetID: rewrite userspace API to atomic updates
      LSM: SafeSetID: add read handler
      LSM: SafeSetID: verify transitive constrainedness
      LSM: SafeSetID: fix use of literal -1 in capable hook

  Micah Morton (2):
      Merge commit 'v5.3-rc2^0'
      Add entry in MAINTAINERS file for SafeSetID LSM

Not pulled.

                  Linus
