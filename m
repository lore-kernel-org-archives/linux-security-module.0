From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Jun 2017 10:25:44 +0800
Subject: [RFC PATCH] print_tpe_error() can be static
In-Reply-To: <20170608034349.31876-2-matt@nmatt.com>
References: <201706161000.YdVELEbH%fengguang.wu@intel.com>
Message-ID: <20170616022544.GA42978@lkp-hsx03.lkp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 tpe_lsm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/tpe/tpe_lsm.c b/security/tpe/tpe_lsm.c
index fda811a..77d2498 100644
--- a/security/tpe/tpe_lsm.c
+++ b/security/tpe/tpe_lsm.c
@@ -42,7 +42,7 @@ static int tpe_strict __read_mostly = IS_ENABLED(CONFIG_SECURITY_TPE_STRICT);
 static int tpe_restrict_root __read_mostly =
 	IS_ENABLED(CONFIG_SECURITY_TPE_RESTRICT_ROOT);
 
-int print_tpe_error(struct file *file, char *reason1, char *reason2,
+static int print_tpe_error(struct file *file, char *reason1, char *reason2,
 	char *method)
 {
 	char *filepath;
@@ -125,7 +125,7 @@ static int tpe_check(struct file *file, char *method)
 		return 0;
 }
 
-int tpe_mmap_file(struct file *file, unsigned long reqprot,
+static int tpe_mmap_file(struct file *file, unsigned long reqprot,
 	unsigned long prot, unsigned long flags)
 {
 	if (!file || !(prot & PROT_EXEC))
@@ -134,7 +134,7 @@ int tpe_mmap_file(struct file *file, unsigned long reqprot,
 	return tpe_check(file, "mmap");
 }
 
-int tpe_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+static int tpe_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	unsigned long prot)
 {
 	if (!vma->vm_file)
@@ -157,7 +157,7 @@ static struct security_hook_list tpe_hooks[] = {
 };
 
 #ifdef CONFIG_SYSCTL
-struct ctl_path tpe_sysctl_path[] = {
+static struct ctl_path tpe_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "tpe", },
 	{ }
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
