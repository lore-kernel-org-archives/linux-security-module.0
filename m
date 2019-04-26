Return-Path: <SRS0=T836=S4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78A5C43218
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAA420B7C
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556296842;
	bh=aYGrbI1SERNmOyxhJ75tfrfLL0vn3KNBa/t1RILo5+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PNzeDDX/i9sP9o2SJhMj0r02VZ71cGIp26RTJGVlIZtijRyqzzN0ayxfM6Vrf0n1R
	 z5xgGvSVi/k2dzQ6tQk+swK7m4WZwM8SSvXbVJ0Y99WSVU93JCS8osjbHGeS1iS7h6
	 CX8LEM6HR9lHv55PoIZ+d/OddhY2g3mWlBgxLVBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfDZQkl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:40:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53724 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfDZQkl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Apr 2019 12:40:41 -0400
Received: by mail-it1-f196.google.com with SMTP id z4so6876531itc.3
        for <linux-security-module@vger.kernel.org>; Fri, 26 Apr 2019 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpfVP/lrM2Q2wBohc8zzCs4q+zAicjTmbOR9EpWu+KM=;
        b=YzBchEnw3mtY1YHu5sF33oylYVI3nOfEG4y0HZgQaJs3IGiOAGg2uLSxEMl9Byl9yI
         c0nS4Koilqx/n6yAiEj7u/DZRZpuFI+SF8Q3SwqUJe2sMDyec493TAbUU9pgD0X3cwNm
         0hERY2zqnEvAI+fi+jcfSLT6mHrs2vVPV5/AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpfVP/lrM2Q2wBohc8zzCs4q+zAicjTmbOR9EpWu+KM=;
        b=gSQnr4/yNtV3MhdICXz8l0yKzV38UyhDJSDozq6pP6lTs3V7sZoAZ9ye1H35hT9mkU
         iS4NYFeIFpgpbPx7CcWGDwHTV4wCfxYxDiTCIIO3kXDJnciNBwkjbSUVB8JbfKYI2Ph/
         ZMJ7nuFKa7Qe7UjNxsbWDthRNWl+Kl8TgcbNi41OvgXoa+oRtot2ayhrNz1MxDi10kRI
         Wl+ODihuKIuj4sK5vWYpBClGOf6ui8v9g3b0BsNXLJHoelX3PNDGq2cCRKuoVLkBKi3x
         KPu/wRqaX4bfh8tD0PaTO1oGznVURpsWkASW7QklyEzRgg8FjwY6WqIbBksxyixXDTBI
         EsTA==
X-Gm-Message-State: APjAAAVgA3wbG6NeGBFw+Qvl6oC9rTj3R5cPLZXbrh9lpVZBmd5cz7NX
        121QcGXDztrjIUF7NNbrlUp7Z8jdGFw6ll+CeA/iLQ==
X-Google-Smtp-Source: APXvYqwW9kSQ5c/BDQ9RuOU9AZc1pvkLKD+0Bxd2Hwf1ST13QGVew2CuHRgH9D9F36FW8jZnvHzXcwE8P2b2WkseHhg=
X-Received: by 2002:a24:198f:: with SMTP id b137mr8812183itb.105.1556296840738;
 Fri, 26 Apr 2019 09:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190426001143.4983-1-namit@vmware.com> <20190426001143.4983-15-namit@vmware.com>
In-Reply-To: <20190426001143.4983-15-namit@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Apr 2019 09:40:29 -0700
Message-ID: <CAADWXX8yZJ9Z4yfqG9wQcb2r+0O7VCk2uQLcOU1=-BOnYhjnow@mail.gmail.com>
Subject: Re: [PATCH v5 14/23] x86/mm/cpa: Add set_direct_map_ functions
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-hardening@lists.openwall.com, Linux-MM <linux-mm@kvack.org>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Nadav,

I get

       dmarc=fail (p=QUARANTINE sp=NONE dis=QUARANTINE) header.from=vmware.com

for these emails, because they lack the vmware DKIM signature.

It clearly did go through some vmware mail servers, but apparently not
the *right* external vmware SMTP gateway.

Please check with vmware MIS what the right SMTP setup for git-send-email is.

                 Linus

On Fri, Apr 26, 2019 at 12:32 AM Nadav Amit <namit@vmware.com> wrote:
>
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
> Add two new functions set_direct_map_default_noflush() and
> set_direct_map_invalid_noflush() for setting the direct map alias for the
> page to its default valid permissions and to an invalid state that cannot
> be cached in a TLB, respectively. These functions do not flush the TLB.
...
