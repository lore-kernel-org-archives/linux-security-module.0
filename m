From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 28 Aug 2018 16:34:04 -0700
Subject: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as
	a struct member name
Message-ID: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Since this header is in "include/uapi/linux/", apparently people
want to use it in userspace programs -- even in C++ ones.
However, the header uses a C++ reserved keyword ("private"),
so change that to "dh_private" instead to allow the header file
to be used in C++ userspace.

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=191051
Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings at vger.kernel.org
Cc: linux-security-module at vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable at vger.kernel.org
---
 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-416.orig/include/uapi/linux/keyctl.h
+++ lnx-416/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	__s32 dh_private;
 	__s32 prime;
 	__s32 base;
 };
--- lnx-416.orig/security/keys/dh.c
+++ lnx-416/security/keys/dh.c
@@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;
