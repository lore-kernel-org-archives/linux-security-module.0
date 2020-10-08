Return-Path: <SRS0=sAtF=DP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDEC4363D
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 01:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F3C20882
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 01:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hDW/iDI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgJHBHW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Oct 2020 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJHBHW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Oct 2020 21:07:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7204C061755
        for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2020 18:07:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so5638136eja.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2020 18:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/fw/vuv+jpX7naIQJNtmb+BuD3O/GoY3uFVsTJ1Bfs=;
        b=hDW/iDI/5zAUvZa/ZFpCvsDx9a+9piT6TL23o6bYiK65glSzEbGfsXy0HqRm4rSDGI
         TJ38VP+bs2L9m9woEI1omY9nCGyeZOGjwB29PUIUn1bj6TZuV7F5iUknuxvmoLohA6CI
         D4eoqPGneGKemHfBXRaoQq8TrVReQSkMhtDdBAuE+ZBYIkH+8i58BfQGFVqdjjxw4Ugl
         o/e+kU8wLFsH6IDGq1PsvHk+yH+tGNgBPENSON3Hbq3sQLIvo+zlLHVqCYqdeQz2HIIO
         bNk9nLA+uugX5vK0KZK/vDL4KHGK8phwYLlOpO9+Yv1zMM3joLCxk679lxthppcz1I+m
         0iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/fw/vuv+jpX7naIQJNtmb+BuD3O/GoY3uFVsTJ1Bfs=;
        b=jYGLtmQGvz9rw5QxFl/jX+MeDV8H9zflpqWR2/guz3X4Qqs8W6FBTVOcjd64f7CnXM
         K2XZEvwls+ZlbQo6FPssAuZISATCBUW+xRDlZLgpRV9oLi5wJ9l3NKZJWkh3mKfYX5Lr
         3hk8PiIQmcSN/MWcYyBllH2msiguVBZ4GPiZ/BseGouQQl3yrjSMlgrl00CeL78wXiDp
         JNY8wMuVhjFMEIk/PHRbnR1NitVRAM00+BGsTDOl9dg8lCPUMDnkMXUlBw1ZvbK4XOwq
         ooxv0AHJTTeNNWt3bmGuXrRU/XbffSE665m/3/HSTATap6IMJVNYcPXHpYWq5Rha4IgD
         hoUg==
X-Gm-Message-State: AOAM532cCVyUd/TSbSxvX+hbINLFDZvIVjbcaojgG0A/mfaiiM7pULFf
        /zh2nw9VexGXD7v88rCm5xRIIEVwSxkdw6gZTSS/5ZaJwg==
X-Google-Smtp-Source: ABdhPJyq302K8QytrlX+hwl6vTBW38bJQQ98PHyDjDLem6jTF6PUhQcylf9edQ8uoAxsI0yXeldAmZjvGkcF5H609FE=
X-Received: by 2002:a17:906:4811:: with SMTP id w17mr5770585ejq.431.1602119240009;
 Wed, 07 Oct 2020 18:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
In-Reply-To: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Oct 2020 21:07:08 -0400
Message-ID: <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> Hi folks,
>
> From some linux kernel module, is it possible to query and find out
> whether or not selinux is currently enabled or not?
>
> Thank you.

[NOTE: CC'ing the SELinux list as it's probably a bit more relevant
that the LSM list]

In general most parts of the kernel shouldn't need to worry about what
LSMs are active and/or enabled; the simply interact with the LSM(s)
via the interfaces defined in include/linux/security.h (there are some
helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
bit more on what you are trying to accomplish?

P.S. Go Blue :)

-- 
paul moore
www.paul-moore.com
