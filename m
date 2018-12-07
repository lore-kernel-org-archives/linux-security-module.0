Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E010C07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AD22146D
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3t/U4Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AD22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeLGXfm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:35:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42427 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXfm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 18:35:42 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so4744935oiw.9;
        Fri, 07 Dec 2018 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYPNYQIncVqOf2qtLmTjj1d6ag1ri60UnmEZB56VvLg=;
        b=a3t/U4NnUs+g65i8eq3z7q9Ju5MdeElGnG7WPM2A2Q6TcfP6GqBto015huqCFfl+4K
         /TRAiuJtQDm4XlxoHU/sBb4f5CpS+oBAaaxb+WXIHthxjviSgzq1s04QOI9lv6Mj7j2T
         wHPqA8gh7UYBDT6wHQBFSQDMpyvx68AxjFQU3AfRFbF6dJj5bjoRj5gqr8wXH4kR0fCN
         y2ep8RWl9RuPJmzuXBNql7cLj+LHV4sfm6LP1AxPmtNSrNVZ3kDxLKotbMrTJ1wY5RBo
         w6m7SXcJNFgBVUNcqUYecBnjCuFWleG0t96RqTMiX3IMjyfyKDlXO4l8lAwlYJJBX0+g
         ANIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYPNYQIncVqOf2qtLmTjj1d6ag1ri60UnmEZB56VvLg=;
        b=rYCmfqUmPy8begZ3Wm7FO4PrEnRu2BEZVOPYt6yHbboOT2G8E5U9tT2/x3cL5sgaTJ
         9Q39gz+vH8FvzHKObKpL7/5JdndgI+2Pr2dUQta0DcaTY1UWMNwalfHyl5BLLR8yktpg
         ujnhcZ9MoDUMWXNYR0y48LHLZirh/wZ+P26xNbTB6P1pWmcOloD1jj/iCrqKrLO0ir1x
         fmlnzYskelbzYj864UhFbXkp+uSDyhkT/6MVhf8mWwBap9nSoBP7AmF2/e0vj3yPGmYB
         cTaiFRrPpEuhwML/vDXNHN/OG7Wnb5I83WAwLkp6kkpQkqVpnoFESJ8841pF7iGsoJwd
         k1aQ==
X-Gm-Message-State: AA+aEWa1/HP3oTF/tMwHsLfZd7rAY+eHvo8qwvt6dvtcLgEtXvc3mJy/
        cYWMOPHWFKCBd19sCdarym/1ftmRB4fk7qs/LB8=
X-Google-Smtp-Source: AFSGD/WfzoLNb59XVqoa10AN1ZU1RPxYLTivzLNjDFevvJhnl23RfEPisiImaaQnt7puDfQ16Lc77QiHAuMRnVdwWPo=
X-Received: by 2002:aca:5a88:: with SMTP id o130mr2510402oib.275.1544225740779;
 Fri, 07 Dec 2018 15:35:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <0a21eadd05b245f762f7d536d8fdf579c113a9bc.camel@intel.com> <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
In-Reply-To: <20181207115713.ia5jbrx5e3osaqxi@kshutemo-mobl1>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Fri, 7 Dec 2018 15:35:29 -0800
Message-ID: <CA+zRj8Uin5MsvOVstRYY3ARhHCfh8iQAHQfsHi1CRso3+siSjQ@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     kirill@shutemov.name
Cc:     jarkko.sakkinen@intel.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, luto@kernel.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, jmorris@namei.org,
        peterz@infradead.org, kai.huang@intel.com,
        keyrings@vger.kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, jun.nakajima@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 7, 2018 at 3:57 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > What is the threat model anyway for AMD and Intel technologies?
> >
> > For me it looks like that you can read, write and even replay
> > encrypted pages both in SME and TME.
>
> What replay attack are you talking about? MKTME uses AES-XTS with physical
> address tweak. So the data is tied to the place in physical address space
> and replacing one encrypted page with another encrypted page from
> different address will produce garbage on decryption.

What if you have some control over the physical addresses you write
the stolen encrypted page to? For instance, VM_Eve might manage to use
physical address space previously used by VM_Alice by getting the
hypervisor to move memory around (memory pressure, force other VMs out
via some type of DOS attack, etc.).

Say:
    C is VM_Alice's clear text at hwaddr
    E = mktme_encrypt(VM_Allice_key, hwaddr, C)
    Eve somehow stole the encrypted bits E

Eve would need to write the page E without further encryption to make
sure that the DRAM contains the original stolen bits E, not encrypted
again with VM_Eve's key or mktme_encrypt(VM_Eve_key, hwaddr, E) would
be present in the DRAM which is not helpful. But with MKTME under the
current proposal VM_Eve can disable encryption for a given mapping,
right? (See also Note 1)

Eve gets the HV to move VM_Alice back over the same physical address,
Eve "somehow" gets VM_Alice to read that page and use its content
(which would likely be a use of uninitialized memory bug, from
VM_Alice's perspective) and you have a replay attack?

For TME, this doesn't work as you cannot partially disable encryption,
so if Eve tries to write the stolen encrypted bits E, even in the
"right place", they get encrypted again to tme_encrypt(hwaddr, E).
Upon decryption, VM_Alice will get E, not C.

Note 1: Actually, even if with MKTME you cannot disable encryption but
*if* Eve knows its own key, Eve can always write a preimage P that the
CPU encrypts to E for VM_Alice to read back and decrypt:
    P = mktme_decrypt(VM_Eve_key, hwaddr, E)

This is not possible with TME as Eve doesn't know the key used by the
CPU and cannot compute P.
