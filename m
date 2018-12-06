Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D5C04EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 11:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD97208E7
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 11:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="oR43NioU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD97208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeLFLXB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:23:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34015 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbeLFLXB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 06:23:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so40916pfg.1
        for <linux-security-module@vger.kernel.org>; Thu, 06 Dec 2018 03:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypEXTIe5gdU9ETWQ6e76F6P/oA26cHe6qZw31vagQAA=;
        b=oR43NioUs2HWE4no1l6PuzA1bfKKkdK/pudqOxzN0Wm9aiXLaqaaPAEEmYPah2x0Ny
         fEiheo03dmXKDVo6lOk7rzf9uJzFDXCEKOITZ3h7KV6w9pFV6fd1iqzqbh013Vr0HmgL
         VtacgbO+CV1mFjResKadmtAdDIEUf4369nfvpfZq+J2v7GexykfuOD6QO2CeKNXgbYFw
         q9mBfrZpXuF1QLkDValrwuZ7sdZwYXt/n8tl10wUrQ0s+Gswdoz018DTriA317JvvldE
         hj1NP/u87OAri54ZnCqsZS8Zlsoifm1hQQDRb/6ewmlUReiSaqNRyoyUQ4+mZSlTZUbK
         //Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypEXTIe5gdU9ETWQ6e76F6P/oA26cHe6qZw31vagQAA=;
        b=Tvb7iVHFLy5qEtxkx7y/wXnJa7WywcYQRJwlYcjVHrZb+41QkKsMWRE1SvqRXDpSZC
         /TCkjJmoGOmm+Zv//FFyEo52D6ThO+S6ooZNoq9caIjfwTQ9NcNVbTw4GjC7/PugX1BX
         e3YxDiFOEWAn2qIKHs1fo0v7EXMW7oqqyVodXUwLQd2PlE1n5dFUgVeNpxZfPJxs71fY
         1hNKpdpiKAVN/rGOwzhYPy5XCK5R/4caEWmchKEDEte4u3AFO434PxMS5Ln+/d+H4Xfr
         WBWbqr4YbSI1Q9e7Brc17bCOeiqNCH/3SrLIJrj9TAERnqtD3qDoqCd/hve1wF+GJ00q
         GNLA==
X-Gm-Message-State: AA+aEWYs98UiTwEyOydA0jQ/c7Phev2ZsR2bhvZGFqrjpHoQL/PS9wjl
        tUei4lSwWMKdm7KbWEmmaCtgqqs52Ds=
X-Google-Smtp-Source: AFSGD/XWQJp1wU+3VUaMSJu8FNo1r2Yoc9c59NCA7s4b9xgT9hke660lzl2NN9PsiLn/R7ZeDaz4Bg==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr23983728pgd.57.1544095380455;
        Thu, 06 Dec 2018 03:23:00 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id d6sm97507pgc.89.2018.12.06.03.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 03:22:59 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 7318C3000CA; Thu,  6 Dec 2018 14:22:55 +0300 (+03)
Date:   Thu, 6 Dec 2018 14:22:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-ID: <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
 <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
 <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 05, 2018 at 08:32:52PM +0000, Sakkinen, Jarkko wrote:
> On Tue, 2018-12-04 at 12:46 +0300, Kirill A. Shutemov wrote:
> > On Tue, Dec 04, 2018 at 09:25:50AM +0000, Peter Zijlstra wrote:
> > > On Mon, Dec 03, 2018 at 11:39:47PM -0800, Alison Schofield wrote:
> > > > (Multi-Key Total Memory Encryption)
> > > 
> > > I think that MKTME is a horrible name, and doesn't appear to accurately
> > > describe what it does either. Specifically the 'total' seems out of
> > > place, it doesn't require all memory to be encrypted.
> > 
> > MKTME implies TME. TME is enabled by BIOS and it encrypts all memory with
> > CPU-generated key. MKTME allows to use other keys or disable encryption
> > for a page.
> 
> When you say "disable encryption to a page" does the encryption get
> actually disabled or does the CPU just decrypt it transparently i.e.
> what happens physically?

Yes, it gets disabled. Physically. It overrides TME encryption.

-- 
 Kirill A. Shutemov
