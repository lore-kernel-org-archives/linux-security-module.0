Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14A45562C
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580037; cv=none; b=Dc7CObj90p0DUJos5myyJL4ivbrxycGBfJe1/EU4QNcFjqzNXW7XJqLIialxPUT79z7dVKMiCy/3ZklTeabSg/lXbLizFV3ybsYKLfbtXQpHbUOUPmXcbJnAvAW2SkLK0n2XtPGmOdeYNC61/aX9dXKdsMqWRLfHllArtPHpY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580037; c=relaxed/simple;
	bh=bJ7inLh4C725HHCujMEt/LH+4GpdepLKY1PwA0rtMnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Kn/zQOCz6KobSWoTdSLMz1/wbNzsH8+SSHLRFsZiJVskBNT7qqCKnN5ZV85w6xRiRELKiYMYtAhGe6/TiLN9zq/w3va52p76F83ii0AQNTHsMfKNh+Q5toIKS+jPJgYj0f4+CwoAbPfwRQurxqGqQukiIZHDbx9ukgPWztnfJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhSYXsJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhSYXsJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790580034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G1BY6pRx9eA1b7lpUBe/92rB45DJWNRvUWjkYSitEHs=;
	b=hhSYXsJ4Vq9WraeWxJpqgA5r8wMLtzDFMAva4HdJh8yzcv+oEAzDRRhGCN2R/DAbzM+WeB
	3t3X442/Cc4jI6oeEhDCOy96NjAyZzj0OlLJ6GY6PRVzNdgCQx4cg0JoG6iJLefODRu8bx
	6APL+wvxm2tVND5b/l5LVwkU4nlQJkM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-O3rJCJaxPZazGHv0VjViUQ-1; Mon,
 28 Sep 2026 03:20:30 -0400
X-MC-Unique: O3rJCJaxPZazGHv0VjViUQ-1
X-Mimecast-MFC-AGG-ID: O3rJCJaxPZazGHv0VjViUQ_1790580029
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBDE31843AC1;
	Mon, 28 Sep 2026 07:20:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA5F51956086;
	Mon, 28 Sep 2026 07:20:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] security: keys: Fix comment of search_process_keyrings_rcu()
Date: Mon, 28 Sep 2026 09:20:23 +0200
Message-ID: <20260928072024.91664-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: qJy_53YxVIS25c4tSumK1X7rgOgK1lx9M6wjNhfD1_A_1790580029
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

search_my_process_keyrings() has been renamed to search_cred_keyrings_rcu()
in commit e59428f721ee ("keys: Move the RCU locks outwards from the keyring
search functions"), but one spot has been missed in a comment.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 security/keys/process_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index a63c46bb2d148..570c131d90d5c 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -528,7 +528,7 @@ key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
 
 /*
  * Search the process keyrings attached to the supplied cred for the first
- * matching key in the manner of search_my_process_keyrings(), but also search
+ * matching key in the manner of search_cred_keyrings_rcu(), but also search
  * the keys attached to the assumed authorisation key using its credentials if
  * one is available.
  *
-- 
2.55.0

