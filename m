Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF1C77B7A
	for <linux-security-module@archiver.kernel.org>; Wed, 17 May 2023 19:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjEQTTC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 May 2023 15:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEQTTB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 May 2023 15:19:01 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAB93FD
        for <linux-security-module@vger.kernel.org>; Wed, 17 May 2023 12:19:00 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-435fff402d0so693567137.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 May 2023 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684351139; x=1686943139;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=djz53qBW24mm+IseX4ilIbjpu0Oru3iTOyqYX1FTEb4=;
        b=RNYlQdUQFCffJ5Ah4bMK6yFukgNScNsvu2z9osVXn/f1Bbc2hYJl9JzzAFM3anChIU
         5/0rFVHXDBFtSXSQNBijbJoOEZ2NwNpzhhxcbYAK5HBNGwaGWJEUGHht13Av+NfORH5b
         RsiCn6NYeiCTdtz7FkvRnJ66+kDf6H3ToRXFUSUqiK1yf3+Bi/UZlI6h8djBPF8cc8wV
         AhKjvQcMb78KWRS3ekkVd2xGohJAMcuCKip1y74qgoT7wLHcvOZkoRPdGPTLAULPQRAP
         7RB1xvrC3iafTdyWs9XROIFRPYf7Namo/cH237B7VqO5Ui62SOldpVtgq5423vh+k513
         s1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351139; x=1686943139;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djz53qBW24mm+IseX4ilIbjpu0Oru3iTOyqYX1FTEb4=;
        b=Npk3wlJX/sYwzkNu4QF98u4y2vGA+Es2KlY/sjSrLC9XwC8ckHMzJVf45QJU0wHPFV
         +823nccWymjxdqROMVRDUK/DsTine0m44sPBfCCVWfqReVNgnNVSXid7RdECAuJSzrS8
         A1kCkBBXEC79RRtS6XZU2fDQHR22NgB0tW4luZCyiC3ZXstyI3WD8TMpa5m9zWndOaCc
         NfMeHVbeiAqKs9c7DsZ2FFe9XsEAKhBBF43mzjGTiaAJeA+9LxvYHpJiZ+JkLbV2EswE
         f8Sf/Q2NBQLDTjne/pM2JReHjp3BGsMh1F/rnjGMVr6xkt0+aynWzqa1xCXXYNcscoNR
         Gncg==
X-Gm-Message-State: AC+VfDxCF0Uy7SdCtkiYgGJoNdW6H5lJ93x3ejjh7TKFGevY26dNcJM/
        C3X6luYg/Hwj8O7KkDgyPusEMGpLGy8E4xYnOrOAiH1akfldt4w5rw==
X-Google-Smtp-Source: ACHHUZ7cCFHkyNROt5MFutOZc6P3Luu85tpsuo1yl7CqaaUYoymJ7WFWh9zdoyi1EVq8/eR/36HWHrBxw+bH23fBtmQ=
X-Received: by 2002:a67:f9c7:0:b0:434:3acf:3241 with SMTP id
 c7-20020a67f9c7000000b004343acf3241mr17459976vsq.30.1684351139151; Wed, 17
 May 2023 12:18:59 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 May 2023 15:18:48 -0400
Message-ID: <CAHC9VhQ+mcOO+HViHL3rVqv+MOx7fkh1iqU0EFM3wCcOjS5TZQ@mail.gmail.com>
Subject: FYI: non-standard use of O_PATH fds in BPF_OBJ_GET and BPF_OBJ_PIN
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This shouldn't impact any in-tree LSMs[1], but I wanted to make
everyone aware that there is a eBPF patchset being discussed which
does some unusual things, namely treating fd 0 as AT_FDCWD in
BPF_OBJ_GET and BPF_OBJ_PIN.  If you are working on a new LSM, or
adding eBPF controls to an existing LSM, you might want to check the
discussion linked below:

* https://lore.kernel.org/all/20230516001348.286414-1-andrii@kernel.org/

[1] Only SELinux currently implements any eBPF controls, and even then
it only enforces policy on BPF_MAP_CREATE and BPF_PROG_LOAD.  Not to
mention that SELinux applies its security policy based on the label
associated with the file/inode, not the pathname.  Regardless of how
the path is resolved, or even if it is resolved correctly, SELinux
will still properly enforce the loaded security policy.

-- 
paul-moore.com
