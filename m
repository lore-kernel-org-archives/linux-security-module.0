Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E64AC433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Oct 2021 22:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5361060EB6
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Oct 2021 22:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbhJHWtf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHWtf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Oct 2021 18:49:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAD7C061570
        for <linux-security-module@vger.kernel.org>; Fri,  8 Oct 2021 15:47:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s75so4441889pgs.5
        for <linux-security-module@vger.kernel.org>; Fri, 08 Oct 2021 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IDL1dGbYQGd5Z4n8MbIk3dyJApzaVNleP7ehAou5XC4=;
        b=k/DtfYhTXoNzDDeSt76IrPgiHKVbJzl+yCmhiVP/k9h8OwZ+VHDbs2A9FEOSncQ6Nu
         c0oNPpuSA0nexNb/AGdFb+q1kORF6YZCNXJNkA0aiLO369TZ7sk5ShzhZMZeTnhRLb7A
         UNQpET4n7Z7KsW9liWrD/WoMIMHK7Ci23ktRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IDL1dGbYQGd5Z4n8MbIk3dyJApzaVNleP7ehAou5XC4=;
        b=mDUrCM5WynqAw9uQI1AW83+h5MKV0f3dvXg9kx8dsov73yZWpCmkVp1UMdMxoizs0p
         c+SDaVwKrut4HFRy2LO0K/TGFwjutRxJ1T65nRXOgexDxd1KMole+6ZoJf9Qu8Wkc2p7
         57a1MI99iBzNayhOWu7TN6Z2NbL4dIDoqC3DUcj1cnf72IGxi1N1r1KFMXSatTE6mbYd
         fk/GpY3V/QneG3v52Nx59snggSKtNmI3TAOeIxwb3g7QAiaqQQeZr85QvkOw2KkhsAsI
         xUofTu5kQ43guDsfQkHFx94u5+Q5JqCr5uVBnWaBfcgn4vycU16zcHG1YMB4NY+itkVB
         chCA==
X-Gm-Message-State: AOAM532wiq/GsYoqmSG2ThznTBfnrwItcBwMjdRrfVkEWFteMs/MG4+u
        kQjX614q3LX7xy7rOVLCQSgvYA==
X-Google-Smtp-Source: ABdhPJwvnmLJjnp89CGi8tOitxi5+0+62XoRbPGjNi0V+bAyRDLPPpqmm4mrkramzCbREIT8ipI6YQ==
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id s4-20020a056a00194400b00438d0026e35mr12543299pfk.20.1633733258954;
        Fri, 08 Oct 2021 15:47:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm295225pff.214.2021.10.08.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:47:38 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:47:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v14 0/3] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <202110081545.8D8C2980@keescook>
References: <20211008104840.1733385-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008104840.1733385-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 08, 2021 at 12:48:37PM +0200, Mickaël Salaün wrote:
> This patch series is mainly a rebase on v5.15-rc4 with some cosmetic
> changes suggested by Kees Cook.  Andrew, can you please consider to
> merge this into your tree?

Thanks for staying on this series! This is a good step in the right
direction for finally plugging the "interpreter" noexec hole. I'm pretty
sure Chrome OS will immediately use this as they've been carrying
similar functionality for a long time.

-- 
Kees Cook
