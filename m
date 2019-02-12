Return-Path: <SRS0=n6I0=QT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC494C282C4
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 17:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9066B222BB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 17:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXi/S/5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfBLRyz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:54:55 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46657 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbfBLRyz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Feb 2019 12:54:55 -0500
Received: by mail-vs1-f68.google.com with SMTP id n10so2107564vso.13
        for <linux-security-module@vger.kernel.org>; Tue, 12 Feb 2019 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsXKwkLM/R+hXtwloqz5pZs2yFDYV/aAOBs3Mg0VcqE=;
        b=YXi/S/5kfTLdxSWAC3y0wCGTa7uM67tEQsikFhpMThsF3Fc43hRI+myllvvpMyORc4
         zalCEhLUpcmJDU69dqHBEnudfmhTKEPJI19BZwd1rnqTqZNi4sBT62dYW1rWTaQXVUiK
         AiWOmDGpgYilpu0vMEamKc5zcK457gNd9aeMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsXKwkLM/R+hXtwloqz5pZs2yFDYV/aAOBs3Mg0VcqE=;
        b=cgMLfp8daEPW8aAtopCjgBSdegVZhuNjblvsbwBxLjF9xyLqwHEdB/IEdx2JSltElC
         KBCwvGPssSg1eoCdgm5yTIRHWyxpRwGNahJsT2ZZXnX2I2bUsRL3JbxtyTHheIV7IG/r
         tMZjqyubT0llt/6ncJBY6KBzbVA2A/MeV5tJes7e61HQcsrgxBfZDx64GviV2MCtIaPs
         q+bOnxEM+wwKU1jkig39kyw0g6FBiER/N2xRha1EAtYmXPptCC+0ZtSPQ9kNZ90hCvv3
         6W881aj+J7gs77o+JTNEG1PUPul9iPqK9zCA6m/W1WdNLPgEYIbxZjJoEPSxVZdeLoOr
         czQA==
X-Gm-Message-State: AHQUAuYgD53oDGNeCjakFaTOy3JFeSdbVmJajeFiJqT0LpXxbclMJG9Q
        Y2RNr3c08pDYLz6OrrmcCO5HN6QZPAA=
X-Google-Smtp-Source: AHgI3IYYSf5G1KuWRwC5Cjgd2Y9x6MTtpT6n48HLpkRFq1NMBJUJiBpZra1PypSAKBmTueR4eB5nhg==
X-Received: by 2002:a67:7fc7:: with SMTP id a190mr2016519vsd.131.1549994093342;
        Tue, 12 Feb 2019 09:54:53 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id d67sm8080422vkd.45.2019.02.12.09.54.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:54:51 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id i64so2133377vsc.8
        for <linux-security-module@vger.kernel.org>; Tue, 12 Feb 2019 09:54:50 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr2023032vsp.188.1549994090430;
 Tue, 12 Feb 2019 09:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20190123110349.35882-1-keescook@chromium.org> <874b8c23-068b-f8e7-2168-12947c06e145@linux.com>
In-Reply-To: <874b8c23-068b-f8e7-2168-12947c06e145@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 09:54:38 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+xz8_wkY2rVRML_iq1o7ZoF1jVp2mi73LjxaKuMNw1cw@mail.gmail.com>
Message-ID: <CAGXu5j+xz8_wkY2rVRML_iq1o7ZoF1jVp2mi73LjxaKuMNw1cw@mail.gmail.com>
Subject: Re: [PATCH 0/3] gcc-plugins: Introduce stackinit plugin
To:     Alexander Popov <alex.popov@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, intel-gfx@lists.freedesktop.org,
        intel-wired-lan@lists.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, dev@openvswitch.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Edwin Zimmerman <edwin@211mainstreet.net>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 28, 2019 at 4:12 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 23.01.2019 14:03, Kees Cook wrote:
> > This adds a new plugin "stackinit" that attempts to perform unconditional
> > initialization of all stack variables
>
> Hello Kees! Hello everyone!
>
> I was curious about the performance impact of the initialization of all stack
> variables. So I did a very brief test with this plugin on top of 4.20.5.
>
> hackbench on Intel Core i7-4770 showed ~0.7% slowdown.
> hackbench on Kirin 620 (ARM Cortex-A53 Octa-core 1.2GHz) showed ~1.3% slowdown.

Thanks for looking at this! I'll be including my hackbench
measurements for the v2 here in a moment.

> This test involves the kernel scheduler and allocator. I can't say whether they
> use stack aggressively. Maybe performance tests of other subsystems (e.g.
> network subsystem) can show different numbers. Did you try?

I haven't found a stable network test yet. If someone can find a
reasonable workload, I'd love to hear about it.

> I've heard a hypothesis that the initialization of all stack variables would
> pollute CPU caches, which is critical for some types of computations. Maybe some
> micro-benchmarks can disprove/confirm that?

I kind of think micro-benchmarks aren't so useful because they don't
represent a real-world workload. I've heard people talk about SAP-HANA
as a good test, but I can't get my hands on it. I wonder if anyone has
tried "mysqlslap"?

-- 
Kees Cook
