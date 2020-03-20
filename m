Return-Path: <SRS0=KxFF=5F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22542C4332B
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Mar 2020 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496F20739
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Mar 2020 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCTRKE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:10:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCTRKE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Mar 2020 13:10:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75934B00D;
        Fri, 20 Mar 2020 17:10:02 +0000 (UTC)
Date:   Fri, 20 Mar 2020 10:09:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dhowells@redhat.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] security, keys: Optimize barrier usage for Rmw atomic
 bitops
Message-ID: <20200320170902.ilwugh33co3poqm3@linux-p48b>
References: <20200129180625.24486-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129180625.24486-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ping?

On Wed, 29 Jan 2020, Davidlohr Bueso wrote:

>For both set and clear_bit, we can avoid the unnecessary barriers
>on non LL/SC architectures, such as x86. Instead, use the
>smp_mb__{before,after}_atomic() calls.
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>---
> security/keys/gc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/security/keys/gc.c b/security/keys/gc.c
>index 671dd730ecfc..ce7b4c22e3c4 100644
>--- a/security/keys/gc.c
>+++ b/security/keys/gc.c
>@@ -102,7 +102,7 @@ void key_gc_keytype(struct key_type *ktype)
>
> 	key_gc_dead_keytype = ktype;
> 	set_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
>-	smp_mb();
>+	smp_mb__after_atomic();
> 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
>
> 	kdebug("schedule");
>@@ -308,7 +308,7 @@ static void key_garbage_collector(struct work_struct *work)
>
> 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
> 		kdebug("dead wake");
>-		smp_mb();
>+		smp_mb__before_atomic();
> 		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
> 		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
> 	}
>-- 
>2.16.4
>
