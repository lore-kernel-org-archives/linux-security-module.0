Return-Path: <SRS0=0itc=OV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB3C67839
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6692084E
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Dec 2018 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544632202;
	bh=GM9SLJsyHGF+xcKhqyBZkYpoDbDXyH+fiJtaUXw9dBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qWPeGrBRH6qdzMZTB6vjSSHJElXy167KE+slwTmKTeV6onpke/JJ976H2CLwcnH/3
	 HqoKMJdvjTSWr+7pAaR2f+hddfp5Ont0RSTxDdy7eSm6AdXrg3FepricsgHLfQbaZP
	 Ak65cKe08W5LJjoFmutldZ8spXDHwGh4foT2YPXc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6692084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbeLLQaB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeLLQaA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Dec 2018 11:30:00 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3AF20989
        for <linux-security-module@vger.kernel.org>; Wed, 12 Dec 2018 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544632199;
        bh=GM9SLJsyHGF+xcKhqyBZkYpoDbDXyH+fiJtaUXw9dBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KOy9MvAUR5jqGHStOI/V5OJ2cVJRqlGSvQIyu0ycwItk6SJ8aPPsH2t6qRuVIkp3Q
         4Nz47h7JOGrt/7D5bj0lQ5hIrc8MiW6Qb4W1l03MJhI/aGBG4FvZeTEwLdaNyazueh
         nqyF9x1NaDhzqgX+Xhp+5d7u8pl0aVGKAC4t3ZGY=
Received: by mail-wm1-f50.google.com with SMTP id n190so6442306wmd.0
        for <linux-security-module@vger.kernel.org>; Wed, 12 Dec 2018 08:29:59 -0800 (PST)
X-Gm-Message-State: AA+aEWZWRRLr1u1DDQXhJ9hvUL58q+kvZlwSq+j/4jfVTyW9gLX0fA5C
        ARaB/wiFciW8Y690pELDmW64fuFf8+GIa9eYXTeH0g==
X-Google-Smtp-Source: AFSGD/WxKgxWj3BtKdNyuy2LLh43uvcSlQxzMyxZaOvXOIb3m9G6EVaJ/+IMWlVJYzWFBgH819FSYwFkxy0yCkRDzW0=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr6811704wme.108.1544632198130;
 Wed, 12 Dec 2018 08:29:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
 <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1> <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
 <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com> <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
In-Reply-To: <655394650664715c39ef242689fbc8af726f09c3.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Dec 2018 08:29:45 -0800
X-Gmail-Original-Message-ID: <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
Message-ID: <CALCETrVztbuRUnp9MUz-Pp85NhY2htNZHGszS+mU_oWoXK3u6A@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>, kai.huang@intel.com,
        keyrings@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 12, 2018 at 7:31 AM Sakkinen, Jarkko
<jarkko.sakkinen@intel.com> wrote:
>
> On Fri, 2018-12-07 at 15:45 -0800, Jarkko Sakkinen wrote:
> > The brutal fact is that a physical address is an astronomical stretch
> > from a random value or increasing counter. Thus, it is fair to say that
> > MKTME provides only naive measures against replay attacks...
>
> I'll try to summarize how I understand the high level security
> model of MKTME because (would be good idea to document it).
>
> Assumptions:
>
> 1. The hypervisor has not been infiltrated.
> 2. The hypervisor does not leak secrets.
>
> When (1) and (2) hold [1], we harden VMs in two different ways:
>
> A. VMs cannot leak data to each other or can they with L1TF when HT
>    is enabled?

I strongly suspect that, on L1TF-vulnerable CPUs, MKTME provides no
protection whatsoever.  It sounds like MKTME is implemented in the
memory controller -- as far as the rest of the CPU and the cache
hierarchy are concerned, the MKTME key selction bits are just part of
the physical address.  So an attack like L1TF that leaks a cacheline
that's selected by physical address will leak the cleartext if the key
selection bits are set correctly.

(I suppose that, if the attacker needs to brute-force the physical
address, then MKTME makes it a bit harder because the effective
physical address space is larger.)

> B. Protects against cold boot attacks.

TME does this, AFAIK.  MKTME does, too, unless the "user" mode is
used, in which case the protection is weaker.

>
> Isn't this what this about in the nutshell roughly?
>
> [1] XPFO could potentially be an opt-in feature that reduces the
>     damage when either of these assumptions has been broken.
>
> /Jarkko
