Return-Path: <SRS0=rt8p=MT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B09C64EB8
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Oct 2018 13:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E57F2087D
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Oct 2018 13:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHe82L1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E57F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeJGUR7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:17:59 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38917 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJGUR7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 7 Oct 2018 16:17:59 -0400
Received: by mail-ot1-f53.google.com with SMTP id l58so2212415otd.6
        for <linux-security-module@vger.kernel.org>; Sun, 07 Oct 2018 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oD4bjPRLM8kX4VFkCnj8A9RoJadoxxf+z4I0MfQN2BU=;
        b=mHe82L1xz+5W7tYOyl9V8oc8H9QC2mmkJQrNTbyeu8/PJGD6qEa9a+YxurCd+42KAV
         fJLhJ2gAC8Ox8g8oE3LFeuPolrCxbmYpzrQ32TjsvaXUrRMyNtPLsouLaGuwSwyisBf5
         f0+wWsFAKaEvt5EIPz5j5e9lOS+rZePK+mPHJmASrPd2J6djJwGR/SJgTrzsY72bgdJv
         ncz+ENWI+oKQ8hIaVyV4J4G55Q8WC2hmsT9hIBkRErsVLNcadD3Wa3CDW2XgxnJRY8+i
         UKH/dGq72WrfVjarg5z+IiG+KY8cX+99jIZmfK+dg1waCU2A4I1Rw/L7dNIUDIeQ0qoB
         kxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oD4bjPRLM8kX4VFkCnj8A9RoJadoxxf+z4I0MfQN2BU=;
        b=n+zSf6J/BmLhdUDe4k4qKS3fLFC0xCNlGmKDqCWXUNwX4iPACNer15BstNKn1eCji8
         uIM1W/2afhvEiB+SPBsZjNJhIn5Pc4I2/Rw8hIr9WDpmiEwJ3zO2brkdbelnSVqqMliV
         aDBWZmKoktiL5xYq7Ib1WTf+dQyha5Y7cIR02hl03G9dWBio3pxMrGrgD8t5Z0XZkJo0
         rdi5Rzcz1jVTiDv3Ooyt98PoTFvJgbpT7P04gitVaUtDoFtVkinTLZ9WVq2MHKi9Enlc
         U8jQn+QWQJLx5Cc1hIhxvHDj0bFFbSkHBcpLan9wweWLAqQv9Rq+Td8b60KfxvlbJmSQ
         SlFA==
X-Gm-Message-State: ABuFfojZlyHKZT9t5lAkC+orgdNIGvYoPgGkk3XpqjB092e3WiT33XlX
        5oBoRZzN2hSjzq5+7N098Hks3M5O0rdhTG3ua2U=
X-Google-Smtp-Source: ACcGV62PtldGoLongCrHd7Bm61emA9qYeHUaSIA9rebLiYK+HdnMWEhlcZ0oAODco+t80SkwjnHQwcLaCJjWl7H+abg=
X-Received: by 2002:a9d:32c9:: with SMTP id u67-v6mr2804164otb.108.1538917847838;
 Sun, 07 Oct 2018 06:10:47 -0700 (PDT)
MIME-Version: 1.0
From:   Marta Rybczynska <rybczynska@gmail.com>
Date:   Sun, 7 Oct 2018 15:10:39 +0200
Message-ID: <CAApg2=RJsmzYD6dW+HextZk8mqp9GfHDTF1gZFBHkyM9kduv5w@mail.gmail.com>
Subject: Re: [RFC 00/12] Multi-Key Total Memory Encryption API (MKTME)
To:     alison.schofield@intel.com, linux-security-module@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> Seeking comments on the APIs supporting MKTME on future Intel platforms.

Alison, the patch 01 (docs) didn't reach the mailing list. Could you
resend the complete version please?

Marta
