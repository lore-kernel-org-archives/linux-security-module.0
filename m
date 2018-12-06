Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA5C04EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F59F214C1
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 15:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F59F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFPjK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:39:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:20087 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFPjJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 10:39:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 07:39:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,322,1539673200"; 
   d="scan'208";a="105392559"
Received: from jbdelcuv-mobl.amr.corp.intel.com (HELO [10.251.27.202]) ([10.251.27.202])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2018 07:39:07 -0800
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     alison.schofield@intel.com, Matthew Wilcox <willy@infradead.org>,
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
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
 <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <5e97e1bf-536c-ef73-576e-54145eee1ae9@intel.com>
Date:   Thu, 6 Dec 2018 07:39:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/5/18 5:09 PM, Andy Lutomirski wrote:
> On Wed, Dec 5, 2018 at 3:49 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> What I was hoping to see was them do this (apologies for the horrible
>> indentation:
>>
>>         ptr = mmap(..., PROT_NONE);
>>         mprotect_pkey(   addr, len, PROT_NONE, pkey);
>>         mprotect_encrypt(addr, len, PROT_NONE, keyid);
>>         mprotect(        addr, len, real_prot);
>>
>> The point is that you *can* stack these things and don't have to have an
>> mprotect_kitchen_sink() if you use PROT_NONE for intermediate
>> permissions during setup.
> 
> Sure, but then why call it mprotect at all?  How about:
> 
> mmap(..., PROT_NONE);
> mencrypt(..., keyid);
> mprotect_pkey(...);

That would totally work too.  I just like the idea of a family of
mprotect() syscalls that do mprotect() plus one other thing.  What
you're proposing is totally equivalent where we have mprotect_pkey()
always being the *last* thing that gets called, plus a family of things
that we expect to get called on something that's probably PROT_NONE.

> But wouldn't this be much nicer:
> 
> int fd = memfd_create(...);
> memfd_set_tme_key(fd, keyid);  /* fails if len != 0 */
> mmap(fd, ...);

No. :)

One really big advantage with protection keys, or this implementation is
that you don't have to implement an allocator.  You can use it with any
old malloc() as long as you own a whole page.

The pages also fundamentally *stay* anonymous in the VM and get all the
goodness that comes with that, like THP.

>>> and it's also functionally just MADV_DONTNEED.  In other words, the
>>> sole user-visible effect appears to be that the existing pages are
>>> blown away.  The fact that it changes the key in use doesn't seem
>>> terribly useful, since it's anonymous memory,
>>
>> It's functionally MADV_DONTNEED, plus a future promise that your writes
>> will never show up as plaintext on the DIMM.
> 
> But that's mostly vacuous.  If I read the docs right, MKTME systems
> also support TME, so you *already* have that promise, unless the
> firmware totally blew it.  If we want a boot option to have the kernel
> use MKTME to forcibly encrypt everything regardless of what the TME
> MSRs say, I'd be entirely on board.  Heck, the implementation would be
> quite simple because we mostly reuse the SME code.

Yeah, that's true.  I seem to always forget about the TME case! :)

"It's functionally MADV_DONTNEED, plus a future promise that your writes
will never be written to the DIMM with the TME key."

But, this gets us back to your very good question about what good this
does in the end.  What value does _that_ scheme provide over TME?  We're
admittedly weak on specific examples there, but I'm working on it.

>>> the direct map as well, probably using the pageattr.c code.
>>
>> The current, public hardware spec has a description of what's required
>> to maintain cache coherency.  Basically, you can keep as many mappings
>> of a physical page as you want, but only write to one mapping at a time,
>> and clflush the old one when you want to write to a new one.
> 
> Surely you at least have to clflush the old mapping and then the new
> mapping, since the new mapping could have been speculatively read.

Nope.  The coherency is "fine" unless you have writeback of an older
cacheline that blows away newer data.  CPUs that support MKTME are
guaranteed to never do writeback of the lines that could be established
speculatively or from prefetching.

>>> Finally, If you're going to teach the kernel how to have some user
>>> pages that aren't in the direct map, you've essentially done XPO,
>>> which is nifty but expensive.  And I think that doing this gets you
>>> essentially all the benefit of MKTME for the non-pmem use case.  Why
>>> exactly would any software want to use anything other than a
>>> CPU-managed key for anything other than pmem?
>>
>> It is handy, for one, to let you "cluster" key usage.  If you have 5
>> Pepsi VMs and 5 Coke VMs, each Pepsi one using the same key and each
>> Coke one using the same key, you can boil it down to only 2 hardware
>> keyid slots that get used, and do this transparently.
> 
> I understand this from a marketing perspective but not a security
> perspective.  Say I'm Coke and you've sold me some VMs that are
> "encrypted with a Coke-specific key and no other VMs get to use that
> key."  I can't think of *any* not-exceedingly-contrived attack in
> which this makes the slightest difference.  If Pepsi tries to attack
> Coke without MKTME, then they'll either need to get the hypervisor to
> leak Coke's data through the direct map or they'll have to find some
> way to corrupt a page table or use something like L1TF to read from a
> physical address Coke owns.  With MKTME, if they can read through the
> host direct map, then they'll get Coke's cleartext, and if they can
> corrupt a page table or use L1TF to read from your memory, they'll get
> Coke's cleartext.

The design definitely has the hypervisor in the trust boundary.  If the
hypervisor is evil, or if someone evil compromises the hypervisor, MKTME
obviously provides less protection.

I guess the question ends up being if this makes its protections weak
enough that we should not bother merging it in its current form.

I still have the homework assignment to go figure out why folks want the
protections as they stand.
