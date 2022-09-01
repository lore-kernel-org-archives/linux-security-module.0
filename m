Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B89ECAAD1
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Sep 2022 15:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiIAP07 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIAP0l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE56DACF
        for <linux-security-module@vger.kernel.org>; Thu,  1 Sep 2022 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=iDCX8NlQJ/C4WgDya+IrsLlDOtQvYnLRfeHFvxRsX/Id1PYRiYo47I7iqBWxgxaTiTBd6+
        TZHacpcnbAAfA+tzNo/m12zvppQPmxAQB9cK/YQLMAKeINdlxvTzsO/ZXqXULcZmXrY6KL
        OlFfkJxLF+cfPPslllIBEV5L6vhbq40=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-CyT2GKtkP8ukkj4ftiKh7A-1; Thu, 01 Sep 2022 11:26:35 -0400
X-MC-Unique: CyT2GKtkP8ukkj4ftiKh7A-1
Received: by mail-ed1-f72.google.com with SMTP id m18-20020a056402511200b0044862412596so8648524edd.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=dUGjhKh6cQEXc4tmWswFyk/BVHTcnyB2AoM8dYVKkcONzfuvn7eAOGbP+TAOxBJfeF
         1XZHpSAxGxV1ZAGTx0yE07GMa1wuaJMknPEm9EOvJwPV+HQmuxsQs+L8wzxqnt585WQd
         1X2viTxIGh7pyUuN7/QKhwWJaLWS/jhx89euvXRW91Cc6BT9VGeCIMSgCUmiNxb8DOsZ
         QTmEOqancP7SatTgRGkg+cmKeSqHh6tSex2wKTvvJCa1CBJSyz7JldbAMujSxQHbzVxj
         QXnHvcP+1EUMw3OrCmJhxseN6/ssgbReRobqsQu4p3xq/Ypqr0muxGk0d/GSKTE8nq40
         BSmg==
X-Gm-Message-State: ACgBeo3w6A1ThK/qiL8FrJ80qzHV5vs1BDldkCPSL6CPG8FlqHecd5z8
        xRXECuE9L7I1pe0+fktwdRXo00170X91062Dz922YP9FM4dmP43vV4HKTIrgGv6b4JnhpWyuQiW
        kCCpdFXRyjV0LtyMhQjbXYOFGI7D/xfjfMJLW
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273242ejk.463.1662045994399;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QRSL2W4ltgrQ+2jhvMhXxgK8EO5Y0yo9Y0cYkz7dkRoZMMOmRYstqqGCjd+xE8U5lttpmRQ==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273233ejk.463.1662045994222;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Date:   Thu,  1 Sep 2022 17:26:30 +0200
Message-Id: <20220901152632.970018-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The goal of these patches is to avoid calling capable() unconditionally
in simple_xattr_list(), which causes issues under SELinux (see
explanation in the second patch).

The first patch tries to make this change safer by converting
simple_xattrs to use the RCU mechanism, so that capable() is not called
while the xattrs->lock is held. I didn't find evidence that this is an
issue in the current code, but it can't hurt to make that change
either way (and it was quite straightforward).

Ondrej Mosnacek (2):
  fs: convert simple_xattrs to RCU list
  fs: don't call capable() prematurely in simple_xattr_list()

 fs/xattr.c            | 39 +++++++++++++++++++++++----------------
 include/linux/xattr.h |  1 +
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.37.2

