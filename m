Return-Path: <SRS0=OCSC=24=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB7C3F68F
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25102081E
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjXXYG32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgAGNcC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:32:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727948AbgAGNcB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jan 2020 08:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578403920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WyfllKJCbYqu2Zq46JXHMpPkRIZEMb8ORcePwezkjkc=;
        b=fjXXYG32Gs2+E5JYluyb7snuYyCHp1jNT3fhIGgjNH9htii+IVZNvpoQE2NaIJUNW3bA8D
        /glaqv1WhLSjjCCDwfh2GfVf+OJSelpeN+ZM/8SnmqysaZan2kSa2Zn4DMU+g+RUqS6gyY
        D5O9uW0gJGLq2BftGmmU5ubCyNmMORw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-0Y2wXPsjObeKDApNdxXJWg-1; Tue, 07 Jan 2020 08:31:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id t4so4105605wmf.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jan 2020 05:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fp/293HNLFU91xHrQJ1y/97VQrAq2eqT3bmbSklivP8=;
        b=ZkRuZR7VqET6UREN1lgm7ga1XXkYye6saBT0aznUi/ATV5g6PJYv0BMrN8wVOSTaTE
         4gx4UKWnIQadlMxo60obU29V7z9JbdwR2gG6tybCJam9gyRcT9ZpjT5Ol60N7AdJ7DvT
         gatDfnJqZT0K1h+X1cvlI/os0YJfFvSQOU+QItO7wHd+FeO/F0olbgUbFk9oVLja33Hq
         /E1AolLaX1muFG81hPkbeMrQgWehMqMn1yq97ZB/uwjb+j+4Gym4mLSdM3NpQFtYb/Gh
         oa3M/+0ldeAXN2oySmm8WmRhOKmEkmT144e8q8iNC71e9WqDmyVo6XkuPU243qIrqcqT
         IdKA==
X-Gm-Message-State: APjAAAUkMDnRogGD9OU4v7rDH0DX9G8iGdTNSYFCo/bX0OInxnRhGrL2
        sY7TmJDghibyJI9UVCo8fK4/tSDwwTdkc0616wSHml3f7/CHi3mbUBy6xhRSkVeb5r4ejl5wJbS
        0I32AAJi/xg4gf9jnEPC+XbqP8gJKkAOgxuW6
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr38777693wmi.69.1578403917534;
        Tue, 07 Jan 2020 05:31:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWr8PxD9y++s6Ts14ifZfLAxpvtO6tz7TxGJsMnX4PCfK/TO+BcTKsa0YwnYejkCP9htBAZw==
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr38777658wmi.69.1578403917289;
        Tue, 07 Jan 2020 05:31:57 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm29097127wme.9.2020.01.07.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:31:56 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 0/2] LSM: Drop security_delete_hooks()
Date:   Tue,  7 Jan 2020 14:31:52 +0100
Message-Id: <20200107133154.588958-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-MC-Unique: 0Y2wXPsjObeKDApNdxXJWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a third iteration of the attempt to fix a race condition in
SELinux runtime disable. [1] [2]

This version takes the approach of removing the security_delete_hooks()
function (and CONFIG_SECURITY_WRITABLE_HOOKS) and just returning from
the hooks early when SELinux has been disabled on runtime. Note that the
runtime disable functionality is being deprecated and this is only a
temporary solution.

The first patch is an SMP semantics cleanup in SELinux; the second one
builds on top of it and does the actual conversion.

Tested on Fedora Rawhide by running selinux-testsuite with SELinux
enabled + boot tested with SELINUX=3Ddisabled. Also compile-tested with
all LSMs enabled in config.

[1] https://lore.kernel.org/selinux/20191211140833.939845-1-omosnace@redhat=
.com/T/
[2] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@redhat=
.com/T/

Ondrej Mosnacek (2):
  selinux: treat atomic flags more carefully
  security,selinux: get rid of security_delete_hooks()

 include/linux/lsm_hooks.h           |  31 --
 security/Kconfig                    |   5 -
 security/apparmor/lsm.c             |   6 +-
 security/commoncap.c                |   2 +-
 security/loadpin/loadpin.c          |   2 +-
 security/lockdown/lockdown.c        |   2 +-
 security/security.c                 |   5 +-
 security/selinux/Kconfig            |   6 -
 security/selinux/hooks.c            | 763 ++++++++++++++++++++++++----
 security/selinux/include/security.h |  33 +-
 security/selinux/ss/services.c      |  38 +-
 security/smack/smack_lsm.c          |   4 +-
 security/tomoyo/tomoyo.c            |   6 +-
 security/yama/yama_lsm.c            |   2 +-
 14 files changed, 715 insertions(+), 190 deletions(-)

--=20
2.24.1

