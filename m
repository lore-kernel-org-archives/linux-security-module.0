Return-Path: <SRS0=4lEG=AM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D8C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955FF2068F
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r44CNLXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgGAOFn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbgGAOFm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 10:05:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB454C08C5C1;
        Wed,  1 Jul 2020 07:05:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so10875351pgc.8;
        Wed, 01 Jul 2020 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=RMM9Z9iqlVaLrecC9159bXlUvQlK4CIqEqnJXgl0LBg=;
        b=r44CNLXio1SwO4uwtZlpHQc2QtN6pgOZX6XtUOA9/HJkTS3x0cxuSP5gz25EObyuMA
         PK5H4y993DtZwklYxD/IwS+Z6NoDf4aQYsx/lDFY89RtA9hYH32GnXQsTbYbXVSBMzR1
         V5ZAT6yiF71y/kgwE21NnxppxPWFgxOZKS4BINbUjd6LKIWXhnun3l3XNXaWT9jPygVs
         rPbfJ9JStAOkVqZlPKkH+COiKW8gRDz4pOsW1kDWJeQ+4cCe+ImzcbEJ0MRn2XFUtU7S
         135AWJt+FWwSv3VoFulqIOJDIXLASMWe3E5dcoS0vAtZuLOjTleymKTL7DfjR8Aqve7P
         JrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=RMM9Z9iqlVaLrecC9159bXlUvQlK4CIqEqnJXgl0LBg=;
        b=Wypv4KCCTX/2xFHxksoKtpQH4HMV9MRBvqBdy8gJ5/vW7m7WhbcYpNiDhIDe+bSbyG
         GL2i80tyuMnhGUpppJlnVR2h2lGkupQfnjgEUXFx6FtlSS+8BCvhN9Q0xDDlLBw7WwzJ
         HBzueh9lUDEb3FDQup7EDWZxieAUCmOc13cdh9apwXi7wzYPCkO5SIbtzQXGLAQj8Sjw
         rv2CmQ+17dDhyaNN/xPt46nLgneCbN5UrveMfnqQn9g4dpgpmbmu6YppjaAAczRXVCtc
         6Kas9fKE4Sl925fe2PS3citqg5ozZtEBIPg7y8aqFauyJccoyGqkdvG0GOqAwPw/8an4
         uL2g==
X-Gm-Message-State: AOAM532qswJ91y0yn8YjT3BVK6d2EdMKf9gWXfeg4NLtlS3okhZvX+WJ
        5llX94SUmjzIDZvA1gjucmQ=
X-Google-Smtp-Source: ABdhPJwvByK5Jzee0/xKvEMoktkPMd7F7n2aH2FmmD/W+GDfavHt+/RsByl41xaRkdIUQ0a288TwSw==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr19281888pgn.194.1593612341558;
        Wed, 01 Jul 2020 07:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([103.86.69.165])
        by smtp.gmail.com with ESMTPSA id y200sm6036543pfb.33.2020.07.01.07.05.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 07:05:41 -0700 (PDT)
From:   =?utf-8?B?6buE6YeR5rW3?= <2538082724huangjinhai@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH 0/7] x86: introduce system calls addess space
 isolation
Message-Id: <65C2C351-F43A-4C32-90E0-8CE412169084@gmail.com>
Date:   Wed, 1 Jul 2020 22:05:34 +0800
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

How about performance when running with ASI?
