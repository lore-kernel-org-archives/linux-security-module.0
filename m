Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2E4C00144
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jul 2022 04:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiG2EwG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jul 2022 00:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiG2EwF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jul 2022 00:52:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5454C9A
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 21:52:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o3so3603776ple.5
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jul 2022 21:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nih3CQ3bvbr3caRHPwLofzDk9DoHwlUp15C4DMS5PBo=;
        b=bYfPignOi/MJPMQdVA/EDZTpDmKF3LvDAsd4Fr7HsUJTIoRn+/bz86QDgO7OfGBmm1
         /Eg3uORkuQT3yF+ysMYvDC7VhVQQuT9l9+eMm8cyWdIxuRIia5S28G/ms1A6hytHKlKJ
         NkjI/sPYggb67XCLFSpJE1AVxLnxqzShpbWtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nih3CQ3bvbr3caRHPwLofzDk9DoHwlUp15C4DMS5PBo=;
        b=N/qLRFoH2cMdUdZftooifRMYjxCfHP0n0SmWO6gGnB7r+DjyE5BIVPU4Q5YYcuD+PE
         rYqOTyxy7o4szXsfDashgmBSxP5YysxKzAUau4eDyZBgmu3GaCAdTBqyGYnptURAC8L4
         E42PFsVCOtZhL0mAgHFOYknVTLEVaYhlfyxj2LOK/ikLjzjaWFGdNITVD9AAKJa6IvBO
         rse2hiXT9C1IVJ7DHBY4ko8KqvYDtlCVrzbcyF+cQFA7OQQo9LMa6tSKYdcnP4bLFeuO
         5dFoY3yrDBx/jA7D6+YrSGc2AMsnUuLyV78FXwYMKlrjS7ksnHbwJUCVZ2jbYdmqt/9+
         ot/g==
X-Gm-Message-State: ACgBeo2cWOYQ2g5RmBcCooRdar9LT04ux5+7TQ0QrG0penwnl1TQ49Ub
        PXchxB8J2ojRHmgE7b8jHtpJLw==
X-Google-Smtp-Source: AA6agR5FJP+NYrdW/k3FkoK3eSp4f0Ik9rJBgd0bR1FQThkmO9kyKATOXvMgiQu4Mti2542araL9Iw==
X-Received: by 2002:a17:90b:3c42:b0:1f3:2e03:d9dc with SMTP id pm2-20020a17090b3c4200b001f32e03d9dcmr2228881pjb.8.1659070323606;
        Thu, 28 Jul 2022 21:52:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 200-20020a6304d1000000b004126fc7c986sm1808648pge.13.2022.07.28.21.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 21:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mka@chromium.org, jmorris@namei.org, agk@redhat.com,
        serge@hallyn.com, snitzer@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, gmazyland@gmail.com,
        sfr@canb.auug.org.au, song@kernel.org, dianders@chromium.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
Date:   Thu, 28 Jul 2022 21:51:55 -0700
Message-Id: <165907031305.2130609.16869003416171682751.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
References: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 28 Jul 2022 08:54:41 -0700, Matthias Kaehlcke wrote:
> Commit 2aec377a2925 ("dm table: remove dm_table_get_num_targets()
> wrapper") in linux-dm/for-next removed the function
> dm_table_get_num_targets() which is used by verity-loadpin. Access
> table->num_targets directly instead of using the defunct wrapper.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
      https://git.kernel.org/kees/c/27603a606fda

-- 
Kees Cook

