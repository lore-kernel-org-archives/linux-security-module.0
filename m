Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C900C38A2A
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A598208E4
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 19:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI2IvlZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEGTtS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTtS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 15:49:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80EC05BD43;
        Thu,  7 May 2020 12:49:18 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id m24so4140905vsq.10;
        Thu, 07 May 2020 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wb8F/ktqtwXPdBAH5RC8RzKS0114niTdu3jaRtN4XCI=;
        b=mI2IvlZAPfNrKd1oowNvjfIJvNUUSgye3FrAlNG1rrKDt9P4vp6KIqeAT8JgpaXsbX
         tn0Geo6nWxFB8S8kAB5FYLr/x4VK++NJNKpgtiGA+5H7pFFmhWJiQ72pxee1Tcmx8UOE
         FEKPYmVIqhTKqO+vjfwE0S6TxoNAP7PHZa+8DIox8b+P3cpuA7DEmCoI7ih9/C0ONNs0
         LawmGbzwUM6siJZSbq4+ZX86clp4Awxfv7HYd1uQhEgmaHsL0jOqHU6qOYVeVXwkomIS
         FNSLWL3fm/8XX1xRajwQZ1wmuKyKs+iZulVTnlHaW0EV4EMXfMIOzi8c45Cw2R7A0C5U
         +JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wb8F/ktqtwXPdBAH5RC8RzKS0114niTdu3jaRtN4XCI=;
        b=Ii1ugu1Fnr0Jot2kECoTSfZfPiUt0IyCVQvfFBdewW2k58pq0K6QD+Xbuj0dBCGF22
         XCsOmiYGq1Kug96n2/M+Sjp/FiWrU1Zz3kzaQKm8t2QNvlsS/EOaE/K7pb1xKAmlHA4K
         lyYlUZqIt2QhMFblXZqfnHolfWQdo5RDtNwhrLRqL6xATVO0RFBv/cX+K3BkRve0bSmf
         e7POlTsGDMnaH2ygoL5kyQevju8OWk+TWsuE9zog/8lwoED2h+0vc+rgEzv/u9ehxUJX
         Up3oA1yqpPow5Sm/3HfYmLCeLi5kSZdbDLXxpX5BPJEUySEP4S254yevigKnsfTIkaIn
         moAQ==
X-Gm-Message-State: AGi0Pubw4oi2p+JAMNPY1q2KLOdCmlmNoG9Dh9vVSTRoODG5QEokjYW0
        owlgv6MZ3cg59UYQHmKlTd14XlSErxQmEN1jAQ82lJ2GwSA=
X-Google-Smtp-Source: APiQypL4L0Nj3j/dNDjLf1rb9EJ+dtNu8FlTUJP2ugx9kCTQ/aFRN4BqAD06LCtlmraPU/shuAl8xZJ76M4w5IEx6kw=
X-Received: by 2002:a67:fc46:: with SMTP id p6mr15108104vsq.169.1588880957253;
 Thu, 07 May 2020 12:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com> <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Thu, 7 May 2020 20:49:05 +0100
Message-ID: <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 7 May 2020 at 20:22, <Mario.Limonciello@dell.com> wrote:
> By default the driver exposes SPI serial flash contents as read-only but =
it can
> be changed from kernel command line, passing =E2=80=9Cintel-spi.writeable=
=3D1=E2=80=9D.

Ahh, that was the bit I didn't know; having the SPI as readonly by
default is certainly a good idea, and probably sane enough to enable
for Fedora/RHEL as you still need to "do" something manual to enable
SPI writing. I guess I can add my securityfs additions to
intel-spi-pci.c with Mikas approval.

Richard
