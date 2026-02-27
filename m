Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F14387591;
	Fri, 27 Feb 2026 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235594; cv=none; b=F2Ts5pfS4OCtx7fcRftztkRYihsYyuHv4Jkyqegd24txK2Cwy0wp9j34+IVVgrn26whg2AP6SuY/K8tQzOpL2xg3CM44n//UV2xX7k0PPP7n6iYp9JB1rS16XMd5m/1IWe57FwPLoM3SYk57RSovWr5f9zdkRo9ahxJd6cEVvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235594; c=relaxed/simple;
	bh=aG/gHlOsbTz9+a8lBQDxwMcyHIhW3ZfZfbbxOIhXOiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awmBG8bDZ17fLNT9XL7/1qnord80Yw67imNdSBbrWtD+uIBg96zLTT2sAukxt3irPt7OH4ScwdQperHbQ1dF0/ERhDeKbPjW4d5jUIdLg75w8XE5xDdBrqRlPwyxJgiY679kg7H9Z5hbtCj7L+VouyOe8Ofc6RTTMN44b3MFVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DPQJg+Ca; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DPQJg+Ca"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id D903720B6F09;
	Fri, 27 Feb 2026 15:39:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D903720B6F09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235590;
	bh=3/BB7M3s6t5MZ9Xf4Zose0JYOcc8Mbk6oIskUtNtMJ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DPQJg+Cage7aogu+FfP+IN+PvzN1fnPJEHZ25LSU9MwxwkuXJh3n3fnFV6sp4Ixaa
	 VzmExYUeGb8bR9/U13NL0VUMiQ9btJRtelE1TQRq7nhdTO1b33vD1CCw6l4A2BcwB0
	 I9dR6sILsTqjVglZS9k/ZGeku4Jlpk1XdFX+74jY=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 04/10] crypto: pkcs7: add ability to extract signed attributes by OID
Date: Fri, 27 Feb 2026 15:38:33 -0800
Message-ID: <20260227233930.2418522-5-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Signers may add any information they like in signed attributes and
sometimes this information turns out to be relevant to specific
signing cases, so add an api pkcs7_get_authattr() to extract the value
of an authenticated attribute by specific OID.  The current
implementation is designed for the single signer use case and simply
terminates the search when it finds the relevant OID.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 crypto/asymmetric_keys/Makefile       |  4 +-
 crypto/asymmetric_keys/pkcs7_aa.asn1  | 18 ++++++
 crypto/asymmetric_keys/pkcs7_parser.c | 81 +++++++++++++++++++++++++++
 include/crypto/pkcs7.h                |  4 ++
 4 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1

diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcb..f99b7169ae7c 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -53,12 +53,14 @@ clean-files	+= pkcs8.asn1.c pkcs8.asn1.h
 obj-$(CONFIG_PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := \
 	pkcs7.asn1.o \
+	pkcs7_aa.asn1.o \
 	pkcs7_parser.o \
 	pkcs7_trust.o \
 	pkcs7_verify.o
 
-$(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
+$(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h $(obj)/pkcs7_aa.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
+$(obj)/pkcs7_aa.asn1.o: $(obj)/pkcs7_aa.asn1.c $(obj)/pkcs7_aa.asn1.h
 
 #
 # PKCS#7 parser testing key
diff --git a/crypto/asymmetric_keys/pkcs7_aa.asn1 b/crypto/asymmetric_keys/pkcs7_aa.asn1
new file mode 100644
index 000000000000..7a8857bdf56e
--- /dev/null
+++ b/crypto/asymmetric_keys/pkcs7_aa.asn1
@@ -0,0 +1,18 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Copyright (C) 2009 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5652#section-3
+
+AA ::= 	CHOICE {
+	aaSet		[0] IMPLICIT AASet,
+	aaSequence	[2] EXPLICIT SEQUENCE OF AuthenticatedAttribute
+}
+
+AASet ::= SET OF AuthenticatedAttribute
+
+AuthenticatedAttribute ::= SEQUENCE {
+	type	OBJECT IDENTIFIER ({ pkcs7_aa_note_OID }),
+	values	SET OF ANY ({ pkcs7_aa_note_attr })
+}
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 6e3ffdac83ac..d467866f7d93 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -15,6 +15,7 @@
 #include <crypto/public_key.h>
 #include "pkcs7_parser.h"
 #include "pkcs7.asn1.h"
+#include "pkcs7_aa.asn1.h"
 
 MODULE_DESCRIPTION("PKCS#7 parser");
 MODULE_AUTHOR("Red Hat, Inc.");
@@ -211,6 +212,86 @@ int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 }
 EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
 
+struct pkcs7_aa_context {
+	bool found;
+	enum OID oid_to_find;
+	const void *data;
+	size_t len;
+};
+
+int pkcs7_aa_note_OID(void *context, size_t hdrlen,
+		      unsigned char tag,
+		      const void *value, size_t vlen)
+{
+	struct pkcs7_aa_context *ctx = context;
+	enum OID oid = look_up_OID(value, vlen);
+
+	ctx->found = (oid == ctx->oid_to_find);
+
+	return 0;
+}
+
+int pkcs7_aa_note_attr(void *context, size_t hdrlen,
+		       unsigned char tag,
+		       const void *value, size_t vlen)
+{
+	struct pkcs7_aa_context *ctx = context;
+
+	if (ctx->found) {
+		ctx->data = value;
+		ctx->len = vlen;
+	}
+
+	return 0;
+}
+
+/**
+ * pkcs7_get_authattr - get authenticated attribute by OID
+ * @pkcs7: The preparsed PKCS#7 message
+ * @oid: the enum value of the OID to find
+ * @_data: Place to return a pointer to the attribute value
+ * @_len: length of the attribute value
+ *
+ * Searches the authenticated attributes until one is found with a
+ * matching OID.  Note that because the attributes are per signer
+ * there could be multiple signers with different values, but this
+ * routine will simply return the first one in parse order.
+ *
+ * Returns -ENODATA if the attribute can't be found
+ */
+int pkcs7_get_authattr(const struct pkcs7_message *pkcs7,
+		       enum OID oid,
+		       const void **_data, size_t *_len)
+{
+	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
+	struct pkcs7_aa_context ctx;
+
+	ctx.data = NULL;
+	ctx.oid_to_find = oid;
+
+	for (; sinfo; sinfo = sinfo->next) {
+		int ret;
+
+		/* only extract OIDs from validated signers */
+		if (!sinfo->verified)
+			continue;
+
+		ret = asn1_ber_decoder(&pkcs7_aa_decoder, &ctx,
+				       sinfo->authattrs, sinfo->authattrs_len);
+		if (ret < 0 || ctx.data != NULL)
+			break;
+	}
+
+	if (!ctx.data)
+		return -ENODATA;
+
+	*_data = ctx.data;
+	*_len = ctx.len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pkcs7_get_authattr);
+
 /*
  * Note an OID when we find one for later processing when we know how
  * to interpret it.
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..bd83202cd805 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -25,6 +25,10 @@ extern void pkcs7_free_message(struct pkcs7_message *pkcs7);
 extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 				  const void **_data, size_t *_datalen,
 				  size_t *_headerlen);
+extern int pkcs7_get_authattr(const struct pkcs7_message *pkcs7,
+			      enum OID oid,
+			      const void **_data, size_t *_len);
+
 
 /*
  * pkcs7_trust.c
-- 
2.52.0

