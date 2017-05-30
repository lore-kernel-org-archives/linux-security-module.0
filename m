From: masanobu2.koike@toshiba.co.jp (Masanobu Koike)
Date: Tue, 30 May 2017 20:14:13 +0900
Subject: [RFC 2/3] WhiteEgret: Add device driver.
Message-ID: <20170530111413.5302-1-masanobu2.koike@toshiba.co.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

WhiteEgret supports communication between kernel space and
user space using device driver.
This RFC provides the driver implementation.

Build the kernel with CONFIG_WHITEEGRET_DRIVER=y.
This option is defined automatically when
CONFIG_SECURITY_WHITEEGRET_DRIVER=y is set.
Then the loadable kernel module we_driver.ko is created into
/lib/modules/$(uname -r)/build/drivers/security/whiteegret/.

Next step is
  insmod we_driver.ko
command. This command creates a special file /dev/wecom.

Signed-off-by: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
---
 drivers/Kconfig                         |   2 +
 drivers/Makefile                        |   1 +
 drivers/security/Kconfig                |   1 +
 drivers/security/Makefile               |   1 +
 drivers/security/whiteegret/Kconfig     |  10 ++
 drivers/security/whiteegret/Makefile    |   3 +
 drivers/security/whiteegret/we_driver.c | 295 ++++++++++++++++++++++++++++++++
 drivers/security/whiteegret/we_driver.h |  32 ++++
 8 files changed, 345 insertions(+)
 create mode 100644 drivers/security/Kconfig
 create mode 100644 drivers/security/Makefile
 create mode 100644 drivers/security/whiteegret/Kconfig
 create mode 100644 drivers/security/whiteegret/Makefile
 create mode 100644 drivers/security/whiteegret/we_driver.c
 create mode 100644 drivers/security/whiteegret/we_driver.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index ba2901e..8922bc7 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -206,4 +206,6 @@ source "drivers/fsi/Kconfig"
 
 source "drivers/tee/Kconfig"
 
+source "drivers/security/whiteegret/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index cfabd14..fc1feeb 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -181,3 +181,4 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
+obj-$(CONFIG_SECURITY)		+= security/
diff --git a/drivers/security/Kconfig b/drivers/security/Kconfig
new file mode 100644
index 0000000..5633ac7
--- /dev/null
+++ b/drivers/security/Kconfig
@@ -0,0 +1 @@
+source "security/whiteegret/Kconfig"
diff --git a/drivers/security/Makefile b/drivers/security/Makefile
new file mode 100644
index 0000000..c17ec8a
--- /dev/null
+++ b/drivers/security/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_WHITEEGRET_DRIVER)		+= whiteegret/
diff --git a/drivers/security/whiteegret/Kconfig b/drivers/security/whiteegret/Kconfig
new file mode 100644
index 0000000..912b690
--- /dev/null
+++ b/drivers/security/whiteegret/Kconfig
@@ -0,0 +1,10 @@
+config WHITEEGRET_DRIVER
+	depends on SECURITY_WHITEEGRET_DRIVER
+	tristate "Driver for WhiteEgret LSM module"
+	default m
+	help
+	  This driver adds communication functionality between user space
+	  and kernel space of the WhiteEgret LSM module.
+	  Building with this option, we_driver.ko is created in this
+	  directory. Then insmod we_driver.ko command create a special
+	  file /dev/wecom.
diff --git a/drivers/security/whiteegret/Makefile b/drivers/security/whiteegret/Makefile
new file mode 100644
index 0000000..7078407
--- /dev/null
+++ b/drivers/security/whiteegret/Makefile
@@ -0,0 +1,3 @@
+ccflags-y += -I$(srctree)/security/whiteegret
+
+obj-$(CONFIG_WHITEEGRET_DRIVER)		+= we_driver.o
diff --git a/drivers/security/whiteegret/we_driver.c b/drivers/security/whiteegret/we_driver.c
new file mode 100644
index 0000000..f1e1c72
--- /dev/null
+++ b/drivers/security/whiteegret/we_driver.c
@@ -0,0 +1,295 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017 Toshiba Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/cdev.h>
+#include "dd_com.h"
+
+/*
+ * This option informs we_driver.h that this file is built as
+ * loadable kernel module.
+ */
+#define WE_LKM
+#include "we_driver.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Toshiba");
+
+#define static_assert(constexpr) \
+	char dummy[(constexpr) ? 1 : -1] __attribute__((unused))
+
+#define WE_COPY_TO_USER(to, from, ret) \
+	do { \
+		static_assert(sizeof((to)) == sizeof((from))); \
+		(ret) = copy_to_user(&(to), &(from), sizeof(to)); \
+	} while (0)
+
+#define WE_COPY_FROM_USER(to, from, ret) \
+	do { \
+		static_assert(sizeof((to)) == sizeof((from))); \
+		(ret) = copy_from_user(&(to), &(from), sizeof(to)); \
+	} while (0)
+
+#define SUCCESS 0
+
+#define WE_MINOR 1
+#define WE_CLASS_NAME "we_class"
+
+static int we_major;
+static struct cdev we_cdev;
+static struct class *we_class;
+
+static rwlock_t resource_lock;
+static struct we_req_q_head *root;
+
+static struct we_req_q *get_alive_we_req(struct we_req_q_head *root)
+{
+	struct list_head *p;
+	struct we_req_q *req, *ret = NULL;
+
+	read_lock(&root->lock);
+	list_for_each(p, &root->head) {
+		req = list_entry(p, struct we_req_q, queue);
+		if (req->finish_flag == STOP_EXEC) {
+			ret = req;
+			break;
+		}
+	}
+	read_unlock(&root->lock);
+
+	return ret;
+}
+
+static struct we_req_q *we_req_search(struct we_req_q_head *root,
+		pid_t ppid)
+{
+	struct list_head *p;
+	struct we_req_q *req, *ret = NULL;
+
+	read_lock(&root->lock);
+	list_for_each(p, &root->head) {
+		req = list_entry(p, struct we_req_q, queue);
+		if (req->data.we_obj_info->ppid == ppid) {
+			ret = req;
+			break;
+		}
+	}
+	read_unlock(&root->lock);
+
+	return ret;
+}
+
+static int check_we_pathsize(struct we_req_q *we_req, int size)
+{
+	if (size - sizeof(*we_req)
+			> we_req->data.we_obj_info->pathsize)
+		return 0;
+	else
+		return -1;
+}
+
+static unsigned long set_we_req_info(struct we_req_user *user,
+		struct we_obj_info *info)
+{
+	unsigned long ret;
+
+	WE_COPY_TO_USER(user->pid, info->pid, ret);
+	if (ret != 0)
+		return -EFAULT;
+
+	WE_COPY_TO_USER(user->ppid, info->ppid, ret);
+	if (ret != 0)
+		return -EFAULT;
+	WE_COPY_TO_USER(user->shortname, info->shortname, ret);
+	if (ret != 0)
+		return -EFAULT;
+	WE_COPY_TO_USER(user->pathsize, info->pathsize, ret);
+	if (ret != 0)
+		return -EFAULT;
+	ret = copy_to_user(user->path, info->path, info->pathsize + 1);
+	if (ret != 0)
+		return -EFAULT;
+	return 0;
+}
+
+static ssize_t we_driver_read(struct file *file, char *buf,
+		size_t size, loff_t *off)
+{
+	int ret;
+	struct we_req_q *we_req;
+	struct we_req_user *user;
+
+	while (1) {
+		ret = wait_event_interruptible(root->waitq,
+				(we_req = get_alive_we_req(root)));
+		if (ret < 0) {
+			pr_info("WhiteEgret: %s: signal (%d)", __func__, ret);
+			return 0;
+		}
+
+		if (we_req) {
+			user = (struct we_req_user *)((void *)(buf));
+			if (check_we_pathsize(we_req, size)) {
+				pr_err("WhiteEgret: ");
+				pr_err("Path length of exec is too long (%d).\n",
+					we_req->data.we_obj_info->pathsize);
+				return -EPERM;
+			}
+
+			set_we_req_info(user,
+					we_req->data.we_obj_info);
+			break;
+		}
+
+		pr_warn("WhiteEgret: %s: can not find we_req.\n", __func__);
+	}
+
+	pr_info("WhiteEgret: read %s.", we_req->data.we_obj_info->path);
+
+	return sizeof(*user) + user->pathsize + 1;
+}
+
+static unsigned long set_we_ack(struct we_ack *to, struct we_ack *from)
+{
+	unsigned long ret;
+
+	WE_COPY_FROM_USER(to->ppid, from->ppid, ret);
+	if (ret != 0)
+		return -EFAULT;
+	WE_COPY_FROM_USER(to->permit, from->permit, ret);
+	if (ret != 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static size_t send_ack(struct we_req_q *req, struct we_ack *ack)
+{
+	if (!req) {
+		pr_warn("WhiteEgret: %s: can not find we_req.\n", __func__);
+		return -EPERM;
+	}
+	req->permit = ack->permit;
+	req->finish_flag = START_EXEC;
+	wake_up_interruptible(&req->waitq);
+	return sizeof(*ack);
+}
+
+static ssize_t we_driver_write(struct file *file, const char *buf,
+		size_t size, loff_t *off)
+{
+	size_t ret;
+	struct we_req_q *we_req;
+	struct we_ack ack;
+
+	set_we_ack(&ack, (struct we_ack *)((void *)buf));
+	we_req = we_req_search(root, ack.ppid);
+	ret = send_ack(we_req, &ack);
+	pr_info("WhiteEgret: write %s.", we_req->data.we_obj_info->path);
+	return ret;
+}
+
+static long we_driver_ioctl(struct file *file,
+		unsigned int arg0, unsigned long arg1)
+{
+	return SUCCESS;
+}
+
+static int we_driver_release(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+
+	ret = stop_we();
+	pr_info("WhiteEgret: we_driver closed (%d)\n", ret);
+	return ret;
+}
+
+static int we_driver_open(struct inode *inode, struct file *filp)
+{
+	root = start_we();
+	if (!root)
+		return -EPERM;
+	return SUCCESS;
+}
+
+static const struct file_operations we_driver_fops = {
+	.owner = THIS_MODULE,
+	.read = we_driver_read,
+	.write = we_driver_write,
+	.unlocked_ioctl = we_driver_ioctl,
+	.open =  we_driver_open,
+	.release = we_driver_release,
+};
+
+static int we_driver_init(void)
+{
+	int ret;
+	dev_t we_dev;
+	struct device *we_device;
+
+	ret = alloc_chrdev_region(&we_dev, 0, WE_MINOR, WE_DEV_NAME);
+	if (ret < 0) {
+		pr_err("WhiteEgret: ");
+		pr_err("alloc_chrdev_region error: can not allocate chrdev.\n");
+		return ret;
+	}
+	we_major = MAJOR(we_dev);
+
+	we_class = class_create(THIS_MODULE, WE_CLASS_NAME);
+	if (IS_ERR(we_class)) {
+		pr_err("WhiteEgret: class_create error.\n");
+		ret = PTR_ERR(we_class);
+		goto failure_register;
+	}
+
+	we_device = device_create(we_class, NULL, we_dev, NULL, WE_DEV_NAME);
+	if (IS_ERR(we_device)) {
+		pr_err("WhiteEgret: device_create error.\n");
+		ret = PTR_ERR(we_device);
+		goto failure_class;
+	}
+
+	cdev_init(&we_cdev, &we_driver_fops);
+	we_cdev.owner = THIS_MODULE;
+	ret = cdev_add(&we_cdev, we_dev, WE_MINOR);
+	if (ret < 0) {
+		pr_err("WhiteEgret: cdev_add error: can not register chrdev.\n");
+		goto failure_device;
+	}
+
+	pr_info("WhiteEgret: we_driver is installed.\n");
+	rwlock_init(&resource_lock);
+	return 0;
+
+failure_device:
+	device_destroy(we_class, we_dev);
+failure_class:
+	class_destroy(we_class);
+failure_register:
+	unregister_chrdev_region(we_dev, WE_MINOR);
+
+	return ret;
+}
+
+static void we_driver_exit(void)
+{
+	dev_t we_dev;
+
+	we_dev = MKDEV(we_major, WE_MINOR);
+	device_destroy(we_class, we_dev);
+	class_destroy(we_class);
+	unregister_chrdev_region(we_dev, WE_MINOR);
+	pr_info("WhiteEgret: we_driver is removed.\n");
+}
+
+module_init(we_driver_init);
+module_exit(we_driver_exit);
diff --git a/drivers/security/whiteegret/we_driver.h b/drivers/security/whiteegret/we_driver.h
new file mode 100644
index 0000000..5907dfa
--- /dev/null
+++ b/drivers/security/whiteegret/we_driver.h
@@ -0,0 +1,32 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017 Toshiba Corporation
+ */
+
+#ifndef _WE_DRIVER_H
+#define _WE_DRIVER_H
+
+#ifndef WE_LKM
+#include <sys/types.h>
+#endif
+
+#define WE_DEV_NAME "wecom"
+#define WE_DEV_PATH "/dev/"WE_DEV_NAME
+
+#define SHORTNAMELENGTH 256
+
+struct we_req_user {
+	pid_t pid;
+	pid_t ppid;
+	char shortname[SHORTNAMELENGTH];
+	int pathsize;
+	char path[0];
+};
+
+struct we_ack {
+	int permit;
+	pid_t ppid;
+};
+
+#endif  /* _WE_DRIVER_H */
-- 
2.9.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
