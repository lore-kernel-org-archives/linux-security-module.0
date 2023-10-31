Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F6C4167B
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Oct 2023 12:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJaMdG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Oct 2023 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbjJaMdC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Oct 2023 08:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9531797
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3DnaCdie6hqZryBnxfeM3IpTCv2hUsxvT+f5bpebJE4=;
        b=bDIobEsHgRbfc5K/EgWPyGTumnYKLNVz+h3UXAvhNqJIpxMi5iz85puYidD3bExWhhEMLG
        7eHsK0bxVeRLuzZ13Mlw2+rs1vkpEEg34qKV5MIhFPKtKn97efRg41zhxpsaEkOuEgrQAH
        F1/cg9xSCQlQ27HXIhJZHaXgf06qIs0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-oO5U-0joMbG3eNec7sUd8w-1; Tue, 31 Oct 2023 08:32:10 -0400
X-MC-Unique: oO5U-0joMbG3eNec7sUd8w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77892f2ee51so697477885a.1
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755530; x=1699360330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DnaCdie6hqZryBnxfeM3IpTCv2hUsxvT+f5bpebJE4=;
        b=qnP2cXJaq26WISU4RQtUlPvhzKlmiGHsmjGOu7nO7ELDwuItgAz7v2eXls++bd9gDA
         zOZWeEDTGpnURRZjXhKN75g+ZIktqGAiq0qjEJDf6p5I12S5QUQpLgiek8fE1/MzagW9
         Jnk9nTknOT6/RKa9rg/kDMGT9PfN8OfTvf9j4LFNDT7aNzbvtz0yZlsuxcBtwDJ1cIsT
         h6skzQho6ANGvQ533qJAeeVNhln6ST/yXkT/DJkQlTRlm6gisXE0bnNuXiHlk/tmCYMR
         rUNnJqHBWbDw38WUyYdZSj9OfWPvZHC2Gk6J9xd7GhfCxwTG+CytQBrgHwfFa8eXWGgr
         qM8w==
X-Gm-Message-State: AOJu0YxgJxq3gyOSXMU5fXuBQRAmP0Sk7qA0SM3wrhnRploGYvAJjkvJ
        +mQ5Pfiudp0RtiExGAVsil8ueFW303bR9vMSyh210sgz8Fo+MCm2T1Ppnxi9C2ljQp5vIgeKTPL
        4F3SsuV3tk6RXooirdakrD5QaM2GO9bhxbkm7
X-Received: by 2002:a05:620a:371a:b0:774:11c4:45cb with SMTP id de26-20020a05620a371a00b0077411c445cbmr15316847qkb.53.1698755530348;
        Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRF2hQntJG+GwSak9Gg0Fe+r97U8evGxvH+rsbr7bRKRAzBo2stdiR75AFPLvChPFBieDyLw==
X-Received: by 2002:a05:620a:371a:b0:774:11c4:45cb with SMTP id de26-20020a05620a371a00b0077411c445cbmr15316823qkb.53.1698755530070;
        Tue, 31 Oct 2023 05:32:10 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:09 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] lsm: fix default return values for some hooks
Date:   Tue, 31 Oct 2023 13:32:05 +0100
Message-ID: <20231031123207.758655-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Some of the default return values listed in <linux/lsm_hook_defs.h>
don't match the actual no-op value and can be trivially fixed.

Ondrej Mosnacek (2):
  lsm: fix default return value for vm_enough_memory
  lsm: fix default return value for inode_getsecctx

 include/linux/lsm_hook_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0

