Return-Path: <SRS0=UBGi=AL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE5C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120A920781
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNBgUBpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgF3AJ0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgF3AJF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 20:09:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB31C03E979;
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so5214552pje.0;
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=N2ghh+x2mnd38hUoBxoJrOWkNTcIvZQjlTMkdavqdz0=;
        b=oNBgUBpj+1ShUQHnAs8/BfFKffFhuDXBkCS4kUeTG6jYJZc6oVuHHgkNayMtpXVkaK
         Ddf0CbIS5TRiP0N6DWUTRTenBe3xIo2k1o3Owu005rLGa4LlCNpPKiRM9aLu2WdyOaRu
         TGtHJ6hvP6+zqgChWUyaqU8REFQj7EBnih6jhAQ9DXjZ4HrrguaEThBfzng6VP3qmp7B
         6XZMyBKvQVpYNoOBL7euZysd6KD2ZjzHSu4Q8v3hj87fNU2CyAQC77brwIyewPQSqmgc
         BNWFy1cyZfJzlXmSegSSvlmbt/wDIgDOZiW06r4uBb/7vgsIGr6oY1W73Y36hfWWF43o
         jJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=N2ghh+x2mnd38hUoBxoJrOWkNTcIvZQjlTMkdavqdz0=;
        b=Q93WzTGytfcwAhol2SX70aqGGtGqWuqQcKCI2IqehmMjE8UGkKYZ6AhNt3YGTnkpFX
         DWxfaG5Zd8xtTV/ruUUtzMYRZkGkFha3rz1a5xICCwcvB8xcxMzzd5/m59XaRCSjEngj
         EkZiq/dN66qbEDchRY88bAXgQuejO4Pxw6oK5SQ7D0UM6+g394qaO8eRbgGvdfPUeGmR
         Vn/p8/2HIlFu5UoqBYpBNIWbAyn8GLT57ypiBJ2Tgut3eEeZzzfAKds/UgrXMD8tYHBw
         n7A2Hgpwd4cDx9JBoj4wM5qVpcJpkouGjs/j1MTSctnD6wuc9ORmIuyEcGxrvglnQ4zY
         +mhA==
X-Gm-Message-State: AOAM5321vz8LiNNTrXBmLpCbLxYGHesg2TY/WpxiXBZ1MWp9/b46TbC+
        cD/kbxkX7Tugeh3Kb2hvovQ=
X-Google-Smtp-Source: ABdhPJzGefNdqarPqnCe1jKaGTGJasxjDFy43fWwUBKu6Jg3mnRjOYWTkeNA+C6ITaCW43nMnHDFjA==
X-Received: by 2002:a17:902:8e8c:: with SMTP id bg12mr11255411plb.202.1593475744522;
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
Received: from [127.0.0.1] ([47.244.202.117])
        by smtp.gmail.com with ESMTPSA id c207sm688780pfb.159.2020.06.29.17.09.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
From:   hackapple <2538082724huangjinhai@gmail.com>
X-Google-Original-From: hackapple <2538082724@qq.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH 1/7] x86/cpufeatures: add X86_FEATURE_SCI
Message-Id: <94E40D06-B481-45B7-A929-CC324F5B856B@qq.com>
Date:   Tue, 30 Jun 2020 08:08:59 +0800
Cc:     James.Bottomley@hansenpartnership.com,
        alexandre.chartre@oracle.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jwadams@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        pjt@google.com, tglx@linutronix.de, x86@kernel.org
To:     rppt@linux.ibm.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

What=E2=80=99s the version of kernel?=
