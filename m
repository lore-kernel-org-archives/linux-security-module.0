Return-Path: <SRS0=B0YM=BO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CACC433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F1C20842
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596576408;
	bh=d17qrTwVToEq2khFjvUCA0fj8FN9UTVwp+G7iaKwOrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QUZXhdBEvPDyxHPEcIu6SybjqwYkf/D8euNirzsDsaWx1qpRsQiuDFskar/m5+KDG
	 MB6k+Yuszf6G2tVACKJxN5UWPqvd7qRx5qALdOTkD+2ec9uSnnaKoXVPsk8cn8IgCQ
	 wdpZ684m/jhat72kppAlq9CHHE5stVKSkJf6kij4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHDV0s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV0s (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Aug 2020 17:26:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A09C06174A
        for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2020 14:26:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so14943007ljc.10
        for <linux-security-module@vger.kernel.org>; Tue, 04 Aug 2020 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7NKZj1R78/D57WU2J4CvrtRn4wBXaNE6KwcqvJ/JXc=;
        b=F7DrzR6KC5lRwPOTJ5+7Vnit32BCitYx1s0qEr4ic3BJyt7CSrbsV5eHcR3dWnXNqs
         kvOTvETu6noM9tj2MwB4kxeKxidzTbTaHuPnWa0BNWEYLv2GU/YQ6k197BDadKCH0f82
         mwPlbiZ2qYYroHX4XXsiG5UzHXhWy8XEKumRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7NKZj1R78/D57WU2J4CvrtRn4wBXaNE6KwcqvJ/JXc=;
        b=brUr+vDX2FtSE677HTJt4dRPMDdwfF3Ezkdp5HxDw7t+U5J5VAnGS5lFMP79Wfdfqg
         Qd++6y6UGIBhsUIqIFE8JfzFufvzlWUA0CUlAoYoWnWWLUQObUffenOQP16pgAkWlb1b
         V/sBLu3583myuuSz+kK5ETHX54EVPqtyccwbvN3Cl25Pi5GT9oaCo7WktdL10sTeqf5S
         u54U/404dxvkV52xNDGt3se6v7hUQvSokf2x0oiX11Y1nRETNx349uveBocOCXoSOJX0
         /qM/K+iLFkbtLDnKUI+FlnPHGmYoT+AX7KarNZOgZhCS+6WbebQWgZrOxm2VN5+9ARBE
         ocjw==
X-Gm-Message-State: AOAM530L7axVNbykrkDdDqMuuGscKGqusvDD9cZ9pqBA/iptldh99KfC
        xkPd/kA2VTqKRfx41E7jOvoMRi0qeDg=
X-Google-Smtp-Source: ABdhPJwXX3j6jgcS8yV0z5sQKF31nZGRE3FPglnMBYivSRY+Fj2VV6r+9KqUYZ6WDTOq7AYrLJvAbA==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr11616480ljg.185.1596576405792;
        Tue, 04 Aug 2020 14:26:45 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m15sm5967049ljh.62.2020.08.04.14.26.44
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 14:26:44 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g6so32626831ljn.11
        for <linux-security-module@vger.kernel.org>; Tue, 04 Aug 2020 14:26:44 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr11503214ljf.285.1596576404472;
 Tue, 04 Aug 2020 14:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <8ce85723-5656-0ee8-67a7-35597d9df0dd.ref@schaufler-ca.com> <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
In-Reply-To: <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 14:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkuGCCk7DCNP6836FYeOaKZR9KLOBzr21fPOVNnOZiKA@mail.gmail.com>
Message-ID: <CAHk-=wjkuGCCk7DCNP6836FYeOaKZR9KLOBzr21fPOVNnOZiKA@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.9
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 4, 2020 at 10:49 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Here are three minor fixes to Smack for the v5.9 release.

I can't pull this: that's not a signed tag, and I don't pull unsigned
stuff from open hosting sites, no matter how obvious they may seem.

You typically have a capitalized signed tag, but I'm not seeing that
this time. Hmm?

             Linus
