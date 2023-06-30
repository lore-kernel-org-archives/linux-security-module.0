Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919CAC001B0
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Jun 2023 02:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjF3CPH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 22:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjF3CPD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 22:15:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536533AAD
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 19:14:45 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-635de6776bdso10014796d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jun 2023 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688091284; x=1690683284;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+KGax9Prrl1aK209DwaJqb3NAowYrI4dDxErwwgPnk=;
        b=C2ts+DNrL1pQiS6JNzSxtLrzLQgwS4NaOS/YnhlmW81by+di/BvhE8arb4BA27x8I9
         7RPiRL//DKgH00EWeUlk5nGnq47qPNg0L0YQOoRH1h54u2xxWKO86Xvv9Rkk+c2eDKHt
         O1QfWsUjjmbF8QQNVeIczz6ooIRZKDX315WMqWw1qkQ83MSnyUdIBgepvnm6VVd8ElDu
         vAA6b7QH2tyRze/wcGKp7SgR1fT2JVAF2IUpQNsWJqAGycMfgoNaxs6iVUjHBMXHEC6T
         ZJc+PuSXkrXJY82Z44ZETTdS+Bry/TBqKQ5TAUq/ajgrFtq9MJeNcTxjIOKw1x37s4JV
         lXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688091284; x=1690683284;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+KGax9Prrl1aK209DwaJqb3NAowYrI4dDxErwwgPnk=;
        b=FkNwScYD8iXuTxYqNAusllRNpGaToQ8FlGbmh8x5Ro1cWjHeV8Kv3c/YpR66xCfos6
         wnq1deOzhjZvnCw0df/dn3iKBuEZ1R49wCnVOJ66MkqC07h+gNMNSHRhy6Jnfb/wiBf7
         2kJEHpWbTL4C+sx05hFnpVGmTeiGfewUWtPV9J5KNugzDDFOpOj2R9c/luEefHWUbXGe
         uExIJtiP9Mi4QAzQFmsYjKxGYYz0+Xf+tq4QbM/55rffHTbcW9qiEfllTWG+nCUPdVZW
         mGXQcxP6PW4FQX+EcC+WJ5q4aBYiGkJdGJngmja3wb1uCZ/BvR8bvIoL29E9mbtRNsAa
         1BLA==
X-Gm-Message-State: ABy/qLb4JLdl1Enf4DYOX6rG+/lPse52x3d51IL0+xrZc3SaZaxkk/wU
        uD8F/f8PiDVo5ops83b5wBDD
X-Google-Smtp-Source: APBJJlH5EBMN8EeWHXhbgDOC/3nssmzHrLsINxD4+rvpHzaF785iwnCjOWgfV1Q24nc5i03ReoYVGA==
X-Received: by 2002:ad4:5ce2:0:b0:634:7c34:6c6f with SMTP id iv2-20020ad45ce2000000b006347c346c6fmr2074259qvb.13.1688091283768;
        Thu, 29 Jun 2023 19:14:43 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ea19-20020ad458b3000000b0062626bd3683sm7564128qvb.59.2023.06.29.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:14:43 -0700 (PDT)
Date:   Thu, 29 Jun 2023 22:14:42 -0400
Message-ID: <f43449f878f629805d5de7fd06306741.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        john.johansen@canonical.com, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v12 0/11] LSM: Three basic syscalls
References: <20230629195535.2590-1-casey@schaufler-ca.com>
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Jun 29, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add three system calls for the Linux Security Module ABI ...

I saw two small things (see patches 7/11 and 8/11) when looking at the
patchset today, but otherwise it looks pretty good to me.  However,
before I can merge this, at a minimum I would like to get an ACK from
John on the AppArmor patch; an ACK or a Reviewed-by on the rest of the
patchset would be great too.  I know Mickaël has reviewed and commented
on this patchset before, it would be nice if we could get his
ACK/Reviewed-by too.  Of course reviews and comments are always welcome
from anyone who has looked over the code; this is an important patchset
so the more eyes the better.

Assuming no one catches anything further, I think we can get this into
the lsm/next branch as soon as the merge window closes.

Thanks for all your work on this Casey.

--
paul-moore.com
