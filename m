Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CBC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B4F207BC
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590692738;
	bh=cJLAhlnq2OqUbmFc8bQXuSL6bgPrceDFYO9vPJzGUCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PreCW4pnFCja8ZXgVe3q6lLMVWojIbWFHMISVbLWUFbXxTFC7VUGNv+tMJIy+dgbI
	 aoN7+Dq14iUKFMqZIbJ/ndd0k4gCPEcKD80ICPuCCMvcJR1z5hF845HMYYmTPJf5hw
	 bssWLfYZnhqrcJ7Qte0yabugD+TxLE/kd2d7aick=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406123AbgE1TFi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406101AbgE1TFh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 15:05:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD54EC08C5C6
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:05:35 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z206so13578869lfc.6
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIM8xuF5VWjvw+TNdHJ4kiSd5AWmWcoZ3yv55b5QhmI=;
        b=FUIN+4JKj2QxyK8i6JHV7/j7vy5lRuVpANaKoY2Mlj+WNN0OnhModMVphPtln7hTfr
         6e2HXcUIfOAsDiHQ1XL5v8z2Xgu1ZqPPoh0MtrHTKjhMN1uPF2+2fHIA2yVkvBMEgomb
         B5DSvFfThv/idiSSPqFeMZtDs8M840ZwViIm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIM8xuF5VWjvw+TNdHJ4kiSd5AWmWcoZ3yv55b5QhmI=;
        b=jPsHOflbUz4I2itYbNXBW/g2ATPcQfJjw20JTmlMDZbOpSaWIBWn0lKxsNVjngE5hy
         yM2mULLExUm1enPbD7iDO/Fwq9LX6GpzMuvXxUGSvI+Zrswfi2qvjuCH4ELEMD+kUOYv
         snWjEXkSPwP0bqA4XVY4tTGGwyfNedVxtJia/Bdu6YJ5uz3k2WB+jNBPkgWUYKYd555P
         XtE4KvL4l5t/ppCpneVXAQCD2+HOGpPLsA4UGBvO1CN7suU3dvu+28hCjMS3n8xen4/s
         pIIxwb3JGMwC6Zm5mLJ76UWEhlDhCyFUgzbM03tJaaB6qC7z2XSx+sJa4ch/Bq7gIvG6
         GBEg==
X-Gm-Message-State: AOAM5304TcXR13YJB0Hn2pXVc4pusnT6OVBV3HLvlDK4SCGEviiST0yg
        q2IVFFaid9b4IUYnXmldxSAr1KzEUjw=
X-Google-Smtp-Source: ABdhPJz+Gx5UTHNDu0bB0D2uN/8xC9b/dfSCUvCaieTY49ckzEo4TifoK+VgobNfPX6Zv8QqTo8llQ==
X-Received: by 2002:a19:8447:: with SMTP id g68mr2448477lfd.132.1590692733479;
        Thu, 28 May 2020 12:05:33 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e10sm1820065ljp.108.2020.05.28.12.05.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:05:32 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id d7so6050532lfi.12
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2020 12:05:32 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr2356099lfu.192.1590692731704;
 Thu, 28 May 2020 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <878shcyskx.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <878shcyskx.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:05:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbYiVkYy0KpjssAEiEApEUogKpyL1VFWNic4wSp9iDYg@mail.gmail.com>
Message-ID: <CAHk-=whbYiVkYy0KpjssAEiEApEUogKpyL1VFWNic4wSp9iDYg@mail.gmail.com>
Subject: Re: [PATCH 02/11] exec: Introduce active_per_clear the per file
 version of per_clear
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As per the naming of "per_clear", I find the "active_per_clear" name
even more confusing.

It has all the same issues, but doubled down. What does "active" mean?

              Linus
