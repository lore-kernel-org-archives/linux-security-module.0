Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE63016F1;
	Fri, 14 Nov 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156009; cv=none; b=pmu7idcd6Lr5FCqGQfkdp/yDQM48inSpslHwanh459WV8hw6NRxTXPwb5Jfvi36o5fQE4Unw89l5Nyfvy0Mc+yxsnJBPPEw6lZEv1E7pI77fvavcUGHMoXLK1WZfUJkyDliIvj2W1Lvf8VZfVQZaxNx8Qx/X2v8vQM4gZ/c1RAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156009; c=relaxed/simple;
	bh=VXjVVPRjMMU4fRw30UE62yW2y9qYauWF5qDhHi6DvDI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pOb3xmXPAsQ4RIvkEGhuiLkPfzYmoA1ws6Go6a1TnWB8YBJF0Y2r+Qr/gFp0r9V91Fia9r3kfgaBx6UBiGyhvtTMD8frW1oCjf5DhJ6fzw+8eUW/uz7bxyRBib/GPWrv75ZQ2f8cddGJHtXr3H5Y9kNegxxcJaDUgduM4LkbwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0E0F4797; Fri, 14 Nov 2025 15:33:19 -0600 (CST)
Date: Fri, 14 Nov 2025 15:33:19 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] Clarify the rootid_owns_currentns
Message-ID: <aRegH8P4cPlzzlX9@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Split most of the rootid_owns_currentns() functionality
into a more generic rootid_owns_ns() function which
will be easier to write tests for.

Rename the functions and variables to make clear that
the ids being tested could be any uid.

Signed-off-by: Serge Hallyn <serge@hallyn.com>
CC: Ryan Foster <foster.ryan.r@gmail.com>
CC: Christian Brauner <brauner@kernel.org>
---
 security/commoncap.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 6bd4adeb4795..8a81fdc12cbe 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -358,17 +358,18 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 	return error;
 }
 
-static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
+/**
+ * kuid_root_in_ns - check whether the given kuid is root in the given ns
+ *
+ * @kuid - the kuid to be tested
+ * @ns - the user namespace to test against
+ *
+ * Returns true if @kuid represents the root user in @ns, false otherwise.
+ */
+static bool kuid_root_in_ns(kuid_t kuid, struct user_namespace *ns)
 {
-	struct user_namespace *ns;
-	kuid_t kroot;
-
-	if (!vfsuid_valid(rootvfsuid))
-		return false;
-
-	kroot = vfsuid_into_kuid(rootvfsuid);
-	for (ns = current_user_ns();; ns = ns->parent) {
-		if (from_kuid(ns, kroot) == 0)
+	for (;; ns = ns->parent) {
+		if (from_kuid(ns, kuid) == 0)
 			return true;
 		if (ns == &init_user_ns)
 			break;
@@ -377,6 +378,16 @@ static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
 	return false;
 }
 
+static bool vfsuid_root_in_currentns(vfsuid_t vfsuid)
+{
+	kuid_t kuid;
+
+	if (!vfsuid_valid(vfsuid))
+		return false;
+	kuid = vfsuid_into_kuid(vfsuid);
+	return kuid_root_in_ns(kuid, current_user_ns());
+}
+
 static __u32 sansflags(__u32 m)
 {
 	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
@@ -481,7 +492,7 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 		goto out_free;
 	}
 
-	if (!rootid_owns_currentns(vfsroot)) {
+	if (!vfsuid_root_in_currentns(vfsroot)) {
 		size = -EOVERFLOW;
 		goto out_free;
 	}
@@ -722,7 +733,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	if (!rootid_owns_currentns(rootvfsuid))
+	if (!vfsuid_root_in_currentns(rootvfsuid))
 		return -ENODATA;
 
 	cpu_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
-- 
2.34.1

