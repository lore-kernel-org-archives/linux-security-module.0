Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C13C7618E
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Apr 2023 23:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjDTXxT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjDTXxR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Apr 2023 19:53:17 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7D5269
        for <linux-security-module@vger.kernel.org>; Thu, 20 Apr 2023 16:53:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f9e41dfa7so2220037b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Apr 2023 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682034791; x=1684626791;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHHZZuHbwLiJ7NY+Ob+HDRHHPDzvLMpAxuYAdsUfBAQ=;
        b=epryOW3J8Xyc4q4qhmbSDG34MQ4prFFY//qNwXIck4/ujK7skA2/p2D5NymsnJ7F+U
         TqH+NG1p+Zv2HLy0d/ZobEyfs/4iIlChuu+Gbk2sckmJUuLQiHqgidja5lg61XnDaYEB
         cfd1bXj2lFv9Y6cA7gytwNdmS1c8/Y9hThGdSeV7Q7nBt63IgzzizwJClKIrW5V23+LR
         dO1V3oocKPX82iw4EeUAIifWIy7AIRcXcWVJ84qKSmnakOLKpqYjzQspdZ2U9X7pC8x+
         Pqio+JENC6noc5QKunnAYttRiExvJu+O3A6h6vsV1XKaBSWq5hpihfJclMnF0+wqz2jD
         7YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682034791; x=1684626791;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHHZZuHbwLiJ7NY+Ob+HDRHHPDzvLMpAxuYAdsUfBAQ=;
        b=drrJ/tluyaT8pl+IKhfA92FGYcZ1UFrmFQoRHwHF3RsBY+tctTwE7SyjcPG60X6z9z
         1fntzGjOr+U/G2ataUwvncKPXXbYoFZ3PmPQy8DD7OBFOHWBYe7DWnT/ZLH+iLC6zp0H
         LKMhNjx2FRs19H5pzEYWBwsgEbc0W7FG+BhsoHqg+ouuZ0OH9hd+n01p+QDofC1betTE
         7TIY3QUR9esjFpwP8ge1geLq7rnVSycDiKEHl4Lfk2471ovxZKu16ylm2aSF1lIC/TS3
         plYentZj4C7Ri/sFtqOiK03carFfMVjoSHr2JGhRWLhFCsXq0tFtm/0BbwoQfQlUON4e
         yuAQ==
X-Gm-Message-State: AAQBX9eMEStNRWX0TYcD3aFb2OdpaKjh6w2bmzR1b461IdYMQnogNfEN
        9dgHml0HgDfFhSgzwOMaNMma9DON53XzhJ3ayuXI
X-Google-Smtp-Source: AKy350ZhNdgyZvx7qtxLr4jn/78Wdk0Sn/X/4jXl8wsfCs5XgsZ2t1s+arzp6nhURgUpvNBAtAecCheHZJtx2qXZ8hs=
X-Received: by 2002:a81:678a:0:b0:54f:9cd0:990 with SMTP id
 b132-20020a81678a000000b0054f9cd00990mr483394ywc.18.1682034791479; Thu, 20
 Apr 2023 16:53:11 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Apr 2023 19:53:00 -0400
Message-ID: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Due to some personal logistics challenges over the next few days I'm
sending the LSM pull request for Linux v6.4 a bit early.  Here is a
quick summary of the changes:

* Move the LSM hook comment blocks into security/security.c
For many years the LSM hook comment blocks were located in a very odd
place, include/linux/lsm_hooks.h, where they lived on their own,
disconnected from both the function prototypes and definitions.  In
keeping with current kernel conventions, this PR moves all of these
comment blocks to the top of the function definitions, transforming
them into the kdoc format in the process.  This should make it much
easier to maintain these comments, which are the main source of LSM
hook documentation.  For the most part the comment contents were left
as-is, although some glaring errors were corrected.  Expect additional
edits in the future as we slowly update and correct the comment
blocks.  This is the bulk of the PR's diffstat.

* Introduce LSM_ORDER_LAST
Similar to how LSM_ORDER_FIRST is used to specify LSMs which should be
ordered before "normal" LSMs, the LSM_ORDER_LAST is used to specify
LSMs which should be ordered after "normal" LSMs.  This is one of the
prerequisites for transitioning IMA/EVM to a proper LSM.

* Remove the security_old_inode_init_security() hook
The security_old_inode_init_security() LSM hook only allows for a
single xattr which is problematic both for LSM stacking and the
IMA/EVM-as-a-LSM effort.  This PR finishes the conversion over to the
security_inode_init_security() hook and removes the single-xattr LSM
hook.

* Fix a reiserfs problem with security xattrs
During the security_old_inode_init_security() removal work it became
clear that reiserfs wasn't handling security xattrs properly so we
fixed it.

Please merge, thanks.

--
paul-moore.com
