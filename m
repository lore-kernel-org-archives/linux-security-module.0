Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810FC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0724920811
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTclWHyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfC2R1K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:27:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46792 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfC2R1K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 13:27:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so2631589ljk.13
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2019 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GiJXZ5xrqrslOyXUFa2D6Tq59VC2N7PSWBCjmjHxjOc=;
        b=eTclWHygd1RpE2VOl3s9gF07E6mPTt/WKSL2hNO3/cYhAlG1uq2/z6YJ821a34DCfe
         F4oBzsdBxYlB0nozfla2tEPghwpQCxulo3EMS7CnlnmG+fOi/crSCsCH/UzqhfiCK4Rz
         l2B55n77TK3oR1+UG9ypfbb0KLoIZjZRabCSzyP5MwcSJ+/ixeBc2b2EA1Fu1c+V7zic
         zHtf+9rnHjGed4naBthpsRY0fQD1B+CFoiRHm6uG+FMhJWwDiEfrFmz4nf+5YTapMFN1
         +Ri0RJLys6zYcPJ0DuNbheagYJhl7GmE+U/89C10ypTspOIReCRl4EMWtDVl/z+xTG/O
         0zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GiJXZ5xrqrslOyXUFa2D6Tq59VC2N7PSWBCjmjHxjOc=;
        b=bpqVct5roC5WPJuboKPQozApxY6Ks7MuwlHxnVFEYIko5ksuZV19pZCbsVmmEMd/bb
         PPbWny7FuqSfD0LjkYwSRZpkPMtnvTsKZylfakj17RuGDVjCvW1IAFw/vB3It9+cmBFl
         nMl7nhPnCUwIukWIxxmGpcegBKdY5oKbXukXlkh82T57MybFhMKCFtCYjRpmjNpiulsS
         jT63qEu4g7wcCNx/pDMBoaSN6VneOinzrPVltrHwXHKrqlyzRNX1c57cX3dm+p5SWk4M
         vtd7tzxIInP0uGWwsJ2sPIKdzyDW+EV8VZiTfIODsM1ocMgGt13cdX00+Y4bo0k1jEL6
         50CA==
X-Gm-Message-State: APjAAAUjAykGf5MJxldFy4mL2CvqvoHzDWorv8uLRoOcu4b6N0b2xs0P
        750MpQhuvRdoAHFemcXM31XfkE82eev+pA8BN++Tg9tN
X-Google-Smtp-Source: APXvYqwKwCuUHnr85ZZoC2nwxid3ib0cGyjkUNmcEhVc8zWEJtSS2cixC8lmoe06LnUquOm3HrZrFGkWCApHyUmb8oo=
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr18991944ljj.27.1553880427729;
 Fri, 29 Mar 2019 10:27:07 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Fri, 29 Mar 2019 17:26:57 +0000
Message-ID: <CABatt_wR2t_jLYx3=-uivpDHnGpozdhBzZOBcz3KJ=Mi-PikBw@mail.gmail.com>
Subject: LoadPin old-api-denied
To:     LSM <linux-security-module@vger.kernel.org>, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I'm seeing the following message when trying to load some backported
kernel modules:
Mar 29 16:24:09 mach-cw-rnet-ppm-1840 kernel: LoadPin: kernel-module
old-api-denied obj=<unknown> pid=340 cmdline="modprobe compat"

I have other kernel modules that were built out of tree and these load
fine, the only difference I can see is that they are loaded via
/etc/modules-load.d

I've read through the loadpin docs and it states that it will only
allow modules that are from the main root filesystem and that
filesystem is read-only.  I've checked and both of these are true for
the failing module.  I've read through the source code and there's a
comment above the code path that loadpin is taking where the file
pointer is NULL.
/* This handles the older init_module API that has a NULL file. */
if (!file) {

I'm not 100% sure what this means, but could it be that
modprobe/insmod are using this older init_module API? if so how can I
get around this, I need to manually insert these modules at an
appropriate time during boot?

Any help greatly appreciated,

Martin.
