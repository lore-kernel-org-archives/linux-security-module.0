Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4544AC433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Apr 2022 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449717AbiDVQ37 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447970AbiDVQ3y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Apr 2022 12:29:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209015EBF1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Apr 2022 09:26:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5666884wmn.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Apr 2022 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQKwgkK7XcnD0Rg5dyzM5z8p1A79/VfuJ1pqbXYKM5g=;
        b=DB7OJJQM6ToLBwkgF1N6fJGkNaBv8n3ClPRlWkq03mVVL/VMuo988a/CRj/JU2y/J3
         LxIs6u2dVbU/dDDZQkfSypxNKRbl/F8k4++kuvNm1WnLAugDdOpzuNve1T0LTcewF0bY
         zmEP3SO2qgXPWgxHFH4ICYAlPt3RzE06HMA2A3AiJv7egQz6/emF65NCjuOgSU9ESYU4
         BDFntr1axQYaCcfEpgCW/juiNKBN5tRTlUoplhRG6UdiHRv6so2i2RIQqbOdUI5f8AnA
         6I5JDeixp+QaRbIk+MeGB/B/IoWYPnesEjbNFuitEtMfGJ/Nrz9uobpFuEWDZMT7afgN
         kKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQKwgkK7XcnD0Rg5dyzM5z8p1A79/VfuJ1pqbXYKM5g=;
        b=Yhwzqf6Ipqw3VgFGDuvZ/OjxPbGvzTh/K0Xnxpxp427D10VvdP8fMKetKesuHx+Qsr
         +Xw5Lnrc+1FeQUrRynNkNMvcYs4jSlgv1QNi+y64KFf5/LqDrX3Nvb9PeT1Ur4devGJ2
         Vgk38V35Uz+4qYilv95UDfmGyDIaNl2e+1+4RXIeXu2jujzz+T6gFZ973cN4VOBuYVdw
         8TaTJpp9fExVMvhiQPvtwmVcrHS8QAqoMp5/i9ZLkuU3kue8oMjrkiVlRiV9eDEuZzbU
         HMxIgrO7EMTfgRH8htr3DiM7CDlwFzBs63DwMqlGrfx5416mlVHP+P1AKcvuzOCMqK0g
         MDpA==
X-Gm-Message-State: AOAM531fnoL0BH0Py6RN8vME4OS0f9caVCxyeGFxtw+M4EP4G1JD8fE5
        SyRLWEoKt9b9FRbKQDcPIA3R/w/TngcRtZMhTgBj
X-Google-Smtp-Source: ABdhPJz0usETe5tYcvsLPEcLUMTwIkTc1Rk3Ud2Ys3tDsyivrygwosiMcwEzjUWboIzGHFJlhESi2sq4OIiN1z5J2UY=
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id
 i131-20020a1c3b89000000b0038eb37f052dmr4774530wma.197.1650644806553; Fri, 22
 Apr 2022 09:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-25-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-25-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:26:35 -0400
Message-ID: <CAHC9VhS04Q5BdOgJAo0QB-HZNSgCVRbp1-YZn7vitGfVrqyDuw@mail.gmail.com>
Subject: Re: [PATCH v35 24/29] LSM: Add a function to report multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 18, 2022 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add a new boolean function lsm_multiple_contexts() to
> identify when multiple security modules provide security
> context strings.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
