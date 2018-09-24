From: jmorris@namei.org (James Morris)
Date: Tue, 25 Sep 2018 07:40:06 +1000 (AEST)
Subject: [GIT PULL] Keys: fix C++ reserved word issue
Message-ID: <alpine.LRH.2.21.1809250738020.27047@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull this revert and update, from David Howells:

"Here's a pair of fixes that need to go upstream asap, please:

 (1) Revert an incorrect fix to the keyrings UAPI for a C++ reserved word
     used as a struct member name.  This change being reverted breaks
     existing userspace code and is thus incorrect.

     Further, *neither* name is consistent with the one in the keyutils
     package public header.

 (2) Fix the problem by using a union to make the name from keyutils
     available in parallel and make the 'private' name unavailable in C++
     with cpp-conditionals."

---
The following changes since commit 02214bfc89c71bcc5167f653994cfa5c57f10ff1:

  Merge tag 'media/v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-09-24 15:16:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.19-rc5

for you to fetch changes up to cae081e4d49ac9be127c4e1b876bb685c2c04159:

  keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h (2018-09-24 13:51:12 -0700)

----------------------------------------------------------------
David Howells (1):
      keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h

Lubomir Rintel (1):
      Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"

 include/uapi/linux/keyctl.h | 7 ++++++-
 security/keys/dh.c          | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 910cc4334b21..0f3cb13db8e9 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,12 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 dh_private;
+	union {
+#ifndef __cplusplus
+		__s32 private;
+#endif
+		__s32 priv;
+	};
 	__s32 prime;
 	__s32 base;
 };
diff --git a/security/keys/dh.c b/security/keys/dh.c
index 3b602a1e27fa..711e89d8c415 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -300,7 +300,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;
