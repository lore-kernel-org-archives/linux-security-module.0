From: dhowells@redhat.com (David Howells)
Date: Wed, 24 May 2017 15:45:32 +0100
Subject: [PATCH 2/5] efi: Add EFI_SECURE_BOOT bit
In-Reply-To: <149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
References: <149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
Message-ID: <149563713211.9419.13591529902587407094.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

UEFI machines can be booted in Secure Boot mode.  Add a EFI_SECURE_BOOT bit
that can be passed to efi_enabled() to find out whether secure boot is
enabled.

This will be used by the SysRq+x handler, registered by the x86 arch, to
find out whether secure boot mode is enabled so that it can be disabled.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-efi at vger.kernel.org
---

 drivers/firmware/efi/secureboot.c |    1 +
 include/linux/efi.h               |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/secureboot.c b/drivers/firmware/efi/secureboot.c
index cf5bccae15e8..730518061a14 100644
--- a/drivers/firmware/efi/secureboot.c
+++ b/drivers/firmware/efi/secureboot.c
@@ -24,6 +24,7 @@ void __init efi_set_secure_boot(enum efi_secureboot_mode mode)
 			pr_info("Secure boot disabled\n");
 			break;
 		case efi_secureboot_mode_enabled:
+			set_bit(EFI_SECURE_BOOT, &efi.flags);
 			pr_info("Secure boot enabled\n");
 			break;
 		default:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e2f53edccf15..5e9a2d7df089 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1081,6 +1081,7 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_DBG			8	/* Print additional debug info at runtime */
 #define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-executable? */
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
+#define EFI_SECURE_BOOT		11	/* Are we in Secure Boot mode? */
 
 #ifdef CONFIG_EFI
 /*

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
