From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 21:16:57 +0100
Subject: [PATCH 17/24] acpi: Ignore acpi_rsdp kernel param when the kernel
	has been locked down
In-Reply-To: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
Message-ID: <149142341772.5101.12366553346604485034.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to circumvent any restrictions imposed on
loading modules.  Ignore the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi at vger.kernel.org
---

 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index db78d353bab1..d4d4ba348451 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -192,7 +192,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa = 0;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down())
 		return acpi_rsdp;
 #endif
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
