Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CEAC433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Oct 2022 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJGRfL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJGRfK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Oct 2022 13:35:10 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF542E71
        for <linux-security-module@vger.kernel.org>; Fri,  7 Oct 2022 10:35:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m130so6286863oif.6
        for <linux-security-module@vger.kernel.org>; Fri, 07 Oct 2022 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dk6tQJdYrdVnt5J0XTqD1Ykt5Zifw0rjbpHHEmz3lLs=;
        b=GMO4QHCYRB7uW89yNSgBKu6So0atvk7I30X3cih57CLaErtXYhsr8vnxtQWwL55U0T
         u94Axl9dsJMl0J6xnuCJaCsc50hud9rOR4EWTE4kguwkaFySGG9XyrrUE/LP5e2aLBhW
         XcR6E/8yzPbF8LSsulYQJFXrGiAPIHNT1BmzVkOBzj8AJp33/0blQPBamAw4RNwELvbR
         bOpyrb4ga/h/VtXBpTFBFwQdLFw5jvoL6GmX69coKW8W+DTVNH3aa0y+S8UJ3iN3cIHZ
         Xlp0cOjSFVkx+fmhwO5CnzYAl/TaeZmGdWATulskMeLyO8b55VWIWlFYq33pTsCq2lMo
         pgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk6tQJdYrdVnt5J0XTqD1Ykt5Zifw0rjbpHHEmz3lLs=;
        b=1AyhbdlM3GVn8ZDKcCXROXSYW2TRu4JU/CmjvwixyrUAqPZoMNRcg6O4f9kn2CP++1
         A+zokQEMDOtvL7hysS3sQhuG/iePKuZw8PQKr3stFrpHlIEuOfn85c2YTO47ue7cg/t5
         dG/E6O2J29Puxh3fxr8kLF0IbwIFCHvN5E7X0wGySb7b8qnKeLSp9qjlKJEV7p4blZHI
         iQUCYeguFIzggXuGn3I19M2wj371cwwO8oJ6xbiypF0IDdp+xZZu1FK2DY5u0hGAetNu
         7T0yzwalfMCiacyLbnCMp6YqfHfYxsgihRIy/cQigIbtDz4LZMsA1u5UBZG5KRzFbgLx
         ZZug==
X-Gm-Message-State: ACrzQf21gNNBchOIA8GLHukEpo6LWCXNlzbxmTcqDaJeWsKKUTr+v8yn
        D95+sUubWXwhhp7pjnOAZwOtvTenf0zxtp1nTQQZgFa6D8PI
X-Google-Smtp-Source: AMsMyM6HOob3OhYe+iDodY/fdaWV2GZRIkRuW67saGDP2dd9w/7MHUwV1/LY76uwHOehBToBbFtWYduOjNB4W270Dzw=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr8293565oiv.51.1665164108830; Fri, 07
 Oct 2022 10:35:08 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Oct 2022 13:34:58 -0400
Message-ID: <CAHC9VhSzQtFkksJ5zBnhOYCpvDGNjjn7SKoC4MmopepWzb+Hfg@mail.gmail.com>
Subject: IORING_OP_SENDMSG_ZC should enable auditing just like IORING_OP_SENDMSG
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 493108d95f14 ("io_uring/net: zerocopy sendmsg") added a new
zerocopy sendmsg command to io_uring, but it enabled the
io_op_def:audit_skip flag, causing the operation to bypass auditing.
As far as I can see, the SENDMSG_ZC operation should be subject to
auditing just as SENDMSG.

-- 
paul-moore.com
