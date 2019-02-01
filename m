Return-Path: <SRS0=Dufg=QI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C5C282D8
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 17:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93B218AC
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 17:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVWglcuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfBARtb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:49:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34707 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfBARt0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Feb 2019 12:49:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so5722881lfc.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Feb 2019 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7lrexG/S2ZMmYpuKyHJIqG74wkYAVGMQ+BpnsBM9Cw=;
        b=bVWglcuNXEYTcI2DPnNSJ687yDAFVE4LcRlyGlRu7KEiazzElLdp5QEWYsGNIuQGmi
         YR+S8F55RsjKDcMQ3sMl+WG3f/Ikw7suvXaNS091xV3aTRgKeoif4C/YT7Yd3imeJ2LM
         D8CjhFcy9U6Q/hQGqvhp8pBKE19I+a0LgJ04g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7lrexG/S2ZMmYpuKyHJIqG74wkYAVGMQ+BpnsBM9Cw=;
        b=sDcanE5LMpH0wfQT9pJ2MxhAVnR/D7KIP5ZJefD1LzbXRVhKSflx+c+OQ6Mg5aX1Nu
         vgkuaKYgMVzgbW4y9SI8OlVXfJc4CmfBHNeHaeShJ3bMWHRMFHzxUWk503ZQvHDYNe32
         E7LhBLkKrC6e1ZZGZ8hYbpSJfyVY1Jg73CCi/GCsrp4zdQw0XWAWeXITV4r0M3BgWN32
         /UlzrlqKX5Y5rWPmjwVGlRkFPhvjLaSvp8XtOc3e5WBYhBac97mBgjsGc7flFwytWoMI
         7gwO0zxs6Vk9hp5FxLeE8nkax3FcuTACUIaQuqV1lKlc02nQqo3M/rHbN64xru4/0gyM
         pRRA==
X-Gm-Message-State: AHQUAuYWVaCs0SWoCP5emmOvJeJbs/zajjN5poyhPYG0wJCA5FvPAsQh
        LiuDkMBzA5Tc7JAAv99yD6Xbvd+gOHs=
X-Google-Smtp-Source: AHgI3IbdXClTCGPKbcULZ3wTkgdO6YLefGTbYE82lnPGWQLou5ukeSZ33XB8K4RQM15AFL8QOlVcuQ==
X-Received: by 2002:ac2:53b7:: with SMTP id j23mr4843289lfh.109.1549043363251;
        Fri, 01 Feb 2019 09:49:23 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d5sm1448209lfi.65.2019.02.01.09.49.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:49:22 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id x201so4391373lff.10
        for <linux-security-module@vger.kernel.org>; Fri, 01 Feb 2019 09:49:21 -0800 (PST)
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr32303202lfk.78.1549043361378;
 Fri, 01 Feb 2019 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Feb 2019 09:49:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Message-ID: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 1, 2019 at 3:33 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Thus, it makes sense to fix this also in tpm_crb, not least because
> the fix can be then backported to stable kernels and make them more robust
> when compiled in differing environments.

Ack, looks sane to me, and should help both the backport and probably
generate better code too.

In the meantime, I've committed the iomem.c change with a *long*
commit message. For all we know, there might be other cases like this
lurking somewhere else that just happened to work. Plus it's the right
thing to do anyway.

               Linus
