From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:50 -0700
Subject: [PATCH 14/17] doc: ReSTify keys.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-15-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This creates a new section in the security development index for kernel
keys, and adjusts for ReST markup.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/crypto/asymmetric-keys.txt           |   2 +-
 Documentation/security/00-INDEX                    |   2 -
 Documentation/security/index.rst                   |   1 +
 Documentation/security/{keys.txt => keys/core.rst} | 314 ++++++++++-----------
 Documentation/security/keys/index.rst              |   8 +
 MAINTAINERS                                        |   2 +-
 include/linux/key.h                                |   2 +-
 7 files changed, 163 insertions(+), 168 deletions(-)
 rename Documentation/security/{keys.txt => keys/core.rst} (89%)
 create mode 100644 Documentation/security/keys/index.rst

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 5ad6480e3fb9..b82b6ad48488 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -265,7 +265,7 @@ mandatory:
 
      The caller passes a pointer to the following struct with all of the fields
      cleared, except for data, datalen and quotalen [see
-     Documentation/security/keys.txt].
+     Documentation/security/keys/core.rst].
 
 	struct key_preparsed_payload {
 		char		*description;
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index cdb2294ec047..a840095bb11c 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -6,5 +6,3 @@ keys-request-key.txt
 	- description of the kernel key request service.
 keys-trusted-encrypted.txt
 	- info on the Trusted and Encrypted keys in the kernel key ring service.
-keys.txt
-	- description of the kernel key retention service.
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 94ba1cfc01c5..298a94a33f05 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -7,6 +7,7 @@ Security Documentation
 
    credentials
    IMA-templates
+   keys/index
    LSM
    self-protection
    tpm/index
diff --git a/Documentation/security/keys.txt b/Documentation/security/keys/core.rst
similarity index 89%
rename from Documentation/security/keys.txt
rename to Documentation/security/keys/core.rst
index cd5019934d7f..0d831a7afe4f 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys/core.rst
@@ -1,6 +1,6 @@
-			 ============================
-			 KERNEL KEY RETENTION SERVICE
-			 ============================
+============================
+Kernel Key Retention Service
+============================
 
 This service allows cryptographic keys, authentication tokens, cross-domain
 user mappings, and similar to be cached in the kernel for the use of
@@ -29,8 +29,7 @@ This document has the following sections:
 	- Garbage collection
 
 
-============
-KEY OVERVIEW
+Key Overview
 ============
 
 In this context, keys represent units of cryptographic data, authentication
@@ -47,14 +46,14 @@ Each key has a number of attributes:
 	- State.
 
 
- (*) Each key is issued a serial number of type key_serial_t that is unique for
+  *  Each key is issued a serial number of type key_serial_t that is unique for
      the lifetime of that key. All serial numbers are positive non-zero 32-bit
      integers.
 
      Userspace programs can use a key's serial numbers as a way to gain access
      to it, subject to permission checking.
 
- (*) Each key is of a defined "type". Types must be registered inside the
+  *  Each key is of a defined "type". Types must be registered inside the
      kernel by a kernel service (such as a filesystem) before keys of that type
      can be added or used. Userspace programs cannot define new types directly.
 
@@ -64,18 +63,18 @@ Each key has a number of attributes:
      Should a type be removed from the system, all the keys of that type will
      be invalidated.
 
- (*) Each key has a description. This should be a printable string. The key
+  *  Each key has a description. This should be a printable string. The key
      type provides an operation to perform a match between the description on a
      key and a criterion string.
 
- (*) Each key has an owner user ID, a group ID and a permissions mask. These
+  *  Each key has an owner user ID, a group ID and a permissions mask. These
      are used to control what a process may do to a key from userspace, and
      whether a kernel service will be able to find the key.
 
- (*) Each key can be set to expire at a specific time by the key type's
+  *  Each key can be set to expire at a specific time by the key type's
      instantiation function. Keys can also be immortal.
 
- (*) Each key can have a payload. This is a quantity of data that represent the
+  *  Each key can have a payload. This is a quantity of data that represent the
      actual "key". In the case of a keyring, this is a list of keys to which
      the keyring links; in the case of a user-defined key, it's an arbitrary
      blob of data.
@@ -91,39 +90,38 @@ Each key has a number of attributes:
      permitted, another key type operation will be called to convert the key's
      attached payload back into a blob of data.
 
- (*) Each key can be in one of a number of basic states:
+  *  Each key can be in one of a number of basic states:
 
-     (*) Uninstantiated. The key exists, but does not have any data attached.
+      *  Uninstantiated. The key exists, but does not have any data attached.
      	 Keys being requested from userspace will be in this state.
 
-     (*) Instantiated. This is the normal state. The key is fully formed, and
+      *  Instantiated. This is the normal state. The key is fully formed, and
 	 has data attached.
 
-     (*) Negative. This is a relatively short-lived state. The key acts as a
+      *  Negative. This is a relatively short-lived state. The key acts as a
 	 note saying that a previous call out to userspace failed, and acts as
 	 a throttle on key lookups. A negative key can be updated to a normal
 	 state.
 
-     (*) Expired. Keys can have lifetimes set. If their lifetime is exceeded,
+      *  Expired. Keys can have lifetimes set. If their lifetime is exceeded,
 	 they traverse to this state. An expired key can be updated back to a
 	 normal state.
 
-     (*) Revoked. A key is put in this state by userspace action. It can't be
+      *  Revoked. A key is put in this state by userspace action. It can't be
 	 found or operated upon (apart from by unlinking it).
 
-     (*) Dead. The key's type was unregistered, and so the key is now useless.
+      *  Dead. The key's type was unregistered, and so the key is now useless.
 
 Keys in the last three states are subject to garbage collection.  See the
 section on "Garbage collection".
 
 
-====================
-KEY SERVICE OVERVIEW
+Key Service Overview
 ====================
 
 The key service provides a number of features besides keys:
 
- (*) The key service defines three special key types:
+  *  The key service defines three special key types:
 
      (+) "keyring"
 
@@ -149,7 +147,7 @@ The key service provides a number of features besides keys:
 	 be created and updated from userspace, but the payload is only
 	 readable from kernel space.
 
- (*) Each process subscribes to three keyrings: a thread-specific keyring, a
+  *  Each process subscribes to three keyrings: a thread-specific keyring, a
      process-specific keyring, and a session-specific keyring.
 
      The thread-specific keyring is discarded from the child when any sort of
@@ -170,7 +168,7 @@ The key service provides a number of features besides keys:
      The ownership of the thread keyring changes when the real UID and GID of
      the thread changes.
 
- (*) Each user ID resident in the system holds two special keyrings: a user
+  *  Each user ID resident in the system holds two special keyrings: a user
      specific keyring and a default user session keyring. The default session
      keyring is initialised with a link to the user-specific keyring.
 
@@ -180,7 +178,7 @@ The key service provides a number of features besides keys:
      If a process attempts to access its session key when it doesn't have one,
      it will be subscribed to the default for its current UID.
 
- (*) Each user has two quotas against which the keys they own are tracked. One
+  *  Each user has two quotas against which the keys they own are tracked. One
      limits the total number of keys and keyrings, the other limits the total
      amount of description and payload space that can be consumed.
 
@@ -194,54 +192,53 @@ The key service provides a number of features besides keys:
      If a system call that modifies a key or keyring in some way would put the
      user over quota, the operation is refused and error EDQUOT is returned.
 
- (*) There's a system call interface by which userspace programs can create and
+  *  There's a system call interface by which userspace programs can create and
      manipulate keys and keyrings.
 
- (*) There's a kernel interface by which services can register types and search
+  *  There's a kernel interface by which services can register types and search
      for keys.
 
- (*) There's a way for the a search done from the kernel to call back to
+  *  There's a way for the a search done from the kernel to call back to
      userspace to request a key that can't be found in a process's keyrings.
 
- (*) An optional filesystem is available through which the key database can be
+  *  An optional filesystem is available through which the key database can be
      viewed and manipulated.
 
 
-======================
-KEY ACCESS PERMISSIONS
+Key Access Permissions
 ======================
 
 Keys have an owner user ID, a group access ID, and a permissions mask. The mask
 has up to eight bits each for possessor, user, group and other access. Only
 six of each set of eight bits are defined. These permissions granted are:
 
- (*) View
+  *  View
 
      This permits a key or keyring's attributes to be viewed - including key
      type and description.
 
- (*) Read
+  *  Read
 
      This permits a key's payload to be viewed or a keyring's list of linked
      keys.
 
- (*) Write
+  *  Write
 
      This permits a key's payload to be instantiated or updated, or it allows a
      link to be added to or removed from a keyring.
 
- (*) Search
+  *  Search
 
      This permits keyrings to be searched and keys to be found. Searches can
      only recurse into nested keyrings that have search permission set.
 
- (*) Link
+  *  Link
 
      This permits a key or keyring to be linked to. To create a link from a
      keyring to a key, a process must have Write permission on the keyring and
      Link permission on the key.
 
- (*) Set Attribute
+  *  Set Attribute
 
      This permits a key's UID, GID and permissions mask to be changed.
 
@@ -249,8 +246,7 @@ For changing the ownership, group ID or permissions mask, being the owner of
 the key or having the sysadmin capability is sufficient.
 
 
-===============
-SELINUX SUPPORT
+SELinux Support
 ===============
 
 The security class "key" has been added to SELinux so that mandatory access
@@ -282,14 +278,13 @@ their associated thread, and both session and process keyrings are handled
 similarly.
 
 
-================
-NEW PROCFS FILES
+New ProcFS Files
 ================
 
 Two files have been added to procfs by which an administrator can find out
 about the status of the key service:
 
- (*) /proc/keys
+  *  /proc/keys
 
      This lists the keys that are currently viewable by the task reading the
      file, giving information about their type, description and permissions.
@@ -301,7 +296,7 @@ about the status of the key service:
      security checks are still performed, and may further filter out keys that
      the current process is not authorised to view.
 
-     The contents of the file look like this:
+     The contents of the file look like this::
 
 	SERIAL   FLAGS  USAGE EXPY PERM     UID   GID   TYPE      DESCRIPTION: SUMMARY
 	00000001 I-----    39 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
@@ -314,7 +309,7 @@ about the status of the key service:
 	00000893 I--Q-N     1  35s 1f3f0000     0     0 user      metal:silver: 0
 	00000894 I--Q--     1  10h 003f0000     0     0 user      metal:gold: 0
 
-     The flags are:
+     The flags are::
 
 	I	Instantiated
 	R	Revoked
@@ -324,10 +319,10 @@ about the status of the key service:
 	N	Negative key
 
 
- (*) /proc/key-users
+  *  /proc/key-users
 
      This file lists the tracking data for each user that has at least one key
-     on the system.  Such data includes quota information and statistics:
+     on the system.  Such data includes quota information and statistics::
 
 	[root at andromeda root]# cat /proc/key-users
 	0:     46 45/45 1/100 13/10000
@@ -335,7 +330,8 @@ about the status of the key service:
 	32:     2 2/2 2/100 40/10000
 	38:     2 2/2 2/100 40/10000
 
-     The format of each line is
+     The format of each line is::
+
 	<UID>:			User ID to which this applies
 	<usage>			Structure refcount
 	<inst>/<keys>		Total number of keys and number instantiated
@@ -346,14 +342,14 @@ about the status of the key service:
 Four new sysctl files have been added also for the purpose of controlling the
 quota limits on keys:
 
- (*) /proc/sys/kernel/keys/root_maxkeys
+  *  /proc/sys/kernel/keys/root_maxkeys
      /proc/sys/kernel/keys/root_maxbytes
 
      These files hold the maximum number of keys that root may have and the
      maximum total number of bytes of data that root may have stored in those
      keys.
 
- (*) /proc/sys/kernel/keys/maxkeys
+  *  /proc/sys/kernel/keys/maxkeys
      /proc/sys/kernel/keys/maxbytes
 
      These files hold the maximum number of keys that each non-root user may
@@ -364,8 +360,7 @@ Root may alter these by writing each new limit as a decimal number string to
 the appropriate file.
 
 
-===============================
-USERSPACE SYSTEM CALL INTERFACE
+Userspace System Call Interface
 ===============================
 
 Userspace can manipulate keys directly through three new syscalls: add_key,
@@ -375,7 +370,7 @@ manipulating keys.
 When referring to a key directly, userspace programs should use the key's
 serial number (a positive 32-bit integer). However, there are some special
 values available for referring to special keys and keyrings that relate to the
-process making the call:
+process making the call::
 
 	CONSTANT			VALUE	KEY REFERENCED
 	==============================	======	===========================
@@ -391,8 +386,8 @@ process making the call:
 
 The main syscalls are:
 
- (*) Create a new key of given type, description and payload and add it to the
-     nominated keyring:
+  *  Create a new key of given type, description and payload and add it to the
+     nominated keyring::
 
 	key_serial_t add_key(const char *type, const char *desc,
 			     const void *payload, size_t plen,
@@ -432,8 +427,8 @@ The main syscalls are:
      The ID of the new or updated key is returned if successful.
 
 
- (*) Search the process's keyrings for a key, potentially calling out to
-     userspace to create it.
+  *  Search the process's keyrings for a key, potentially calling out to
+     userspace to create it::
 
 	key_serial_t request_key(const char *type, const char *description,
 				 const char *callout_info,
@@ -453,7 +448,7 @@ The main syscalls are:
 
 The keyctl syscall functions are:
 
- (*) Map a special key ID to a real key ID for this process:
+  *  Map a special key ID to a real key ID for this process::
 
 	key_serial_t keyctl(KEYCTL_GET_KEYRING_ID, key_serial_t id,
 			    int create);
@@ -466,7 +461,7 @@ The keyctl syscall functions are:
      non-zero; and the error ENOKEY will be returned if "create" is zero.
 
 
- (*) Replace the session keyring this process subscribes to with a new one:
+  *  Replace the session keyring this process subscribes to with a new one::
 
 	key_serial_t keyctl(KEYCTL_JOIN_SESSION_KEYRING, const char *name);
 
@@ -484,7 +479,7 @@ The keyctl syscall functions are:
      The ID of the new session keyring is returned if successful.
 
 
- (*) Update the specified key:
+  *  Update the specified key::
 
 	long keyctl(KEYCTL_UPDATE, key_serial_t key, const void *payload,
 		    size_t plen);
@@ -498,7 +493,7 @@ The keyctl syscall functions are:
      add_key().
 
 
- (*) Revoke a key:
+  *  Revoke a key::
 
 	long keyctl(KEYCTL_REVOKE, key_serial_t key);
 
@@ -507,7 +502,7 @@ The keyctl syscall functions are:
      be findable.
 
 
- (*) Change the ownership of a key:
+  *  Change the ownership of a key::
 
 	long keyctl(KEYCTL_CHOWN, key_serial_t key, uid_t uid, gid_t gid);
 
@@ -520,7 +515,7 @@ The keyctl syscall functions are:
      its group list members.
 
 
- (*) Change the permissions mask on a key:
+  *  Change the permissions mask on a key::
 
 	long keyctl(KEYCTL_SETPERM, key_serial_t key, key_perm_t perm);
 
@@ -531,7 +526,7 @@ The keyctl syscall functions are:
      error EINVAL will be returned.
 
 
- (*) Describe a key:
+  *  Describe a key::
 
 	long keyctl(KEYCTL_DESCRIBE, key_serial_t key, char *buffer,
 		    size_t buflen);
@@ -547,7 +542,7 @@ The keyctl syscall functions are:
      A process must have view permission on the key for this function to be
      successful.
 
-     If successful, a string is placed in the buffer in the following format:
+     If successful, a string is placed in the buffer in the following format::
 
 	<type>;<uid>;<gid>;<perm>;<description>
 
@@ -555,12 +550,12 @@ The keyctl syscall functions are:
      is hexadecimal. A NUL character is included at the end of the string if
      the buffer is sufficiently big.
 
-     This can be parsed with
+     This can be parsed with::
 
 	sscanf(buffer, "%[^;];%d;%d;%o;%s", type, &uid, &gid, &mode, desc);
 
 
- (*) Clear out a keyring:
+  *  Clear out a keyring::
 
 	long keyctl(KEYCTL_CLEAR, key_serial_t keyring);
 
@@ -573,7 +568,7 @@ The keyctl syscall functions are:
      DNS resolver cache keyring is an example of this.
 
 
- (*) Link a key into a keyring:
+  *  Link a key into a keyring::
 
 	long keyctl(KEYCTL_LINK, key_serial_t keyring, key_serial_t key);
 
@@ -592,7 +587,7 @@ The keyctl syscall functions are:
      added.
 
 
- (*) Unlink a key or keyring from another keyring:
+  *  Unlink a key or keyring from another keyring::
 
 	long keyctl(KEYCTL_UNLINK, key_serial_t keyring, key_serial_t key);
 
@@ -604,7 +599,7 @@ The keyctl syscall functions are:
      is not present, error ENOENT will be the result.
 
 
- (*) Search a keyring tree for a key:
+  *  Search a keyring tree for a key::
 
 	key_serial_t keyctl(KEYCTL_SEARCH, key_serial_t keyring,
 			    const char *type, const char *description,
@@ -628,7 +623,7 @@ The keyctl syscall functions are:
      fails. On success, the resulting key ID will be returned.
 
 
- (*) Read the payload data from a key:
+  *  Read the payload data from a key::
 
 	long keyctl(KEYCTL_READ, key_serial_t keyring, char *buffer,
 		    size_t buflen);
@@ -650,7 +645,7 @@ The keyctl syscall functions are:
      available rather than the amount copied.
 
 
- (*) Instantiate a partially constructed key.
+  *  Instantiate a partially constructed key::
 
 	long keyctl(KEYCTL_INSTANTIATE, key_serial_t key,
 		    const void *payload, size_t plen,
@@ -677,7 +672,7 @@ The keyctl syscall functions are:
      array instead of a single buffer.
 
 
- (*) Negatively instantiate a partially constructed key.
+  *  Negatively instantiate a partially constructed key::
 
 	long keyctl(KEYCTL_NEGATE, key_serial_t key,
 		    unsigned timeout, key_serial_t keyring);
@@ -700,12 +695,12 @@ The keyctl syscall functions are:
      as rejecting the key with ENOKEY as the error code.
 
 
- (*) Set the default request-key destination keyring.
+  *  Set the default request-key destination keyring::
 
 	long keyctl(KEYCTL_SET_REQKEY_KEYRING, int reqkey_defl);
 
      This sets the default keyring to which implicitly requested keys will be
-     attached for this thread. reqkey_defl should be one of these constants:
+     attached for this thread. reqkey_defl should be one of these constants::
 
 	CONSTANT				VALUE	NEW DEFAULT KEYRING
 	======================================	======	=======================
@@ -731,7 +726,7 @@ The keyctl syscall functions are:
      there is one, otherwise the user default session keyring.
 
 
- (*) Set the timeout on a key.
+  *  Set the timeout on a key::
 
 	long keyctl(KEYCTL_SET_TIMEOUT, key_serial_t key, unsigned timeout);
 
@@ -744,7 +739,7 @@ The keyctl syscall functions are:
      or expired keys.
 
 
- (*) Assume the authority granted to instantiate a key
+  *  Assume the authority granted to instantiate a key::
 
 	long keyctl(KEYCTL_ASSUME_AUTHORITY, key_serial_t key);
 
@@ -766,7 +761,7 @@ The keyctl syscall functions are:
      The assumed authoritative key is inherited across fork and exec.
 
 
- (*) Get the LSM security context attached to a key.
+  *  Get the LSM security context attached to a key::
 
 	long keyctl(KEYCTL_GET_SECURITY, key_serial_t key, char *buffer,
 		    size_t buflen)
@@ -787,7 +782,7 @@ The keyctl syscall functions are:
      successful.
 
 
- (*) Install the calling process's session keyring on its parent.
+  *  Install the calling process's session keyring on its parent::
 
 	long keyctl(KEYCTL_SESSION_TO_PARENT);
 
@@ -807,7 +802,7 @@ The keyctl syscall functions are:
      kernel and resumes executing userspace.
 
 
- (*) Invalidate a key.
+  *  Invalidate a key::
 
 	long keyctl(KEYCTL_INVALIDATE, key_serial_t key);
 
@@ -823,20 +818,19 @@ The keyctl syscall functions are:
      A process must have search permission on the key for this function to be
      successful.
 
- (*) Compute a Diffie-Hellman shared secret or public key
+  *  Compute a Diffie-Hellman shared secret or public key::
 
-       long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,
-		   char *buffer, size_t buflen,
-		   struct keyctl_kdf_params *kdf);
+	long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,
+		    char *buffer, size_t buflen, struct keyctl_kdf_params *kdf);
 
-     The params struct contains serial numbers for three keys:
+     The params struct contains serial numbers for three keys::
 
 	 - The prime, p, known to both parties
 	 - The local private key
 	 - The base integer, which is either a shared generator or the
 	   remote public key
 
-     The value computed is:
+     The value computed is::
 
 	result = base ^ private (mod prime)
 
@@ -858,12 +852,12 @@ The keyctl syscall functions are:
      of the KDF is returned to the caller. The KDF is characterized with
      struct keyctl_kdf_params as follows:
 
-	 - char *hashname specifies the NUL terminated string identifying
+	 - ``char *hashname`` specifies the NUL terminated string identifying
 	   the hash used from the kernel crypto API and applied for the KDF
 	   operation. The KDF implemenation complies with SP800-56A as well
 	   as with SP800-108 (the counter KDF).
 
-	 - char *otherinfo specifies the OtherInfo data as documented in
+	 - ``char *otherinfo`` specifies the OtherInfo data as documented in
 	   SP800-56A section 5.8.1.2. The length of the buffer is given with
 	   otherinfolen. The format of OtherInfo is defined by the caller.
 	   The otherinfo pointer may be NULL if no OtherInfo shall be used.
@@ -875,10 +869,10 @@ The keyctl syscall functions are:
      and either the buffer length or the OtherInfo length exceeds the
      allowed length.
 
- (*) Restrict keyring linkage
+  *  Restrict keyring linkage::
 
-       long keyctl(KEYCTL_RESTRICT_KEYRING, key_serial_t keyring,
-		   const char *type, const char *restriction);
+	long keyctl(KEYCTL_RESTRICT_KEYRING, key_serial_t keyring,
+		    const char *type, const char *restriction);
 
      An existing keyring can restrict linkage of additional keys by evaluating
      the contents of the key according to a restriction scheme.
@@ -900,8 +894,7 @@ The keyctl syscall functions are:
      To apply a keyring restriction the process must have Set Attribute
      permission and the keyring must not be previously restricted.
 
-===============
-KERNEL SERVICES
+Kernel Services
 ===============
 
 The kernel services for key management are fairly simple to deal with. They can
@@ -915,29 +908,29 @@ call, and the key released upon close. How to deal with conflicting keys due to
 two different users opening the same file is left to the filesystem author to
 solve.
 
-To access the key manager, the following header must be #included:
+To access the key manager, the following header must be #included::
 
 	<linux/key.h>
 
 Specific key types should have a header file under include/keys/ that should be
-used to access that type.  For keys of type "user", for example, that would be:
+used to access that type.  For keys of type "user", for example, that would be::
 
 	<keys/user-type.h>
 
 Note that there are two different types of pointers to keys that may be
 encountered:
 
- (*) struct key *
+  *  struct key *
 
      This simply points to the key structure itself. Key structures will be at
      least four-byte aligned.
 
- (*) key_ref_t
+  *  key_ref_t
 
-     This is equivalent to a struct key *, but the least significant bit is set
+     This is equivalent to a ``struct key *``, but the least significant bit is set
      if the caller "possesses" the key. By "possession" it is meant that the
      calling processes has a searchable link to the key from one of its
-     keyrings. There are three functions for dealing with these:
+     keyrings. There are three functions for dealing with these::
 
 	key_ref_t make_key_ref(const struct key *key, bool possession);
 
@@ -955,7 +948,7 @@ When accessing a key's payload contents, certain precautions must be taken to
 prevent access vs modification races. See the section "Notes on accessing
 payload contents" for more information.
 
-(*) To search for a key, call:
+ *  To search for a key, call::
 
 	struct key *request_key(const struct key_type *type,
 				const char *description,
@@ -977,7 +970,7 @@ payload contents" for more information.
     See also Documentation/security/keys-request-key.txt.
 
 
-(*) To search for a key, passing auxiliary data to the upcaller, call:
+ *  To search for a key, passing auxiliary data to the upcaller, call::
 
 	struct key *request_key_with_auxdata(const struct key_type *type,
 					     const char *description,
@@ -990,14 +983,14 @@ payload contents" for more information.
     is a blob of length callout_len, if given (the length may be 0).
 
 
-(*) A key can be requested asynchronously by calling one of:
+ *  A key can be requested asynchronously by calling one of::
 
 	struct key *request_key_async(const struct key_type *type,
 				      const char *description,
 				      const void *callout_info,
 				      size_t callout_len);
 
-    or:
+    or::
 
 	struct key *request_key_async_with_auxdata(const struct key_type *type,
 						   const char *description,
@@ -1010,7 +1003,7 @@ payload contents" for more information.
 
     These two functions return with the key potentially still under
     construction.  To wait for construction completion, the following should be
-    called:
+    called::
 
 	int wait_for_key_construction(struct key *key, bool intr);
 
@@ -1022,11 +1015,11 @@ payload contents" for more information.
     case error ERESTARTSYS will be returned.
 
 
-(*) When it is no longer required, the key should be released using:
+ *  When it is no longer required, the key should be released using::
 
 	void key_put(struct key *key);
 
-    Or:
+    Or::
 
 	void key_ref_put(key_ref_t key_ref);
 
@@ -1034,8 +1027,8 @@ payload contents" for more information.
     the argument will not be parsed.
 
 
-(*) Extra references can be made to a key by calling one of the following
-    functions:
+ *  Extra references can be made to a key by calling one of the following
+    functions::
 
 	struct key *__key_get(struct key *key);
 	struct key *key_get(struct key *key);
@@ -1047,7 +1040,7 @@ payload contents" for more information.
     then the key will not be dereferenced and no increment will take place.
 
 
-(*) A key's serial number can be obtained by calling:
+ *  A key's serial number can be obtained by calling::
 
 	key_serial_t key_serial(struct key *key);
 
@@ -1055,7 +1048,7 @@ payload contents" for more information.
     latter case without parsing the argument).
 
 
-(*) If a keyring was found in the search, this can be further searched by:
+ *  If a keyring was found in the search, this can be further searched by::
 
 	key_ref_t keyring_search(key_ref_t keyring_ref,
 				 const struct key_type *type,
@@ -1070,7 +1063,7 @@ payload contents" for more information.
     reference pointer if successful.
 
 
-(*) A keyring can be created by:
+ *  A keyring can be created by::
 
 	struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
 				  const struct cred *cred,
@@ -1109,7 +1102,7 @@ payload contents" for more information.
     -EPERM to in this case.
 
 
-(*) To check the validity of a key, this function can be called:
+ *  To check the validity of a key, this function can be called::
 
 	int validate_key(struct key *key);
 
@@ -1119,7 +1112,7 @@ payload contents" for more information.
     returned (in the latter case without parsing the argument).
 
 
-(*) To register a key type, the following function should be called:
+ *  To register a key type, the following function should be called::
 
 	int register_key_type(struct key_type *type);
 
@@ -1127,13 +1120,13 @@ payload contents" for more information.
     present.
 
 
-(*) To unregister a key type, call:
+ *  To unregister a key type, call::
 
 	void unregister_key_type(struct key_type *type);
 
 
 Under some circumstances, it may be desirable to deal with a bundle of keys.
-The facility provides access to the keyring type for managing such a bundle:
+The facility provides access to the keyring type for managing such a bundle::
 
 	struct key_type key_type_keyring;
 
@@ -1143,8 +1136,7 @@ with keyring_search().  Note that it is not possible to use request_key() to
 search a specific keyring, so using keyrings in this way is of limited utility.
 
 
-===================================
-NOTES ON ACCESSING PAYLOAD CONTENTS
+Notes On Accessing Payload Contents
 ===================================
 
 The simplest payload is just data stored in key->payload directly.  In this
@@ -1154,31 +1146,31 @@ More complex payload contents must be allocated and pointers to them set in the
 key->payload.data[] array.  One of the following ways must be selected to
 access the data:
 
- (1) Unmodifiable key type.
+  1) Unmodifiable key type.
 
      If the key type does not have a modify method, then the key's payload can
      be accessed without any form of locking, provided that it's known to be
      instantiated (uninstantiated keys cannot be "found").
 
- (2) The key's semaphore.
+  2) The key's semaphore.
 
      The semaphore could be used to govern access to the payload and to control
      the payload pointer. It must be write-locked for modifications and would
      have to be read-locked for general access. The disadvantage of doing this
      is that the accessor may be required to sleep.
 
- (3) RCU.
+  3) RCU.
 
      RCU must be used when the semaphore isn't already held; if the semaphore
      is held then the contents can't change under you unexpectedly as the
      semaphore must still be used to serialise modifications to the key. The
      key management code takes care of this for the key type.
 
-     However, this means using:
+     However, this means using::
 
 	rcu_read_lock() ... rcu_dereference() ... rcu_read_unlock()
 
-     to read the pointer, and:
+     to read the pointer, and::
 
 	rcu_dereference() ... rcu_assign_pointer() ... call_rcu()
 
@@ -1194,11 +1186,11 @@ access the data:
      usage.  This is called key->payload.rcu_data0.  The following accessors
      wrap the RCU calls to this element:
 
-     (a) Set or change the first payload pointer:
+     a) Set or change the first payload pointer::
 
 		rcu_assign_keypointer(struct key *key, void *data);
 
-     (b) Read the first payload pointer with the key semaphore held:
+     b) Read the first payload pointer with the key semaphore held::
 
 		[const] void *dereference_key_locked([const] struct key *key);
 
@@ -1206,39 +1198,38 @@ access the data:
 	 parameter.  Static analysis will give an error if it things the lock
 	 isn't held.
 
-     (c) Read the first payload pointer with the RCU read lock held:
+     c) Read the first payload pointer with the RCU read lock held::
 
 		const void *dereference_key_rcu(const struct key *key);
 
 
-===================
-DEFINING A KEY TYPE
+Defining a Key Type
 ===================
 
 A kernel service may want to define its own key type. For instance, an AFS
 filesystem might want to define a Kerberos 5 ticket key type. To do this, it
 author fills in a key_type struct and registers it with the system.
 
-Source files that implement key types should include the following header file:
+Source files that implement key types should include the following header file::
 
 	<linux/key-type.h>
 
 The structure has a number of fields, some of which are mandatory:
 
- (*) const char *name
+  *  ``const char *name``
 
      The name of the key type. This is used to translate a key type name
      supplied by userspace into a pointer to the structure.
 
 
- (*) size_t def_datalen
+  *  ``size_t def_datalen``
 
      This is optional - it supplies the default payload data length as
      contributed to the quota. If the key type's payload is always or almost
      always the same size, then this is a more efficient way to do things.
 
      The data length (and quota) on a particular key can always be changed
-     during instantiation or update by calling:
+     during instantiation or update by calling::
 
 	int key_payload_reserve(struct key *key, size_t datalen);
 
@@ -1246,18 +1237,18 @@ The structure has a number of fields, some of which are mandatory:
      viable.
 
 
- (*) int (*vet_description)(const char *description);
+  *  ``int (*vet_description)(const char *description);``
 
      This optional method is called to vet a key description.  If the key type
      doesn't approve of the key description, it may return an error, otherwise
      it should return 0.
 
 
- (*) int (*preparse)(struct key_preparsed_payload *prep);
+  *  ``int (*preparse)(struct key_preparsed_payload *prep);``
 
      This optional method permits the key type to attempt to parse payload
      before a key is created (add key) or the key semaphore is taken (update or
-     instantiate key).  The structure pointed to by prep looks like:
+     instantiate key).  The structure pointed to by prep looks like::
 
 	struct key_preparsed_payload {
 		char		*description;
@@ -1285,7 +1276,7 @@ The structure has a number of fields, some of which are mandatory:
      otherwise.
 
 
- (*) void (*free_preparse)(struct key_preparsed_payload *prep);
+  *  ``void (*free_preparse)(struct key_preparsed_payload *prep);``
 
      This method is only required if the preparse() method is provided,
      otherwise it is unused.  It cleans up anything attached to the description
@@ -1294,7 +1285,7 @@ The structure has a number of fields, some of which are mandatory:
      successfully, even if instantiate() or update() succeed.
 
 
- (*) int (*instantiate)(struct key *key, struct key_preparsed_payload *prep);
+  *  ``int (*instantiate)(struct key *key, struct key_preparsed_payload *prep);``
 
      This method is called to attach a payload to a key during construction.
      The payload attached need not bear any relation to the data passed to this
@@ -1318,7 +1309,7 @@ The structure has a number of fields, some of which are mandatory:
      free_preparse method doesn't release the data.
 
 
- (*) int (*update)(struct key *key, const void *data, size_t datalen);
+  *  ``int (*update)(struct key *key, const void *data, size_t datalen);``
 
      If this type of key can be updated, then this method should be provided.
      It is called to update a key's payload from the blob of data provided.
@@ -1343,10 +1334,10 @@ The structure has a number of fields, some of which are mandatory:
      It is safe to sleep in this method.
 
 
- (*) int (*match_preparse)(struct key_match_data *match_data);
+  *  ``int (*match_preparse)(struct key_match_data *match_data);``
 
      This method is optional.  It is called when a key search is about to be
-     performed.  It is given the following structure:
+     performed.  It is given the following structure::
 
 	struct key_match_data {
 		bool (*cmp)(const struct key *key,
@@ -1357,23 +1348,23 @@ The structure has a number of fields, some of which are mandatory:
 	};
 
      On entry, raw_data will be pointing to the criteria to be used in matching
-     a key by the caller and should not be modified.  (*cmp)() will be pointing
+     a key by the caller and should not be modified.  ``(*cmp)()`` will be pointing
      to the default matcher function (which does an exact description match
      against raw_data) and lookup_type will be set to indicate a direct lookup.
 
      The following lookup_type values are available:
 
-      [*] KEYRING_SEARCH_LOOKUP_DIRECT - A direct lookup hashes the type and
+       *  KEYRING_SEARCH_LOOKUP_DIRECT - A direct lookup hashes the type and
       	  description to narrow down the search to a small number of keys.
 
-      [*] KEYRING_SEARCH_LOOKUP_ITERATE - An iterative lookup walks all the
+       *  KEYRING_SEARCH_LOOKUP_ITERATE - An iterative lookup walks all the
       	  keys in the keyring until one is matched.  This must be used for any
       	  search that's not doing a simple direct match on the key description.
 
      The method may set cmp to point to a function of its choice that does some
      other form of match, may set lookup_type to KEYRING_SEARCH_LOOKUP_ITERATE
-     and may attach something to the preparsed pointer for use by (*cmp)().
-     (*cmp)() should return true if a key matches and false otherwise.
+     and may attach something to the preparsed pointer for use by ``(*cmp)()``.
+     ``(*cmp)()`` should return true if a key matches and false otherwise.
 
      If preparsed is set, it may be necessary to use the match_free() method to
      clean it up.
@@ -1381,20 +1372,20 @@ The structure has a number of fields, some of which are mandatory:
      The method should return 0 if successful or a negative error code
      otherwise.
 
-     It is permitted to sleep in this method, but (*cmp)() may not sleep as
+     It is permitted to sleep in this method, but ``(*cmp)()`` may not sleep as
      locks will be held over it.
 
      If match_preparse() is not provided, keys of this type will be matched
      exactly by their description.
 
 
- (*) void (*match_free)(struct key_match_data *match_data);
+  *  ``void (*match_free)(struct key_match_data *match_data);``
 
      This method is optional.  If given, it called to clean up
      match_data->preparsed after a successful call to match_preparse().
 
 
- (*) void (*revoke)(struct key *key);
+  *  ``void (*revoke)(struct key *key);``
 
      This method is optional.  It is called to discard part of the payload
      data upon a key being revoked.  The caller will have the key semaphore
@@ -1404,7 +1395,7 @@ The structure has a number of fields, some of which are mandatory:
      a deadlock against the key semaphore.
 
 
- (*) void (*destroy)(struct key *key);
+  *  ``void (*destroy)(struct key *key);``
 
      This method is optional. It is called to discard the payload data on a key
      when it is being destroyed.
@@ -1416,7 +1407,7 @@ The structure has a number of fields, some of which are mandatory:
      It is not safe to sleep in this method; the caller may hold spinlocks.
 
 
- (*) void (*describe)(const struct key *key, struct seq_file *p);
+  *  ``void (*describe)(const struct key *key, struct seq_file *p);``
 
      This method is optional. It is called during /proc/keys reading to
      summarise a key's description and payload in text form.
@@ -1432,7 +1423,7 @@ The structure has a number of fields, some of which are mandatory:
      caller.
 
 
- (*) long (*read)(const struct key *key, char __user *buffer, size_t buflen);
+  *  ``long (*read)(const struct key *key, char __user *buffer, size_t buflen);``
 
      This method is optional. It is called by KEYCTL_READ to translate the
      key's payload into something a blob of data for userspace to deal with.
@@ -1448,8 +1439,7 @@ The structure has a number of fields, some of which are mandatory:
      as might happen when the userspace buffer is accessed.
 
 
- (*) int (*request_key)(struct key_construction *cons, const char *op,
-			void *aux);
+  *  ``int (*request_key)(struct key_construction *cons, const char *op, void *aux);``
 
      This method is optional.  If provided, request_key() and friends will
      invoke this function rather than upcalling to /sbin/request-key to operate
@@ -1463,7 +1453,7 @@ The structure has a number of fields, some of which are mandatory:
      This method is permitted to return before the upcall is complete, but the
      following function must be called under all circumstances to complete the
      instantiation process, whether or not it succeeds, whether or not there's
-     an error:
+     an error::
 
 	void complete_request_key(struct key_construction *cons, int error);
 
@@ -1479,16 +1469,16 @@ The structure has a number of fields, some of which are mandatory:
      The key under construction and the authorisation key can be found in the
      key_construction struct pointed to by cons:
 
-     (*) struct key *key;
+      *  ``struct key *key;``
 
      	 The key under construction.
 
-     (*) struct key *authkey;
+      *  ``struct key *authkey;``
 
      	 The authorisation key.
 
 
- (*) struct key_restriction *(*lookup_restriction)(const char *params);
+  *  ``struct key_restriction *(*lookup_restriction)(const char *params);``
 
      This optional method is used to enable userspace configuration of keyring
      restrictions. The restriction parameter string (not including the key type
@@ -1497,12 +1487,11 @@ The structure has a number of fields, some of which are mandatory:
      attempted key link operation. If there is no match, -EINVAL is returned.
 
 
-============================
-REQUEST-KEY CALLBACK SERVICE
+Request-Key Callback Service
 ============================
 
 To create a new key, the kernel will attempt to execute the following command
-line:
+line::
 
 	/sbin/request-key create <key> <uid> <gid> \
 		<threadring> <processring> <sessionring> <callout_info>
@@ -1511,10 +1500,10 @@ line:
 keyrings from the process that caused the search to be issued. These are
 included for two reasons:
 
-  (1) There may be an authentication token in one of the keyrings that is
+   1  There may be an authentication token in one of the keyrings that is
       required to obtain the key, eg: a Kerberos Ticket-Granting Ticket.
 
-  (2) The new key should probably be cached in one of these rings.
+   2  The new key should probably be cached in one of these rings.
 
 This program should set it UID and GID to those specified before attempting to
 access any more keys. It may then look around for a user specific process to
@@ -1539,7 +1528,7 @@ instead.
 
 
 Similarly, the kernel may attempt to update an expired or a soon to expire key
-by executing:
+by executing::
 
 	/sbin/request-key update <key> <uid> <gid> \
 		<threadring> <processring> <sessionring>
@@ -1548,8 +1537,7 @@ In this case, the program isn't required to actually attach the key to a ring;
 the rings are provided for reference.
 
 
-==================
-GARBAGE COLLECTION
+Garbage Collection
 ==================
 
 Dead keys (for which the type has been removed) will be automatically unlinked
@@ -1557,6 +1545,6 @@ from those keyrings that point to them and deleted as soon as possible by a
 background garbage collector.
 
 Similarly, revoked and expired keys will be garbage collected, but only after a
-certain amount of time has passed.  This time is set as a number of seconds in:
+certain amount of time has passed.  This time is set as a number of seconds in::
 
 	/proc/sys/kernel/keys/gc_delay
diff --git a/Documentation/security/keys/index.rst b/Documentation/security/keys/index.rst
new file mode 100644
index 000000000000..ddfe7e4726e6
--- /dev/null
+++ b/Documentation/security/keys/index.rst
@@ -0,0 +1,8 @@
+===========
+Kernel Keys
+===========
+
+.. toctree::
+   :maxdepth: 1
+
+   core
diff --git a/MAINTAINERS b/MAINTAINERS
index 3e78b5c9b3f9..3973e25e5aca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7342,7 +7342,7 @@ KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 L:	keyrings at vger.kernel.org
 S:	Maintained
-F:	Documentation/security/keys.txt
+F:	Documentation/security/keys/core.rst
 F:	include/linux/key.h
 F:	include/linux/key-type.h
 F:	include/linux/keyctl.h
diff --git a/include/linux/key.h b/include/linux/key.h
index 0c9b93b0d1f7..24dfe6c1f8cb 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -9,7 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  *
  *
- * See Documentation/security/keys.txt for information on keys/keyrings.
+ * See Documentation/security/keys/core.rst for information on keys/keyrings.
  */
 
 #ifndef _LINUX_KEY_H
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
