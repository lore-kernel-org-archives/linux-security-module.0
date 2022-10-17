Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46DC43217
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Oct 2022 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJQSLJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJQSLI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Oct 2022 14:11:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173C674CC1
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 11:11:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h2so4156031plb.2
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wk/AfKxmKFFMFtDOBSmyqEUOU7F5xvb3yjHU7rI31n4=;
        b=aIwed63klUDo4ZfnVYo5sFh2Wh9Cyo0Wi7mucCNbpPn+JH2k43Rp/Z8N8K9lf7ujVP
         io8FvnbDY9GHHeAs7p9DDW7PmTsDVyNZcakall+CN5pHextcQxGmP1YY/SIzQ4yZY1K1
         WQcSquaAKvf1om/K6J20YizK63oKDrlaZTL38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk/AfKxmKFFMFtDOBSmyqEUOU7F5xvb3yjHU7rI31n4=;
        b=bMAM0d6S0YKKnEZPMWTYmoxXzyDonZlnhpKruGM/NbHzCs7JB1myOz5Q6vBUaKkybV
         kq49nnVbaCtc1Gu1ENQbXy8ei0zD2XUGun6zIeBITQO/8J0p3ugpwMkZHCV34TrTmZd+
         ngtfLZ9fJstFpzxSu9WAeaOJTv92C5N6/ir4cMiZKGhpgpT0I1K4mfu1sEBI3K2GjZAc
         DtoSYao+WzSnzazMRKCK/ALHnDJaEFUB2Q/VAQIXg5z9HD4JtCIIiVQ+478LFnhy2MbF
         eGgV3GHjD13xQ8ZqLi2n7nVBVOketVr+2Z3spMaRKp+FACYS/MX0CoYwubofxWol16a0
         a6wA==
X-Gm-Message-State: ACrzQf0S10Br3CA26BV9uXxYuL8TM5E9N+0sO8G41/+jHwZWIc4oP8ZA
        Yc6KEHF4thSgsEaOr4YPnzc6ZQ==
X-Google-Smtp-Source: AMsMyM7+VVMBV+Yo7/YZZ4yIOQlr/fUEzxuXTxelzcdrHHW0YYgHQNR/3QsalaLB2/Y7RM/OwQi9Nw==
X-Received: by 2002:a17:90b:f02:b0:20a:9965:eeee with SMTP id br2-20020a17090b0f0200b0020a9965eeeemr14825583pjb.182.1666030262802;
        Mon, 17 Oct 2022 11:11:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b00177faf558b5sm6897713pls.250.2022.10.17.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:11:02 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:11:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Message-ID: <202210171101.2E96A7D557@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
 <202210141050.A8DF7D10@keescook>
 <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 17, 2022 at 11:26:44AM +0200, Mickaël Salaün wrote:
> 
> On 14/10/2022 19:59, Kees Cook wrote:
> > On Fri, Oct 14, 2022 at 04:40:01PM +0200, Mickaël Salaün wrote:
> > > This is not backward compatible
> > 
> > Why? Nothing will be running LSM hooks until init finishes, at which
> > point the integrity inode cache will be allocated. And ima and evm don't
> > start up until lateinit.
> > 
> > > , but can easily be fixed thanks to
> > > DEFINE_LSM().order
> > 
> > That forces the LSM to be enabled, which may not be desired?
> 
> This is not backward compatible because currently IMA is enabled
> independently of the "lsm=" cmdline, which means that for all installed
> systems using IMA and also with a custom "lsm=" cmdline, updating the kernel
> with this patch will (silently) disable IMA. Using ".order =
> LSM_ORDER_FIRST," should keep this behavior.
> 
> BTW, I think we should set such order (but maybe rename it) for LSMs that do
> nothing unless configured (e.g. Yama, Landlock).

Ah yeah, good point. the .enabled stuff will need to be correctly wired
up. Anyway, it's a good starting point for the conversion, so I'm hoping
it can be carried forward by someone who is not me. :) (Hint hint to the
integrity folks...)

> > > Side node: I proposed an alternative to that but it was Nacked:
> > > https://lore.kernel.org/all/20210222150608.808146-1-mic@digikod.net/
> > 
> > Yeah, for the reasons pointed out -- that can't work. The point is to
> > not have The Default LSM. I do think Casey's NAK was rather prickly,
> > though. ;)
> 
> I don't agree, there is no "the default LSM", and this new behavior is under
> an LSM_AUTO configuration option.

The "config it twice" aspect of the current situation is suboptimal,
yes. Let me go comment on the old thread...

-- 
Kees Cook
