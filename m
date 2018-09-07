From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri,  7 Sep 2018 23:08:11 +0200
Subject: [PATCH 4.18 025/145] Fix kexec forbidding kernels signed with keys in
	the secondary keyring to boot
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
Message-ID: <20180907210905.703424333@linuxfoundation.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yannik Sembritzki <yannik@sembritzki.me>

commit ea93102f32244e3f45c8b26260be77ed0cc1d16c upstream.

The split of .system_keyring into .builtin_trusted_keys and
.secondary_trusted_keys broke kexec, thereby preventing kernels signed by
keys which are now in the secondary keyring from being kexec'd.

Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
verify_pefile_signature().

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: kexec at lists.infradead.org
Cc: keyrings at vger.kernel.org
Cc: linux-security-module at vger.kernel.org
Cc: stable at kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kexec-bzimage64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loade
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       NULL,
+				       VERIFY_USE_SECONDARY_KEYRING,
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif
