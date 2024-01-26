Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753F1426F
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265863; cv=none; b=GCEqsm1S3/X1G41Ig8Lzbkgla7OQ1+TTc2yTwcUqgSrOM98NQqlmYwF7jbUKsnDcDSgBCpAnybTw1DUtaQIvh26pzo96EnLPq64i5aj6cFcbM2fAgaKITQycYZ9LIldFE8yp5/kwLK+f8wknCv+LvHuDy0DlGkPTvO5d4cW3nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265863; c=relaxed/simple;
	bh=KDwKvxjFBtCGcBHvMr/jFLU0CTemadUlZgy031SYquI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcBH8el8vrkTUf8FuO3h6GohGxMLEOmxjR6PKWROVsXQYlqARMiEKb51u9NaaHiEkoenDGVD9E1IcSCblLg2d4Hel9thd/2h/NEWAZLtCuSkJGU9Ki5w2JflDw60SHxbYfKVd2iFTOE8MG4a4FhPYE5FvGWaO56rYJ5kNGWpI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BldUMdts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BldUMdts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706265851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEWqYXcFpyH0h2J3JzWjNyw0EkIiJEepfjoSL7blk4o=;
	b=BldUMdtsqHXCNHjv/Dox+rUpc14Llx82Ma9SMJUm0KjMOgHfvPP+CNmcZh0KxdLBX5Sg2/
	cMfAq7e6+PlhXdRj81aItJ76aMO72uDET0i9euCZsoLcwk2VuvzCookBG31l9WXtziSvdG
	DdJvTS3eHPDc9hjwbHCYpsne3o0eibE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-KYKcGl-tO86i_Q0oZRLu3Q-1; Fri, 26 Jan 2024 05:44:10 -0500
X-MC-Unique: KYKcGl-tO86i_Q0oZRLu3Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5101e826a3dso190166e87.3
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 02:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706265849; x=1706870649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEWqYXcFpyH0h2J3JzWjNyw0EkIiJEepfjoSL7blk4o=;
        b=GFpYk6+5X5mw7Bn3Rn+0L3pn/5VnfuNLE7+lbRJDak7mbWVD+1fFmXww225NT0C8io
         zMDLwaM4JYU8zBNgOPfEXBLmjkQ89Gcs392rUHzrFEWCjDUdWWLJgjl3mQKtFOEaW4Ds
         DdbhouwdK0Cpf/mtGiz40U566uhV4XaAmL7VRLsu6T9KzdLmxfhGxwWSWHL1Q08hIee7
         SuCL3zKZRAOBTtpTW05sW+upCNwFoO32B4APmJ8lXNLsAXPogl4HxUNY2xXIG0hy4cfO
         SnNH3yM034QG3XyZ7qEJ+eg3RQG2sGnT0WmWXIfrrNB+P3N8whnJPNfitGcyfglqXMZ7
         TEpQ==
X-Gm-Message-State: AOJu0YweDmJnCZ1VSr6GFpbJhCZkqPnOp+9suozUC6U9OU439FQCF3aL
	FOWfI7AeGjD+rYsw9LpvfV5vIKAR46/HVNjWiffhhKCiNSQAOhkTKpSDrfTPbaZbhXZmimNOECL
	mQwQ3FwtsEQ9itfvTjKHb19+eqRBjx14E8JPFtG7+kOh7840ugb5dNdUNeg7gSxwufSMz04zbPA
	==
X-Received: by 2002:ac2:4564:0:b0:510:1023:784d with SMTP id k4-20020ac24564000000b005101023784dmr574329lfm.81.1706265847910;
        Fri, 26 Jan 2024 02:44:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLz0ct9zFeeITjNYcc+4b79PuevNDGcLbg6XkBVWisv//4gW2d8624fgOAcbVF9MSADDq+dA==
X-Received: by 2002:ac2:4564:0:b0:510:1023:784d with SMTP id k4-20020ac24564000000b005101023784dmr574307lfm.81.1706265846018;
        Fri, 26 Jan 2024 02:44:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id d19-20020ac24c93000000b0051025dcd3e0sm139616lfl.69.2024.01.26.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 02:44:05 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] security: fix the logic in security_inode_getsecctx()
Date: Fri, 26 Jan 2024 11:44:03 +0100
Message-ID: <20240126104403.1040692-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The inode_getsecctx LSM hook has previously been corrected to have
-EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
behavior. However, the call_int_hook()-generated loop in
security_inode_getsecctx() was left treating 0 as the neutral value, so
after an LSM returns 0, the loop continues to try other LSMs, and if one
of them returns a non-zero value, the function immediately returns with
said value. So in a situation where SELinux and the BPF LSMs registered
this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
returned 0.

Fix this by open-coding the call_int_hook() loop and making it use the
correct LSM_RET_DEFAULT() value as the neutral one, similar to what
other hooks do.

Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

I ran 'tools/nfs.sh' on the patch and even though it fixes the most
serious issue that Stephen reported, some of the tests are still
failing under NFS (but I will presume that these are pre-existing issues
not caused by the patch).

I can also see an opportunity to clean up the hook implementations in
security/security.c - I plan to have a go at it and send it as a
separate patch later.

 security/security.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 0144a98d3712..6196ccaba433 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4255,7 +4255,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
  */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
+		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(inode_getsecctx);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
-- 
2.43.0

