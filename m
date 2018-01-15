From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 15 Jan 2018 13:35:43 +0100
Subject: [PATCH 4.14 116/118] security/Kconfig: Correct the Documentation
	reference for PTI
In-Reply-To: <20180115123415.325497625@linuxfoundation.org>
References: <20180115123415.325497625@linuxfoundation.org>
Message-ID: <20180115123422.238688977@linuxfoundation.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: W. Trevor King <wking@tremily.us>

commit a237f762681e2a394ca67f21df2feb2b76a3609b upstream.

When the config option for PTI was added a reference to documentation was
added as well. But the documentation did not exist at that point. The final
documentation has a different file name.

Fix it up to point to the proper file.

Fixes: 385ce0ea ("x86/mm/pti: Add Kconfig")
Signed-off-by: W. Trevor King <wking@tremily.us>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-mm at kvack.org
Cc: linux-security-module at vger.kernel.org
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: stable at vger.kernel.org
Link: https://lkml.kernel.org/r/3009cc8ccbddcd897ec1e0cb6dda524929de0d14.1515799398.git.wking at tremily.us
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/Kconfig
+++ b/security/Kconfig
@@ -63,7 +63,7 @@ config PAGE_TABLE_ISOLATION
 	  ensuring that the majority of kernel addresses are not mapped
 	  into userspace.
 
-	  See Documentation/x86/pagetable-isolation.txt for more details.
+	  See Documentation/x86/pti.txt for more details.
 
 config SECURITY_INFINIBAND
 	bool "Infiniband Security Hooks"


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
