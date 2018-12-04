Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647EFC04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BBD20834
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 20:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZuq3yTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BBD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLDUAz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeLDUAz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 15:00:55 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC4F2154B
        for <linux-security-module@vger.kernel.org>; Tue,  4 Dec 2018 20:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543953655;
        bh=tnRqBL84RFMkmg3g7qCHeyfaOxf4C+DW7ciGqa+hfJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DZuq3yTF72dT6Mh8jVC2qMzMp5W/ly8it0lyLAM4YY9TihfwohnGmg5KVBYXt3LdP
         eSy9mEFgJoLaGhdxVbC1qSydu/02SV69nBrXsDOhidLbgDm4HBDfL2JKGoF9eBnjNI
         vYsndaNXyo2WNZm06cuyAK6yPS5ui/f+klzwUxcI=
Received: by mail-wm1-f52.google.com with SMTP id s14so10950785wmh.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Dec 2018 12:00:54 -0800 (PST)
X-Gm-Message-State: AA+aEWabQdBRfjiWYgMUF50KDtuVqP0NpvUV5dyooep3JCIEHj/8/RS/
        FuuTr7ePvYyM23POJR7R2Gwnx0d37sask5firKWJew==
X-Google-Smtp-Source: AFSGD/VT36ibHLtIjdCEfXG794eclUyBjTWMPOY554fHMWGdk3M/f63MKZK0dMgf3nOkDXFlOljC/TSzcOZ5xl8jH+w=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr2894982wme.108.1543953653038;
 Tue, 04 Dec 2018 12:00:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com> <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
In-Reply-To: <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 12:00:41 -0800
X-Gmail-Original-Message-ID: <CALCETrXM_nQMFHsAfQGqqURL3=B46AXdiG+4p8Mpm6n4cOqXsw@mail.gmail.com>
Message-ID: <CALCETrXM_nQMFHsAfQGqqURL3=B46AXdiG+4p8Mpm6n4cOqXsw@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     alison.schofield@intel.com, Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, kai.huang@intel.com,
        Jun Nakajima <jun.nakajima@intel.com>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 4, 2018 at 11:19 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 11:37 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >

> Finally, If you're going to teach the kernel how to have some user
> pages that aren't in the direct map, you've essentially done XPO,
> which is nifty but expensive.  And I think that doing this gets you
> essentially all the benefit of MKTME for the non-pmem use case.  Why
> exactly would any software want to use anything other than a
> CPU-managed key for anything other than pmem?
>

Let me say this less abstractly.  Here's a somewhat concrete actual
proposal.  Make a new memfd_create() flag like MEMFD_ISOLATED.  The
semantics are that the underlying pages are made not-present in the
direct map when they're allocated (which is hideously slow, but so be
it), and that anything that tries to get_user_pages() the resulting
pages fails.  And then make sure we have all the required APIs so that
QEMU can still map this stuff into a VM.

If there is indeed a situation in which MKTME-ifying the memory adds
some value, then we can consider doing that.

And maybe we get fancy and encrypt this memory when it's swapped, but
maybe we should just encrypt everything when it's swapped.
