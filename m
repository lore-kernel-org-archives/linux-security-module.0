Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB72C38145
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Sep 2022 22:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGWe2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGWe1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Sep 2022 18:34:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411A627F
        for <linux-security-module@vger.kernel.org>; Wed,  7 Sep 2022 15:34:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso444395pjk.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Sep 2022 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Pp4y+VXW5QuKNOfWHvi4eGa5eVSczb0JEs1BHSpJSao=;
        b=FV41OpH/zYkOpWATnK6blHNr73aeb2iEyq49smzLx8q2obuklQVtsju0Ul3RTSamuK
         D1fToC27p9Pt6NEleAg6dp9SKDX3io+srHT/274GiN9NSJXFFKvRG9KNNwbtEhF9Qby6
         maYNTqXLg0tJfBKJIkR8RPgQBWLbExuHcPsbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Pp4y+VXW5QuKNOfWHvi4eGa5eVSczb0JEs1BHSpJSao=;
        b=1qm1zF4hU4RL1GoSfqxH4aQtBT8j5Ny0xGykWANWzvocEq0bJ3zl/RJ9XrCpRfu8L4
         Pbkich5cjkzZ4ZPNP35HbcBwqAZX06rdhzkInU4hfiVeryfQB/wi8ZJ9MWqf8s+/08Zc
         WnwRhBhkvzjLTzRHggFTo1SqngyW0IO9IiZjislR20Q/55KJM+kNcy38fYU2v3XTX3qy
         FbKnHj2vr8SSINDXVkB070uM7grB7XAWuwMrjQDxlsIlP9PcIY6e26BXfTgLsKfGqf6N
         vwX9DpQTcS+0KwEeLzdRCHenGYGwjhRh241bHHGM0MaG14qsQAEYe2Kz0n+N4YFtLTfs
         zIBg==
X-Gm-Message-State: ACgBeo0c7Fv1T1yo/M13HwckvHm4UCc6/5jvhhU2x40XNVWuyTxx/2E1
        ercn66qlFKqp4SHueyb8cddEiQ==
X-Google-Smtp-Source: AA6agR5bxK5DKuJ4g7Wu/Tuk9tp1HvYw8sClTJInhRq1N4MSQnfDWDR2wyiSwI1H2US21Pg7QsiEnw==
X-Received: by 2002:a17:90a:9f8f:b0:200:e27:398f with SMTP id o15-20020a17090a9f8f00b002000e27398fmr764902pjp.116.1662590066538;
        Wed, 07 Sep 2022 15:34:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001714e7608fdsm7529520plg.256.2022.09.07.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:34:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     snitzer@kernel.org, agk@redhat.com, mka@chromium.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sarthakkukreti@chromium.org,
        dm-devel@redhat.com, dianders@chromium.org
Subject: Re: [PATCH] dm: verity-loadpin: Only trust verity targets with enforcement
Date:   Wed,  7 Sep 2022 15:34:08 -0700
Message-Id: <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> Verity targets can be configured to ignore corrupted data blocks.
> LoadPin must only trust verity targets that are configured to
> perform some kind of enforcement when data corruption is detected,
> like returning an error, restarting the system or triggering a
> panic.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm: verity-loadpin: Only trust verity targets with enforcement
      https://git.kernel.org/kees/c/2e1875c05267

-- 
Kees Cook

