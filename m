Return-Path: <SRS0=jdUL=TV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CABC072B5
	for <linux-security-module@archiver.kernel.org>; Tue, 21 May 2019 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E7D21773
	for <linux-security-module@archiver.kernel.org>; Tue, 21 May 2019 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2KTTUPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfEUWkR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 May 2019 18:40:17 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:32809 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUWkR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 May 2019 18:40:17 -0400
Received: by mail-qt1-f201.google.com with SMTP id m15so182745qtc.0
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2019 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CxR5AlWDpArVLEx0HLe6lnTbiemspwxzj3fum4FdAg8=;
        b=a2KTTUPYY68mgnwLoZX7NpSamuPKa/UmPwh3ZXp/yHmS1liRwwJzfEOpVjkQVsGegs
         6StcJObJONEMW4BoSCAz3v0V84ruIgUSBpAkqjHte5mNxudvhWYOXjWrr1yAaOo70Ni2
         B+PnJGvCbugteJbXDXPpmFTtHbkNAYDPGoC4vaPDhxWwa3zD+c5WuQCs6jw/IrwcEBg4
         pN9GNTEhvTAO0EF2pA2C09Z2ieNP0ea7otA4B6ezj2yTvTslcHkPjU7pUrUV9nws7uJO
         7FJiK0RqG/f4trm++BfAF10+spOplapIV1LzayaMkLF19AnC2OhAMwPE3Ck//7irDXC/
         L3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CxR5AlWDpArVLEx0HLe6lnTbiemspwxzj3fum4FdAg8=;
        b=Xq6+rSbpaSHWVa6Zt/j/a6LlUMntgRLTGH+/rerQ3jmVDVwgAIguKRBU2Zd55ZnxkD
         SOSkGIKQs7mZf6lyKXD69FJcqpbHoSTjArrqDcTkc4Aqv5X+RHlcneOhAL6qvX1o6VKi
         xO7yFVloj7j+qC0UidG7lSGGeWcJ9V1iiZznAd0jvnFSd+zC6bBa71jCVzi4v9GuhwBO
         nGtkK8pRr1W7y/cGwHitVFvH0lSi4XxfV3an2ynqWpLJSf2ZrnrhOlyRPQPL4+VVlOt/
         1rCAVGc+jCnfnyV3YNNBhN5XuZUDCyn52RFqPP51lQnZ/+3wYVzPvHQO9ht1SxIlV9T0
         nKkA==
X-Gm-Message-State: APjAAAXDd0FMw+DUTBjGFm9RJ97CiWZx5D3OT6KYa2XAcmtnjWoVVfY8
        LUDSFRQgdB1RazWkX+FkLsrqA1zGLVTWgz0XxiG+YA==
X-Google-Smtp-Source: APXvYqz4gdnvVuv7br9Lscej3ltCpnqgHO2bJjQda55zn6GOiF+J20YzxwBnrBHrqmZD6gAn0V2OPJ8Zkw9G2OvLC8Cs7Q==
X-Received: by 2002:a37:660d:: with SMTP id a13mr28849673qkc.347.1558478416387;
 Tue, 21 May 2019 15:40:16 -0700 (PDT)
Date:   Tue, 21 May 2019 15:40:11 -0700
Message-Id: <20190521224013.3782-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC] Turn lockdown into an LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

This is a quick attempt to integrate lockdown into the existing LSM
framework. It adds a new lockdown security hook and an LSM that defines
the existing coarse-grained policy, and also adds a new
DEFINE_EARLY_LSM() definition in order to permit lockdown (and
potentially other modules) to be initialised at the top of kernel init
in order to allow policy to be imposed on stuff that happens in
setup_arch(). The goal here is to allow policy to be devolved to other
LSMs on systems that have a secure mechanism for loading LSM policy
early in boot, allowing creation of arbitrarily complicated policies
without interfering with the common-case coarse-grained approach.

This should probably be extended so a uapi-exposed constant is passed to
the hook in order to make it easier to write policy in other LSMs, but
does this broadly look like you were imagining?


