From: jmorris@namei.org (James Morris)
Date: Thu, 20 Apr 2017 15:33:29 +1000 (AEST)
Subject: [GIT PULL] Bugfixes for the Keys subsystem
Message-ID: <alpine.LRH.2.20.1704201528500.30154@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these patches for the Keys subsystem, which fix:

- CVE-2017-7472
- CVE-2017-6951
- CVE-2016-9604


The following changes since commit f61143c45077df4fa78e2f1ba455a00bbe1d5b8c:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2017-04-19 17:16:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-linus

David Howells (2):
      KEYS: Disallow keyrings beginning with '.' to be joined as session keyrings
      KEYS: Change the name of the dead type to ".dead" to prevent user access

Eric Biggers (1):
      KEYS: fix keyctl_set_reqkey_keyring() to not leak thread keyrings

 security/keys/gc.c           |    2 +-
 security/keys/keyctl.c       |   20 ++++++++++--------
 security/keys/process_keys.c |   44 +++++++++++++++++++++++++----------------
 3 files changed, 39 insertions(+), 27 deletions(-)

---

commit b1be815668e2f0c6a1ebb9e5c27e3ae1bf4b9917
Author: Eric Biggers <ebiggers@google.com>
Date:   Wed Apr 19 17:13:02 2017 +0100

    KEYS: fix keyctl_set_reqkey_keyring() to not leak thread keyrings
    
    This fixes CVE-2017-7472.
    
    Running the following program as an unprivileged user exhausts kernel
    memory by leaking thread keyrings:
    
    	#include <keyutils.h>
    
    	int main()
    	{
    		for (;;)
    			keyctl_set_reqkey_keyring(KEY_REQKEY_DEFL_THREAD_KEYRING);
    	}
    
    Fix it by only creating a new thread keyring if there wasn't one before.
    To make things more consistent, make install_thread_keyring_to_cred()
    and install_process_keyring_to_cred() both return 0 if the corresponding
    keyring is already present.
    
    Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
    Cc: stable at vger.kernel.org
    Signed-off-by: Eric Biggers <ebiggers@google.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Signed-off-by: James Morris <james.l.morris@oracle.com>

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ab082a2..4ad3212 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1258,8 +1258,8 @@ long keyctl_reject_key(key_serial_t id, unsigned timeout, unsigned error,
  * Read or set the default keyring in which request_key() will cache keys and
  * return the old setting.
  *
- * If a process keyring is specified then this will be created if it doesn't
- * yet exist.  The old setting will be returned if successful.
+ * If a thread or process keyring is specified then it will be created if it
+ * doesn't yet exist.  The old setting will be returned if successful.
  */
 long keyctl_set_reqkey_keyring(int reqkey_defl)
 {
@@ -1284,11 +1284,8 @@ long keyctl_set_reqkey_keyring(int reqkey_defl)
 
 	case KEY_REQKEY_DEFL_PROCESS_KEYRING:
 		ret = install_process_keyring_to_cred(new);
-		if (ret < 0) {
-			if (ret != -EEXIST)
-				goto error;
-			ret = 0;
-		}
+		if (ret < 0)
+			goto error;
 		goto set;
 
 	case KEY_REQKEY_DEFL_DEFAULT:
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b6fdd22..9139b18 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -128,13 +128,18 @@ int install_user_keyrings(void)
 }
 
 /*
- * Install a fresh thread keyring directly to new credentials.  This keyring is
- * allowed to overrun the quota.
+ * Install a thread keyring to the given credentials struct if it didn't have
+ * one already.  This is allowed to overrun the quota.
+ *
+ * Return: 0 if a thread keyring is now present; -errno on failure.
  */
 int install_thread_keyring_to_cred(struct cred *new)
 {
 	struct key *keyring;
 
+	if (new->thread_keyring)
+		return 0;
+
 	keyring = keyring_alloc("_tid", new->uid, new->gid, new,
 				KEY_POS_ALL | KEY_USR_VIEW,
 				KEY_ALLOC_QUOTA_OVERRUN,
@@ -147,7 +152,9 @@ int install_thread_keyring_to_cred(struct cred *new)
 }
 
 /*
- * Install a fresh thread keyring, discarding the old one.
+ * Install a thread keyring to the current task if it didn't have one already.
+ *
+ * Return: 0 if a thread keyring is now present; -errno on failure.
  */
 static int install_thread_keyring(void)
 {
@@ -158,8 +165,6 @@ static int install_thread_keyring(void)
 	if (!new)
 		return -ENOMEM;
 
-	BUG_ON(new->thread_keyring);
-
 	ret = install_thread_keyring_to_cred(new);
 	if (ret < 0) {
 		abort_creds(new);
@@ -170,17 +175,17 @@ static int install_thread_keyring(void)
 }
 
 /*
- * Install a process keyring directly to a credentials struct.
+ * Install a process keyring to the given credentials struct if it didn't have
+ * one already.  This is allowed to overrun the quota.
  *
- * Returns -EEXIST if there was already a process keyring, 0 if one installed,
- * and other value on any other error
+ * Return: 0 if a process keyring is now present; -errno on failure.
  */
 int install_process_keyring_to_cred(struct cred *new)
 {
 	struct key *keyring;
 
 	if (new->process_keyring)
-		return -EEXIST;
+		return 0;
 
 	keyring = keyring_alloc("_pid", new->uid, new->gid, new,
 				KEY_POS_ALL | KEY_USR_VIEW,
@@ -194,11 +199,9 @@ int install_process_keyring_to_cred(struct cred *new)
 }
 
 /*
- * Make sure a process keyring is installed for the current process.  The
- * existing process keyring is not replaced.
+ * Install a process keyring to the current task if it didn't have one already.
  *
- * Returns 0 if there is a process keyring by the end of this function, some
- * error otherwise.
+ * Return: 0 if a process keyring is now present; -errno on failure.
  */
 static int install_process_keyring(void)
 {
@@ -212,14 +215,18 @@ static int install_process_keyring(void)
 	ret = install_process_keyring_to_cred(new);
 	if (ret < 0) {
 		abort_creds(new);
-		return ret != -EEXIST ? ret : 0;
+		return ret;
 	}
 
 	return commit_creds(new);
 }
 
 /*
- * Install a session keyring directly to a credentials struct.
+ * Install the given keyring as the session keyring of the given credentials
+ * struct, replacing the existing one if any.  If the given keyring is NULL,
+ * then install a new anonymous session keyring.
+ *
+ * Return: 0 on success; -errno on failure.
  */
 int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 {
@@ -254,8 +261,11 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 }
 
 /*
- * Install a session keyring, discarding the old one.  If a keyring is not
- * supplied, an empty one is invented.
+ * Install the given keyring as the session keyring of the current task,
+ * replacing the existing one if any.  If the given keyring is NULL, then
+ * install a new anonymous session keyring.
+ *
+ * Return: 0 on success; -errno on failure.
  */
 static int install_session_keyring(struct key *keyring)
 {

commit 06660e8ff8af89dba5036bacd48cb019f2ae43be
Author: David Howells <dhowells@redhat.com>
Date:   Wed Apr 19 17:12:36 2017 +0100

    KEYS: Change the name of the dead type to ".dead" to prevent user access
    
    This fixes CVE-2017-6951.
    
    Userspace should not be able to do things with the "dead" key type as it
    doesn't have some of the helper functions set upon it that the kernel
    needs.  Attempting to use it may cause the kernel to crash.
    
    Fix this by changing the name of the type to ".dead" so that it's rejected
    up front on userspace syscalls by key_get_type_from_user().
    
    Though this doesn't seem to affect recent kernels, it does affect older
    ones, certainly those prior to:
    
    	commit c06cfb08b88dfbe13be44a69ae2fdc3a7c902d81
    	Author: David Howells <dhowells@redhat.com>
    	Date:   Tue Sep 16 17:36:06 2014 +0100
    	KEYS: Remove key_type::match in favour of overriding default by match_preparse
    
    which went in before 3.18-rc1.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: stable at vger.kernel.org
    Signed-off-by: James Morris <james.l.morris@oracle.com>

diff --git a/security/keys/gc.c b/security/keys/gc.c
index addf060..9cb4fe4 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -46,7 +46,7 @@
  * immediately unlinked.
  */
 struct key_type key_type_dead = {
-	.name = "dead",
+	.name = ".dead",
 };
 
 /*

commit eb4d19e546d2e0e2dd1f8b45d709a10aca176df7
Author: David Howells <dhowells@redhat.com>
Date:   Wed Apr 19 17:12:24 2017 +0100

    KEYS: Disallow keyrings beginning with '.' to be joined as session keyrings
    
    This fixes CVE-2016-9604.
    
    Keyrings whose name begin with a '.' are special internal keyrings and so
    userspace isn't allowed to create keyrings by this name to prevent
    shadowing.  However, the patch that added the guard didn't fix
    KEYCTL_JOIN_SESSION_KEYRING.  Not only can that create dot-named keyrings,
    it can also subscribe to them as a session keyring if they grant SEARCH
    permission to the user.
    
    This, for example, allows a root process to set .builtin_trusted_keys as
    its session keyring, at which point it has full access because now the
    possessor permissions are added.  This permits root to add extra public
    keys, thereby bypassing module verification.
    
    This also affects kexec and IMA.
    
    This can be tested by (as root):
    
    	keyctl session .builtin_trusted_keys
    	keyctl add user a a @s
    	keyctl list @s
    
    which on my test box gives me:
    
    	2 keys in keyring:
    	180010936: ---lswrv     0     0 asymmetric: Build time autogenerated kernel key: ae3d4a31b82daa8e1a75b49dc2bba949fd992a05
    	801382539: --alswrv     0     0 user: a
    
    Fix this by rejecting names beginning with a '.' in the keyctl.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
    cc: linux-ima-devel at lists.sourceforge.net
    cc: stable at vger.kernel.org
    Signed-off-by: James Morris <james.l.morris@oracle.com>

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 52c3453..ab082a2 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -273,7 +273,8 @@ long keyctl_get_keyring_ID(key_serial_t id, int create)
  * Create and join an anonymous session keyring or join a named session
  * keyring, creating it if necessary.  A named session keyring must have Search
  * permission for it to be joined.  Session keyrings without this permit will
- * be skipped over.
+ * be skipped over.  It is not permitted for userspace to create or join
+ * keyrings whose name begin with a dot.
  *
  * If successful, the ID of the joined session keyring will be returned.
  */
@@ -290,12 +291,16 @@ long keyctl_join_session_keyring(const char __user *_name)
 			ret = PTR_ERR(name);
 			goto error;
 		}
+
+		ret = -EPERM;
+		if (name[0] == '.')
+			goto error_name;
 	}
 
 	/* join the session */
 	ret = join_session_keyring(name);
+error_name:
 	kfree(name);
-
 error:
 	return ret;
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
