Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E7C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Oct 2021 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540B561151
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Oct 2021 20:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhJNUNB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhJNUM5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Oct 2021 16:12:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDAC061570
        for <linux-security-module@vger.kernel.org>; Thu, 14 Oct 2021 13:10:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y12so30029633eda.4
        for <linux-security-module@vger.kernel.org>; Thu, 14 Oct 2021 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnnTzxnLXt4VhkUHGABCkclql/5mQjOOyO0ZD6llwjE=;
        b=YVgy1WUwNLioe4mblTZvY/cP233J0tPnkTam5Is7eNATlCxUx/WtIh74YFVOuvYTU5
         Lwx0jsTh4o/tx/iZNazYJxYNXBn9MJZfCqTP/A1iaXy61G5eKZhYYwscjpOY8Y/2fbby
         1D0AwGVXRXyE+iibw+nRzZwHWm9UEAbAGD8UErd8BMBkx6HkWCJ8PZS4IH6MsaPbxpY5
         X09gArNgj6GVMAUzxOb01c/0+Hpr64QKswGHB8uIdVN50VfAXnQKJOXot6SF1T4PuAwW
         TSOc92YjljESMytDSDpmyNoI2Z37QJ0KTiZucBmEFTvENyEqIVjAiwk/HnEcpiJ0yVjA
         wwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnnTzxnLXt4VhkUHGABCkclql/5mQjOOyO0ZD6llwjE=;
        b=BZEskbGfP4gpXv/iVoObeJL71Fm8rTZnZzviO1WNBK8oIeERb5S3zQF+rCsQLupy/Y
         Zg/4G53+NJ399CHHQ2xfKAUJA4MsOMV77Dge6OQJCrLtrv1wwEpTk8Ae/6SsZE1Lfy8H
         h0EpOJkijgnbsySnyniTuTd4NnLeTkkHGnFNEE2dAD8oraucCrZRPWriS4L8prT9pNRu
         qHzyTRPOqkmP/OjkvVsiItWbXD26n3KOVaKa8E+QfK6IBrPpqp8MkqQKKys/n0poleo6
         XhRwWF2cxyi3XihFbG+tJw28eKc4mLUtsVXAAz78NEegOmNqMqxoIGy3qepWfr/ZX86R
         suBQ==
X-Gm-Message-State: AOAM531CglqnXryghNleIvSXao41kwgCgYpFJJqvPpD/np5JrMzxonMz
        YtaoOhNyAVVMHETFlMBBaBZmnp//8PZp2gQ366dRkb5lQA==
X-Google-Smtp-Source: ABdhPJwWzJGR2cUTRpXT12uyqjsVzaNPhaCMo8lo50fa/jfWtK5qqfDyeGaFwjWlT2u8poeE65KLID+G4JukGveV9Sg=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr1370420ejc.69.1634242250176;
 Thu, 14 Oct 2021 13:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211013172847.1196305-1-keescook@chromium.org>
 <CAHC9VhT0+omwDjqrJ2BtnRfa8SSGAkyUvB6WX95E=ntf9gUbmQ@mail.gmail.com> <f1a143f5-7972-413d-497c-617b915c4b30@namei.org>
In-Reply-To: <f1a143f5-7972-413d-497c-617b915c4b30@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Oct 2021 16:10:39 -0400
Message-ID: <CAHC9VhSA+B5-C5+3kR-zM+O-k3+=A31Hd=3YoZ7Q+3zkAB8=fg@mail.gmail.com>
Subject: Re: [PATCH] LSM: Avoid warnings about potentially unused hook variables
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 13, 2021 at 6:01 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 13 Oct 2021, Paul Moore wrote:
>
> > Looks reasonable to me, thanks Kees.  Unless James wants to pick this
> > up for the security tree, I can pull this into the SElinux tree with
> > the io_uring change which is causing the testing robot to complain.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> Sounds good.
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

I just merged this into selinux/next, thanks everyone!

-- 
paul moore
www.paul-moore.com
