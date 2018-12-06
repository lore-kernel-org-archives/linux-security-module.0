Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0593C65BB9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665D0214DE
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544058586;
	bh=YA6e/PEWV/dzrCMXmrHj/b7kMxo2bbK03bHaG7f0Gtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GgQU1JBFhml3RO9KlJZZJ2mbZxAmlmNzxasdh+nJKZQDmybOwKpNDE4VayYP9dbHV
	 Kucq/ba1EHq7xJwcDJ7NySnFdN3+LL+4kzCfq8/W4qFZLh21NZFWtNqnZ6Od7PVA2Z
	 u9QE7coFzIAp3QLNAb5auaycMt+b5+YTJcXHnTSA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665D0214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeLFBJp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFBJp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 20:09:45 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C883821582
        for <linux-security-module@vger.kernel.org>; Thu,  6 Dec 2018 01:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544058584;
        bh=YA6e/PEWV/dzrCMXmrHj/b7kMxo2bbK03bHaG7f0Gtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UjCdWhq0KunrjyuUT+gxsE5BDqSl/SjOyNG/C8/CYzcDRah8LkTiiTtuV54g4l8iA
         X1WJ3OAgYDCR52nCncnYN1mzdGt7god2jjg7KEk54JoXcvfa24tWMjRqN0wznAorZ5
         njBf+kWv4zayfnM30iy+zB9AgvOiLcscmn/EZdhI=
Received: by mail-wm1-f42.google.com with SMTP id n190so12699749wmd.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Dec 2018 17:09:43 -0800 (PST)
X-Gm-Message-State: AA+aEWbKZGIx4D58X/JH38jenqp2fceXx+rnKM4RY5EsWAYgcBpu3uDf
        tlhtzDrdWP6juX1e2UhdWppc4MMZsQE9464ddHoS0g==
X-Google-Smtp-Source: AFSGD/U/D65akm8pRKQjY/6rP23p1rwDrq1DieqF3CxPU8lZpnUsPSKUuezh5g+76iFJ6rfuN1PG+a0kTp2NDf6/Q8Y=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr18916495wmc.74.1544058582103;
 Wed, 05 Dec 2018 17:09:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com> <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
In-Reply-To: <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Dec 2018 17:09:30 -0800
X-Gmail-Original-Message-ID: <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
Message-ID: <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, alison.schofield@intel.com,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        kai.huang@intel.com, Jun Nakajima <jun.nakajima@intel.com>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 5, 2018 at 3:49 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/4/18 11:19 AM, Andy Lutomirski wrote:
> > I'm not Thomas, but I think it's the wrong direction.  As it stands,
> > encrypt_mprotect() is an incomplete version of mprotect() (since it's
> > missing the protection key support),
>
> I thought about this when I added mprotect_pkey().  We start with:
>
>         mprotect(addr, len, prot);
>
> then
>
>         mprotect_pkey(addr, len, prot);
>
> then
>
>         mprotect_pkey_encrypt(addr, len, prot, key);
>
> That doesn't scale because we eventually have
> mprotect_and_a_history_of_mm_features(). :)
>
> What I was hoping to see was them do this (apologies for the horrible
> indentation:
>
>         ptr = mmap(..., PROT_NONE);
>         mprotect_pkey(   addr, len, PROT_NONE, pkey);
>         mprotect_encrypt(addr, len, PROT_NONE, keyid);
>         mprotect(        addr, len, real_prot);
>
> The point is that you *can* stack these things and don't have to have an
> mprotect_kitchen_sink() if you use PROT_NONE for intermediate
> permissions during setup.

Sure, but then why call it mprotect at all?  How about:

mmap(..., PROT_NONE);
mencrypt(..., keyid);
mprotect_pkey(...);

But wouldn't this be much nicer:

int fd = memfd_create(...);
memfd_set_tme_key(fd, keyid);  /* fails if len != 0 */
mmap(fd, ...);

>
> > and it's also functionally just MADV_DONTNEED.  In other words, the
> > sole user-visible effect appears to be that the existing pages are
> > blown away.  The fact that it changes the key in use doesn't seem
> > terribly useful, since it's anonymous memory,
>
> It's functionally MADV_DONTNEED, plus a future promise that your writes
> will never show up as plaintext on the DIMM.

But that's mostly vacuous.  If I read the docs right, MKTME systems
also support TME, so you *already* have that promise, unless the
firmware totally blew it.  If we want a boot option to have the kernel
use MKTME to forcibly encrypt everything regardless of what the TME
MSRs say, I'd be entirely on board.  Heck, the implementation would be
quite simple because we mostly reuse the SME code.

>
> We also haven't settled on the file-backed properties.  For file-backed,
> my hope was that you could do:
>
>         ptr = mmap(fd, size, prot);
>         printf("ciphertext: %x\n", *ptr);
>         mprotect_encrypt(ptr, len, prot, keyid);
>         printf("plaintext: %x\n", *ptr);

Why would you ever want the plaintext?  Also, how does this work on a
normal fs, where relocation of the file would cause the ciphertext to
get lost?  It really seems to be that it should look more like
dm-crypt where you encrypt a filesystem.  Maybe you'd just configure
the pmem device to be encrypted before you mount it, or you'd get a
new pmem-mktme device node instead.  This would also avoid some nasty
multiple-copies-of-the-direct-map issue, since you'd only ever have
one of them mapped.

>
> > The main implementation concern I have with this patch set is cache
> > coherency and handling of the direct map.  Unless I missed something,
> > you're not doing anything about the direct map, which means that you
> > have RW aliases of the same memory with different keys.  For use case
> > #2, this probably means that you need to either get rid of the direct
> > map and make get_user_pages() fail, or you need to change the key on
> > the direct map as well, probably using the pageattr.c code.
>
> The current, public hardware spec has a description of what's required
> to maintain cache coherency.  Basically, you can keep as many mappings
> of a physical page as you want, but only write to one mapping at a time,
> and clflush the old one when you want to write to a new one.

Surely you at least have to clflush the old mapping and then the new
mapping, since the new mapping could have been speculatively read.

> > Finally, If you're going to teach the kernel how to have some user
> > pages that aren't in the direct map, you've essentially done XPO,
> > which is nifty but expensive.  And I think that doing this gets you
> > essentially all the benefit of MKTME for the non-pmem use case.  Why
> > exactly would any software want to use anything other than a
> > CPU-managed key for anything other than pmem?
>
> It is handy, for one, to let you "cluster" key usage.  If you have 5
> Pepsi VMs and 5 Coke VMs, each Pepsi one using the same key and each
> Coke one using the same key, you can boil it down to only 2 hardware
> keyid slots that get used, and do this transparently.

I understand this from a marketing perspective but not a security
perspective.  Say I'm Coke and you've sold me some VMs that are
"encrypted with a Coke-specific key and no other VMs get to use that
key."  I can't think of *any* not-exceedingly-contrived attack in
which this makes the slightest difference.  If Pepsi tries to attack
Coke without MKTME, then they'll either need to get the hypervisor to
leak Coke's data through the direct map or they'll have to find some
way to corrupt a page table or use something like L1TF to read from a
physical address Coke owns.  With MKTME, if they can read through the
host direct map, then they'll get Coke's cleartext, and if they can
corrupt a page table or use L1TF to read from your memory, they'll get
Coke's cleartext.

TME itself provides a ton of protection -- you can't just barge into
the datacenter, refrigerate the DIMMs, walk away with them, and read
off everyone's data.

Am I missing something?

>
> But, I think what you're implying is that the security properties of
> user-supplied keys can only be *worse* than using CPU-generated keys
> (assuming the CPU does a good job generating it).  So, why bother
> allowing user-specified keys in the first place?

That too :)
