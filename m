Return-Path: <SRS0=vdt1=TW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB7C282DD
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 11:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E82F217F9
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 11:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a41e1Uh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfEVLtp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 May 2019 07:49:45 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:41049 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVLtp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 May 2019 07:49:45 -0400
Received: by mail-lj1-f172.google.com with SMTP id q16so1775304ljj.8;
        Wed, 22 May 2019 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uIdoOztshDUuLaoQRg4eCsnj/AUikqazqIDLkqu9Ns8=;
        b=a41e1Uh4X1oCCXgl5Zhgbduh32DxvQ635KgxhemHXTl/qDN7CByVbGGLh1jeKHGT93
         Kt1qy+OsNzR2KnYZQCypiruC8t5wXsusBgVQupvxA0d6boLzlyFWz/nXALDdww8Vl2D8
         fpaZ0OX9ZBTRrcEn3d4r/MBzzd7H56OE8AIRMDQodGIcn2nlMkL9DT3w70h28BqZNacy
         XUjAbIuvSiAONJMkHCrOrMcQCKi3JOnEX/dhAId0JacmLYpDYhy7kb0h+ltI7u7PPHI4
         WKEcwKDfBS2GFc05M93jXJW772VyuZDnTFfl/STANqogf3qT3panfeG9skzQlBzO8Xzz
         F8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uIdoOztshDUuLaoQRg4eCsnj/AUikqazqIDLkqu9Ns8=;
        b=An63q+IgynewoGyMecBaSmrUO36B/gfE+z9PijsaROFY7hRU8nLjDl3pACWyTgo/JH
         i24Jn8cCFyOVD5R7/rclpbQVLsVWUtgtvtPCU30KIAyvdeleg0T3SwjAOx/nxqWCovEZ
         fCBEBVMuyw9hETkDCtjOU7oiKnnS57VoigkfpdBDcL6pDKWI4mutPHhdO0IeOBsT8q51
         PPlPDc7RRzSqPHQxapWSBIh2K0piO20PIKWgJ0ewL01iuCWly/2v3QK7SHF8xLIJ8CWv
         F1J3lvBrBf3LWhjYJ3/xa81zvIttS0EhsmgvNCvw0Cgs2X2y/x1n2JPtvCg1bpXm4Izz
         uNvQ==
X-Gm-Message-State: APjAAAX4S3WMY+qx8TDyl7g4nlNxS6h7le/Nx8cGGe7h9d2oKYud8xZ6
        xKj6s2SLGQc+jHcWvD0uRuE9n5FDzz898cnou5A=
X-Google-Smtp-Source: APXvYqx49p9DUPuxuNRoVVDXn+38Vd1dC25MyIcb1Cv5aImwiXVuc1BSNhkBOAIJIGCXjE59EYNXy/l8Qu0VL400/Lo=
X-Received: by 2002:a2e:8644:: with SMTP id i4mr2812499ljj.0.1558525783351;
 Wed, 22 May 2019 04:49:43 -0700 (PDT)
MIME-Version: 1.0
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 22 May 2019 14:49:32 +0300
Message-ID: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
Subject: sleep in selinux_audit_rule_init
To:     Mimi Zohar <zohar@linux.ibm.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I managed to hit a following BUG, looks like ima can call
selinux_audit_rule_init that can sleep in rcu critical section in
ima_match_policy():

__might_sleep
kmem_cache_alloc_trace
selinux_audit_rule_init <<< kzalloc (.. GFP_KERNEL)
security_audit_rule_init
ima_match_policy <<< list_for_each_entry_rcu
ima_get_action
process_measurement
ima_file_check
path_openat
do_filp_open
..

I guess this is the ima_match_rules() calling ima_lsm_update_rules()
when it concludes that the selinux policy may have been reloaded.

The easy way for me to fix my own butt in this regard is to change the
selinux allocation not to wait, but Paul would you be OK with such
change? The alternative looks like a pretty big change in the ima?


--
Janne
