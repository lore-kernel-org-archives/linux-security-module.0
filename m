Return-Path: <SRS0=+ZQZ=OP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED3C04EB8
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9DD2146D
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Dec 2018 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544122354;
	bh=oAgDX3wRJRoNdRE4dwh5IrKTPAbfj3Df+q4m08d44Gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RWyGg2QKY4j42JzTnWZPunhas7EymXN1N55JZUFkiAzBs9lBvs+mL//niNobgRJrC
	 G0ElGk1S86QoFEy35Cxi3vo7mHr2tqsAKSmSi513kv6BeAVERr7gZOTQDet0hRQK+q
	 +6usohYFVy/JlpqDaFew1zsLG5hLuLT6wJrWg1uU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9DD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeLFSwd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeLFSwc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Dec 2018 13:52:32 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745E5214DE
        for <linux-security-module@vger.kernel.org>; Thu,  6 Dec 2018 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544122351;
        bh=oAgDX3wRJRoNdRE4dwh5IrKTPAbfj3Df+q4m08d44Gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hW6QITFWMpM280ON9ldg4Unkt9T1OusqjhcMpJgc2BVk+BDS+QqK7F3x9tO5yfsF/
         fdKiv9nE+tqDlngZLqw+eeK4H4KH+htpzxekPWKyLLYFX0gzTSecWsSUkDBXzYPrAi
         dSGDp9nSZYmEl66KLoah+MsjrFaAlL7putMmT50s=
Received: by mail-wr1-f51.google.com with SMTP id t27so1525680wra.6
        for <linux-security-module@vger.kernel.org>; Thu, 06 Dec 2018 10:52:31 -0800 (PST)
X-Gm-Message-State: AA+aEWacvfcXGxKcvrbssLLEJ/fU/nDQWvmj+e0qsiCXLDydgzF7cVGa
        3AmZGR8z7imDAfBsiF1rJ/eiDNuDw8uj1m6RS69o0Q==
X-Google-Smtp-Source: AFSGD/XpdrwzoiKAf5DdSEf+1opYz4PuD/0mQWNsMc2USxRrqMI3p6CQhY1XCyrM2ajQJj/5LxQPs+4pnvcVcc3fjtI=
X-Received: by 2002:a5d:5502:: with SMTP id b2mr27227151wrv.330.1544122349912;
 Thu, 06 Dec 2018 10:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20181205013408.47725-1-namit@vmware.com> <20181205013408.47725-14-namit@vmware.com>
In-Reply-To: <20181205013408.47725-14-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 10:52:18 -0800
X-Gmail-Original-Message-ID: <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
Message-ID: <CALCETrWZf5sNmXU=yP1ZHxiBi=Z9d3G5FnWH08PasniG1hs26g@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before freeing
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 5, 2018 at 12:52 AM Nadav Amit <namit@vmware.com> wrote:
>
> When module memory is about to be freed, there is no apparent reason to
> make it (and its data) executable, but that's exactly what is done
> today. This is not efficient and not secure.
>
> There are various theories why it was done, but none of them seem as
> something that really require it today. nios2 uses kmalloc for module
> memory, but anyhow it does not change the PTEs of the module memory.  In
> x86, changing vmalloc'd memory mappings also modifies the direct mapping
> alias, but the NX-bit is not modified in such way.
>
> So let's remove it. Andy suggested that the changes of the PTEs can be
> avoided (excluding the direct-mapping alias), which is true. However,
> in x86 it requires some cleanup of the contiguous page allocator, which
> is outside of the scope of this patch-set.
>


I'm okay with this, but I'd like to see Rick's stuff get rebased on
top of it and clean it up for real.
