Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F43C64EB1
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4377D20868
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 11:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yrfh+HiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4377D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLGL5U (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:57:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32970 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeLGL5T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 06:57:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so1871705pfb.0
        for <linux-security-module@vger.kernel.org>; Fri, 07 Dec 2018 03:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5n9L0IcDFv5lcT6j3ghjOA/ga73n6c00Zuhsde/qtRo=;
        b=yrfh+HiNiMUgFDK2quCiW5kBajACzONkxlK1HM7EWFboN0JeAKtC2U6EupTNjwRAyH
         50NhPADjYJ/XtiH2U4bGuO6dNcROBUhud4RMl3quzhxlPtWpZHcd26Mjeio/ig9sYqok
         TEIBpJhId3qF/8wV6K2+sFoSaE6P11332mzjhvtYnKbT+M8TTNNNHVyCkGWuXoUtZb8D
         SJGKCZunMmsp3wdiBCR37eu3Y2iqYT2fmhIDOJNJbVkgRRLb9COJuzoYyhHR1cmFemhC
         onlv7d15YXw3WoJTzdwD9m9kgjm6+m8H7WKcQHVCVNY8gAO27eLzqUJR47tco53aCEME
         UCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5n9L0IcDFv5lcT6j3ghjOA/ga73n6c00Zuhsde/qtRo=;
        b=ud6TUt4lzHnrn9TUCOYvSmTSL9zvk5mIYlLqUyNrsSfE+27b5rFDXUVLm7HVbe87ji
         DdtIOm4hXTvWWht5hJFRgpW8RgV/UEDNk/3r2wRUJe3v2lcqdWTzeVvNu9F7z5K/BRoh
         Ylg8nNIwc2cZeCiowwTR0B7LYw9J1fM7ajyii6ft97UZIM2LggeAAcEj4JGcB1uato21
         BhwP2O3vXxQiNPYWc6BDNM8D7EQ4vcHClZ3+w0SkWANNqP+XPUs6W/rOP2n1TJm/JqaK
         r0/XtQZOvb4Tzjo73JTvoGrAD1Xx8RfrGpajnZGlUXpWIfi6WWSd2rPBA8v87UE7xxbs
         rFFQ==
X-Gm-Message-State: AA+aEWaBRU58nNhfDRAxquY4AlIQyS+MYcsLpH5c0GUObCz6DIUTmXvh
        81PxN06uc60eBYRAjSjy4gZ9uQ==
X-Google-Smtp-Source: AFSGD/WpmtzQYlAq9hx7ZGoS3vLF1UAwy1BL2CWsaLWBYqxge81CaxI3xGZF6Jg/Apbt3S+60b4X6Q==
X-Received: by 2002:a63:5907:: with SMTP id n7mr1638943pgb.435.1544183838675;
        Fri, 07 Dec 2018 03:57:18 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id a73sm5412368pfa.7.2018.12.07.03.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 03:57:17 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A97E13000CA; Fri,  7 Dec 2018 14:57:13 +0300 (+03)
Date:   Fri, 7 Dec 2018 14:57:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-ID: <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 05, 2018 at 10:19:20PM +0000, Sakkinen, Jarkko wrote:
> On Tue, 2018-12-04 at 11:19 -0800, Andy Lutomirski wrote:
> > I'm not Thomas, but I think it's the wrong direction.  As it stands,
> > encrypt_mprotect() is an incomplete version of mprotect() (since it's
> > missing the protection key support), and it's also functionally just
> > MADV_DONTNEED.  In other words, the sole user-visible effect appears
> > to be that the existing pages are blown away.  The fact that it
> > changes the key in use doesn't seem terribly useful, since it's
> > anonymous memory, and the most secure choice is to use CPU-managed
> > keying, which appears to be the default anyway on TME systems.  It
> > also has totally unclear semantics WRT swap, and, off the top of my
> > head, it looks like it may have serious cache-coherency issues and
> > like swapping the pages might corrupt them, both because there are no
> > flushes and because the direct-map alias looks like it will use the
> > default key and therefore appear to contain the wrong data.
> > 
> > I would propose a very different direction: don't try to support MKTME
> > at all for anonymous memory, and instead figure out the important use
> > cases and support them directly.  The use cases that I can think of
> > off the top of my head are:
> > 
> > 1. pmem.  This should probably use a very different API.
> > 
> > 2. Some kind of VM hardening, where a VM's memory can be protected a
> > little tiny bit from the main kernel.  But I don't see why this is any
> > better than XPO (eXclusive Page-frame Ownership), which brings to
> > mind:
> 
> What is the threat model anyway for AMD and Intel technologies?
> 
> For me it looks like that you can read, write and even replay 
> encrypted pages both in SME and TME. 

What replay attack are you talking about? MKTME uses AES-XTS with physical
address tweak. So the data is tied to the place in physical address space
and replacing one encrypted page with another encrypted page from
different address will produce garbage on decryption.

-- 
 Kirill A. Shutemov
