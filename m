From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:08 +0100
Subject: [PATCH v2 13/15] evm: add kernel command line option to select
	protected xattrs
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-14-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

EVM protects all extended attributes defined by LSMs, if LSMs are enabled
in the kernel configuration.

It is desirable to select a subset of extended attributes at run-time, so
that setting remaining extended attributes is allowed if they should not be
protected. At the moment, this option can be used to select security.ima
and ignore other extended attributes.

Protecting only security.ima is useful when the IMA policy does not rely on
the correctness of file metadata (e.g. when only rules based on subject
criteria are specified).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +++
 include/linux/evm.h                             |  6 +++++
 security/integrity/evm/evm_main.c               | 36 +++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 05496622b4ef..ac292121bd90 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1149,6 +1149,10 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	evm_xattrs=	[EVM]
+			Format: { "security.ima" }
+			Protect only security.ima extended attribute.
+
 	failslab=
 	fail_page_alloc=
 	fail_make_request=[KNL]
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 35ed9a8a403a..d31c02fb2ac1 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -14,6 +14,7 @@
 struct integrity_iint_cache;
 
 #ifdef CONFIG_EVM
+extern int evm_set_includes_protected_xattrs(char **set, int count);
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
@@ -44,6 +45,11 @@ static inline int posix_xattr_acl(const char *xattrname)
 #endif
 #else
 
+static inline int evm_set_includes_protected_xattrs(char **set, int count)
+{
+	return 1;
+}
+
 static inline int evm_set_key(void *key, size_t keylen)
 {
 	return -EOPNOTSUPP;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9826c02e2db8..afd6ee027250 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -68,6 +68,18 @@ static int __init evm_set_fixmode(char *str)
 }
 __setup("evm=", evm_set_fixmode);
 
+static int __init evm_select_xattrs(char *str)
+{
+#ifdef CONFIG_IMA_APPRAISE
+	if (strcmp(str, XATTR_NAME_IMA) == 0) {
+		evm_config_xattrnames[0] = XATTR_NAME_IMA;
+		evm_config_xattrnames[1] = NULL;
+	}
+#endif
+	return 0;
+}
+__setup("evm_xattrs=", evm_select_xattrs);
+
 static void __init evm_init_config(void)
 {
 #ifdef CONFIG_EVM_ATTR_FSUUID
@@ -221,6 +233,30 @@ static int evm_protected_xattr(const char *req_xattr_name)
 }
 
 /**
+ * evm_set_includes_protected_xattrs - check if set includes protected xattrs
+ * @set: array of extended attribute names to check
+ * @count: size of array
+ *
+ * Check if the provided set includes all EVM protected extended attributes.
+ *
+ * Return: 1 if set includes all protected xattrs, 0 otherwise.
+ */
+int evm_set_includes_protected_xattrs(char **set, int count)
+{
+	char **xattr;
+	int i, found = 1;
+
+	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++) {
+		for (i = 0; i < count; i++)
+			if (strcmp(set[i], *xattr) == 0)
+				break;
+		if (i == count)
+			return 0;
+	}
+	return found;
+}
+
+/**
  * evm_verifyxattr - verify the integrity of the requested xattr
  * @dentry: object of the verify xattr
  * @xattr_name: requested xattr
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
