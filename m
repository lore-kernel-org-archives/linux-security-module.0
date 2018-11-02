Return-Path: <SRS0=l7tI=NN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D343C65C22
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20A20833
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 20:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZYRd/eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F20A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKCF5w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:57:52 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38888 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCF5v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 3 Nov 2018 01:57:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so1287657ywa.5
        for <linux-security-module@vger.kernel.org>; Fri, 02 Nov 2018 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AdbRP1e8hhSctEX2RFnFJdxI7Ntlt0NMbsw9ytVJYUQ=;
        b=MZYRd/eHgIPhy4q251SCFQz1FbPFZ2DATzZ72cqhh0z59yxwEZeaeJxElQo3rkIg8r
         66DpVpmMkRxdfasZ9XGXCa5VrZwEwR0DUm2vpUUoLaDrZvU3ydBRop6FG/ZZf4MlOQpB
         vknMJ6EbPx2O443vkScDvzm/jGerGHoLcUHRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AdbRP1e8hhSctEX2RFnFJdxI7Ntlt0NMbsw9ytVJYUQ=;
        b=KCs+mnC6VwWliq9DN22OrR+gYpXGkqCtDdGMw6ubV+2OS1xV7r0ptPyn8y7cJz7RpH
         /zFMbEua18UUNW9G8Q3qFi/Xxs5y2jE/U2EuGdMaVNPmDh9iczgr71TUETr1noUEzjEL
         d6rdBtjI+5wEn5v2svStPby0QctjDjFD7PXZ4bdcWrllzHtvdiduKuaWk1KG4x1zsImw
         qy5glzq1MFH/xs+k5OttqXLCHAvDjHAYkUwsHqoEc5YoQ6yI5xTwWkS9pjHGS0YRrDJQ
         ddRmZ68ncMYCImCzMOSttzZi5jocd/dYum0aeiUreWTioKXW2eTEGfNb9yTLIiZNgnvT
         SAvw==
X-Gm-Message-State: AGRZ1gI2xOMQPbqfB4jJQtQNdejnNG3vrfiNepU+mxDFQLN8Fvw4czhx
        VJTnTwOOlSMkZvlgm7el0Wxuc6py3l4=
X-Google-Smtp-Source: AJdET5fVDOiLXhM/vkT2tAO6A68FHz3PgjBl8tKjv0aS15vzAXJ3idhH4PEKkVqzo2aNrDCZ4AotiA==
X-Received: by 2002:a81:9401:: with SMTP id l1-v6mr12985988ywg.2.1541191752901;
        Fri, 02 Nov 2018 13:49:12 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id q126-v6sm8525156ywf.7.2018.11.02.13.49.10
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:49:10 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id i185-v6so1274522ywa.12
        for <linux-security-module@vger.kernel.org>; Fri, 02 Nov 2018 13:49:10 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr13322078ywf.237.1541191749802;
 Fri, 02 Nov 2018 13:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 13:49:09 -0700 (PDT)
In-Reply-To: <1541182406.20901.31.camel@linux.ibm.com>
References: <20181011001846.30964-1-keescook@chromium.org> <20181011001846.30964-13-keescook@chromium.org>
 <1541182406.20901.31.camel@linux.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 2 Nov 2018 13:49:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
Message-ID: <CAGXu5jKM_goC2519EXZu7Bh0VoW8jQeR=AJ0XovUPe4_635XNw@mail.gmail.com>
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered initialization
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 2, 2018 at 11:13 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> I don't recall why "integrity" is on the security_initcall, while both
> IMA and EVM are on the late_initcall().

It's because integrity needs to have a VFS buffer allocated extremely
early, so it used the security init to do it. While it's not an LSM,
it does use this part of LSM infrastructure. I didn't see an obvious
alternative at the time, but now that I think about it, maybe just a
simple postcore_initcall() would work?

-Kees

-- 
Kees Cook
