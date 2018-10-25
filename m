Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9617CC46475
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1032054F
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hD0XyUca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1032054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeJZFFY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:05:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38955 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZFFY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Oct 2018 01:05:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so7812854lfc.6
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ubu7hiIXp/Cf6M28prv4hk/vUOl9HoBHNpLAI80hflk=;
        b=hD0XyUcaGfWNSl6iBi87qv+OBvn5MN0p6OAAm0vvFAd8wiH0zqJj+6DKQ3nFAcsLq4
         yfsU2OQDanDEokJA9o3r93bR2EI9GDCSJDPL57evETouJk9D/DCk+n19ApFkbLVx0ICL
         Kvzy+8YWEejbVXg79Ur37NAxgG6Vqq6KsLzNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ubu7hiIXp/Cf6M28prv4hk/vUOl9HoBHNpLAI80hflk=;
        b=l7AmmRb49jyBHZ7tAL0a7FbDXYXHF/4R0gG3XPuMS0WaDXsUD3hPrP+nwym1dvJO4A
         i9fwUkyH6JCzXfpOcpnTaMe4LE3QFmYzrqJKfQiG4bLCvkQ9T6JL2pWGC6JnIV2WzhBF
         UnYyQS/SSFV2DOPEt8Oav/O0S/xrl8SkHAm+X9rQKiw9wk545bldOLBOedPFspaiDzmL
         7XiX19OzE9h04BQEvY99VCPF40Lv2EbBgbNFNaaoTrE644ldcub4DbNmf0EPgRQp0iXx
         kuThrY8JBcCIxllnE6wNBg48XyfeqIruWDUFF3wpmxAnXV2V1miziYnBAbFNKHhq8Ky8
         KRKQ==
X-Gm-Message-State: AGRZ1gLSDz2ubpJNOrxvPlEv/PYyAYLumpGeJPbXY1ujqQvd3Oi7x4hn
        csBKEczJggHGaEznz5iOJRType7uiplAEA==
X-Google-Smtp-Source: AJdET5daQK30vuan8FBuuWdKhxNrJJlNzRnzkBbPOwVlhAyRVQ5nDYK5z6FA9J3VLUSv1uXBmx/l8Q==
X-Received: by 2002:a19:10da:: with SMTP id 87mr450814lfq.60.1540499469686;
        Thu, 25 Oct 2018 13:31:09 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t15-v6sm1265019lji.75.2018.10.25.13.31.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:31:08 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f3-v6so348573ljk.9
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:31:08 -0700 (PDT)
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr530691ljj.6.1540499468327;
 Thu, 25 Oct 2018 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252035220.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252035220.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:30:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwjHF9NrHY6Vii3gSz8aKVgjPZwAvA78R+t3t6iq+L3A@mail.gmail.com>
Message-ID: <CAHk-=wgwjHF9NrHY6Vii3gSz8aKVgjPZwAvA78R+t3t6iq+L3A@mail.gmail.com>
Subject: Re: [GIT PULL] security: Smack updates for v4.20
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 25, 2018 at 2:37 AM James Morris <jmorris@namei.org> wrote:
>
> From Casey: "Here are three patches for Smack for 4.20. Two clean up
> warnings and one is a rarely encountered ptrace capability check."

Pulled,

                 Linus
