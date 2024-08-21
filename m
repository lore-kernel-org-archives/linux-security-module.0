Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C0191F6A
	for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243794; cv=none; b=j/2mlYm1aM3FosmFrp00Zi80Y2ihcXBx6QdabjHcdoT8p/Wt+itUp8REHKlbYTL997hZPYLTLeaR3ggVInqHQze7neDSgiRLVS/WsehEGtkPsuhVjG8FFhAXudhgPTYWItRemjODo8i5MymUFG/3xuHqc9LCVhfmoIqpNcE8kBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243794; c=relaxed/simple;
	bh=vxY1xD4PYBOudJSOqSNC2Vu4G+cS92ZDHn4k+kBjiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLJFEUoqfmZ0q8O+XhBg/A8iq4+mkQ29FpHfctqpbE5oDghxTGCm5iooJp2P8uyj0vzOn39WzGneoAyVmyBU9s5RLmHjphKNKRoc3NGcuf5Fh6BdBoNpnsauiqWhLlaTgbcvcoExHpW7gY3pZBDGbHs/3AbDWDrqYnX60oAnYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHKniEQ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHKniEQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9bQJ2co3elsRL5KhC8W7d+SgjU49zr7xREsgM6Vv2Q=;
	b=CHKniEQ9EzxH8hH4hvSnlQiVLphmTiQB+ZF/cqStKvFX/v5wuzbqhrJSSF7nyKcdvyn1eJ
	atQz8rh4oKqLjWKUAtEQQ6183MFc2UQ7jpZEdXl/Hu/iEJhmpK6wX9aFah/11I9621yaXC
	P9NPasdl/v21gaW0pbLhKxYxVGMqB1o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-l2A2HIDUPR-LvjBZbaP7-Q-1; Wed,
 21 Aug 2024 08:36:28 -0400
X-MC-Unique: l2A2HIDUPR-LvjBZbaP7-Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30E6E195608A;
	Wed, 21 Aug 2024 12:36:27 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1ACB19560AE;
	Wed, 21 Aug 2024 12:36:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] keys: Out of line key_is_dead() so it can have tracepoints added in
Date: Wed, 21 Aug 2024 13:36:09 +0100
Message-ID: <20240821123616.60401-2-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move key_is_dead() out of line so that tracepoints can be added in to it
without incurring circular #includes.  Also, it is only used from the file
it is moved into.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 security/keys/internal.h | 20 --------------------
 security/keys/keyring.c  | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 2cffa6dc8255..8ba87127e446 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -211,26 +211,6 @@ extern struct key *request_key_auth_new(struct key *target,
 
 extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
 
-/*
- * Determine whether a key is dead.
- */
-static inline bool key_is_dead(const struct key *key, time64_t limit)
-{
-	time64_t expiry = key->expiry;
-
-	if (expiry != TIME64_MAX) {
-		if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
-			expiry += key_gc_delay;
-		if (expiry <= limit)
-			return true;
-	}
-
-	return
-		key->flags & ((1 << KEY_FLAG_DEAD) |
-			      (1 << KEY_FLAG_INVALIDATED)) ||
-		key->domain_tag->removed;
-}
-
 /*
  * keyctl() functions
  */
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4448758f643a..0eed018448cb 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1687,6 +1687,26 @@ static void keyring_revoke(struct key *keyring)
 	}
 }
 
+/*
+ * Determine whether a key is dead.
+ */
+static bool key_is_dead(const struct key *key, time64_t limit)
+{
+	time64_t expiry = key->expiry;
+
+	if (expiry != TIME64_MAX) {
+		if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
+			expiry += key_gc_delay;
+		if (expiry <= limit)
+			return true;
+	}
+
+	return
+		key->flags & ((1 << KEY_FLAG_DEAD) |
+			      (1 << KEY_FLAG_INVALIDATED)) ||
+		key->domain_tag->removed;
+}
+
 static bool keyring_gc_select_iterator(void *object, void *iterator_data)
 {
 	struct key *key = keyring_ptr_to_key(object);

