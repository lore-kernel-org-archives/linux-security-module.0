Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A25C4360F
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B69F217F5
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6+RrZ7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfB0U1D (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:27:03 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:56595 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0U1D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 15:27:03 -0500
Received: by mail-oi1-f201.google.com with SMTP id c186so7831622oih.23
        for <linux-security-module@vger.kernel.org>; Wed, 27 Feb 2019 12:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3Kfjwj6d2eSKpoWcFfFc9NzavlqFkeO15Wc7Bn8QSiU=;
        b=C6+RrZ7M7QLFsjoR7kJT38en+nrsa0tx2Xm/bcJehIDTbvwyiEjiYQyGytXmXax8nr
         zxvZbVuTeTV4INXw5yMG1qzPn6hCvNye1KOnE4/rEuAj82Y6cL42KVRrKzHPLf6bpQ6m
         4aafjmfQoNIwwElaxIQG5JwHutP6h5Ti9zUXsPvNXfcEBzcJFIXQz2WQdCvDumqp1+jp
         ssIuXsCiS/vxNoOqHe0dGjq5xtX+Wm5AfIzgdtTaHWq8IWcxXiWCjqTmEF9mSuAhg6L/
         4ezKVv5wUv4Ilp5XjRzBycoG46ZpQN2ASwkbb1vdYGTFhJqJcDyS0xZ75FyCuea7e5Ey
         oc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3Kfjwj6d2eSKpoWcFfFc9NzavlqFkeO15Wc7Bn8QSiU=;
        b=PADDPXGxCNSL1i5zwtBQBGLuBdWvNLzwzRLcKbH9WugFZVurwkLZQ1cSFlX3FvBGM1
         z18RNQU0YHrOFcr1n/D6XPDOPDBe8sRmGlc2UVsDUbT7ZQ04tcRF5pwx6PcAUXdhKHwt
         tAl+jgBdKeU+AT9BtMEjQiojbHkLLzzzTqOBfpmkA5u5L4Cg0aU427RrMfkbsBFmN3vg
         JnzynNQDMEMgo/Kg1lyO3HiaCB+4SV5XSKWBdDX1Ig2WPJZzeOZhNR0cjGj0XeR7Z/kO
         mY38Ts5ThDsX0MmBAqbFlrHHnQ0P7PKFrKZ8XBO2thFuXrwySVuCr/bmWhS4GIL/gN0F
         P0Sg==
X-Gm-Message-State: AHQUAuYPRu8gkLu9L7M2R5Tw+GOLCXoWF+Z8vfQb9VPJir4ANDKFICt4
        lFP09VQqzO1P0NUZe8nK2R6Jmhl+98SBZUhWPsBgIA==
X-Google-Smtp-Source: AHgI3IZgugPM+DBmTteF2hpZSOfGcogUwDvjhjvoxla1uC7DRKd9EpiP36U/7AiDsjBrKLfTHQIPYTnak09NE4IhKZUWjA==
X-Received: by 2002:a9d:5f17:: with SMTP id f23mr2962158oti.31.1551299222955;
 Wed, 27 Feb 2019 12:27:02 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:26:54 -0800
Message-Id: <20190227202658.197113-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: Add support for TCG2 log format on UEFI systems
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Identical to V4, but based on tpmdd-next


