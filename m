Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A952C04EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960D20989
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123459;
	bh=7umUMcBtxO7CaTYFnaBTCHw67qHn4pGIqdlzip2mTXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dH0lFEaWpOxyICHTQiF+VgyKoxfsG3dxrUKCPMnU2F9tcXYKRUNQqnqaBIcnyFkB/
	 7qJlQgwcupEAq+n4L1F7yMJfP0/xiQ7+dPzYO0xZSIBQakc4HeoCN6KrtihywvgVSP
	 PYsO07TWkkeLb/WzZfNddh46PGEoVKZiPPIyXEgk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0960D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFTK6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFTK6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 14:10:58 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A40B21708
        for <linux-security-module@vger.kernel.org>; Thu,  6 Dec 2018 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544123457;
        bh=7umUMcBtxO7CaTYFnaBTCHw67qHn4pGIqdlzip2mTXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NqkJ5rmNiXxOJzwE9edNqawPswscufwFUyNvKi+xMu/V9VoYyTOPqVfbw/roSk+ds
         n1vMGHCAYRC+Xa5kMKN5HkWjNN0e3vzBjtCPSDV4SJEV0Hf9YILvk1mqZmmNYcTSPt
         LzBzgzZo7114RxILGGr2c9nV/2Va3pVsWGH5B/WU=
Received: by mail-wr1-f48.google.com with SMTP id l9so1532599wrt.13
        for <linux-security-module@vger.kernel.org>; Thu, 06 Dec 2018 11:10:57 -0800 (PST)
X-Gm-Message-State: AA+aEWaX7b0IGvKSM4NSbVxX0TUOIheqC68yRiibJuhWs9qQG2XkQjdP
        n+d10TCJ2vPtWFVLVZ4wk43BUP/x+089rKt/tTkeSw==
X-Google-Smtp-Source: AFSGD/UFDo2bc4aamynFPZljlxXSXEGPkbN2/3cZwLkSH7gvO5+38UhRl8/3v9kQiq4Llq10D6htbCz1DF3dVl3+Npg=
X-Received: by 2002:a5d:5502:: with SMTP id b2mr27272736wrv.330.1544123455517;
 Thu, 06 Dec 2018 11:10:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com> <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
 <5e97e1bf-536c-ef73-576e-54145eee1ae9@intel.com>
In-Reply-To: <5e97e1bf-536c-ef73-576e-54145eee1ae9@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 11:10:43 -0800
X-Gmail-Original-Message-ID: <CALCETrVPhay-ziRVjL9dDCwJQHhr4HfG5aGJzYh06k6HEMZTiQ@mail.gmail.com>
Message-ID: <CALCETrVPhay-ziRVjL9dDCwJQHhr4HfG5aGJzYh06k6HEMZTiQ@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> On Dec 6, 2018, at 7:39 AM, Dave Hansen <dave.hansen@intel.com> wrote:

>>>> the direct map as well, probably using the pageattr.c code.
>>>
>>> The current, public hardware spec has a description of what's required
>>> to maintain cache coherency.  Basically, you can keep as many mappings
>>> of a physical page as you want, but only write to one mapping at a time=
,
>>> and clflush the old one when you want to write to a new one.
>>
>> Surely you at least have to clflush the old mapping and then the new
>> mapping, since the new mapping could have been speculatively read.
>
> Nope.  The coherency is "fine" unless you have writeback of an older
> cacheline that blows away newer data.  CPUs that support MKTME are
> guaranteed to never do writeback of the lines that could be established
> speculatively or from prefetching.

How is that sufficient?  Suppose I have some physical page mapped with
keys 1 and 2. #1 is logically live and I write to it.  Then I prefetch
or otherwise populate mapping 2 into the cache (in the S state,
presumably).  Now I clflush mapping 1 and read 2.  It contains garbage
in the cache, but the garbage in the cache is inconsistent with the
garbage in memory.  This can=E2=80=99t be a good thing, even if no writebac=
k
occurs.

I suppose the right fix is to clflush the old mapping and then to zero
the new mapping.

>
>>>> Finally, If you're going to teach the kernel how to have some user
>>>> pages that aren't in the direct map, you've essentially done XPO,
>>>> which is nifty but expensive.  And I think that doing this gets you
>>>> essentially all the benefit of MKTME for the non-pmem use case.  Why
>>>> exactly would any software want to use anything other than a
>>>> CPU-managed key for anything other than pmem?
>>>
>>> It is handy, for one, to let you "cluster" key usage.  If you have 5
>>> Pepsi VMs and 5 Coke VMs, each Pepsi one using the same key and each
>>> Coke one using the same key, you can boil it down to only 2 hardware
>>> keyid slots that get used, and do this transparently.
>>
>> I understand this from a marketing perspective but not a security
>> perspective.  Say I'm Coke and you've sold me some VMs that are
>> "encrypted with a Coke-specific key and no other VMs get to use that
>> key."  I can't think of *any* not-exceedingly-contrived attack in
>> which this makes the slightest difference.  If Pepsi tries to attack
>> Coke without MKTME, then they'll either need to get the hypervisor to
>> leak Coke's data through the direct map or they'll have to find some
>> way to corrupt a page table or use something like L1TF to read from a
>> physical address Coke owns.  With MKTME, if they can read through the
>> host direct map, then they'll get Coke's cleartext, and if they can
>> corrupt a page table or use L1TF to read from your memory, they'll get
>> Coke's cleartext.
>
> The design definitely has the hypervisor in the trust boundary.  If the
> hypervisor is evil, or if someone evil compromises the hypervisor, MKTME
> obviously provides less protection.
>
> I guess the question ends up being if this makes its protections weak
> enough that we should not bother merging it in its current form.

Indeed, but I=E2=80=99d ask another question too: I expect that MKTME is we=
ak
enough that it will be improved, and without seeing the improvement,
it seems quite plausible that using the improvement will require
radically reworking the kernel implementation.

As a straw man, suppose we get a way to say =E2=80=9Cthis key may only be
accessed through such-and-such VPID or by using a special new
restricted facility for the hypervisor to request access=E2=80=9D.    Now w=
e
have some degree of serious protection, but it doesn=E2=80=99t work, by
design, for anonymous memory.  Similarly, something that looks more
like AMD's SEV would be very very awkward to support with anything
like the current API proposal.

>
> I still have the homework assignment to go figure out why folks want the
> protections as they stand.
