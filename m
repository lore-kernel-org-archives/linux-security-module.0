Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEBC433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Nov 2021 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5843663263
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Nov 2021 22:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhKOW1c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349573AbhKOWTO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Nov 2021 17:19:14 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1E6C025545
        for <linux-security-module@vger.kernel.org>; Mon, 15 Nov 2021 13:37:37 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id k1so18173352ilo.7
        for <linux-security-module@vger.kernel.org>; Mon, 15 Nov 2021 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=AcKSBTvLAW0gj40GbXq2aP/U78AStpOkB0MPl9oMU5U=;
        b=v9PY7keA/WOnuwebpkySYYfb3fifjLPflW1uRGH1P1DoaUTZBjG0Fj77dKlFcZBz15
         VFwDd42szs4hKUi1ekn05lhDXx6LUJ4Cg+vLfHz+4p/5cLwocbAXl4HU9j6z9INBDQrV
         n68Dx/GdigRjoOC9V0P+KqOZEjlHkPKG8bMU5Um3gSto+jwrjx119w9gxGn5F4iuPsZL
         yeA+ViWknSnYBuV3RVNrlggI1Heb+6QP0wTmBEP7decqGnbkbU3Xm04jvM/RQ3BX+/ga
         tuAHHUPkulvitg21kNN+HZGty3eZCHgjDUgD1k0sVwIEDgQb+Kv632/Y+nbKO4qu3ZpJ
         H7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=AcKSBTvLAW0gj40GbXq2aP/U78AStpOkB0MPl9oMU5U=;
        b=ZyDymQ6m7PDRlLF1qiHqnQrd7v8IdCYrKPe41xsCU63JiYqP2maMqUtgnzFqcUc8CZ
         V7s4NoX+i3O1Ymic58P4Ck0IuFR1NOD7ai6AP7wOVW9oPAhMDjc1MobO8BZuJ37zVaKy
         MYfUEtsja7ssXpauf/1XGg+Vcm8UJzV7BE5Cl5BHRNnpQhlFJ9vL8+XGJ31oqz11FdN5
         RTMClCQnTqLYNC26sfKuA3j8TMau5mIaNzXOeKvl8D/A7fwjb9PT5/JpvWKpyvAPFFhc
         ZiH6ubElPjRQeR958o0m4iziZx/H8qiPiIY1y82LgbqlLq2TQ4CxsfPvPyWRj6cMi1Bd
         +SZw==
X-Gm-Message-State: AOAM530hIi8AtX7EhLKQKKjn9J+Yz4S88ZpcTS7R/6oPiTEI3uJdHOe5
        a02Q2/hPqmWUFr/B2MH2kUKEwUDUaEvqvPCb
X-Google-Smtp-Source: ABdhPJwXrMjYdhOuZhYyB1MaOORmDZWRJav/IZApf9RJkatUYCCTo84c2Ob9wG9NDX4eI7z70eI3VQ==
X-Received: by 2002:a05:6e02:17cc:: with SMTP id z12mr1240203ilu.267.1637012256820;
        Mon, 15 Nov 2021 13:37:36 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b6sm11771900ilv.67.2021.11.15.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:37:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Cc:     linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, kernel-team@android.com,
        selinux@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>,
        Serge Hallyn <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211115181655.3608659-1-adelva@google.com>
References: <20211115181655.3608659-1-adelva@google.com>
Subject: Re: [PATCH v2] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
Message-Id: <163701225573.78831.14755675586127114548.b4-ty@kernel.dk>
Date:   Mon, 15 Nov 2021 14:37:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 15 Nov 2021 18:16:55 +0000, Alistair Delva wrote:
> Booting to Android userspace on 5.14 or newer triggers the following
> SELinux denial:
> 
> avc: denied { sys_nice } for comm="init" capability=23
>      scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
>      permissive=0
> 
> [...]

Applied, thanks!

[1/1] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
      commit: 94c4b4fd25e6c3763941bdec3ad54f2204afa992

Best regards,
-- 
Jens Axboe


