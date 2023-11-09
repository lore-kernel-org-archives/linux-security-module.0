Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC0AC4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Nov 2023 23:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjKIX7u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Nov 2023 18:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIX7t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Nov 2023 18:59:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F91420B
        for <linux-security-module@vger.kernel.org>; Thu,  9 Nov 2023 15:59:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cb76f3cf0so9260941cf.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Nov 2023 15:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699574386; x=1700179186; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Y/5+f5ZseD7XIsxNKIqTBp4EbKQG/VB7Ps5YKHI8M=;
        b=D1tThWPmQy42PUSHS4R2PRg1sEi8QroS/GP0j8sNDl3E9RIaBmeii6XGkGXi209Te3
         ftk0s9Y1xdRmlPPvBCnDnzdFb8h30yxiDErUtfLM+6B+dhkfVuh+kIf1CpPzfnE8+4Iq
         HcXGZ0XjkcE64ixsCtPYG0CBeIZ6k1bdk14Ezk7cEk1pl+9HEzFfwSOaHb2NL4GQudA9
         X/xejMtXC3NEIxPswI8Ne1BGP61E7JVds+94qVROt4srscMk3Qmjn3pww4d9tyPuyQKj
         6rCWoo/VgGdI8KWDTNJCPRtZ/FVJWsRk96Xbgz6wKybZ4Q2ylnkp3Hmo4qlOGPOjnJPg
         qSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574386; x=1700179186;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Y/5+f5ZseD7XIsxNKIqTBp4EbKQG/VB7Ps5YKHI8M=;
        b=vRqXqeocS40OBwOV+OyatFqclf3n9YCUNuRZDfHMlp3uUrT5cw3ORjL2oS/VWi4FKQ
         EA5lsJ+43Y6bDLyl7pImEV3DzSxjI3Ol0hk09GZBqkmEvyTRu9g0M3N/KJyw0cnXEoBv
         NHs8+3M2MkBArXeS/Hx3Ba4OzKj6jlXxz6Gn4fapHjhkKa+5ZSZx9KG8YF/FNMOwRNN+
         flb3AV+bfpXoZWNwZ5+va5LwpLbeTXeQ8X7hVr7f2tE9oUe7sIY5g4C1KhgYLrlroojk
         S/o3dkYOf1Cx/QbAnNWzIB8ee82+V2eoL2MQwaclk4BoKIqgBQt06TVuw/sHVstknMHE
         RLcQ==
X-Gm-Message-State: AOJu0YwCCy+lpgYQttwc9HDxqnHbQ8sxxcTZhvVQPGcGmNz3UfO9ZJtH
        kRV2A1xMHM4FMkbQ1Sv4aD/TeRf6FrSmBVR5cA==
X-Google-Smtp-Source: AGHT+IGBIxGfqmKYpnr3KMhhwjcJSEasLX3u3P2NoivgpvURxnnL44y08ZqllLXR45ZvgNTXz/Iumg==
X-Received: by 2002:ac8:5fd4:0:b0:421:ad5c:d742 with SMTP id k20-20020ac85fd4000000b00421ad5cd742mr956220qta.3.1699574386501;
        Thu, 09 Nov 2023 15:59:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id y17-20020ac87091000000b00419c40a0d70sm2388783qto.54.2023.11.09.15.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:59:46 -0800 (PST)
Date:   Thu, 09 Nov 2023 18:59:45 -0500
Message-ID: <9672faa215f6b6f1c17ccc622a633611.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20231109
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Not much to say here beyond the commit descriptions, but we've got two
small patches to correct the default return value of two LSM hooks:
security_vm_enough_memory_mm() and security_inode_getsecctx().

Thanks,
-Paul

--
The following changes since commit e508560672890b2873c89258b88fade1356392ce:

  lsm: fix a spelling mistake (2023-10-04 16:19:29 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20231109

for you to fetch changes up to b36995b8609a5a8fe5cf259a1ee768fcaed919f8:

  lsm: fix default return value for inode_getsecctx
    (2023-11-08 15:39:42 -0500)

----------------------------------------------------------------
lsm/stable-6.7 PR 20231109

----------------------------------------------------------------
Ondrej Mosnacek (2):
      lsm: fix default return value for vm_enough_memory
      lsm: fix default return value for inode_getsecctx

 include/linux/lsm_hook_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
paul-moore.com
