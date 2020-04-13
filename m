Return-Path: <SRS0=fcCn=55=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B86C2BB1D
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Apr 2020 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D793320692
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Apr 2020 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586803386;
	bh=uhoZuMrO5BqkZOUD83qRbvqECeDmnsZILh54dVWMe/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j/9wNaU6mcwUQQnsNYD8AgP99iXdX/ofgkxtwAdxa6Dc1bIdODBdjesasUFNbu/+m
	 nsiUBZlIttmhOrNHuJnUzLAbUxWjaFqWmlRERtuF6W/NozDGKf1JXZlp2JbYorXDae
	 Qo1x5Rfu2f46Iv6lowiZnqsAEbmcjHEkg91UNSag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbgDMSnE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733067AbgDMSnD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Apr 2020 14:43:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EFDC0A3BDC;
        Mon, 13 Apr 2020 11:43:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so7583797qtv.3;
        Mon, 13 Apr 2020 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9hdOyb+Q0mokX/44CwUiOk5xqFj7SYWIPZ+lCG7T0Eg=;
        b=Kr9vO3PMsgCeOyFWhO3TclJuGWbs0fHJc2AQA/LmQCGhLqsm5iDtr/GcnANGo/OM3o
         KoRhQfZLMOcf9LqLKw9VUUol0zQmx9m48N01HKzdS+cNkKFmU1R9ANNu48Io0ip4VsLA
         xgWlYxpDYPP/kex3O9362IwKK1Qi0dcXIs7xJi8Trxi3tSqpdxfmUIuNvqTN+rq2uxqa
         +gKc5WUlclLNcMNdYMeApePAtb7m9ZaAbOkV0i42+yd4fm3e/uhcE4ydDIj4aTJ+rPr0
         x5YwDs2/H0omUWxqjCnnP1d5aANFrnG2xTJtU3wuna9/0xLMgy4id0Rl0koe65gBtn5M
         JluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9hdOyb+Q0mokX/44CwUiOk5xqFj7SYWIPZ+lCG7T0Eg=;
        b=MCCMPRRTyaev8Ryqc16o7OFKXsnlQ5pUxtSCSibUUd/91zOP6YLjt+2tCucP4n2gA9
         bNZJdaffB9FtbvzBcBWdQgwhWOh7T0s3gIVQvne0Fw1byhtS8rKR035hZuJ6t95aku8Z
         mSarH0LIMO4MM/GHDz3ZD/dTW/ilqUekKyxgmHizyhfdsHOjii+bWjxSwx0Uj+tv7Jtg
         q+FqoQS7dNclBj2Yavm0qiqsjZTS0riong86WkPQOUIrSl18R/88U64aibuBeStbXrRF
         B+j4WqGLTp6SloNn1Lqt2UCBBkaVfgh4SMaGBEwaB+rDoqgTNA6X9C4wHWXT0spSe4hX
         ZYHQ==
X-Gm-Message-State: AGi0PuZFEDAv5Cb5eEzKrbcUXJ73Krwalr3IkyG43RC0dz9qUOAN3CCN
        YTEictjqKlj4lu1fh71l9fA=
X-Google-Smtp-Source: APiQypIPdW/QJJZqLP/TkerWlwHpaMuPK/bLBUC9J5nqxzuhhRMaFL7EwWWnl1+xrYlNcjysRl71yA==
X-Received: by 2002:ac8:27f9:: with SMTP id x54mr12450620qtx.45.1586803382293;
        Mon, 13 Apr 2020 11:43:02 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id z3sm9060905qtq.7.2020.04.13.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 11:43:01 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:43:00 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@ugedal.com>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harish.Kasiviswanathan@amd.com,
        guro@fb.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
Message-ID: <20200413184300.GE60335@mtj.duckdns.org>
References: <20200403175528.225990-1-odin@ugedal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403175528.225990-1-odin@ugedal.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 03, 2020 at 07:55:28PM +0200, Odin Ugedal wrote:
> Original cgroup v2 eBPF code for filtering device access made it
> possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
> filtering. Change 
> commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
> reverted this, making it required to set it to y.
> 
> Since the device filtering (and all the docs) for cgroup v2 is no longer
> a "device controller" like it was in v1, someone might compile their
> kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
> filter will not be invoked, and all processes will be allowed access
> to all devices, no matter what the eBPF filter says.

Applied to cgroup/for-5.7-fixes.

Thanks.

-- 
tejun
