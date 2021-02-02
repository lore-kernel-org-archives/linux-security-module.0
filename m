Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF380C433E9
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Feb 2021 19:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B52B64F91
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Feb 2021 19:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbhBBTQ2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbhBBTOS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Feb 2021 14:14:18 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C1C0613ED;
        Tue,  2 Feb 2021 11:13:37 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a8so29575793lfi.8;
        Tue, 02 Feb 2021 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ti+SnrqAH/0Tc4A4Abslaivo8HMiDpiHUB8vKR58GDw=;
        b=ephl6gjqGHlTsdvTdIVUtzb67nBWtZbdDKxYFbl5ty7e04/qfiRJW6B0g14zpvZP2W
         8v9qsZ5oLAbZ6iMzmiWUXq/XQDQbVmIezaeen2RNiLoNDAwwAMNN/iujQL+SJhtU4dun
         Tce4STX39FyOq3FeGf/WlC+GABCw3t+2Pml+y/laIxPFN12TBPVYAdVz5OaA79/nqS3x
         4t5v4XwV57bgBbSqDAvHywHv6APg7uNx4EIj5dIRcNNJn85D3udvnBHlNnv778upWAoZ
         dq510L/EkbWwnUh2dyp+Dfbm7pJbs9pQBfzw7csebedB1PCHlrJHvn29m3LejpOQ49BI
         hb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ti+SnrqAH/0Tc4A4Abslaivo8HMiDpiHUB8vKR58GDw=;
        b=TvIzS9DImXolx8xVG4OiGzKRf/QXYtJRNpQ8e7yK1M888vJaC/GQ3QZxv7k6ZiXAFX
         3UXomwzrtAzz+ibS+Xc2f3AINZlj9Z/IxnN1datA6aR/tQBWRmiN8Sv9aifV3K127TS8
         VLp411BOCEJBZ6CPic3odUzpaejKA9w7ISBJSkidvBCWFQfH6Tm5nQkwkRpJyws2Idfe
         xssRb0fRqSYQ7zPfB5ddN7X9YWKQncEFCS10Y+kdxhihFjh+Ca6Xtg/I8lvZhpMzLUzz
         C8WYBiBy8xSLw7ficowsbv4q38Os+XrZZGisEnffIZD7O9jMBNr7CjNf0x9wC3K1tatd
         Jg9w==
X-Gm-Message-State: AOAM533B3K66DKXDFDQQWbQiKm7g8gBdALXLkEbqh7LPSAAOPhOPyjP0
        LswAs06aLLcI7dHp7Mc1dyg=
X-Google-Smtp-Source: ABdhPJyM5hMXLtPcTE+bvMnPhU60nqy2i/9nc7bSQTSeDpcUZx3vwxO/s9YORLHgLXx2LKgFguWzWg==
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr12096680lfe.200.1612293215695;
        Tue, 02 Feb 2021 11:13:35 -0800 (PST)
Received: from localhost.localdomain ([37.151.209.186])
        by smtp.googlemail.com with ESMTPSA id p3sm3402591lfg.14.2021.02.02.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:13:34 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     casey@schaufler-ca.com
Cc:     andreyknvl@google.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com,
        snovitoll@gmail.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] smackfs: restrict bytes count in smackfs write functions
Date:   Wed,  3 Feb 2021 01:13:18 +0600
Message-Id: <20210202191318.1402500-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d0f9a341-281b-704c-04e4-4304ed17ba23@schaufler-ca.com>
References: <d0f9a341-281b-704c-04e4-4304ed17ba23@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> if PAGE_SIZE >= SMK_LOADSIZE all legitimate requests can be made
> using PAGE_SIZE as a limit. Your example with 19990 spaces before
> the data demonstrates that the interface is inadequately documented.
> Tizen and Automotive Grade Linux are going to be fine with a PAGE_SIZE
> limit. The best way to address this concern is to go ahead with the
> PAGE_SIZE limit and create ABI documents for the smackfs interfaces.
> I will take your patch for the former and create a patch for the latter.

Please let me know if there is anything else required for this patch.
AFAIU, we agreed with PAGE_SIZE as the limit.
