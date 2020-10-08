Return-Path: <SRS0=sAtF=DP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA6C4363D
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 00:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E2A20872
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 00:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="NGN+kjcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgJHAlH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Oct 2020 20:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJHAlH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Oct 2020 20:41:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D94C061755
        for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2020 17:41:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a3so5511672ejy.11
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2020 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=19bhq8c46tqD2XXeaXIOYNV1pnsPaE+IkbLDl3E+riY=;
        b=NGN+kjcrz++DE8iKOhqxPsGstoJr8kGZcAKwpctOK59+twhJp1b9/+esc7YuhPMUz6
         ZbMp8XiyIMdP0ZOBrLS48pL/oXTBNqZBAe4QZdvGSpXpvENEcCsvlUwKpmxFV4q0Mdrl
         PJ13DHXITdtS46ywwMKQtEjpOAzMQ1tiaXliLOM8s9POyMFrusiVnPsxcc1Uom1OIvnD
         ORFfxmCamYNPxTfXu0E7FTqXYKHXOlf4/n/ruF0+dTmdPhceAZsbtKnz036r/5tUxSPM
         mjOX56wORybJSY9Y79rVgnf9sFcv2poUuOW1FrvSpy8Eyl9s9knv3K9J3WTQA3mvjcCQ
         qw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=19bhq8c46tqD2XXeaXIOYNV1pnsPaE+IkbLDl3E+riY=;
        b=kxEE0WpnVRT6BWqW3exDoqtgYjiWRTpwueW8m+/Am3GMbApFjM+M/IVDtJA6KqFf/w
         /pEIA0NHVKtaes7XN1rN6BJ0nLEciXR0Jj94SWupRHRbbXoCboWoTcgMA8Wiot9p7GZC
         WN+2mxrZ3JpT3/3SxhN/nf9AXwCQK45PfeY/6kaIOU6xrjFoDiZ5GjTOlCc9jnIhvXM1
         xJpmGqV21bVoMi4oaGarTD9xzTqhfYiHg67JBRQPAcbUwtksrYPH69cI+w1tbXHXEBEt
         r6k5vn5Vg1pd/HsVHw82Gy0KvC8zSoy7rTrG9FsEbI1wp7Sup0jp2JrFivRifFR6CxAj
         DD2Q==
X-Gm-Message-State: AOAM531rDGgj2ObNN8w0F/7V3NGKyaz6FpPullTEuSlreup4Dp9TPMeE
        Gekk546JMDDgcH/SwY/4AY1WZ2lyVLuy7bvxrl37++RLthc=
X-Google-Smtp-Source: ABdhPJxlSJO00Y+vmDL8haQYegRlhaLWRVQt9JZSxINzZ3/xDHSst9IZSgCWykU/EemIUwvjXRF+Kp4GzZ/Kuqb5o2A=
X-Received: by 2002:a17:906:bfe2:: with SMTP id vr2mr2961173ejb.248.1602117664979;
 Wed, 07 Oct 2020 17:41:04 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 7 Oct 2020 20:40:54 -0400
Message-ID: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
Subject: selinux: how to query if selinux is enabled
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi folks,

From some linux kernel module, is it possible to query and find out
whether or not selinux is currently enabled or not?

Thank you.
