Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539EFC07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1761F2083D
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226552;
	bh=+F8d5KIATjvVOBmPmVYoR3a66b5Jf7WRJd+1EIdknrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oVTyb+rTP9qA1M0JSySaIgm3mHZxh5G7udWN5H8ZXggXlpaSensNwBbiF4lWgjcku
	 CS1g6sUvSlmAxdcYTqntdSEjAnG4y2ibseRvm8tK+g7Lk10U8PDhdlkzU4+EbcTI1k
	 ZTPi37A4S5TAffErvFIFlWM4f6VOwy0HTQR1yZMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1761F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeLGXtL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLGXtL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 18:49:11 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FAC21582
        for <linux-security-module@vger.kernel.org>; Fri,  7 Dec 2018 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544226550;
        bh=+F8d5KIATjvVOBmPmVYoR3a66b5Jf7WRJd+1EIdknrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XBRPhRmj2Ey/WWP1ZczWo9LOho5mKk5LqiTDrcFUzW6EiMKk7xiNVhXSG5RuTxfZs
         8W3CvqGgsiL/z3ZLsiT56lDShTDo84J9Goijo0p0CGbtiP7BxpUA2nduRqFXC61mNG
         SFGwcCbYhFVJ5ejdqYirEuE/y20ONCViE/BW+O5U=
Received: by mail-wr1-f47.google.com with SMTP id j2so5321241wrw.1
        for <linux-security-module@vger.kernel.org>; Fri, 07 Dec 2018 15:49:09 -0800 (PST)
X-Gm-Message-State: AA+aEWYapRPTd/isJmSnE3UY/GcYeH6izMfAJDBOp/KQsL22Z9fUpTkl
        Tjd1JgtrF/Rhsc0rm273a89zR10lDBHKBjpXueizLg==
X-Google-Smtp-Source: AFSGD/VZhr4OqrO/A/G3BPk6ijlEJpd2KHIxafsIWu2LmdEhQy1YK/p6M3pua7LZwDDgEEZaskch9WxWdUaS132ZwaI=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr3122973wri.199.1544226548221;
 Fri, 07 Dec 2018 15:49:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com>
 <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1> <fd94ec722edc45008097a39d0c84a5d7134641c7.camel@intel.com>
 <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
In-Reply-To: <19c539f8c6c9b34974e4cb4f268eb64fe7ba4297.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 Dec 2018 15:48:55 -0800
X-Gmail-Original-Message-ID: <CALCETrXOkwZ-SmK1euy_ys=VvMx6dAGbTqPm-VW9jWw3TvoFag@mail.gmail.com>
Message-ID: <CALCETrXOkwZ-SmK1euy_ys=VvMx6dAGbTqPm-VW9jWw3TvoFag@mail.gmail.com>
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

On Fri, Dec 7, 2018 at 3:45 PM Sakkinen, Jarkko
<jarkko.sakkinen@intel.com> wrote:
>
> On Fri, 2018-12-07 at 13:59 -0800, Jarkko Sakkinen wrote:
> > On Fri, 2018-12-07 at 14:57 +0300, Kirill A. Shutemov wrote:
> > > > What is the threat model anyway for AMD and Intel technologies?
> > > >
> > > > For me it looks like that you can read, write and even replay
> > > > encrypted pages both in SME and TME.
> > >
> > > What replay attack are you talking about? MKTME uses AES-XTS with physical
> > > address tweak. So the data is tied to the place in physical address space
> > > and
> > > replacing one encrypted page with another encrypted page from different
> > > address will produce garbage on decryption.
> >
> > Just trying to understand how this works.
> >
> > So you use physical address like a nonce/version for the page and
> > thus prevent replay? Was not aware of this.
>
> The brutal fact is that a physical address is an astronomical stretch
> from a random value or increasing counter. Thus, it is fair to say that
> MKTME provides only naive measures against replay attacks...
>

And this is potentially a big deal, since there are much simpler
replay attacks that can compromise the system.  For example, if I can
replay the contents of a page table, I can write to freed memory.

--Andy
