From: pmoore@redhat.com (Paul Moore)
Date: Wed, 13 Jun 2018 16:26:46 -0400
Subject: [PATCH] MAINTAINERS: remove the outdated "LINUX SECURITY MODULE
	(LSM) FRAMEWORK" entry
Message-ID: <152892160671.9347.17619818032833751594.stgit@chester>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

This has been replaced with the "SECURITY SUBSYSTEM" entry.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c13b9fb3be0b..9528eb6290ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8322,11 +8322,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/memory-model/
 F:	Documentation/memory-barriers.txt
 
-LINUX SECURITY MODULE (LSM) FRAMEWORK
-M:	Chris Wright <chrisw@sous-sol.org>
-L:	linux-security-module at vger.kernel.org
-S:	Supported
-
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
