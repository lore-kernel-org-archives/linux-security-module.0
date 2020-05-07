Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A0C38A24
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 05:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F8320753
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 05:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAffVvEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEGFuy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 01:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEGFuy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 01:50:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77EDC061A0F;
        Wed,  6 May 2020 22:50:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so4911890lje.10;
        Wed, 06 May 2020 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mq6HIDH5BrDBTzENE5J2lC+OBSXHG1cl8m7LfKfKF6E=;
        b=iAffVvElIIkM/97CnrTukgk2THSnmjXrSSfqNZZioLnNn0ITW+wSquwB5M9i5fIQAD
         1WcrpPYaHGfL38aTq6GqE7NP04pVzQRUwe5OaYNO6GYg6eI4A1x9AXWQ0hmRd2RtnOXP
         l9ki8ATv/d2kf2w9vsalM2DbBUy0RepJzcNE31/TMNuGRKDzvef3HSEWei1pAl7SW59U
         A8vP3ZmLcqD55jixIJyxMuz9RNERHbPbOqoqVcf8ARHh5wvbWGUuWeajZ1/FbKgGuC1x
         pirH6PjU/IPWMG06SmkHUfyXlogr7ZJQtLltrEQD+dCef/DAyXESz+CDP9EcDkF6/ZSr
         60yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mq6HIDH5BrDBTzENE5J2lC+OBSXHG1cl8m7LfKfKF6E=;
        b=X11s4cwZeKt4kgx5ypCr42YHSyw5tGw4ZD4kV0AZ7Ynh4VVNnbp3765ZOgU+7G1hRk
         MGXaoPJq2v5ez1Hu+Ji4BQllaUjaUHs51AR+MgPFGGEc7xmvsA7O1gDCHhbQtVnisgtM
         dgatsGLe4ucWg3Iqd3aWAGK7qFDwEzgfGUJIuGsCidLJzpSEhOsuVzRl1C+CvDdaqe5O
         sP/2sE4+59Meian01VULGSqssRwn/IsfZVA862e2NEpxIdJ2ZqB9IYUJiH9vdgHXzg/s
         PhsBeKeMbWPZsa5jEbxUDoqdK8fMnbNAhRZ3KMKdvDXjgb8hw0Wqi15fmvuoj7toPSS3
         qB9g==
X-Gm-Message-State: AGi0PuZWjTR5Y0In7TepiqJzZT5JxIPa1Ftn1TjULw/ZDnSdESn0Funf
        Q50OOfh9zlss/bbPM2g+blhSxHAwV33ECMXdLxw=
X-Google-Smtp-Source: APiQypKApDz/cUh129GGJeJkYPhX5zGgi6wuKgYvKSMz/d2JSVOYgHdxKUpMEIF9IhUQV7nR7nDF9wIvBpIOaPUn78Y=
X-Received: by 2002:a2e:990f:: with SMTP id v15mr7500790lji.7.1588830651087;
 Wed, 06 May 2020 22:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200430155240.68748-1-kpsingh@chromium.org> <alpine.LRH.2.21.2005011345380.29679@namei.org>
In-Reply-To: <alpine.LRH.2.21.2005011345380.29679@namei.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 May 2020 22:50:39 -0700
Message-ID: <CAADnVQLN-OtyzwzNwontLK9q3w3hPET2vDJWHhPs-cKqvmHuVQ@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix the default value of
 fs_context_parse_param hook
To:     James Morris <jmorris@namei.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 30, 2020 at 8:46 PM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 30 Apr 2020, KP Singh wrote:
>
> > From: KP Singh <kpsingh@google.com>
> >
>
> Applied to:
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v5.7
>

James,
could you please send PR to Linus this week to make sure
the fix makes it into the next -rc ?
Few other people reported issues that are fixed by this patch.
Thanks!
