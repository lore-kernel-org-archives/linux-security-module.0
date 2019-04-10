Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3529DC10F14
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472C20830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTEh16bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfDJNSa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:18:30 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53561 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbfDJNSa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 09:18:30 -0400
Received: by mail-qt1-f202.google.com with SMTP id 18so2156584qtw.20
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qpyh2PaNh/u0oi9ThfEHkFImlddlN8fnWeaDdSG7BTU=;
        b=tTEh16bK+/alZUiIcYZFseVJR45vK/paTzk+IFa7C+s7m86gzClwbMVALTH2LR7o0+
         iSA2p+o7pjQmeoQHq+tT9MyzjOWl5w9HnGh66tjT87ucsUFZrtD6OUeuykEloorYwxk4
         9uvA4kZn65GgkUlh03F3YFnpVNYbsqk2a8JVGxg02LgSgi25ywNqiFSlF0AzUIZccqlt
         JsxR/6siAcnh4tW7zhUZGZuQ6yl4ghSUIsPZDLYrJrJyv2HQdPJ69lVou+iYXUNeLfj3
         w2nQKFJwvdKdrh20GykU3Go3NF9GzVe1PCaSsPQ/Nmg/eQ8uTH/fQKswFe76iPsbM3JV
         h8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qpyh2PaNh/u0oi9ThfEHkFImlddlN8fnWeaDdSG7BTU=;
        b=LHb7qeG5KDt16XXr9GvwiswCtKrXzSK6UUc4FTxsKmJWieS00FSqu73luBLlERr0qk
         9DgCPWU8qkHeF2CwsjEEk15CtqV0oksALxe8rG53Uy95Kwl8xgB2QIDq8EhAF1h1jf4p
         1ck6ftuTFD+BtLKxIiJEFslZEmQGSIbJShjlK/Q4y6Yq91CEoCiy0lJdQQ/vDF/NHnqb
         N3Dpv3fj/FssGeFnBclh4ouWT+m2pG1RQaXM7UyidT21jMA/zaYBTn8djnabwN6VGcG6
         /5Slij2MQEOxRoik1T6LW5MzeiZ+DpvQpqjdaaw2sEgbLM3HlRCxMKb2K5WvUEp5pPui
         kn6Q==
X-Gm-Message-State: APjAAAUABwaOo7B0su9KiHlDUVWktlXw77CW574XIt+6SQEvHbTR0KyC
        6oxpgEWDRsvR5QWgzz2TsNOhILHSWnI=
X-Google-Smtp-Source: APXvYqwHKsvirtbcvUeQdpP+cIjxWUEgXzJiwWi4ZgBf0UNrbIdb93uo9rTFr7bKYns6oDjGchZCYX/oc3c=
X-Received: by 2002:aed:3e16:: with SMTP id l22mr5656924qtf.50.1554902309282;
 Wed, 10 Apr 2019 06:18:29 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:17:26 +0200
In-Reply-To: <20190410131726.250295-1-glider@google.com>
Message-Id: <20190410131726.250295-4-glider@google.com>
Mime-Version: 1.0
References: <20190410131726.250295-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 3/3] net: make sk_prot_alloc() work with CONFIG_INIT_ALL_HEAP
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Rename sk_prot_clear_nulls() to sk_prot_clear() and introduce an extra
init_byte parameter to be passed to memset() when initializing struct sock.
In the case CONFIG_INIT_ALL_HEAP is on, initialize newly created struct
sock with 0xAA.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sandeep Patil <sspatil@android.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-security-module@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
---
 include/net/sock.h | 8 ++++----
 net/core/sock.c    | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8de5ee258b93..a49c1f1c71c1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1044,13 +1044,13 @@ struct module;
 
 /*
  * caches using SLAB_TYPESAFE_BY_RCU should let .next pointer from nulls nodes
- * un-modified. Special care is taken when initializing object to zero.
+ * un-modified. Special care is taken when initializing object.
  */
-static inline void sk_prot_clear_nulls(struct sock *sk, int size)
+static inline void sk_prot_clear(struct sock *sk, int size, int init_byte)
 {
 	if (offsetof(struct sock, sk_node.next) != 0)
-		memset(sk, 0, offsetof(struct sock, sk_node.next));
-	memset(&sk->sk_node.pprev, 0,
+		memset(sk, init_byte, offsetof(struct sock, sk_node.next));
+	memset(&sk->sk_node.pprev, init_byte,
 	       size - offsetof(struct sock, sk_node.pprev));
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 782343bb925b..1ad855e99512 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1601,8 +1601,9 @@ static struct sock *sk_prot_alloc(struct proto *prot, gfp_t priority,
 		sk = kmem_cache_alloc(slab, priority & ~__GFP_ZERO);
 		if (!sk)
 			return sk;
-		if (priority & __GFP_ZERO)
-			sk_prot_clear_nulls(sk, prot->obj_size);
+		if (GFP_INIT_ALWAYS_ON || (priority & __GFP_ZERO))
+			sk_prot_clear(sk, prot->obj_size,
+				      INITMEM_FILL_BYTE(priority));
 	} else
 		sk = kmalloc(prot->obj_size, priority);
 
-- 
2.21.0.392.gf8f6787159e-goog

