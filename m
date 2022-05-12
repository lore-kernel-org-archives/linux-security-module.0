Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D7C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354697AbiELQco (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352803AbiELQcn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 12:32:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA145644E5
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 09:32:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fv2so5677300pjb.4
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17dcYjfimvIOYymjaNY8EcKOIt8zMl63bRjEnHOWcx0=;
        b=ny0jpUiJ5rZt9idpMi+thHZD39TfW0g2h4IRLrJ8canABhHvLdgQF0hzq4uc7yO9aK
         4buzCPx/3EYHUcvpJ1UI5FsSmKtmiEYA32uFOdITleEvNabyPI+/+mXEYp44Ohp4aa2S
         Dw+IX6MDDH9mykd2QW63JhfgGU9RYgvbr8yMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17dcYjfimvIOYymjaNY8EcKOIt8zMl63bRjEnHOWcx0=;
        b=pKAvuYWxgROrJcEkJZ+BUjz5kVa8r+9SytuZoHSBI7jFtfT8kGBYnffWrHUa4YsPZh
         keGzRYwy/bL1EpHJTbi1f9S5KDN+64xaSGlsrZ8q6gHvs0rNHbMdpkcqqzcAn/40RZkL
         RECEUUC89o8DtguvNWNW89Fqw/79cOoh9ElwMW+3FSzoVDghzyb70BOIsPvRT/bRVye1
         yF2OmV1u1pxg5QmSHceCJlK+vQ6alQqzlffwm14RSaNYilniJS891mFNCCO3zuNMmpzV
         XZX02RvQLP+h7jZum0Kl/gc3BXTToLSSiq+aq8WCrQ6RjMJBpxZ9RPP91tiSJoXryoJI
         u2uw==
X-Gm-Message-State: AOAM530B+Xp4SDQqcOSW+ERsGXHmWBBlo/2WhKTZGqZnOGMh2d0p5fBb
        oa1W1hF1CTQYjEcNRPcW8RuYszZCHSq1Bg==
X-Google-Smtp-Source: ABdhPJxvTEpGplnIM+mjcTtTmMGRVezrr+r5Sz1udXgL0ByrGYvs6GazSPDmAs3ma+dQwJs0BgRnwg==
X-Received: by 2002:a17:90b:304:b0:1d9:752b:437f with SMTP id ay4-20020a17090b030400b001d9752b437fmr11557789pjb.242.1652373162214;
        Thu, 12 May 2022 09:32:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902b20b00b0015e8d4eb206sm133095plr.80.2022.05.12.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:32:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        jmorris@namei.org
Subject: Re: [PATCH] loadpin: stop using bdevname
Date:   Thu, 12 May 2022 09:32:36 -0700
Message-Id: <165237315358.973069.4038914246436510919.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512062014.1826835-1-hch@lst.de>
References: <20220512062014.1826835-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 12 May 2022 08:20:14 +0200, Christoph Hellwig wrote:
> Use the %pg format specifier to save on stack consuption and code size.

Applied to for-next/hardening, thanks!

[1/1] loadpin: stop using bdevname
      https://git.kernel.org/kees/c/8c296a9ad2c8

-- 
Kees Cook

