Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18F8C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Dec 2022 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLSRzk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLSRzj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Dec 2022 12:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC21261A
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671472495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9vuU5Z4D8BDai4R1MtulQviiaupoVVoxrdaniDuSmc=;
        b=M+4Bb3bDO+6GJZE/bNlML5UepdhDgb65uIRxp0gizaMN2wVCufeKbX1ibXNudP8nCmtitB
        xEME2SskRAgjNa8rRH3dNawhNSKiLl6is3EkZutH+GJVVJr2YTYF1rdEygq8HvgD1/s/Tr
        ZNB/E6fyTfG/jxYCUtbLDtE1XV9dFOk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-fUbLkVe6PGKstyvO5yHBGw-1; Mon, 19 Dec 2022 12:54:54 -0500
X-MC-Unique: fUbLkVe6PGKstyvO5yHBGw-1
Received: by mail-ed1-f71.google.com with SMTP id j11-20020aa7c40b000000b0046b45e2ff83so7057886edq.12
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 09:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9vuU5Z4D8BDai4R1MtulQviiaupoVVoxrdaniDuSmc=;
        b=4rowLp+F/MY0ykF/lTsXifBj2XRWA9SDXpdccf8fo/4IYapQfF49FyKYIAPhTkn5NO
         iI9UHFZouLbaxj3SqKUnDtB4RiiiRSHNg1LJJENXfckQwRXjRZeDc1Ls/OwF33NoaQKl
         0tfca4n5kRzhUcGw65UQwHxsLlCYH8aF2qzuTtTPKtr04iAszIHraNFsifCUoBWbdqlA
         PC+8TRxJY2r1Y4CtTdRkL8Y/R85E6MFSFfJ2SIbyYmDKEQ1hpLaYV3gIoYx2lvgH7rcp
         9nDEh/mFhvSdAWY2AJDMi8ljh+FXx3wu1czxIt+oQ2PxzN0beDjqQLYzLuPTIm1xwH1K
         ZrkQ==
X-Gm-Message-State: ANoB5pnn74IDZScZ2ncNXDCm5MiM9j+S1PIlSijQA4ZtalfVIohBPvQs
        qhxuCmVXKM6za5AfaDmOL2glxUMn9zA9hey/NlW6e/JArnbByeOUGjafNutQZq0e69xpfqKiP/2
        NcwAcOyCFB47cz97LLY4vAbRymyMq3iI6Bff3
X-Received: by 2002:a17:906:6d0:b0:7c1:33b2:6a02 with SMTP id v16-20020a17090606d000b007c133b26a02mr25072788ejb.30.1671472493086;
        Mon, 19 Dec 2022 09:54:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7QnSsvJl0qbchhgN7/T6EmdIMrXYMaGvctjJdaBF70LE3Z1Z3Ja+l487e1h6E1lUWBbvbMPg==
X-Received: by 2002:a17:906:6d0:b0:7c1:33b2:6a02 with SMTP id v16-20020a17090606d000b007c133b26a02mr25072780ejb.30.1671472492946;
        Mon, 19 Dec 2022 09:54:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709063b0400b007bdc2de90e6sm4604210ejf.42.2022.12.19.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:54:52 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH 0/2] Provide matching audit timestamp in the SELinux AVC trace event
Date:   Mon, 19 Dec 2022 18:54:47 +0100
Message-Id: <20221219175449.1657640-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series allows to match the SELinux AVC trace events to the
corresponding audit events via the audit event timestamp. This
will help with troubleshooting SELinux denials.

Ondrej Mosnacek (2):
  audit: introduce a struct to represent an audit timestamp
  selinux: provide matching audit timestamp in the AVC trace event

 include/linux/audit.h      | 13 +++++++++++++
 include/trace/events/avc.h | 25 +++++++++++++++++--------
 kernel/audit.c             | 23 +++++++++++++++--------
 kernel/audit.h             |  4 ++--
 kernel/auditsc.c           |  9 ++++-----
 security/selinux/avc.c     |  4 +++-
 6 files changed, 54 insertions(+), 24 deletions(-)

-- 
2.38.1

