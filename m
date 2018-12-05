Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD1C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A0208E7
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 23:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544052951;
	bh=ZehGqbjMr5q47QLE6b0zqp0GEvTN8r59vfhlLMuWjgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KcRP+EDQWTdIG7Oq3TlWgRgKNyHDcFazKoYTxiE/xTaMnsfqVBdirFjsy71HvT2u4
	 wqT8ixc6KYVEIw+ek/QXWbEt3JoFsIPaA7DWpxx6e1vRnLSp7aXlIHCQz8dciKL0CX
	 AysPP734yC5QaEI88C2DNMo7uTpYGjPFYy8p+Qko=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520A0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeLEXfu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEXfu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 18:35:50 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E1A2133F
        for <linux-security-module@vger.kernel.org>; Wed,  5 Dec 2018 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544052949;
        bh=ZehGqbjMr5q47QLE6b0zqp0GEvTN8r59vfhlLMuWjgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T7TNc5DEcriJ+yz9jVhqyUmFc2Yskic9JVlYwC50M7k0vYwz0g0+XJE08hMLVJjl9
         5SVthX5qxRridDGkQeQ9sGs3OYbBIkW0RVb2FFNrkrNdHLRJHhkk0H2GzU+7w1pTi+
         /Z0TRAoVm/jRrAt/JSisL2tGb/Z5pJ0veWqJQjDI=
Received: by mail-wm1-f52.google.com with SMTP id m22so14682048wml.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Dec 2018 15:35:48 -0800 (PST)
X-Gm-Message-State: AA+aEWbPDFHD+AW2cSuvcy7yWmAz6nn7/R3zQHu2i231bsL9TljkXHS4
        qAQFOEUKBmDIWC/Fa2c6g4VUyEC+w8QeH3pZzcxc0w==
X-Google-Smtp-Source: AFSGD/XTsM7li9eyGMTPLSIfVk/T3ULkT5m8HhOovBj+yXm6pTtIibalTT2eTTkGZFfHTT+msRCryNcg/BAOY2+pu+0=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr18728862wmc.74.1544052947440;
 Wed, 05 Dec 2018 15:35:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c2276bbbb19f3a28bd37c3dd6b1021e2d9a10916.1543903910.git.alison.schofield@intel.com>
 <4ED70A75-9A88-41B4-B595-87FB748772F9@amacapital.net> <20181205192255.GA988@alison-desk.jf.intel.com>
In-Reply-To: <20181205192255.GA988@alison-desk.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Dec 2018 15:35:36 -0800
X-Gmail-Original-Message-ID: <CALCETrXsh6wAy9kE_m1L+0yW8a6bNOb6g2Tf9nwpQJnyMzdSuw@mail.gmail.com>
Message-ID: <CALCETrXsh6wAy9kE_m1L+0yW8a6bNOb6g2Tf9nwpQJnyMzdSuw@mail.gmail.com>
Subject: Re: [RFC v2 01/13] x86/mktme: Document the MKTME APIs
To:     alison.schofield@intel.com
Cc:     David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, kai.huang@intel.com,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

>> On Dec 5, 2018, at 11:22 AM, Alison Schofield <alison.schofield@intel.co=
m> wrote:
>>
>> On Wed, Dec 05, 2018 at 10:11:18AM -0800, Andy Lutomirski wrote:
>>
>>
>>> On Dec 3, 2018, at 11:39 PM, Alison Schofield <alison.schofield@intel.c=
om> wrote:
>>
>> I realize you=E2=80=99re writing code to expose hardware behavior, but I=
=E2=80=99m not sure this
>> really makes sense in this context.
>
> Your observation is accurate. The Usage defined here is very closely
> aligned to the Intel MKTME Architecture spec. That's a starting point,
> but not the ending point. We need to implement the feature set that
> makes sense. More below...
>
>>> +
>>> +    type=3D
>>> +        *user*    User will supply the encryption key data. Use this
>>> +                type to directly program a hardware encryption key.
>>> +
>>
>> I think that =E2=80=9Cuser=E2=80=9D probably sense as a =E2=80=9Ckey ser=
vice=E2=80=9D key, but I don=E2=80=99t think it is at all useful for non-pe=
rsistent memory.  Even if we take for granted that MKTME for anonymous memo=
ry is useful at all, =E2=80=9Ccpu=E2=80=9D seems to be better in all respec=
ts.
>>
>>
>> Perhaps support for =E2=80=9Cuser=E2=80=9D should be tabled until there=
=E2=80=99s a design for how to use this for pmem?  I imagine it would look =
quite a bit like dm-crypt.  Advanced pmem filesystems could plausibly use d=
ifferent keys for different files, I suppose.
>>
>> If =E2=80=9Cuser=E2=80=9D is dropped, I think a lot of the complexity go=
es away. Hotplug becomes automatic, right?
>
> Dropping 'user' type removes a great deal of complexity.
>
> Let me follow up in 2 ways:
> 1) Find out when MKTME support for pmem is required.
> 2) Go back to the the requirements and get the justification for user
> type.
>
>>
>>> +        *cpu*    User requests a CPU generated encryption key.
>>
>> Okay, maybe, but it=E2=80=99s still unclear to me exactly what the inten=
ded benefit is, though.
> *cpu* is the RANDOM key generated by the cpu. If there were no other
> options, then this would be default, and go away.
>
>>> +        *clear* User requests that a hardware encryption key be
>>> +                cleared. This will clear the encryption key from
>>> +                the hardware. On execution this hardware key gets
>>> +                TME behavior.
>>> +
>>
>> Why is this a key type?  Shouldn=E2=80=99t the API to select a key just =
have an option to ask for no key to be used?
>
> The *clear* key has been requested in order to clear/erase the users
> key data that has been programmed into a hardware slot. User does not
> want to leave a slot programmed with their encryption data when they
> are done with it.

Can=E2=80=99t you just clear the key when the key is deleted by the user?
Asking the user to allocate a *new* key and hope that it somehow ends
up in the same spot seems like a poor design, especially if future
hardware gains support for key slot virtualization in some way that
makes the slot allocation more dynamic.

>
>>> +        *no-encrypt*
>>> +                 User requests that hardware does not encrypt
>>> +                 memory when this key is in use.
>>
>> Same as above.  If there=E2=80=99s a performance benefit, then there cou=
ld be a way to ask for cleartext memory.  Similarly, some pmem users may wa=
nt a way to keep their pmem unencrypted.
>
> So, this is the way to ask for cleartext memory.
> The entire system will be encrypted with the system wide TME Key.
> A subset of that will be protected with MKTME Keys.
> If user wants, no encrypt, this *no-encrypt* is the way to do it.
>

Understood.  I=E2=80=99m saying that having a *key* (in the add_key sense) =
for
it seems unnecessary.  Whatever the final API for controlling the use
of keys, adding an option to ask for clear text seems reasonable.
This actually seems more useful for anonymous memory than the
cpu-generates keys are IMO.

I do think that, before you invest too much time in perfecting the
series with the current design, you should identify the use cases,
make sure the use cases are valid, and figure out whether your API
design is appropriate.  After considerable head-scratching, I haven=E2=80=
=99t
thought of a reason that explicit CPU generated keys are any better
than the default TME key, at least in the absence of additional
hardware support for locking down what code can use what key.  The
sole exception is that a key can be removed, which is probably faster
than directly zeroing large amounts of data.

I understand that it would be very nice to say "hey, cloud customer,
your VM has all its memory encrypted with a key that is unique to your
VM", but that seems to be more or less just a platitude with no actual
effect.  Anyone who snoops the memory bus or steals a DIMM learns
nothing unless they also take control of the CPU and can replay all
the data into the CPU.  On the other hand, anyone who can get the CPU
to read from a given physical address (which seems like the most
likely threat) can just get the CPU to decrypt any tenant's data.  So,
for example, if someone manages to write a couple of words to the EPT
for one VM, then they can easily read another VM's data, MKTME or no
MKTME, because the memory controller has no clue which VM initiated
the access.

I suppose there's some smallish value in rotating the key every now
and then to make old data non-replayable, but an attack that
compromises the memory bus and only later compromises the CPU is a
strange threat model.
