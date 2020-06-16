Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A6FC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 18:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D34207C4
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dgp70rXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgFPShx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgFPShw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 14:37:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6FC061573
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k6so3810605pll.9
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LbWK89MuCvj1Sl4N39K4jNgkLJl8ySKC6ZW5gbfqTIE=;
        b=Dgp70rXHX7fnmUeMFYCfX+qP4dQ0ouFW9JvgEAXf8RQjWuosjN4K2kcoDDx3X6EGCd
         gqfzfT1evQX/H5CFii9INhsHzWc/0QRxoWNvDEje7IgWDjZAqzWwG4SFM5nnDGXrCvGq
         oYg/+EWEPEqiUnTNTUA8nUAAYg8FfdFtj7PQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbWK89MuCvj1Sl4N39K4jNgkLJl8ySKC6ZW5gbfqTIE=;
        b=mfp4DsN21FUZD2crBl33xaMDaabqI/M3amb4YrILBdtptX2Y+XTJrV6/xVUXJyhuLR
         iiMUn0qVZPHk9kuoOsAJcY70GN531gzwNetpEXco74MtTwSbsv6h/ZPUor2szvlGsI+X
         FyCbpNh5DP9jojG77Q15PLICdiCc7JJGGAy/cyQSqpXNd1YZ4JVT6fRVzyDcahK8Ootc
         AHvYOC3SvTX5vjWZzfl1n87/w3S/c4jDLDNONSiyZvhN+uYokTF6zVSR9AoU4mBUf5EK
         o3FiuB9OnIj2CkrqnWMXDjeyQCRwTqXt22REeeQwhlk8xaZMrAqhLwtLGXYASpXpn0gZ
         pN1Q==
X-Gm-Message-State: AOAM531+I94eM9RT3AMt4jBTDHIh0zEIfGZnV9ajyW25BYf4ymwItwgG
        xJdOjEmKVLFtQBTAeX1xb80Q1A==
X-Google-Smtp-Source: ABdhPJzfKYAOTTy2Indkj4vuMYGO+9jnZ8oJ5woe6pxlS8gYmHIPPkUqYdSfRMXeUnQd3cx/XtTqWw==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr3308489pls.106.1592332671017;
        Tue, 16 Jun 2020 11:37:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a83sm17453213pfa.146.2020.06.16.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:37:50 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:37:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 6/8] x86: Provide API for local kernel TLB flushing
Message-ID: <202006161136.524AA1C@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-7-keescook@chromium.org>
 <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVSnLAkWN_b7rNY1mbF16qXavbXYtv9fVZA-Q4ZVnTXhQ@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 09:59:29AM -0700, Andy Lutomirski wrote:
> On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > The seccomp constant action bitmap filter evaluation routine depends
> > on being able to quickly clear the PTE "accessed" bit for a temporary
> > allocation. Provide access to the existing CPU-local kernel memory TLB
> > flushing routines.
> 
> Can you write a better justification?  Also, unless I'm just

Er, dunno? That's the entire reason this series needs it.

> incompetent this morning, I can't find anyone calling this in the
> series.

It's in patch 4, seccomp_update_bitmap():
https://lore.kernel.org/lkml/20200616074934.1600036-5-keescook@chromium.org/

-- 
Kees Cook
