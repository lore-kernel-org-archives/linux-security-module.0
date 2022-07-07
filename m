Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9135DC433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 08:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiGGIzJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiGGIzJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 04:55:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BFB326E5
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 01:55:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t24so30004119lfr.4
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lY/lsBhQBz8QvneU4i4JCT6k5G987YiEUZYiRd9GBEo=;
        b=gkd1cvKO/qP8Vu3xfg+LDmsebuj4tLeI0t/TdkF86LKu1W85F1Av2N0ZzfHjljwE7N
         PaNz1D4O8yjdj+O13Cp6cyiLilpJdbpFyMau0AnIPQmtp73jJejbfGBfqTCzxWIbAowl
         ydX8hAVSY8+cihpy6+aRhCeKcGZa/RgOTFdld6aNPJcaV16dlppuXcY7NORY3rBCdz7t
         rIen2gBUvIydNzuOsHIuzepCfGEnLe9DUETre7YGd87tjCa/qZyQnIJfdX577Fu7J2zi
         g2mFVENSddhl91i6nvaNdFli9PTu6stBGAknoxa9Iopw9kHtz7mhRoJJQDhL9pixVwrc
         Ojhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lY/lsBhQBz8QvneU4i4JCT6k5G987YiEUZYiRd9GBEo=;
        b=iRjJcqD7q1L9e4gNUAdbQI28jlMuBDs3l3EO2Lgrx2dnA6oRuS3KRspNk9MPhXeHkP
         EYsGSTNxqqaD3vEe/7nC/F/rjMCbTB3kKJqMfIH4gpdXdcwUsohNkJ3aq8EYz6T9rtih
         o5ke6i0BS8qbY11p6BEzweqNEpjnUs9potiNNIJZoQN2ic53RlQ8d4KJelZpPcrBBMYr
         ijykYeybXfmC1Dvm9KX+5tX6TMLwIaOtjylX6Y8cSA6/UP6Xkq+kcqlUlCY0NKStxAOt
         tqJtwEWbwD05cPMcvjDoPe/2rHOIRf2DN5IOiTArDCcjfm5CwdIUjTegMlCjgIenfXoN
         FajQ==
X-Gm-Message-State: AJIora/v6YSEMbZhnKyVckWy2/cYiZNwN6zwKXQNVXyV4yqXUOKxZZyy
        XBcW4aWR1G/vKrD3LWUFFzJbqb+W7nzEFn1ILlM7XuYGbrI=
X-Google-Smtp-Source: AGRyM1utqlabePJsikcWyGWtuuW15gYdEE8KElfH38UPRnPifHL4Jhu5NNl3aHHRpDGdz5yiNsIhE+zujgVYxn7PcjU=
X-Received: by 2002:a05:6512:3409:b0:47f:af5b:b24e with SMTP id
 i9-20020a056512340900b0047faf5bb24emr31050687lfr.555.1657184105444; Thu, 07
 Jul 2022 01:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
 <1980b9da-fa51-44c8-9d8c-160e9bffd327@gmail.com>
In-Reply-To: <1980b9da-fa51-44c8-9d8c-160e9bffd327@gmail.com>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Thu, 7 Jul 2022 11:54:54 +0300
Message-ID: <CACE9dm-YDRPMkALweVH=7cnzW0hfGAd2w2Et9_jbTk-RywP3Rw@mail.gmail.com>
Subject: Re: LSM performance measurement
To:     Igor Zhbanov <izh1979@gmail.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 6, 2022 at 6:47 PM Igor Zhbanov <izh1979@gmail.com> wrote:
>
> Hi Dmitry,
>
> On 06.07.2022 18:22, Dmitry Kasatkin wrote:
> > Could anybody suggest a good approach/test suite to measure LSMs
> > runtime overheads?
>
> There are a couple of old articles on the same subject.
> So, you can get some ideas from there:
> - Evaluation of Performance of Secure OS Using Performance Evaluation
>   Mechanism of LSM-Based LSMPMON
>   http://www.swlab.cs.okayama-u.ac.jp/~yamauchi/research/sectech2010_yamamoto.pdf
> - Analyzing the Overhead of Filesystem Protection Using Linux Security Modules
>   https://arxiv.org/pdf/2101.11611
>

Hello,

Thanks. Google also gave me that second article.
Seems to be useful to read.


-- 
Thanks,
Dmitry
