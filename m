Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30725EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 20:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjFSUDT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjFSUDS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 16:03:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9873E68
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b51414b080so21872115ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687204996; x=1689796996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2vsVFtTkQYhqMmseMllBPLpJkQ52+kcj5AVBSFXuKs=;
        b=JsVpqeSoU9JGqhw/Knvq+EH87u0+brLVuGMPOl8wehYwMXal8PD7rLPtJBQ/LuIXD5
         q3wqzN82EFF2hMFosDRrnb1S1epH4esiYijM7wdbAxvyvzl4rwMrBd7CSb+DzCUf5j3q
         T3LWRqxFv4IL50FXaZc8BOq6WyjU0DNPTavMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204996; x=1689796996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2vsVFtTkQYhqMmseMllBPLpJkQ52+kcj5AVBSFXuKs=;
        b=TGYz1L6rv2Hdvz9Gve7zfOBFDOD/6Uxe9iPr1mCP6k/hCBQawVnrFUioW/jEQA8O+f
         VtyppWhCf6I4Yc1NatTb2OiqI51ACGSnsQkW961QiryHCKaLBKPJZY6hMLUd3UI5VwsI
         xEB0E8ZTlCIvXwwwGU/8TZHLXV/JAgAMSVZnDJP/esFCoy/ZRdbxdmzXhhJ7kdAP1u5a
         cS3MqSKgSapaF+Fqb6Jd4bl9NsvIWeLrO7WTRSKdrHjqggQ30vk70lQWgYQj3X9k7lBN
         +k0WffYJGoQuAweN9cQaGK3FgwmLfLOwEXA7/x6eitAy0f3KsMYjlqoFXXswULEvPqAc
         6stA==
X-Gm-Message-State: AC+VfDxtrUnfDlLhoYqY0jDOhNF/oJC+xAvld8Ko3P0wBRo7DJ/rtLz1
        cd40hAU2NF7XklYkcBQO4EOKBQ==
X-Google-Smtp-Source: ACHHUZ5HqjiOiMuPXsXe61fAouVKC1e7CFohAxEHW/IHu7rnhqq6QlH4Id/lSqykOkNqmpqcNWkgTg==
X-Received: by 2002:a17:902:eac2:b0:1b1:ae33:30de with SMTP id p2-20020a170902eac200b001b1ae3330demr8178420pld.13.1687204996405;
        Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001a072aedec7sm221542plg.75.2023.06.19.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:03:15 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:03:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v11 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <202306191303.7F374EC@keescook>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
 <20230616165055.4705-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616165055.4705-12-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 16, 2023 at 09:50:55AM -0700, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
