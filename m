Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367DC636D6
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 19:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjBQTFD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Feb 2023 14:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBQTFA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 14:05:00 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE56A63BFA
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 11:04:57 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b20so1140473pfi.9
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 11:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1676660697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0UUHSwRSBgw1Di3hv1dc2joLpIRoKiVHCR6u2xZ5s5U=;
        b=OUWPNpcwDDtQrNXH6zN+BDhoorzvlY5ERleApwFo4ggnfrHqIm1X2Qmh0NBQqtuKv+
         KxdBbmjayrQ28Z0NF9mXJ+BKSQ9YF3DHu38lipOnUxFi8DktrsW3uuNDvQPJNhUa5c65
         Ppk6WWWYWuhPbQLEbDiCz1XleJDQGyD4TboZ0Z2qAiy61wpkS5pjY2xw+PArdcux70R1
         Lo/Ze/FZq2HxQlcBSwWXTFLPjLjxzbIsIOWwjq9cEw+jtHz/Bmf/VSwxq1D7zFqNmsPS
         uV9elUgZvU6h0sB4GB8hc4Gmb3gd4dydMcLsqscJJRHQiY7Wx5azolhjESGhWXYamQSd
         rZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676660697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UUHSwRSBgw1Di3hv1dc2joLpIRoKiVHCR6u2xZ5s5U=;
        b=FDVayjng6EQ/Cq9L8KKbqllrNeEFIWAWi9Bs36oZRaJUcHJWX/DktW4UTXIqs6m2Ek
         nSFhfVW6yvpet0mY5Kk1qMtPgqeSFDeahTT8skg+d/dRZr7CakN/zWOMBw/yeQqr1M8o
         5EN5qwwXqvQNsgei0A0yb38TeONYmE0EzMnR04i0Jvf8sXh7JhmZWwfbIUNkA6ge6FVr
         ac4j+KVraaWGohqLh5dOt35AYLDK0Zoe2EszaEcsgagI2O//9hho1g5NAl9pCGgcUHDB
         OGB/bE2wfKASMwM6NRqhuPIeEFiqQhB3icgOpv0r5IKFyvZQ22vmF2TsKrujOiaoY3yU
         cPWA==
X-Gm-Message-State: AO0yUKVbp2/lK/SxpT7UnJKFGaPTTnvSMo4PivOu5DhvhPcW0bu0VcNQ
        QfLSyUuNz8ieioTeZGlLb804N9F1ewhlrvnHsjatEDNrJNTe
X-Google-Smtp-Source: AK7set8xmsVK/imRt+Md1GvGaWzgcL6pNncVVqdqQ2wxxDuk2g/7PoC0UqTWtwPFaV3Y6lN7YGZuEJflI/WxpVorl9w=
X-Received: by 2002:aa7:8bdb:0:b0:5a8:ab32:10e2 with SMTP id
 s27-20020aa78bdb000000b005a8ab3210e2mr26794pfd.19.1676660696714; Fri, 17 Feb
 2023 11:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20230217032625.678457-1-paul@paul-moore.com> <2ae3ccd7-c3fc-7b6d-d5bf-d427f1baef3f@schaufler-ca.com>
In-Reply-To: <2ae3ccd7-c3fc-7b6d-d5bf-d427f1baef3f@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Feb 2023 14:04:45 -0500
Message-ID: <CAHC9VhTWJD_BscNPmBAsWe6=ySXP1y82eRJOU+-HBmk+a4EvYQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 17, 2023 at 12:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> ... There's a lot of work to be done to make the comment
> content up to snuff, but that's another barrel of kittens.

Yes, most definitely.  My hope is that this patchset gives us a better
chance at both noticing that the comments are out-of-sync/bad and
maintaining them long term.

I'm also hoping that other folks will feel free to submit patches
correcting the comment blocks for their favorite LSM hooks after this
lands in lsm/next :)

-- 
paul-moore.com
