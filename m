Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4444ECDE46
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880552054F
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EpkZecDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880552054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeJZFHV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:07:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45268 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZFHU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Oct 2018 01:07:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so9471031ljc.12
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3F1HmxSHrZUW1vm0fTyKVjpWBWe8A501fSMloOg8qQ=;
        b=EpkZecDSFQ+JZNVSHb3xyzdcKuwr7rlMkF0wv4M5YXLF2SbogKgBwJp4R4+cr3qbuz
         fDrd/l8PpRHkJ1SWvukmKtC46JBpqXyLd0GRpkijfgqlGDfQLQNI7EoefkrepUUTXERG
         1y1IP496C+bD6pjpMHEXdJ5B4yb1ZK9ml1zzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3F1HmxSHrZUW1vm0fTyKVjpWBWe8A501fSMloOg8qQ=;
        b=Au/0vl2Fb7y2CZWNhCko1Oz7SWQL4zYRfSZbALlVMTuQJVBNOcrc+SlpC1cPablitm
         PPUdmX/tmd8E//fTR4L8JXMnbcJYSatG0jI0Mbl+trQtLN9ahRDlFDlRE8O9NF2C5JS3
         Mfq427CrW6J1sVt0b/SVYtaLyVodwWLWw55knf5vnBt1WYH7oxFa0ip8GjS5hDEvSoDm
         qCM0LhwPnxuEjR8q8UuYlH9EHFSCEuW3Ug2AYXi+KpNUhTW9JGh5u5YsP7sG/fa2N/ld
         ejk5bIhkFWO4fmcvf/Bq1Zqmott4za2D4jIzkT0Sq1m7kmfS13mRy549pclAPAFOq7ig
         8O9Q==
X-Gm-Message-State: AGRZ1gJ3wY1z3o8Dl7PiuaJedYtn6wC3zqg0Rkih4Ku3rIux7ZpSsdWk
        YyT7fAzhV/p0dulGk2LjFZvE1d0SjwHDGg==
X-Google-Smtp-Source: AJdET5d2fxn3NOeKxYysLfKRs7KBMjqrAW+PgT/rgYe3/+3ueVnvxfr+bEQBUgTYjV2UQpS8aylwNQ==
X-Received: by 2002:a2e:9dc4:: with SMTP id x4-v6mr482612ljj.133.1540499584728;
        Thu, 25 Oct 2018 13:33:04 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id r10-v6sm1421532lfi.15.2018.10.25.13.33.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:33:04 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id k11-v6so9472910lja.5
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:33:03 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr445405ljh.59.1540499583375;
 Thu, 25 Oct 2018 13:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252038150.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252038150.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:32:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaCGkKadx3+C8RVRdA33kRMPH+7DYSm1VcetBc47CJ7g@mail.gmail.com>
Message-ID: <CAHk-=wgaCGkKadx3+C8RVRdA33kRMPH+7DYSm1VcetBc47CJ7g@mail.gmail.com>
Subject: Re: [GIT PULL] security: LoadPin changes for v4.20
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 25, 2018 at 2:39 AM James Morris <jmorris@namei.org> wrote:
>
> From Kees: "This is a small reporting improvement and the param change
> needed for the ordering series (but since the loadpin change is desired
> and separable, I'm putting it here)."

Pulled,

                Linus
