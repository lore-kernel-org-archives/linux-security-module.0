Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E71BEB64D9
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jul 2023 02:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGCCOL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 2 Jul 2023 22:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCCOK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 2 Jul 2023 22:14:10 -0400
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 19:14:08 PDT
Received: from mfwd06.mailplug.co.kr (mfwd06.mailplug.co.kr [14.49.36.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EB61B9
        for <linux-security-module@vger.kernel.org>; Sun,  2 Jul 2023 19:14:08 -0700 (PDT)
Received: (qmail 29571 invoked from network); 3 Jul 2023 11:06:45 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        3 Jul 2023 11:06:01 +0900
Received: (qmail 3493686 invoked from network); 3 Jul 2023 11:06:01 +0900
Received: from unknown (HELO sslauth12) (lsahn@wewakecorp.com@211.253.39.85)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        3 Jul 2023 11:06:01 +0900
Message-ID: <c0ee001b-caf4-22ec-d1c5-d3d8d790760c@wewakecorp.com>
Date:   Mon, 3 Jul 2023 11:06:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     casey@schaufler-ca.com
Cc:     john.johansen@canonical.com, linux-security-module@vger.kernel.org
From:   Leesoo Ahn <lsahn@wewakecorp.com>
Subject: [LSM Stacking] new files fail to inherit SELinux security context of
 the current directory
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Test env
- Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
- boot param: lsm=apparmor,selinux
- AppArmor (Host) + SELinux (Container Fedora 36)

Hello! I'm currently working on a project related to LSM Stacking, and a 
few days ago, I encountered a significant issue of SELinux in the 
container environment.

When creating new files in the container using 'mkdir' and 'touch', the 
new files fail to inherit the security context of the current directory. 
This problem occurs by the following reason that 
'security_inode_init_security' hook is called, which sequentially calls 
'apparmor_inode_init_security' and 'selinux_inode_init_security' in 
order. 'apparmor_inode_init_security' always returns -EOPNOTSUPP, hence 
'selinux_inode_init_security' is never called.

Does 'return 0' in 'apparmor_inode_init_security' to call stacking hooks 
sequentially have no side-effects? if so, the solution would be easy though.

Best regards,
Leesoo
