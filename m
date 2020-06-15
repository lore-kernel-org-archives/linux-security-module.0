Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D95EC433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF13F207D4
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdDL5AnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgFORDV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFORDV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 13:03:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B758CC061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 10:03:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so20051586lji.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+e+6oiMfPcuzfOioIuAZY78N0uqSVxHMMheHIvnJFI=;
        b=ZdDL5AnKuDKjT78TYGdiLM90FU4CSgVPQvBPwBxI4352g9rT5orcRSoCEyhOgCzmrb
         4e5RDz3iPk4xgm/IQFSISxou4eEhtOFpaahQc3QKC4aym1agnSpfRVXS8vTqXb2Plmrd
         JE+g5jt9NSl4Bg3MUUdIcJO1AZwUTx6w0nfikkonIXSuSDXlbWYxbECK8lmFLj4afdYC
         HrXWm/+8PH0LuJZpduXLjdnuoL+cnyvy/wanzTOdUAr9jrz/ji7YRX+MTUSO0WBJYFXJ
         eCTY/xUIKoC3WPvskinA4vXddp2oIjFSeL+i1Yt4RZNpAH1rkFIT1NsfcEEsKZQU8Oth
         aD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+e+6oiMfPcuzfOioIuAZY78N0uqSVxHMMheHIvnJFI=;
        b=qJq/kkd8kAbg10qTXMTutoKeXvoEzgrRuI5fm3n4lXod+Uh2Vx7Vvh6t/AWbyGarub
         klFgvhIZTIcYVP3kuq7RXQENrgKdttMs8jh0U0D7uP3YQi+lcwYr8zHSdk6PCX4unmeJ
         M8IyHakg6Gt1MgATiIX4JeODTrkbTbFap+at4Rl7ovZrkDgsdmoyG0ls2COrYT1hFyyC
         nIGiboxsR+TqCSROTdTpDLjCLuJ7v3MrECLRsdrGOCWNW5y5cvjpvqcwO4yKhnBIxjht
         7R3jSbfK+13OGtFEefMzDwCE6sT1/WTxHQR4D+RlIlLjDoqWTN2uvPrHErPdAry7VHNc
         yGgw==
X-Gm-Message-State: AOAM530HLxBi4AXyNJKsgEoeKuVfVlvCfsYAGK8DmTynAxhEawwT1J6h
        STl0ttRkG8OPwlyQdqb3MX0Q6yG1VCyC1nCsCUlxzA==
X-Google-Smtp-Source: ABdhPJxKghjauWCQ06S7R7giwAOWLRv8YnNXKPN82l+nvWY9jbQW3XjbsykSVqW3lMHbTPuJcLGB8eKa4JCQbYJKd3Y=
X-Received: by 2002:a05:651c:38b:: with SMTP id e11mr12109574ljp.415.1592240597617;
 Mon, 15 Jun 2020 10:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <206DB19C-0117-4F4B-AFF7-212E40CB8C75@oracle.com>
In-Reply-To: <206DB19C-0117-4F4B-AFF7-212E40CB8C75@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Jun 2020 19:02:51 +0200
Message-ID: <CAG48ez3fQbBLUBUkSaF-0b_DhL8M_1JU4DKkjTYXGB_6G1RgiA@mail.gmail.com>
Subject: Re: [oss-security] lockdown bypass on mainline kernel for loading
 unsigned modules
To:     John Haxby <john.haxby@oracle.com>
Cc:     oss-security@lists.openwall.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 15, 2020 at 6:24 PM John Haxby <john.haxby@oracle.com> wrote:
> > On 15 Jun 2020, at 11:26, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Yesterday, I found a lockdown bypass in Ubuntu 18.04's kernel using
> > ACPI table tricks via the efi ssdt variable [1]. Today I found another
> > one that's a bit easier to exploit and appears to be unpatched on
> > mainline, using acpi_configfs to inject an ACPI table. The tricks are
> > basically the same as the first one, but this one appears to be
> > unpatched, at least on my test machine. Explanation is in the header
> > of the PoC:
> >
> > https://git.zx2c4.com/american-unsigned-language/tree/american-unsigned-language-2.sh
> >
> > I need to get some sleep, but if nobody posts a patch in the
> > meanwhile, I'll try to post a fix tomorrow.
> >
> > Jason
> >
> > [1] https://www.openwall.com/lists/oss-security/2020/06/14/1
>
>
> This looks CVE-worthy.   Are you going to ask for a CVE for it?

Does it really make sense to dole out CVEs for individual lockdown
bypasses when various areas of the kernel (such as filesystems and
BPF) don't see root->kernel privilege escalation issues as a problem?
It's not like applying the fix for this one issue is going to make
systems meaningfully safer.
