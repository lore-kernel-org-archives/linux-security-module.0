Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52066C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0781720645
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0781720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeLEXtp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:49:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:57141 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbeLEXto (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 18:49:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 15:49:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,320,1539673200"; 
   d="scan'208";a="116346811"
Received: from ray.jf.intel.com (HELO [10.7.201.16]) ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2018 15:49:43 -0800
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     Andy Lutomirski <luto@kernel.org>, alison.schofield@intel.com,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
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
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
Date:   Wed, 5 Dec 2018 15:49:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/4/18 11:19 AM, Andy Lutomirski wrote:
> I'm not Thomas, but I think it's the wrong direction.  As it stands,
> encrypt_mprotect() is an incomplete version of mprotect() (since it's
> missing the protection key support),

I thought about this when I added mprotect_pkey().  We start with:

	mprotect(addr, len, prot);

then

	mprotect_pkey(addr, len, prot);

then

	mprotect_pkey_encrypt(addr, len, prot, key);

That doesn't scale because we eventually have
mprotect_and_a_history_of_mm_features(). :)

What I was hoping to see was them do this (apologies for the horrible
indentation:

	ptr = mmap(..., PROT_NONE);
	mprotect_pkey(   addr, len, PROT_NONE, pkey);
	mprotect_encrypt(addr, len, PROT_NONE, keyid);
	mprotect(        addr, len, real_prot);

The point is that you *can* stack these things and don't have to have an
mprotect_kitchen_sink() if you use PROT_NONE for intermediate
permissions during setup.

> and it's also functionally just MADV_DONTNEED.  In other words, the
> sole user-visible effect appears to be that the existing pages are
> blown away.  The fact that it changes the key in use doesn't seem
> terribly useful, since it's anonymous memory,

It's functionally MADV_DONTNEED, plus a future promise that your writes
will never show up as plaintext on the DIMM.

We also haven't settled on the file-backed properties.  For file-backed,
my hope was that you could do:

	ptr = mmap(fd, size, prot);
	printf("ciphertext: %x\n", *ptr);
	mprotect_encrypt(ptr, len, prot, keyid);
	printf("plaintext: %x\n", *ptr);

> and the most secure choice is to use CPU-managed keying, which
> appears to be the default anyway on TME systems.  It also has totally
> unclear semantics WRT swap, and, off the top of my head, it looks
> like it may have serious cache-coherency issues and like swapping the
> pages might corrupt them, both because there are no flushes and
> because the direct-map alias looks like it will use the default key
> and therefore appear to contain the wrong data.

I think we fleshed this out on IRC a bit, but the other part of the
implementation is described here: https://lwn.net/Articles/758313/, and
contains a direct map per keyid.  When you do phys_to_virt() and
friends, you get the correct, decrypted view direct map which is
appropriate for the physical page.  And, yes, this has very
consequential security implications.

> I would propose a very different direction: don't try to support MKTME
> at all for anonymous memory, and instead figure out the important use
> cases and support them directly.  The use cases that I can think of
> off the top of my head are:
> 
> 1. pmem.  This should probably use a very different API.
> 
> 2. Some kind of VM hardening, where a VM's memory can be protected a
> little tiny bit from the main kernel.  But I don't see why this is any
> better than XPO (eXclusive Page-frame Ownership), which brings to
> mind:

The XPO approach is "fun", and would certainly be a way to keep the
direct map from being exploited to get access to plain-text mappings of
ciphertext.

But, it also has massive performance implications and we didn't quite
want to go there quite yet.

> The main implementation concern I have with this patch set is cache
> coherency and handling of the direct map.  Unless I missed something,
> you're not doing anything about the direct map, which means that you
> have RW aliases of the same memory with different keys.  For use case
> #2, this probably means that you need to either get rid of the direct
> map and make get_user_pages() fail, or you need to change the key on
> the direct map as well, probably using the pageattr.c code.

The current, public hardware spec has a description of what's required
to maintain cache coherency.  Basically, you can keep as many mappings
of a physical page as you want, but only write to one mapping at a time,
and clflush the old one when you want to write to a new one.

> As for caching, As far as I can tell from reading the preliminary
> docs, Intel's MKTME, much like AMD's SME, is basically invisible to
> the hardware cache coherency mechanism.  So, if you modify a physical
> address with one key (or SME-enable bit), and you read it with
> another, you get garbage unless you flush.  And, if you modify memory
> with one key then remap it with a different key without flushing in
> the mean time, you risk corruption.

Yes, all true (at least with respect to Intel's implementation).

> And, what's worse, if I'm reading
> between the lines in the docs correctly, if you use PCONFIG to change
> a key, you may need to do a bunch of cache flushing to ensure you get
> reasonable effects.  (If you have dirty cache lines for some (PA, key)
> and you PCONFIG to change the underlying key, you get different
> results depending on whether the writeback happens before or after the
> package doing the writeback notices the PCONFIG.)

We're not going to allow a key to be PCONFIG'd while there are any
physical pages still associated with it.  There are per-VMA refcounts
tied back to the keyid slots, IIRC.  So, before PCONFIG can happen, we
just need to make sure that all the VMAs are gone, all the pages are
freed, and all dirty cachelines have been clflushed.

This is where get_user_pages() is our mortal enemy, though.  I hope we
got that right.  Kirill/Alison, we should chat about this one. :)

> Finally, If you're going to teach the kernel how to have some user
> pages that aren't in the direct map, you've essentially done XPO,
> which is nifty but expensive.  And I think that doing this gets you
> essentially all the benefit of MKTME for the non-pmem use case.  Why
> exactly would any software want to use anything other than a
> CPU-managed key for anything other than pmem?

It is handy, for one, to let you "cluster" key usage.  If you have 5
Pepsi VMs and 5 Coke VMs, each Pepsi one using the same key and each
Coke one using the same key, you can boil it down to only 2 hardware
keyid slots that get used, and do this transparently.

But, I think what you're implying is that the security properties of
user-supplied keys can only be *worse* than using CPU-generated keys
(assuming the CPU does a good job generating it).  So, why bother
allowing user-specified keys in the first place?

It's a good question and I don't have a solid answer for why folks want
this.  I'll find out.
