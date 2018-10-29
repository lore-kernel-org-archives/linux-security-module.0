Return-Path: <SRS0=k4kS=NJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD6BC0044C
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Oct 2018 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FF320870
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Oct 2018 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlvG2fBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FF320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeJ3Ehw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:37:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33179 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3Ehv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Oct 2018 00:37:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id i26so2706243lfc.0;
        Mon, 29 Oct 2018 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OSI8WggWUkh3l9NcpbEVJXbbRwwdMMcVDoCVkF1GW5o=;
        b=jlvG2fBnoHG5x+iuVysZUcCSZwRyOwuGUu4XT/5BtcWg4qD5Ca1AMr2g6Bah7CDluv
         OTXHvjofUsZwK/yUaIQmc2C8l4+ihdpDSmkCNKr4hlkVEN34jd9BRfHEJ2CK5b4GgTlI
         R8blnfOTktWDd9FxkzQoxhdZLXY4ygVDixuP80orUXDM2/0IVI2r8aOR8TK+k8GwIl2O
         5meQc8XATWewoS5+ZG62mxJsgXt3PK1Dw54ahq98PPOZsGbN+hS5saT7pG3M058CetHM
         TQoMCcSpVrY/bQ4I+H/YoGpIflcaumPGSejZZXqZ4IX2PfVLFueK0x+PxJ+NMLKdGLNt
         MRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OSI8WggWUkh3l9NcpbEVJXbbRwwdMMcVDoCVkF1GW5o=;
        b=JPGUk8hwCiWz6DdV3SB+S0G42lktyhL+KrXis1HXKtCPsdp++sHAafF6ixzaS+jAl7
         w9B1KlLf4RwCVSN56ykoYNCrmst7ysG0d6ZHhmystyomKrNbOZrJ4WovNU0+hNYm4GZe
         R3PwL1vYl+L+EqX2zZtN1CwMGlIUOfBU2uy6R8XPcWU8GTtV9qvrAaakEhwW02NxfJEi
         WJsZLDFfMDRM0bazkDFBi154kIvMpNWLytM2/5bQsnKbOi5oXgK/6c6JkLa5gFBFElLU
         lm41h2qpytM9jkMALrr748oWunjTqv3TZDbCol3EYyvGsrOxWOmZX27fllIoj2W9R0Ft
         nyyg==
X-Gm-Message-State: AGRZ1gLyOWWoWW98eRFjdjVaxj0aOcHUU/KSJl5X6JECb1A3l9jM+lcl
        xIiXWIN0YRHu09tws2luFLU=
X-Google-Smtp-Source: AJdET5czUOvlimV4PeoNFQ1TdlBDAaKHwmG0K5rN8i1MnJkAYRy25kta/s5qeeX1KrsHej+Mock5yA==
X-Received: by 2002:a19:ab1a:: with SMTP id u26-v6mr46402lfe.103.1540842461899;
        Mon, 29 Oct 2018 12:47:41 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2075688lfc.61.2018.10.29.12.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:47:41 -0700 (PDT)
Subject: Re: [RFC v1 PATCH 00/17] prmem: protected memory
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181024230345.GE6311@dastard>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <aa37468e-651d-fbcd-692c-aa19d19d9f38@gmail.com>
Date:   Mon, 29 Oct 2018 21:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024230345.GE6311@dastard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 25/10/2018 00:03, Dave Chinner wrote:
> On Wed, Oct 24, 2018 at 12:34:47AM +0300, Igor Stoppa wrote:
>> -- Summary --
>>
>> Preliminary version of memory protection patchset, including a sample use
>> case, turning into write-rare the IMA measurement list.
> 
> I haven't looked at the patches yet, but I see a significant issue
> from the subject lines. "prmem" is very similar to "pmem"
> (persistent memory) and that's going to cause confusion. Especially
> if people start talking about prmem and pmem in the context of write
> protect pmem with prmem...
> 
> Naming is hard :/

yes, at some point I had to go from rare-write to write-rare because I 
realized that the acronym "rw" was likely to be interpreted as "read/write"

I propose to keep prmem for the time being, just to avoid adding extra 
changes that are not functional.
Once the code has somewhat settled down, I can proceed with the 
renaming. In the meanwhile, a better name could be discussed.

For example, would "prmemory" be sufficiently unambiguous?

--
igor
