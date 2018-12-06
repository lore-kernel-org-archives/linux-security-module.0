Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA04C04EB9
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 01:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B6220892
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 01:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zcW/ZtmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B6220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeLFB0H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:26:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39095 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFB0H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 20:26:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so16695410otl.6
        for <linux-security-module@vger.kernel.org>; Wed, 05 Dec 2018 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOznW5nm480uXoIyKiDIeNVFCtLiK2+Fso6nzxzg9Sk=;
        b=zcW/ZtmF6t4Tq0gwoakwsfWRKwPdOabZmweOKCgVUeGsDp88OV1jciJdl4WAVAjgo1
         zmSwZXlAITKkVcc8+MjFFJQdKFybqMUWi3oX7zYZylbqwnZhRR1yV0tnzQrmNWaWCHFx
         YaeseWpYAj5gBPXnafsy0C3jLKDp+pgerFRMEGcgXMV/JSvpLY86o63sAmGJyJvJwL5U
         CeWYivvIVpOSahK8M3Sdp/FpeP/f6wD7gRnCQnefjYnt0OHrQx3hJ59bhEif0aWKu3qN
         IIfpEkG2IAsOdsZyBt6yioBCM8W3DdxTOLBHL685H3Aw04kHLSMMdp/WIZbso56ZPK8x
         Fr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOznW5nm480uXoIyKiDIeNVFCtLiK2+Fso6nzxzg9Sk=;
        b=B4rjW2+aGir4VuJwFw1BCvmm8F3c3U3IdzF/U5OgrJENpyhknygBuGO8010iZl2Nxy
         vqhdtcYJrBfh9HfeAIHg1n+w5Tm/juhdJtC+U4R23W2i3E4pOzlYAaMCqQHSfHnrRaAx
         UPRUy7OCnZv1OUNeS0Pwncea+JtXfN05XNwTSGmsU8JM2rvjxi4fQ37MoYKtXsu8GY1P
         S1fgNgf8wldAF3WT2lYHdu/zS+4taMAkwy0NQz9KhEYsSfzamvYeH9g0ffzft7/hDeqb
         H5LeWaO3/H7HjiUA9Y2mZ4bShXEkEJ3zerZy9e0JkRCgoTopqGyTcZBdoR//EQ8xp2cj
         oKJA==
X-Gm-Message-State: AA+aEWbGBQWYiSg7xC+LeW+cxU5y4aqq2s5++9cqHz8kRhvBetNaq+dO
        NCfYCEE/h9QfujjaOidtI6TQ529wgqRMITniP8vhzg==
X-Google-Smtp-Source: AFSGD/WOiIXIRN7tluKwzJJqhQIlodb+ebtlZRFjDjLgLunQVbfoyYgO8oB5m1jca852wQpUHwIPbW3Nbsz236BCHfk=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr16537226otg.229.1544059566604;
 Wed, 05 Dec 2018 17:26:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com> <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
In-Reply-To: <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Dec 2018 17:25:55 -0800
Message-ID: <CAPcyv4gg5ymssw75q9k8NwwPrstDUrqmCEeU_VNU=rKEM7izGg@mail.gmail.com>
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[ only responding to the pmem side of things... ]

On Wed, Dec 5, 2018 at 5:09 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Dec 5, 2018 at 3:49 PM Dave Hansen <dave.hansen@intel.com> wrote:
[..]
> > We also haven't settled on the file-backed properties.  For file-backed,
> > my hope was that you could do:
> >
> >         ptr = mmap(fd, size, prot);
> >         printf("ciphertext: %x\n", *ptr);
> >         mprotect_encrypt(ptr, len, prot, keyid);
> >         printf("plaintext: %x\n", *ptr);
>
> Why would you ever want the plaintext?  Also, how does this work on a
> normal fs, where relocation of the file would cause the ciphertext to
> get lost?  It really seems to be that it should look more like
> dm-crypt where you encrypt a filesystem.  Maybe you'd just configure
> the pmem device to be encrypted before you mount it, or you'd get a
> new pmem-mktme device node instead.  This would also avoid some nasty
> multiple-copies-of-the-direct-map issue, since you'd only ever have
> one of them mapped.

Yes, this is really the only way it can work. Otherwise you need to
teach the filesystem that "these blocks can't move without the key
because encryption", and have an fs-feature flag to say "you can't
mount this legacy / encryption unaware filesystem from an older kernel
because we're not sure you'll move something and break the
encryption".

So pmem namespaces (volumes) would be encrypted providing something
similar to dm-crypt, although we're looking at following the lead of
the fscrypt key management scheme.
