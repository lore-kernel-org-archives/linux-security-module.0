From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:52 -0700
Subject: [PATCH 16/17] doc: ReSTify keys-request-key.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-17-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under keys security devel index.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/filesystems/nfs/idmapper.txt         |  2 +-
 Documentation/networking/dns_resolver.txt          |  2 +-
 Documentation/security/00-INDEX                    |  2 -
 Documentation/security/keys/index.rst              |  1 +
 .../{keys-request-key.txt => keys/request-key.rst} | 69 +++++++++++-----------
 security/keys/request_key.c                        |  2 +-
 security/keys/request_key_auth.c                   |  2 +-
 7 files changed, 38 insertions(+), 42 deletions(-)
 rename Documentation/security/{keys-request-key.txt => keys/request-key.rst} (78%)

diff --git a/Documentation/filesystems/nfs/idmapper.txt b/Documentation/filesystems/nfs/idmapper.txt
index fe03d10bb79a..b86831acd583 100644
--- a/Documentation/filesystems/nfs/idmapper.txt
+++ b/Documentation/filesystems/nfs/idmapper.txt
@@ -55,7 +55,7 @@ request-key will find the first matching line and corresponding program.  In
 this case, /some/other/program will handle all uid lookups and
 /usr/sbin/nfs.idmap will handle gid, user, and group lookups.
 
-See <file:Documentation/security/keys-request-key.txt> for more information
+See <file:Documentation/security/keys/request-key.rst> for more information
 about the request-key function.
 
 
diff --git a/Documentation/networking/dns_resolver.txt b/Documentation/networking/dns_resolver.txt
index d86adcdae420..eaa8f9a6fd5d 100644
--- a/Documentation/networking/dns_resolver.txt
+++ b/Documentation/networking/dns_resolver.txt
@@ -143,7 +143,7 @@ the key will be discarded and recreated when the data it holds has expired.
 dns_query() returns a copy of the value attached to the key, or an error if
 that is indicated instead.
 
-See <file:Documentation/security/keys-request-key.txt> for further
+See <file:Documentation/security/keys/request-key.rst> for further
 information about request-key function.
 
 
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index 08a6e7a195ef..c8dbbc227326 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -1,6 +1,4 @@
 00-INDEX
 	- this file.
-keys-request-key.txt
-	- description of the kernel key request service.
 keys-trusted-encrypted.txt
 	- info on the Trusted and Encrypted keys in the kernel key ring service.
diff --git a/Documentation/security/keys/index.rst b/Documentation/security/keys/index.rst
index d34f663354bb..d7ddbc1c2502 100644
--- a/Documentation/security/keys/index.rst
+++ b/Documentation/security/keys/index.rst
@@ -7,3 +7,4 @@ Kernel Keys
 
    core
    ecryptfs
+   request-key
diff --git a/Documentation/security/keys-request-key.txt b/Documentation/security/keys/request-key.rst
similarity index 78%
rename from Documentation/security/keys-request-key.txt
rename to Documentation/security/keys/request-key.rst
index 51987bfecfed..5cdcee28479e 100644
--- a/Documentation/security/keys-request-key.txt
+++ b/Documentation/security/keys/request-key.rst
@@ -1,19 +1,19 @@
-			      ===================
-			      KEY REQUEST SERVICE
-			      ===================
+===================
+Key Request Service
+===================
 
 The key request service is part of the key retention service (refer to
 Documentation/security/keys.txt).  This document explains more fully how
 the requesting algorithm works.
 
 The process starts by either the kernel requesting a service by calling
-request_key*():
+``request_key*()``::
 
 	struct key *request_key(const struct key_type *type,
 				const char *description,
 				const char *callout_info);
 
-or:
+or::
 
 	struct key *request_key_with_auxdata(const struct key_type *type,
 					     const char *description,
@@ -21,14 +21,14 @@ or:
 					     size_t callout_len,
 					     void *aux);
 
-or:
+or::
 
 	struct key *request_key_async(const struct key_type *type,
 				      const char *description,
 				      const char *callout_info,
 				      size_t callout_len);
 
-or:
+or::
 
 	struct key *request_key_async_with_auxdata(const struct key_type *type,
 						   const char *description,
@@ -36,7 +36,7 @@ or:
 					     	   size_t callout_len,
 						   void *aux);
 
-Or by userspace invoking the request_key system call:
+Or by userspace invoking the request_key system call::
 
 	key_serial_t request_key(const char *type,
 				 const char *description,
@@ -67,38 +67,37 @@ own upcall mechanisms.  If they do, then those should be substituted for the
 forking and execution of /sbin/request-key.
 
 
-===========
-THE PROCESS
+The Process
 ===========
 
 A request proceeds in the following manner:
 
- (1) Process A calls request_key() [the userspace syscall calls the kernel
+  1) Process A calls request_key() [the userspace syscall calls the kernel
      interface].
 
- (2) request_key() searches the process's subscribed keyrings to see if there's
+  2) request_key() searches the process's subscribed keyrings to see if there's
      a suitable key there.  If there is, it returns the key.  If there isn't,
      and callout_info is not set, an error is returned.  Otherwise the process
      proceeds to the next step.
 
- (3) request_key() sees that A doesn't have the desired key yet, so it creates
+  3) request_key() sees that A doesn't have the desired key yet, so it creates
      two things:
 
-     (a) An uninstantiated key U of requested type and description.
+      a) An uninstantiated key U of requested type and description.
 
-     (b) An authorisation key V that refers to key U and notes that process A
+      b) An authorisation key V that refers to key U and notes that process A
      	 is the context in which key U should be instantiated and secured, and
      	 from which associated key requests may be satisfied.
 
- (4) request_key() then forks and executes /sbin/request-key with a new session
+  4) request_key() then forks and executes /sbin/request-key with a new session
      keyring that contains a link to auth key V.
 
- (5) /sbin/request-key assumes the authority associated with key U.
+  5) /sbin/request-key assumes the authority associated with key U.
 
- (6) /sbin/request-key execs an appropriate program to perform the actual
+  6) /sbin/request-key execs an appropriate program to perform the actual
      instantiation.
 
- (7) The program may want to access another key from A's context (say a
+  7) The program may want to access another key from A's context (say a
      Kerberos TGT key).  It just requests the appropriate key, and the keyring
      search notes that the session keyring has auth key V in its bottom level.
 
@@ -110,10 +109,10 @@ A request proceeds in the following manner:
      instantiate key U, using key W as a reference (perhaps it contacts a
      Kerberos server using the TGT) and then instantiates key U.
 
- (9) Upon instantiating key U, auth key V is automatically revoked so that it
+  9) Upon instantiating key U, auth key V is automatically revoked so that it
      may not be used again.
 
-(10) The program then exits 0 and request_key() deletes key V and returns key
+ 10) The program then exits 0 and request_key() deletes key V and returns key
      U to the caller.
 
 This also extends further.  If key W (step 7 above) didn't exist, key W would
@@ -127,8 +126,7 @@ This is because process A's keyrings can't simply be attached to
 of them, and (b) it requires the same UID/GID/Groups all the way through.
 
 
-====================================
-NEGATIVE INSTANTIATION AND REJECTION
+Negative Instantiation And Rejection
 ====================================
 
 Rather than instantiating a key, it is possible for the possessor of an
@@ -145,23 +143,22 @@ signal, the key under construction will be automatically negatively
 instantiated for a short amount of time.
 
 
-====================
-THE SEARCH ALGORITHM
+The Search Algorithm
 ====================
 
 A search of any particular keyring proceeds in the following fashion:
 
- (1) When the key management code searches for a key (keyring_search_aux) it
+  1) When the key management code searches for a key (keyring_search_aux) it
      firstly calls key_permission(SEARCH) on the keyring it's starting with,
      if this denies permission, it doesn't search further.
 
- (2) It considers all the non-keyring keys within that keyring and, if any key
+  2) It considers all the non-keyring keys within that keyring and, if any key
      matches the criteria specified, calls key_permission(SEARCH) on it to see
      if the key is allowed to be found.  If it is, that key is returned; if
      not, the search continues, and the error code is retained if of higher
      priority than the one currently set.
 
- (3) It then considers all the keyring-type keys in the keyring it's currently
+  3) It then considers all the keyring-type keys in the keyring it's currently
      searching.  It calls key_permission(SEARCH) on each keyring, and if this
      grants permission, it recurses, executing steps (2) and (3) on that
      keyring.
@@ -173,20 +170,20 @@ returned.
 When search_process_keyrings() is invoked, it performs the following searches
 until one succeeds:
 
- (1) If extant, the process's thread keyring is searched.
+  1) If extant, the process's thread keyring is searched.
 
- (2) If extant, the process's process keyring is searched.
+  2) If extant, the process's process keyring is searched.
 
- (3) The process's session keyring is searched.
+  3) The process's session keyring is searched.
 
- (4) If the process has assumed the authority associated with a request_key()
+  4) If the process has assumed the authority associated with a request_key()
      authorisation key then:
 
-     (a) If extant, the calling process's thread keyring is searched.
+      a) If extant, the calling process's thread keyring is searched.
 
-     (b) If extant, the calling process's process keyring is searched.
+      b) If extant, the calling process's process keyring is searched.
 
-     (c) The calling process's session keyring is searched.
+      c) The calling process's session keyring is searched.
 
 The moment one succeeds, all pending errors are discarded and the found key is
 returned.
@@ -194,7 +191,7 @@ returned.
 Only if all these fail does the whole thing fail with the highest priority
 error.  Note that several errors may have come from LSM.
 
-The error priority is:
+The error priority is::
 
 	EKEYREVOKED > EKEYEXPIRED > ENOKEY
 
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 9822e500d50d..63e63a42db3c 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -8,7 +8,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  *
- * See Documentation/security/keys-request-key.txt
+ * See Documentation/security/keys/request-key.rst
  */
 
 #include <linux/module.h>
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 0f062156dfb2..afe9d22ab361 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -8,7 +8,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  *
- * See Documentation/security/keys-request-key.txt
+ * See Documentation/security/keys/request-key.rst
  */
 
 #include <linux/module.h>
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
