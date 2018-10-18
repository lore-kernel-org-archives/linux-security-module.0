Return-Path: <SRS0=lG96=M6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF8C67863
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Oct 2018 23:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E81204FD
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Oct 2018 23:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cS3YpZ7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E81204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeJSHI6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:08:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34376 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeJSHI6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Oct 2018 03:08:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so14884707pgs.1
        for <linux-security-module@vger.kernel.org>; Thu, 18 Oct 2018 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qK/gG52okx4Lt3QKRjuCSNmd4fb1In9g2aR2Gz3YbLU=;
        b=cS3YpZ7qWVPnduE/b9nNqDBtIZqfdwbtyRZNepN0dK16Y+uUSKz1l2vJASTuJwgls1
         gcA+CGqEGop5J2kvCvRxIWCHiU9HJ5THodXUK/Uvdyo0KxF/s+G74qjzY27K5AVFtkVT
         /iW8AY651kRyqj+xf8HntGF99KUq18YiVOaVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qK/gG52okx4Lt3QKRjuCSNmd4fb1In9g2aR2Gz3YbLU=;
        b=TEKQ6AcMTI59haLkKhMnuHcAGfxsW9DZSVvaBWg5o+pEtwPSy4kIpT+kE1HCp1+Zq2
         S2qxZN63934gmKWcGpg3l5rkypVZmZi0tA7lhqODJTZEn+W1v6fVWxVKij3KJvGW114z
         XquTlZ0XfK7DC54FF8DvEpgSqwFQVxNnJcgd9A46lr5RIN6Eq1Cr3oeDndhE7Uhcm/9w
         0fdhRqNJe+NhvzvEi1zTBnrl0IwNHCnNH4Blqpzy/o5bnalzdAQ2uMw5MgzB5ZBs9VKA
         79E6VdyQ8Ov95rynnhqgli9AY8RUaJXI49mP1xhyejNkqRnRlvV1iRFlhnpAJfOMD5VF
         wEfw==
X-Gm-Message-State: ABuFfogtmT3KEzMslcJBGb8P+YVpb7lRw09hoJ4F+YWlzL5AvHJetoNs
        k/2yhIasgmeM3ikJNG4FxHPbjw==
X-Google-Smtp-Source: ACcGV61s05Z8DcrCguoiLvPPgkUxPhr2os+z59TUDCEkLOh2qFE1HpyM7TytgBtxk7xrefRTA6CTIg==
X-Received: by 2002:a62:824a:: with SMTP id w71-v6mr32053324pfd.68.1539903944652;
        Thu, 18 Oct 2018 16:05:44 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r1-v6sm34923513pff.145.2018.10.18.16.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 16:05:43 -0700 (PDT)
Date:   Thu, 18 Oct 2018 16:05:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org
Subject: [GIT PULL] loadpin updates for security-next
Message-ID: <20181018230542.GA48284@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

Please pull these loadpin changes for security-next. This is a small
reporting improvement and the param change needed for the ordering
series (but since the loadpin change is desired and separable, I'm
putting it here).

Thanks!

-Kees

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/loadpin-security-next

for you to fetch changes up to 13523bef1e2154b6d02836cd0f6c0ffc89b2eae6:

  LoadPin: Rename boot param "enabled" to "enforce" (2018-10-18 15:29:44 -0700)

----------------------------------------------------------------
LoadPin: report improvement and parameter renaming

- Report human-readable device name during init
- Change boot parameter and Kconfig "enabled" to "enforce"

----------------------------------------------------------------
Kees Cook (2):
      LoadPin: Report friendly block device name
      LoadPin: Rename boot param "enabled" to "enforce"

 security/loadpin/Kconfig   |  4 ++--
 security/loadpin/loadpin.c | 26 +++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
Kees Cook
Pixel Security
