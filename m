Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B0F9C0;
	Wed, 19 Nov 2025 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510706; cv=none; b=QUGU7xAP4YIs9473ClPP4CxH8+jJyZdourmo3uwauWGPqhTzM4sevCAI0LC0RotrTyDPkPE/1xGyYclUGswoRTh4lsx6PD6iJiEsDrADGSJlMNogEQ575zKEoulB49Sb7RE6KsJYWhrmfo73Nwys3rBAlGMcOl+rH6oAYYj1rLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510706; c=relaxed/simple;
	bh=UNZ9ICjSP+rM+UyQ5Ef84eRN3B7Pn3YzaRJMOY7Kqho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=See79XysYtR8x349Fm5LyDO5a80LGRESTmwCrspgcvgsq8JoMHqulTshDTcg1tcTEeTd3lt/UuLY42Rtyg82NxZIiclZZm3wDWKn2I5WW8Z7eRc/AR9nBPeGHVqg7f33CpS19nb3lzR+ru7foPzgnlwp4eUZ3IpxzEI1umDyHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 23B1F43C; Tue, 18 Nov 2025 18:05:00 -0600 (CST)
Date: Tue, 18 Nov 2025 18:05:00 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] Clarify the rootid_owns_currentns
Message-ID: <aR0JrOvDxDKZPELd@mail.hallyn.com>
References: <aRegH8P4cPlzzlX9@mail.hallyn.com>
 <aRx/1MvvBqu5MhKv@mail.hallyn.com>
 <CAHC9VhQu7gSVO-QZFE_iaCB0qBqB3surdHQo4Vg71zc890uEhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQu7gSVO-QZFE_iaCB0qBqB3surdHQo4Vg71zc890uEhA@mail.gmail.com>

On Tue, Nov 18, 2025 at 10:47:06AM -0500, Paul Moore wrote:
> On Tue, Nov 18, 2025 at 9:16 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Fri, Nov 14, 2025 at 03:33:19PM -0600, Serge E. Hallyn wrote:
> > > Split most of the rootid_owns_currentns() functionality
> > > into a more generic rootid_owns_ns() function which
> > > will be easier to write tests for.
> > >
> > > Rename the functions and variables to make clear that
> > > the ids being tested could be any uid.
> > >
> > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > > CC: Ryan Foster <foster.ryan.r@gmail.com>
> > > CC: Christian Brauner <brauner@kernel.org>
> >
> > Paul, Christian, let me know if you have any objections, else I will
> > queue this up in caps-next.
> 
> Seems reasonable to me, but it would be good to fix the parameter doc
> bug that the kernel test robot identified.  I suspect it is just the
> extra vertical comment space between the top one line summary and the
> parameter list.

Actually I think it was probably the use of - instead of : after the
parameter name, but I went ahead and changed both, thanks.

Pushed the below patch for linux-next.

Subject: [PATCH 1/1] Clarify the rootid_owns_currentns

Split most of the rootid_owns_currentns() functionality
into a more generic rootid_owns_ns() function which
will be easier to write tests for.

Rename the functions and variables to make clear that
the ids being tested could be any uid.

Signed-off-by: Serge Hallyn <serge@hallyn.com>
CC: Ryan Foster <foster.ryan.r@gmail.com>
CC: Christian Brauner <brauner@kernel.org>

---
v2: change the function parameter documentation to mollify the bot.
---
 security/commoncap.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 6bd4adeb4795..496e054c5d37 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -358,17 +358,17 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 	return error;
 }
 
-static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
+/**
+ * kuid_root_in_ns - check whether the given kuid is root in the given ns
+ * @kuid: the kuid to be tested
+ * @ns: the user namespace to test against
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
@@ -377,6 +377,16 @@ static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
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
@@ -481,7 +491,7 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 		goto out_free;
 	}
 
-	if (!rootid_owns_currentns(vfsroot)) {
+	if (!vfsuid_root_in_currentns(vfsroot)) {
 		size = -EOVERFLOW;
 		goto out_free;
 	}
@@ -722,7 +732,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	if (!rootid_owns_currentns(rootvfsuid))
+	if (!vfsuid_root_in_currentns(rootvfsuid))
 		return -ENODATA;
 
 	cpu_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
-- 
2.34.1

