Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C8C04A6A
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 17:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjHCROQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHCROM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 13:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0886E3C0A
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691082802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/DKi39ipC+Viuoauq1EnIfUNo+yDKrdwtx2BmcqF2jk=;
        b=hol3HfTy4gcOOEX2jrXtS1Rxo/zhf6H2YHR9qMABTD2CnnvizYXXD13D8DPhJg802FjC0A
        tlEd/KA29cxoGNSoTlr96sQuY8z8NmfI+MNV0CTzbIonO5poOCpbfYvEO0zDq+TtJNmx8y
        x5wQ8Nxxj3Hz3nKlg5wWP51eZpA/73I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-ZBnb5GPuNN22HR-Gy5Ug9A-1; Thu, 03 Aug 2023 13:13:18 -0400
X-MC-Unique: ZBnb5GPuNN22HR-Gy5Ug9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 616AA29DD992;
        Thu,  3 Aug 2023 17:13:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6748200A7CA;
        Thu,  3 Aug 2023 17:13:16 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH RFC 0/3] security: allow a LSM to specify NO-OP return code
Date:   Thu,  3 Aug 2023 19:12:39 +0200
Message-ID: <cover.1691082677.git.pabeni@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is another attempt to solve the current problem with eBPF LSM,
already discussed at least in [1].

The basic idea is to introduce the minimum amount of changes to let
the core consider a no-op any LSM hooks returning the
LSM_RET_DEFAULT [2].

AFAICS that is already the case for most int hooks with LSM_RET_DEFAULT
equal to 0 due to the current call_int_hook implementation. Even most
int hook with non zero LSM_RET_DEFAULT are not problematic. Specifically
the hooks [3]:

fs_context_parse_param
dentry_init_security
inode_getsecurity
inode_setsecurity
inode_copy_up_xattr
task_prctl
security_secid_to_secctx 

already have special handling for to basically ignore default return
value from the LSMs, while:

security_getprocattr
security_setprocattr

only operate on the specified LSM.

The only hooks that need some love are:

* hooks that have a 0 LSM_RET_DEFAULT, but with no LSM loaded returns a
  non zero value to the security_<hook> caller:
sb_set_mnt_opts
inode_init_security
inode_getsecctx
socket_getpeersec_stream
socket_getpeersec_dgram

* hooks that have a 0 LSM_RET_DEFAULT, but internally security_<hook>
  uses a non zero return value as a selector to perform a default
  action:
inode_setxattr
inode_removexattr

* hooks the somehow have to reconciliate multiple, non-zero, LSM return
  values to take a single decision:
vm_enough_memory
xfrm_state_pol_flow_match

This series introduces a new variant of the call_int_hook macro and
changes the LSM_RET_DEFAULT for the mentioned hooks, to achieve the
goal [2].

The patches have been split according to the above grouping with the
hope to simplify the reviews, but I guess could be squashed in a single
one.

A simple follow-up would be extend the new hook usage to the hooks [3]
to reduce the code duplication.

Sharing as an early RFC (with almost no testing) to try to understand if
this path is a no go or instead is somewhat viable.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.2026362-1-kpsingh@kernel.org/

Paolo Abeni (3):
  security: introduce and use call_int_hook_ignore_default()
  security: two more call_int_hook_ignore_default use-cases
  security: more call_int_hook_ignore_default use-cases

 include/linux/lsm_hook_defs.h | 16 +++----
 security/security.c           | 83 ++++++++++++++++++-----------------
 2 files changed, 51 insertions(+), 48 deletions(-)

-- 
2.41.0

