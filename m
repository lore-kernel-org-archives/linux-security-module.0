Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405ADC61DA4
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Mar 2023 22:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCFWk6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFWk5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Mar 2023 17:40:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A58410BD
        for <linux-security-module@vger.kernel.org>; Mon,  6 Mar 2023 14:40:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso14714222pjb.2
        for <linux-security-module@vger.kernel.org>; Mon, 06 Mar 2023 14:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678142456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBoig9wEGw3EbR3+woAH2dR4re4VhU48T9ppuwonemM=;
        b=Qck3KLSL4F/bYC/0Hy2X2d9uqc8wGtpfIXkb6zWlBJwzySwd3imhC5wOXe4grlWTM0
         lqXcCTYb3JoyXFGJ77Ady4FlPDbcT9gOgY4cxnKpaccscYpyMuo4d7Gsgpx5HroeHi0A
         HZvGfm2L3BZdXs1q0PEwhbqVQ9oMcWHD3kyts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBoig9wEGw3EbR3+woAH2dR4re4VhU48T9ppuwonemM=;
        b=yiMLIgRvQPBi1x8+WbguGXCiTovYq3dsTpEbQV3ozk4sL20QEysHbK9gL9usMvjRZu
         kXLKv9+SLVHzkSLLfi6EfRImvkEOjdGA8faLeFC6Br543oaH+73+PcJA2h7zfchtI1f9
         8MQCrjPHVIz3D6kwEyWH2zhyM2759I3R2EVb1ICKZjSTYXdZXoB0JmrhNzXNESF5reeK
         fStUgi74Qz9ZyODr568lP8SfTgUKzNvVTAW4kC2d4UM+VscDj51diSMwpGUDL7ikSpqc
         yA9uZjpm2G4q9HjdYuAvBn/kLwSNSuU7URy8TpM87cAQvotwCzQUlYkKtWPJKdwWriiZ
         Ks2w==
X-Gm-Message-State: AO0yUKXmQ2GzDj1AJLRCmMIlWdMaL7QbegKTTwegLewZjyre0JU9/Ayw
        zB6Uidf8VgCbg3l+2+Ys8qVEyNCMgokQ1mLZ2kWqCg==
X-Google-Smtp-Source: AK7set9cKJlGSzgxKnkPZY5ctLt21/DqK/y+sSAr+IxNcy5uQ8u+UBGv+xUwzIz+ePM0PuMkUf/uECetqfBxXRpUqQw=
X-Received: by 2002:a17:90a:a04:b0:234:ba6f:c97a with SMTP id
 o4-20020a17090a0a0400b00234ba6fc97amr4646164pjo.3.1678142456459; Mon, 06 Mar
 2023 14:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20230302185257.850681-1-enlightened@chromium.org> <e8cf7da9-77e4-e836-9107-db219a266158@schaufler-ca.com>
In-Reply-To: <e8cf7da9-77e4-e836-9107-db219a266158@schaufler-ca.com>
From:   Shervin Oloumi <enlightened@chromium.org>
Date:   Mon, 6 Mar 2023 14:40:45 -0800
Message-ID: <CAMb9sThf-ys4a+vmH=p5SKLixfhJtm8j3XX_4M004WvZheyRoA@mail.gmail.com>
Subject: Re: [PATCH 0/1] process attribute support for Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     mic@digikod.net, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jeffxu@chromium.org, allenwebb@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> Emphasis: DO NOT USE /proc/.../attr/current! Seriously!
>
> I made a huge mistake reusing current in Smack. If you want to
> provide a Landlock attribute in /proc create a new one. Long term
> we're trying to move to a syscall interface (patches in review).
> But for the time being (and backports) a new name in attr is easy
> enough to do and will avoid many headaches. Better yet, a subdirectory
> in attr - /proc/.../attr/landlock - will avoid all sorts of issues.

Thanks for flagging this. Creating a new directory and attribute name
for this makes sense, but you can still only interact with process
attributes of a single LSM on the system right? Just want to make sure
my understanding is correct, because even when Landlock uses a
different name and a new subdirectory for this, still the kernel only
calls the hook function of the first LSM on the list (Landlock in our
case). So reading proc/.../attr/current or any other attribute besides
/proc/.../attr/landlock/some_attribute would result in EINVAL if
Landlock was first on the CONFIG_LSM list.
