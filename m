Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC05C433F5
	for <linux-security-module@archiver.kernel.org>; Sun,  1 May 2022 06:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiEAGZW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 1 May 2022 02:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiEAGZV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 May 2022 02:25:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D14F9CF
        for <linux-security-module@vger.kernel.org>; Sat, 30 Apr 2022 23:21:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id iq10so10395287pjb.0
        for <linux-security-module@vger.kernel.org>; Sat, 30 Apr 2022 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKTKYlNwPBswI7KvwVvUGgGSktP9nkI84ndIRwt7nQ0=;
        b=Klg91Olbd9xvNnScoI9Jo7qffnF+b87zdB61YiDV72+oZO1lZnu38azldFFnB409su
         WisdSBkqncsM9LG+UvU6GTYOBjG9KgdMMMwq25PKUB+zgdvBYW2U/N1Gjj/BAQBBdfs2
         76jREBR9IZ4vrpFIo9Vz8EUUuF4iFpJyQSqTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKTKYlNwPBswI7KvwVvUGgGSktP9nkI84ndIRwt7nQ0=;
        b=y8eDMGopry1sGYLDP8zZqUaFp1SpK+x3Vd7t7TDNwP1hnFp5CRATkx6FT4YwV231QG
         AO6b6LhkPd8hpODYM7GqznnfkjWe8km1JyZUrPwey4tbMXHTACCSd0QJND7mCkqv8VjP
         1vNI055zdhnz8TRTEPChTfUUp9LdOgsVQM/ch7DpuNdmj77pYnSCUOKZFGuLaxIIWpLY
         FG5CTzrTpSEpEVN7U6p4E+xk5H0mJk9ro33STW/qfMMGFxwz/SiSpqysXRPaYgJr76Bz
         l3itD8/ZlGH5b/+/TtjwFXYA484VFXtjSNJKkAkDMKBehaxP3c1EzssRaKxzWbIWMaK+
         ey/w==
X-Gm-Message-State: AOAM533h1cSqklVz5yNgkfhA0yXYhr22jDRpsCN2vZHGT5TYsGNqYRz5
        lUL7MsDwm8TE6kdVPuaDDVTw2A==
X-Google-Smtp-Source: ABdhPJz+jfrVtgiEdIHSI8aK+wUVMyDTcGdWEOLCrg/rORW+7ZJJmVsK5AsizYEC9lrxUsWwCp9rcg==
X-Received: by 2002:a17:902:f684:b0:15e:8c4a:c54b with SMTP id l4-20020a170902f68400b0015e8c4ac54bmr6278847plg.21.1651386115938;
        Sat, 30 Apr 2022 23:21:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c12-20020a65618c000000b003c14af5061asm9085007pgv.50.2022.04.30.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 23:21:55 -0700 (PDT)
Date:   Sat, 30 Apr 2022 23:21:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202204302316.AF04961@keescook>
References: <20220426213110.3572568-1-mka@chromium.org>
 <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 26, 2022 at 02:31:09PM -0700, Matthias Kaehlcke wrote:
> I'm still doubting what would be the best way to configure
> the list of trusted digests. The approach in v2 of writing
> a path through sysctl is flexible, but it also feels a bit
> odd. I did some experiments with passing a file descriptor
> through sysctl, but it's also odd and has its own issues.
> Passing the list through a kernel parameter seems hacky.
> A Kconfig string would work, but can be have issues when
> the same config is used for different platforms, where
> some may have trusted digests and others not.

I prefer the idea of passing an fd, since that can just use LoadPin
itself to verify the origin of the fd.

I also agree, though, that it's weird as a sysctl. Possible thoughts:

- make it a new ioctl on /dev/mapper/control (seems reasonable given
  that it's specifically about dm devices).
- have LoadPin grow a securityfs node, maybe something like
  /sys/kernel/security/loadpin/dm-verify and do the ioctl there (seems
  reasonable given that it's specifically about LoadPin, but is perhaps
  more overhead to built the securityfs).

-- 
Kees Cook
