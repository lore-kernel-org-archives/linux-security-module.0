Return-Path: <SRS0=YlXY=OQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89BC07E85
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F3520868
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Dec 2018 23:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226812;
	bh=3Gt9hvf9FZJqk2BC20dGXauTReKTvwNpeI1Djtwo4qs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FyosMaNr9JxDvWDbjXf8oEpCw41r2IDa04SVgn5eOwaPprFfAVwuYvofF9dLNtjWk
	 AmEAH9uMUKtmJePAFDisC08A1uTe/eNNJK8gHK6knfeUTV4kOdd5fGvkHZ0cbsEorw
	 rURGMTBT6I1X6YvuU+Ghahh/ZSf4hI+dzROlKm2A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F3520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLGXxb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeLGXxb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Dec 2018 18:53:31 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70CB214F1
        for <linux-security-module@vger.kernel.org>; Fri,  7 Dec 2018 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544226810;
        bh=3Gt9hvf9FZJqk2BC20dGXauTReKTvwNpeI1Djtwo4qs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tkzUiU6hQVawWr161oqZcGcCoNs4cGWvlg7UVEy07RIHHRqPmK5cG04X2Qaqh0npG
         sZOvHZKVAgVPljk8gXCVvv4uMLT0m9spAWox93Q6x9vj7E/4qDsY6OL179+C2+6LKH
         rqrvhzP7aO+p3mMJzS0JhSSn+plKbBNh2k7NVSgY=
Received: by mail-wm1-f48.google.com with SMTP id y1so5843581wmi.3
        for <linux-security-module@vger.kernel.org>; Fri, 07 Dec 2018 15:53:29 -0800 (PST)
X-Gm-Message-State: AA+aEWbs188xqH6gbWW8iAgnYRiGnZ3z+KTD506GXOXV1fKo3NbVT2pR
        y0DDKk0nNyD9G/QUyerf9GZXIyr5ABJcbOSrtw0bZw==
X-Google-Smtp-Source: AFSGD/XqhK1lvo0VGAjvQyEAgvy0AmacluDKcpntgU9CTmID7+uUKMTCdS0iBOz7rE5FXTtNNmZ+t2Qd1lFBs/xSgQI=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr4042733wmf.32.1544226808187;
 Fri, 07 Dec 2018 15:53:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com> <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
 <1544147742.28511.18.camel@intel.com>
In-Reply-To: <1544147742.28511.18.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 Dec 2018 15:53:16 -0800
X-Gmail-Original-Message-ID: <CALCETrWHqE-H1jTJY-ApuuLt5cyZ3N1UdgH+szgYm+7mUMZ2pg@mail.gmail.com>
Message-ID: <CALCETrWHqE-H1jTJY-ApuuLt5cyZ3N1UdgH+szgYm+7mUMZ2pg@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     kai.huang@intel.com
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Peter Zijlstra <peterz@infradead.org>,
        keyrings@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> On Dec 6, 2018, at 5:55 PM, Huang, Kai <kai.huang@intel.com> wrote:
>
>
>>
>> TME itself provides a ton of protection -- you can't just barge into
>> the datacenter, refrigerate the DIMMs, walk away with them, and read
>> off everyone's data.
>>
>> Am I missing something?
>
> I think we can make such assumption in most cases, but I think it's bette=
r that we don't make any
> assumption at all. For example, the admin of data center (or anyone) who =
has physical access to
> servers may do something malicious. I am not expert but there should be o=
ther physical attack
> methods besides coldboot attack, if the malicious employee can get physic=
al access to server w/o
> being detected.
>
>>
>>>
>>> But, I think what you're implying is that the security properties of
>>> user-supplied keys can only be *worse* than using CPU-generated keys
>>> (assuming the CPU does a good job generating it).  So, why bother
>>> allowing user-specified keys in the first place?
>>
>> That too :)
>
> I think one usage of user-specified key is for NVDIMM, since CPU key will=
 be gone after machine
> reboot, therefore if NVDIMM is encrypted by CPU key we are not able to re=
trieve it once
> shutdown/reboot, etc.
>
> There are some other use cases that already require tenant to send key to=
 CSP. For example, the VM
> image can be provided by tenant and encrypted by tenant's own key, and te=
nant needs to send key to
> CSP when asking CSP to run that encrypted image.


I can imagine a few reasons why one would want to encrypt one=E2=80=99s ima=
ge.
For example, the CSP could issue a public key and state, or even
attest, that the key is wrapped and locked to particular PCRs of their
TPM or otherwise protected by an enclave that verifies that the key is
only used to decrypt the image for the benefit of a hypervisor.

I don=E2=80=99t see what MKTME has to do with this.  The only remotely
plausible way I can see to use MKTME for this is to have the
hypervisor load a TPM (or other enclave) protected key into an MKTME
user key slot and to load customer-provided ciphertext into the
corresponding physical memory (using an MKTME no-encrypt slot).  But
this has three major problems.  First, it's effectively just a fancy
way to avoid one AES pass over the data.  Second, sensible scheme for
this type of VM image protection would use *authenticated* encryption
or at least verify a signature, which MKTME can't do.  The third
problem is the real show-stopper, though: this scheme requires that
the ciphertext go into predetermined physical addresses, which would
be a giant mess.
