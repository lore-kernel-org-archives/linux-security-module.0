Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D84C77B7A
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Jun 2023 00:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjFHA2T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjFHA2Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 20:28:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41B26B3
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 17:28:01 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565cdb77b01so208917b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686184080; x=1688776080;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UzYw+LyF924EEMlPqkfygY9zoALc/0ZzYr6nZVpQ7XE=;
        b=MNmJ/QjHACCsAAsn+SQPvHn3KzdxJyhDuTmBdHsv3OqRkuwDOaOnamvjEGvQB3ugYa
         7XpgkuLgD8Vpml0kpQ5JNZvZ+BpPM0H6sxPQcvPKBsyq2111SIC3AoTc3xr1UgSlwHM+
         wOGTY62psBXfFaglTETmJOL1I2mGyxGBHbm9y66zPjHsh3dCqVXz6UjK2i4fgHdXz/oG
         NqnJpGDO+6vjb+ePobgCG/wt5+YR+sS9D/eQA9FDVDFospSWVp/X8uElQXv1zhuvs9/O
         ZWxJz1Qy32/oVgANcdJIccCbbjaz3MWeKqyFCSFhuRzIRB3V97/pV2O73JFC0GVse09+
         A+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686184080; x=1688776080;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzYw+LyF924EEMlPqkfygY9zoALc/0ZzYr6nZVpQ7XE=;
        b=ZtJvYvGITsH/8ur4LZ4h57TEKTHSkUKT5ahi6plcAfXo0TCoKBPlRem1NrnxG/a0Rw
         lo7sNmwTazcqLFw7/GXta1RIdXdWoOP8aigguxBBtxoPwc3xb/33kh8R5+4txBgFh1NY
         UMVeYq1QWJDH1EENbengTzjuSWDrhOoOgPnZ/NuzhF8ddMjFfvLH//2lU0LIXtJ74X4T
         20rKkjZZzcr5Hl4RoGrIu3Qwgxztu7mBx3y3M/aPkpgIty7jSJt4qS7n7Y/jfzMoAltY
         BhvxGQlvyN3i93AaPxaovIs/xnH3zs5Sg+gcJf05Wz72KxHW1hDDs4YTQjZYSDvs4sB4
         3YVg==
X-Gm-Message-State: AC+VfDxr9+IrvKbMe3EpglTRv6d+GQPfnSbZyxcevvYrvp+i9AJmFhLo
        6r6pTKH3tAqUP+l/Y0h+SSBZZ/xkzW+GsU+4/pU2H376ch+IlIo=
X-Google-Smtp-Source: ACHHUZ4bkS64rTy2S223VE1/sLC3nZmEwG8VU7f9Mi9RNhPzfDttoXskFDy1bAfcrFFWjVcpKMuawIXlAtDWwhMdjJE=
X-Received: by 2002:a0d:d449:0:b0:569:72c9:993c with SMTP id
 w70-20020a0dd449000000b0056972c9993cmr6652849ywd.52.1686184079939; Wed, 07
 Jun 2023 17:27:59 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Jun 2023 20:27:49 -0400
Message-ID: <CAHC9VhQgzshziG2tvaQMd9jchAVMu39M4Ym9RCComgbXj+WF0Q@mail.gmail.com>
Subject: ANN: LSM and stable kernel changes
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello all,

After a discussion with the stable kernel maintainers, I've learned
that they have a list of subsystems where only commits that are
explicitly marked for the stable kernels are backported to the stable
kernels.  As this has always made more sense to me than the current
approach of simply backporting everything with a 'Fixes:' tag, I've
asked the stable kernel maintainers to add the LSM layer to that list.

I don't view this as a significant change for the LSM since I have
been explicitly marking stable candidate commits as part of the normal
merge process, but it is something to keep in mind.  My hope is that
this should help reduce unnecessary, and risky, backports.

If any other LSM maintainers are interested in taking a similar
approach, I would encourage you to send mail to the stable kernel
maintainers.

-- 
paul-moore.com
