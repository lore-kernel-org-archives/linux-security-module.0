Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C4CC433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 02:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKPC1Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKPC1P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Nov 2022 21:27:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B127B37
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:27:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso1022396pjc.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahZz9AJmzGlJIQIWPIPRIoLfIVWlXjpHEZJmoMH+xOc=;
        b=gGDZf0rtUePdblahow2E25VxQTPgN7jbIs+awl+TPpQNdPWanNp680Xf0nzQ7ZL+Ot
         pavAPVefaCJKXta+Y2M8VoiD75BMMdqL/nc6y3Yqu8UwQA1u6qmGuuFK0fY+nLsSH8Lv
         4roikcbwV07w5YhUXsWDMXrCohpJH7hktpUdLVjXRv7d5HQGPloCu2jKkH/ynM3gk50w
         h8zf6xWphdiQfuoWFN4iMPRILF10kWYXSXI11LOTIWcFzwHeIcSv1L8dXgpqEKnCy0x6
         7F+DA+dujgDJl1VAuzCRA5O4PpI8PiHDtP+PbEAhCa2VYjLRh7PxPQ5GU2Ty5bSEaJQ5
         EriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahZz9AJmzGlJIQIWPIPRIoLfIVWlXjpHEZJmoMH+xOc=;
        b=Zze0Pt71o6G1Fsuhwy9qp6aNCpHFF7c0qzpotewdNr6Y/qw3iUef+N5m1UAGV477M5
         4wCWf1KVwVzv7GQqh80OMjoAUk91wX761A//u+9rMuDq7RtkRWpYnIabHSbg95kbG0iy
         AStHkuX4DXdavZeKw5tXVr2Dfz7ZA62tLQFUHbEqUBGGVJs8irZuKwtYLL8fj4ZloggX
         CcmpCAj9GtTJFVzPQ+gRhxHSUiK/7SBR2u36jrdWAi8xh6Gud9SGVKFj7t9VhfsCxg4u
         rFw+l9sPCkFha5Hw6S1ucI7DVhx5GsUs0cX6m8dQRphbHkYK+Jyv5umpCMGra2Ez1UZ5
         HPrA==
X-Gm-Message-State: ANoB5pljbIcCu5Kh9jcdY1WfgXzqTTMq0jvnaiaOig5qKb/esTWK+RRX
        /MZZHsXnJjGAA5y8OHN5Jg4NeQdD0WGKFjW29RFV
X-Google-Smtp-Source: AA0mqf4YV8pgzBiL96jyU49MeQd2r/aiOKiYHCrbMrG+E2Fkmtbk+xgzRFLez6ziTJjdzAaOlAYcvbYh3pAWRbHWEqM=
X-Received: by 2002:a17:90a:2b8c:b0:212:f4f1:96ee with SMTP id
 u12-20020a17090a2b8c00b00212f4f196eemr1447232pjd.72.1668565634126; Tue, 15
 Nov 2022 18:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:27:02 -0500
Message-ID: <CAHC9VhTA7SgFnTFGNxOGW38WSkWu7GSizBmNz=TuazUR4R_jUg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] lsm: Redefine LSM_HOOK() macro to add return
 value flags as argument
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Define four return value flags (LSM_RET_NEG, LSM_RET_ZERO, LSM_RET_ONE,
> LSM_RET_GT_ONE), one for each interval of interest (< 0, = 0, = 1, > 1).
>
> Redefine the LSM_HOOK() macro to add return value flags as argument, and
> set the correct flags for each LSM hook.
>
> Implementors of new LSM hooks should do the same as well.
>
> Cc: stable@vger.kernel.org # 5.7.x
> Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf_lsm.h       |   2 +-
>  include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
>  include/linux/lsm_hooks.h     |   9 +-
>  kernel/bpf/bpf_lsm.c          |   5 +-
>  security/bpf/hooks.c          |   2 +-
>  security/security.c           |   4 +-
>  6 files changed, 466 insertions(+), 335 deletions(-)

Just a quick note here that even if we wanted to do something like
this, it is absolutely not -stable kernel material.  No way.

-- 
paul-moore.com
