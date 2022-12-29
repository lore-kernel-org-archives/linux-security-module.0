Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A624C46467
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiL2VSJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiL2VR6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 16:17:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB862CA
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:17:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p4so20458025pjk.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVeiyrJ2WHN92bOJqf7CtraviVKVi1HlRqN5mSCkjjM=;
        b=aGtwoQFnxCOg2D24HxwUW/JFCCJLEI4Roxj6OX5hwsUp3UtrC/e2UUTaoartuC2HQw
         HJmOeMy6FP74c9Ya+x4eA2Elu0gJofWadUsACAxBg+UTHKGl8tNMMSB1D9CjGUlh1pTB
         eegCNHcVM+J3DYP1XKBloNJaC/BO3gk/Obp0c6cBTRP0dN9BswQRuI0JzL81Xp3/IhrF
         gnl8LLNGPc3bkLBM96EW/zzRccVpNv8HWKxRC9bprFf04BHq0oF3KADkmnqwMK9Pu9Mg
         8VDE1i/yzyY+3ru6tBcZJwkJKxbHqEgroZK8GjrJslTIsHywtO4KPWT/iveABvqIGgv3
         iVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVeiyrJ2WHN92bOJqf7CtraviVKVi1HlRqN5mSCkjjM=;
        b=k2g2NIvirHLbXnfhNUGuhs96wVjHBQTFNc4XmzDFgOBrXM1apwRjlMNfcqSuKsLMUY
         fqOa6X0qhKvzz5sBeFjWo3gr2HQowPRu8n1/1ig4iZEoqvd/hjekk6ZYKllAQugoHga3
         IKI1KEUqBEIOwEBFtsQZ8MiyYbWzA7Yizjaj5y8OqcLIyBBBCXLPPMZlndN+88l5hONd
         QVJgAQ78RosWi7RWJKVCCmUt4ju7+CG5QUY5tGM8gCu/13LPc22K4DZ+ZkCd4CIbFsPp
         8dp/J2L5iweuUyprxDCJ/Y20Jv6/ty6t8j3Qw6R15ERtcwjfvXBhgINwmOp/aaJCIAco
         UwTQ==
X-Gm-Message-State: AFqh2kqvDFtQIiPRyjBCF1Q9xfixxRABzExrD9/LEzf/VO6lVjpCVPO9
        P/jjhTvqXo6dpcPXAa3h/tqdCX8t5QkVo+8yLsT1fQ==
X-Google-Smtp-Source: AMrXdXtnfld70zc/Sz8/dhzCpeSttKs7mH9WArXVBw4CH/BQt8SiOMJzuKIeCUGkHDJ2kKEvta3sqOau92KRaNzGTaE=
X-Received: by 2002:a17:902:f2ca:b0:189:894c:6b58 with SMTP id
 h10-20020a170902f2ca00b00189894c6b58mr1453827plc.172.1672348674283; Thu, 29
 Dec 2022 13:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20221229211446.3154454-1-jeffxu@google.com>
In-Reply-To: <20221229211446.3154454-1-jeffxu@google.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 29 Dec 2022 13:17:15 -0800
Message-ID: <CALmYWFuEt=DnSLxu05=zk+A81NM3EEatzyPmNxCyRj+a1mPsWg@mail.gmail.com>
Subject: Re: [PATCH v7 0/1] selftests/landlock: fix test when overlayfs is
To:     jeffxu@chromium.org
Cc:     mic@digikod.net, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Not sure why the subject is still showing V6, even though this is the
cover letter for V7,
and I checked the original patch, it is V7 in the subject line.

On Thu, Dec 29, 2022 at 1:14 PM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Overlayfs can be disabled in kernel config, causing related tests to
> fail. Adding a check for overlayfs=E2=80=99s supportability at runtime,
> so we can call SKIP() when needed.
>
> v7:
> Fix bug in supports_overlayfs().
> Manual test with kernel with and without overlayfs.
>
> v6: https://lore.kernel.org/all/20221229201215.3006512-1-jeffxu@google.co=
m/
> In v4, the SKIP() was applied at FIXTURE_SETUP() after mount() fail,
> however, FIXTURE_TEARDOWN() will fail. It might be complicated
> for test infra or testcase itself to have cleanup code handing the
> success/failure of steps in SETUP().
>
> This patch changes the approach, it calls supports_overlay() and SKIP()
> at the beginning of FIXTURE_SETUP(), FIX_TEARDOWN(), TEST_F_FORK().
> Because no modification of system is done by the test, cleanup is not
> needed.
>
> v4:
> https://lore.kernel.org/all/20220823010216.2653012-1-jeffxu@google.com/
>
> Jeff Xu (1):
>   selftests/landlock: skip overlayfs test when kernel not support it
>
>  tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
>
> base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
> --
> 2.39.0.314.g84b9a713c41-goog
>
