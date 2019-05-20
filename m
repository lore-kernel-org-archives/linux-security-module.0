Return-Path: <SRS0=478F=TU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B4C04AAF
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5702171F
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 20:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwKcFS84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfETUzI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 May 2019 16:55:08 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:44928 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfETUzH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 May 2019 16:55:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id t51so15300014qtb.11
        for <linux-security-module@vger.kernel.org>; Mon, 20 May 2019 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=KwKcFS84Od+0uDcbkZwTpIrT43f2kU8zmORrILLiHk2F8YkNKiv1DApHnhAMtYlYNA
         TTKtXmA8TJ8/ipv7ecH3TyAPVRf9bZ8GXZEFmFgwDXPD4Hjtc9OoZlG6aBmwZtYTn8Oc
         Nvt9VJVKM4ko0egxxq7cUr2yFh5bt2A6FPsfeESlkTgj+tTo5HipWQkdt0PV7yGNpC2p
         qwWO/zif0wXn7M/9LQBi1kh21TF0FRSHZu9qfX+5MMJsj7woSz3xBh9gb5WkU4/0KX4c
         dnI+ZE7GgTCEi7VKzXkA1bmYAkK0Nv9eJ0xJyAJqd/DQAikMJoy/AIkKcuCOHk84b2v+
         el5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=akNQHWG72t27DgH2Q9B0MIW+BGb8Ajg50xQWIYijzbtAzCRmTtGVjvJDXBGnstynBq
         IvzuqPSvGHSMzzKH8+GxUUZqcPOqVRvDYSsf3xUafZD0uQ9yy8C9p/pbY0aRHm4U89Nv
         dxD+iyvlFXd9MaOYpWayKbVgwtOGBitVru/Y/YpqpjlsSsm8O3KS0bH87f5LnBf8WiM+
         f5Cdqw9OuJHmFLhk3oOBIixxDvGNRM3FMeUkNg3U3TLeUyy006kAN+zryeqxNGqH8xPY
         ijXd4taGYs1lDlUs/VApJIsbov8HVvioMRK8XW4jqPwU9r4qDALryXrpVFTZRbUPo6LK
         EUeQ==
X-Gm-Message-State: APjAAAXPMF9l84hw1nIXYC2CGuDBR5quhAIKdRnElhEeVOcH5hZ0auFw
        WHql2/QS3koYkwQlR8TAVRsmJkImBmgHrAh8FZ/c6w==
X-Google-Smtp-Source: APXvYqxcgPZwWQB2M99XR5b353YmJ/Ei17uYUIv35ZBhj13nsYbaZL7VC+EcLkbxPlvT59VqEEmZiqG52LG+K02tnRds4g==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr32298826qkl.243.1558385706056;
 Mon, 20 May 2019 13:55:06 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:57 -0700
Message-Id: <20190520205501.177637-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 0/4] Add support for crypto agile logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Identical to previous version except without the KSAN workaround - Ard
has a better solution for that.


