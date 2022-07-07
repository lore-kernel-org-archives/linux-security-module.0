Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE9C43334
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 08:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGGIyP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiGGIyO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 04:54:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B3C326DF
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 01:54:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d12so6639049lfq.12
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMufOnGt5GDik8InFIYB4XbqT5gXE6gGkijhqrGLbhU=;
        b=mq850q+A9dkK0SSmPzh8RVu8+ALsSnMlLeXO/07axOosHR6ne1A8TpjV6FPlBYjRix
         tysNmHsIS/MEMEPkGGhSYLFAWTl62z6qn4er7MxeQd+xW1apvNIRB7G/M2KOfiozYy6Y
         3/atMBHus+q35N07bWS9oDXyGpypZdMS0BpLGOL98V7wCqAy+qKw5A9dBx3M944CrLAO
         1RNWT0OKwbqoXGO3kqhTyVAsXsU8MQG2C9unJqkoQz+i8+aS45icocxll27zr0IYp5JG
         kiDiJYtyDUhiuLy63+BBJCjPsgNAxNTJjFE0z+Obq4CWQ9tum7+a2x9g4wbjvSQ8kylN
         388A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMufOnGt5GDik8InFIYB4XbqT5gXE6gGkijhqrGLbhU=;
        b=qt8wE1w9r8lmjflGIDD9yOWknHMVdR5Uri9qpUpdXdR0N2ta1WkTGR996cvmLpZx6w
         tcVwBkzfXVoaJ0KQQsF4UptY9NFdZ6xXP1jrOn/KePlw7PjJw7lmOAirBRzblmysxukK
         mec0IyrTTcg11vkCjo8F3P5gend8bdyFQyWOqz/8iEfjL2kyYC5sS/HKFdtqTGrOnZTQ
         cr58K/5HTK8YzUvGp7P7oN3V0nyPj8vQghkliB+11175xHtb+rU3ltMmfDIr2IA2qb/p
         tWTnxnZzw21Z2Y36bwzSzrmoe7HGEX5kNObCZQjnwHKOJw0fto61IjV9uSJzQLkrz9Lt
         iI5w==
X-Gm-Message-State: AJIora9nvKE8O3P62Lz/BEbZAa/JAvCVNsTc/gmOQdot8E78CvaC/KRz
        cZz9xz2wfpvd0b7S2MQSlagq/qUqh+0yprFmqiNrzUl3+KQ=
X-Google-Smtp-Source: AGRyM1uBqP93Y9MaXcW+ua3FxjbBXbMsGrSuVPcpG/hNmFsRlB3w1BViLs853bFyYhTV6JV3nN/xAvXmYMy7Hgd4xxQ=
X-Received: by 2002:a05:6512:16a3:b0:485:6df4:2cb1 with SMTP id
 bu35-20020a05651216a300b004856df42cb1mr5784814lfb.208.1657184051914; Thu, 07
 Jul 2022 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
 <f871c6ad-0fa1-1c4a-bf7c-47070abce444@schaufler-ca.com>
In-Reply-To: <f871c6ad-0fa1-1c4a-bf7c-47070abce444@schaufler-ca.com>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Thu, 7 Jul 2022 11:54:00 +0300
Message-ID: <CACE9dm-uGHEK7NuQ35CR+MhhB9z2Nw0W0SgttRL7qzohi9Egqw@mail.gmail.com>
Subject: Re: LSM performance measurement
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Casey,

Thanks. Those certainly sound familiar..
Will have a look.

-Dmitry

On Wed, Jul 6, 2022 at 6:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 7/6/2022 8:22 AM, Dmitry Kasatkin wrote:
> > Hi,
> >
> > Could anybody suggest a good approach/test suite to measure LSMs
> > runtime overheads?
>
> I have used LMbench, ltp and kernel builds when checking the
> overhead on the LSM stacking work. I have also tried timing the
> SELinux, audit and Smack testsuites, but they all have built in
> delays that make performance numbers questionable. Be sure to
> include network throughput and latency measurements if you're
> looking at SELinux and/or Smack. Also be sure that you have
> meaningful policy loaded, that you're consistent with how IMA
> is used, and that you know how your audit limits are configured.
>


-- 
Thanks,
Dmitry
