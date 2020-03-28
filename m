Return-Path: <SRS0=+cyb=5N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEEFC2D0E5
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Mar 2020 21:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D444020732
	for <linux-security-module@archiver.kernel.org>; Sat, 28 Mar 2020 21:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvU8SQl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgC1VuS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:50:18 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37510 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgC1VuR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 28 Mar 2020 17:50:17 -0400
Received: by mail-pj1-f65.google.com with SMTP id o12so5486898pjs.2
        for <linux-security-module@vger.kernel.org>; Sat, 28 Mar 2020 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRb5IsEMXQfgboPnAgWj3+2vIpSyjSusXFWfLG3LqXc=;
        b=CvU8SQl5E+YmYbDxDmbskBQ2t0JHHJQ8sASp0i2I0gH2ECAI5tRnkGDbtdi/C0KT5R
         LbajgCaWikJ72Ca+qnR7CDrJck+PCmajv50Re1zqDdZjjyRVXL4YMc9/4bUJWPVD1kum
         wnnHIQxObr7V1lZf1r4WgKqWIy6wY+zGWsFq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRb5IsEMXQfgboPnAgWj3+2vIpSyjSusXFWfLG3LqXc=;
        b=QVfq/gpsqx3qb0p5VTFj0ukwKvG8g+430us+laquBFf4j5c/Kcsju5T2O8L2mkyUKe
         YkFDYhlHgqdnbUqtDIyRomdvhm86GJi5UDin2ANkPajtRlovu84StV7hRDEt2nqWC9Wi
         yr2nhyOXPGymkRjratlU3NQeBL4ZZaY2wskBHafIvurR1mpEcYcfHAk3GWhE2AuwQWYH
         07E14/kMScDlfcOFy0lIP0zBYda6Wmu950+CvjMZJSnY2S84XhFmhaCpFZVXKIGn8Y03
         +/bVxwb0a/ziLwqJaPblNUSA8dZ5I1ZkNgoFbM/b9Rb3RS0f7lW1iSl6wVrFqHaAuBs6
         0Xjg==
X-Gm-Message-State: ANhLgQ07G2QDsnejagb7AtgEh2SgGejJXoo6PDFXszyKVSjbrGAsVqp5
        xlOk2w2NLZZQSZougqGxyx5U+Q==
X-Google-Smtp-Source: ADFU+vu2NiUwwEDLHzJMv3dcJEsAb3IO6DOtzKCkclXs6mjC9Cb9juZjNRndmUuOgRpk8swbUuht2A==
X-Received: by 2002:a17:90a:5d96:: with SMTP id t22mr7300491pji.132.1585432216326;
        Sat, 28 Mar 2020 14:50:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189sm6820905pfg.170.2020.03.28.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:50:15 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:50:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <202003281449.333BDAF6@keescook>
References: <20200327192854.31150-1-kpsingh@chromium.org>
 <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328195636.GA95544@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
> Since the attachment succeeds and the hook does not get called, it
> seems like "bpf" LSM is not being initialized and the hook, although
> present, does not get called.
> 
> This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
> there by default as we added it to default value of CONFIG_LSM and
> also for other DEFAULT_SECURITY_* options.
> 
> Let me know if that's the case and it fixes it.

Is the selftest expected to at least fail cleanly (i.e. not segfault)
when the BPF LSF is not built into the kernel?

-- 
Kees Cook
