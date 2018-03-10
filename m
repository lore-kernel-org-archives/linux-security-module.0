From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 10 Mar 2018 14:14:50 -0800
Subject: [PATCH v3 1/6] tpm-buf: create new functions for handling TPM buffers
In-Reply-To: <1520720026.4495.11.camel@HansenPartnership.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
Message-ID: <1520720090.4495.12.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This separates out the old tpm_buf_... handling functions from static
inlines into tpm.h and makes them their own tpm-buf.c file.  It also
adds handling for tpm2b structures and also incremental pointer
advancing parsers.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: added this patch to separate out the API changes
v3: added tpm_buf_reset_cmd()
---
 drivers/char/tpm/Makefile  |   2 +-
 drivers/char/tpm/tpm-buf.c | 191 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h     |  95 ++++------------------
 3 files changed, 208 insertions(+), 80 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index d37c4a1748f5..41b2482b97c3 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_TCG_TPM) += tpm.o
 tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
 	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
-         tpm2-space.o
+         tpm2-space.o tpm-buf.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
 tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
 tpm-$(CONFIG_OF) += tpm_eventlog_of.o
diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
new file mode 100644
index 000000000000..146a71cec067
--- /dev/null
+++ b/drivers/char/tpm/tpm-buf.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Handing for tpm2b structures to facilitate the building of commands
+ */
+
+#include "tpm.h"
+
+#include <linux/module.h>
+
+#include <asm/unaligned.h>
+
+static int __tpm_buf_init(struct tpm_buf *buf)
+{
+	buf->data_page = alloc_page(GFP_HIGHUSER);
+	if (!buf->data_page)
+		return -ENOMEM;
+
+	buf->flags = 0;
+	buf->data = kmap(buf->data_page);
+
+	return 0;
+}
+
+void tpm_buf_reset_cmd(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	struct tpm_input_header *head;
+
+	head = (struct tpm_input_header *) buf->data;
+
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset_cmd);
+
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	int rc;
+
+	rc = __tpm_buf_init(buf);
+	if (rc)
+		return rc;
+
+	tpm_buf_reset_cmd(buf, tag, ordinal);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init);
+
+int tpm_buf_init_2b(struct tpm_buf *buf)
+{
+	struct tpm_input_header *head;
+	int rc;
+
+	rc = __tpm_buf_init(buf);
+	if (rc)
+		return rc;
+
+	head = (struct tpm_input_header *) buf->data;
+
+	head->length = cpu_to_be32(sizeof(*head));
+
+	buf->flags = TPM_BUF_2B;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
+
+void tpm_buf_destroy(struct tpm_buf *buf)
+{
+	kunmap(buf->data_page);
+	__free_page(buf->data_page);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_destroy);
+
+static void *tpm_buf_data(struct tpm_buf *buf)
+{
+	if (buf->flags & TPM_BUF_2B)
+		return buf->data + TPM_HEADER_SIZE;
+	return buf->data;
+}
+
+u32 tpm_buf_length(struct tpm_buf *buf)
+{
+	struct tpm_input_header *head = (struct tpm_input_header *)buf->data;
+	u32 len;
+
+	len = be32_to_cpu(head->length);
+	if (buf->flags & TPM_BUF_2B)
+		len -= sizeof(*head);
+	return len;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_length);
+
+u16 tpm_buf_tag(struct tpm_buf *buf)
+{
+	struct tpm_input_header *head = (struct tpm_input_header *)buf->data;
+
+	return be16_to_cpu(head->tag);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_tag);
+
+void tpm_buf_append(struct tpm_buf *buf,
+		    const unsigned char *new_data,
+		    unsigned int new_len)
+{
+	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
+	u32 len = be32_to_cpu(head->length);
+
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_OVERFLOW)
+		return;
+
+	if ((len + new_len) > PAGE_SIZE) {
+		WARN(1, "tpm_buf: overflow\n");
+		buf->flags |= TPM_BUF_OVERFLOW;
+		return;
+	}
+
+	memcpy(&buf->data[len], new_data, new_len);
+	head->length = cpu_to_be32(len + new_len);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append);
+
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
+{
+	tpm_buf_append(buf, &value, 1);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
+
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
+{
+	__be16 value2 = cpu_to_be16(value);
+
+	tpm_buf_append(buf, (u8 *) &value2, 2);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
+
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
+{
+	__be32 value2 = cpu_to_be32(value);
+
+	tpm_buf_append(buf, (u8 *) &value2, 4);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
+
+static void tpm_buf_reset(struct tpm_buf *buf)
+{
+	struct tpm_input_header *head;
+
+	head = (struct tpm_input_header *)buf->data;
+	head->length = cpu_to_be32(sizeof(*head));
+}
+
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
+{
+	u16 len = tpm_buf_length(tpm2b);
+
+	tpm_buf_append_u16(buf, len);
+	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
+	/* clear the buf for reuse */
+	tpm_buf_reset(tpm2b);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
+
+/* functions for unmarshalling data and moving the cursor */
+u8 tpm_get_inc_u8(const u8 **ptr)
+{
+	return *((*ptr)++);
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
+
+u16 tpm_get_inc_u16(const u8 **ptr)
+{
+	u16 val;
+
+	val = get_unaligned_be16(*ptr);
+	*ptr += sizeof(val);
+	return val;
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u16);
+
+u32 tpm_get_inc_u32(const u8 **ptr)
+{
+	u32 val;
+
+	val = get_unaligned_be32(*ptr);
+	*ptr += sizeof(val);
+	return val;
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 3e083a30a108..2fca263d4ca3 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -404,6 +404,7 @@ struct tpm_cmd_t {
 
 enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
+	TPM_BUF_2B		= BIT(1),
 };
 
 struct tpm_buf {
@@ -412,85 +413,21 @@ struct tpm_buf {
 	u8 *data;
 };
 
-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	struct tpm_input_header *head;
-
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
-		return -ENOMEM;
-
-	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
-
-	head = (struct tpm_input_header *) buf->data;
-
-	head->tag = cpu_to_be16(tag);
-	head->length = cpu_to_be32(sizeof(*head));
-	head->ordinal = cpu_to_be32(ordinal);
-
-	return 0;
-}
-
-static inline void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
-}
-
-static inline u32 tpm_buf_length(struct tpm_buf *buf)
-{
-	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
-
-	return be32_to_cpu(head->length);
-}
-
-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
-
-	return be16_to_cpu(head->tag);
-}
-
-static inline void tpm_buf_append(struct tpm_buf *buf,
-				  const unsigned char *new_data,
-				  unsigned int new_len)
-{
-	struct tpm_input_header *head = (struct tpm_input_header *) buf->data;
-	u32 len = tpm_buf_length(buf);
-
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
-		return;
-
-	if ((len + new_len) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
-		return;
-	}
-
-	memcpy(&buf->data[len], new_data, new_len);
-	head->length = cpu_to_be32(len + new_len);
-}
-
-static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
-{
-	tpm_buf_append(buf, &value, 1);
-}
-
-static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
-{
-	__be16 value2 = cpu_to_be16(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 2);
-}
-
-static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
-{
-	__be32 value2 = cpu_to_be32(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 4);
-}
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_reset_cmd(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_2b(struct tpm_buf *buf);
+void tpm_buf_destroy(struct tpm_buf *buf);
+u32 tpm_buf_length(struct tpm_buf *buf);
+void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
+		    unsigned int new_len);
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
+
+u8 tpm_get_inc_u8(const u8 **ptr);
+u16 tpm_get_inc_u16(const u8 **ptr);
+u32 tpm_get_inc_u32(const u8 **ptr);
 
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
-- 
2.12.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
