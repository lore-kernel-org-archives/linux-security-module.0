Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E377193432
	for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243800; cv=none; b=JHdhIXlc7mIxlfoqXxtRyPSgcjnBfpZ0u8mUf15dA4fjy16N/X7Oigp0dc3VLQ4wPAk9eNF0bGmgHsXcR33bFky2YocbeqFOvAZAmyiH/xcKQUFlViOrMfpcuIqzlVoDcaS9hdy5ibF8xgXOWLMTfbUFOnNLCsrIAvWUz7036bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243800; c=relaxed/simple;
	bh=Yautcy9ck/HanBfjk9RDHnxNHXSiPTSG9X+XqexUOe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5hmjMFaxaAHM/GWmW274nKnVVSDxc2Ge4bVl0hFDjqfBog2X9H0dTI2tjYegSCHX+u6YMYnKPHs5jIZ+v51gmrsSXecPAG9iYFqKRJqpVboU4MrU7nXOzrIa3jOwm1cu6lq104MD5XxHIbGM0Kuw25fYz2Nd/sZ8EIcNq4vWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/OiiFA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/OiiFA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+EPM0BxZa29yRtUIP6Bqy4vu3lGbdW23TC1wKLwsMs=;
	b=H/OiiFA2IFqvJILiKM9M9GpGXE5P+g3wVAJsDFmuSh9PmQtJV8KicWwq3ZYueVrD1CW48W
	OphA4P+mg/VYjgusCJqsVU0OxA8kVqsKw3uSnNYHA1URC1KerdUJhI+xuQnsS3vGaOAesp
	PiRvSU64FZM8xZJHHb2IadF4K/kG06Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-TGQLKAD3MFGxqxid0qWvaw-1; Wed,
 21 Aug 2024 08:36:34 -0400
X-MC-Unique: TGQLKAD3MFGxqxid0qWvaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A9A31954B23;
	Wed, 21 Aug 2024 12:36:33 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86D4319560AD;
	Wed, 21 Aug 2024 12:36:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] keys: Move key_get() out of line so a tracepoint can be added
Date: Wed, 21 Aug 2024 13:36:11 +0100
Message-ID: <20240821123616.60401-4-dhowells@redhat.com>
In-Reply-To: <20240821123616.60401-1-dhowells@redhat.com>
References: <20240821123616.60401-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Move key_get() out of line so that a tracepoint can be added into it
without incurring circular header dependencies or overly expanding the
callers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---
 include/linux/key.h |  6 +-----
 security/keys/key.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 943a432da3ae..08062b4f807c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -299,6 +299,7 @@ extern struct key *key_alloc(struct key_type *type,
 
 extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
+struct key *key_get(struct key *key);
 extern void key_put(struct key *key);
 extern bool key_put_tag(struct key_tag *tag);
 extern void key_remove_domain(struct key_tag *domain_tag);
@@ -309,11 +310,6 @@ static inline struct key *__key_get(struct key *key)
 	return key;
 }
 
-static inline struct key *key_get(struct key *key)
-{
-	return key ? __key_get(key) : key;
-}
-
 static inline void key_ref_put(key_ref_t key_ref)
 {
 	key_put(key_ref_to_ptr(key_ref));
diff --git a/security/keys/key.c b/security/keys/key.c
index 3d7d185019d3..14c7ee77ea15 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -635,6 +635,20 @@ int key_reject_and_link(struct key *key,
 }
 EXPORT_SYMBOL(key_reject_and_link);
 
+/**
+ * key_get - Get a reference on a key
+ * @key: The key to get a reference on.
+ *
+ * Get a reference on a key, if not NULL, and return the parameter.
+ */
+struct key *key_get(struct key *key)
+{
+	if (key)
+		refcount_inc(&key->usage);
+	return key;
+}
+EXPORT_SYMBOL(key_get);
+
 /**
  * key_put - Discard a reference to a key.
  * @key: The key to discard a reference from.

