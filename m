From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 11 Jul 2017 19:47:15 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <ca6e0001-6aeb-74dc-ab91-44aed3b7d128@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170711171222.GB31603@mail.hallyn.com>
	<ca6e0001-6aeb-74dc-ab91-44aed3b7d128@linux.vnet.ibm.com>
Message-ID: <20170712004715.GC6436@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> On 07/11/2017 01:12 PM, Serge E. Hallyn wrote:
> >>diff --git a/fs/xattr.c b/fs/xattr.c
> >>index 464c94b..eacad9e 100644
> >>--- a/fs/xattr.c
> >>+++ b/fs/xattr.c
> >>@@ -133,20 +133,440 @@ xattr_permission(struct inode *inode, const char *name, int mask)
> >>  	return inode_permission(inode, mask);
> >>  }
> >>+/*
> >>+ * A list of extended attributes that are supported in user namespaces
> >>+ */
> >>+static const char *const userns_xattrs[] = {
> >>+	XATTR_NAME_CAPS,
> >>+	NULL
> >>+};
> >>+
> >>+/*
> >>+ * xattrs_is_userns_supported - Check whether an xattr is supported in userns
> >>+ *
> >>+ * @name:   full name of the extended attribute
> >>+ * @prefix: do a prefix match (true) or a full match (false)
> >>+ *
> >>+ * This function returns < 0 if not supported, an index into userns_xattrs[]
> >>+ * otherwise.
> >>+ */
> >>+static int
> >>+xattr_is_userns_supported(const char *name, int prefix)
> >>+{
> >>+	int i;
> >>+
> >>+	if (!name)
> >>+		return -1;
> >>+
> >>+	for (i = 0; userns_xattrs[i]; i++) {
> >>+		if (prefix) {
> >>+			if (!strncmp(userns_xattrs[i], name,
> >>+				     strlen(userns_xattrs[i])))
> >>+				return i;
> >I think you here need to also check that the next char is either
> >'\0' or '.' (or maybe '@')
> 
> I have the checks for '@' and '\0' done by the caller. With the
> current support of only security.capability I don't think we need to
> check for '.'.

Ah - ok, thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
