From: masanobu2.koike@toshiba.co.jp (Masanobu Koike)
Date: Tue, 30 May 2017 20:14:32 +0900
Subject: [RFC 3/3] WhiteEgret: Add an example of user application.
Message-ID: <20170530111432.5349-1-masanobu2.koike@toshiba.co.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A user application is required to use WhiteEgret.
This RFC provides a sample user application program.

Usage
  sample-we-user <exe>

This sample user application always returns "not permit"
for the executable specified by the argument <exe>,
otherwise always returns "permit". Set the absolute path
of an executable to be blocked for <exe>.

Example
  sample-we-user /bin/df

Then every executions of /bin/df are blocked.
The other commands can be issued normally.

How to build
To build this sample user application, set option
CONFIG_SAMPLE_WHITEEGRET=y. When the option
CONFIG_SECURITY_WHITEEGRET_DRIVER is not set, netlink library
libnl is required. Install libnl to /usr/local/bin.

Remark
This sample user application must run with CAP_NET_ADMIN
capability.
This sample user application does not use a whitelist.
It simply returns "not permit" only when WhiteEgret sends
the absolute path of argv[1] to the application.
The reason why this sample user application adopts
blacklist-like approach is to avoid a host to become
uncontrollable. Namely, if this sample provides a sample
whitelist and it misses indispensable executable components
for a host, the host cannot run or stop normally.
Because indispensable executable components are depend on
each environment, we decide not to provide a whitelisting-type
sample user application.

Signed-off-by: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
---
 samples/Kconfig                 |   6 ++
 samples/Makefile                |   2 +-
 samples/whiteegret/Makefile     |  25 +++++
 samples/whiteegret/checkwl.c    |  80 ++++++++++++++
 samples/whiteegret/checkwl.h    |  29 +++++
 samples/whiteegret/gennl.c      | 232 +++++++++++++++++++++++++++++++++++++++
 samples/whiteegret/gennl_user.h |  32 ++++++
 samples/whiteegret/main.c       | 234 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 639 insertions(+), 1 deletion(-)
 create mode 100644 samples/whiteegret/Makefile
 create mode 100644 samples/whiteegret/checkwl.c
 create mode 100644 samples/whiteegret/checkwl.h
 create mode 100644 samples/whiteegret/gennl.c
 create mode 100644 samples/whiteegret/gennl_user.h
 create mode 100644 samples/whiteegret/main.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 9cb6318..78316ac 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -118,4 +118,10 @@ config SAMPLE_STATX
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
+config SAMPLE_WHITEEGRET
+	bool "Build WhiteEgret sample user application"
+	depends on SECURITY_WHITEEGRET
+	help
+	  Build sample userspace application for WhiteEgret LSM module.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index db54e76..00bcba5 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
-			   vfio-mdev/ statx/
+			   vfio-mdev/ statx/ whiteegret/
diff --git a/samples/whiteegret/Makefile b/samples/whiteegret/Makefile
new file mode 100644
index 0000000..d861303
--- /dev/null
+++ b/samples/whiteegret/Makefile
@@ -0,0 +1,25 @@
+# kbuild trick to avoid linker error. Can be omitted if a module is built.
+obj- := dummy.o
+
+# List of programs to build
+hostprogs-$(CONFIG_SAMPLE_WHITEEGRET) := sample-we-user
+
+sample-we-user-objs := main.o checkwl.o
+ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+sample-we-user-objs += gennl.o
+endif
+
+HOSTCFLAGS += -Wall
+HOSTCFLAGS += -I/usr/local/include
+HOSTCFLAGS += -I$(srctree)/security/whiteegret
+ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+HOSTCFLAGS += -I$(srctree)/drivers/security/whiteegret
+HOSTCFLAGS += -DCONFIG_SECURITY_WHITEEGRET_DRIVER
+endif
+
+ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+HOSTLOADLIBES_sample-we-user += -lnl
+endif
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
diff --git a/samples/whiteegret/checkwl.c b/samples/whiteegret/checkwl.c
new file mode 100644
index 0000000..4839572
--- /dev/null
+++ b/samples/whiteegret/checkwl.c
@@ -0,0 +1,80 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017 Toshiba Corporation
+ */
+
+#include <errno.h>
+#include <string.h>
+#include "checkwl.h"
+
+#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+#include "gennl_common.h"
+#include "gennl_user.h"
+#endif
+
+/*
+ * The function check_whitelist() returns -EPERM
+ * only when path to be examined equals to @a not_permit_exe.
+ */
+char not_permit_exe[NOTPERMITEXENAMELENGTH];
+
+/**
+ * check_whitelist - Examine whether the executable input to this function
+ *                   is included in whitelist or not.
+ *
+ * @result: Result of the examination.
+ *            0      if the executble is included in whitelist
+ *            -EPERM otherwise ("not included")
+ *
+ * Returns 0 for success, -1 otherwise.
+ */
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+int check_whitelist(int *result, struct we_req_user *user)
+#else
+int check_whitelist(int *result, struct nlattr *attrs[])
+#endif
+{
+	char *path;
+#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+	int path_byte_len;
+	int margin = 2;  /* margin size for terminating null byte */
+#endif
+
+	*result = 0;
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+	if ((result == NULL) || (user == NULL))
+#else
+	if ((result == NULL) || (attrs == NULL))
+#endif
+		return -1;
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+	path = user->path;
+#else
+	path_byte_len = strlen(nla_get_string(attrs[WE_A_PATH]));
+	path = (char *)calloc(path_byte_len + margin, sizeof(char));
+	if (path == NULL)
+		return -1;
+	snprintf(path, path_byte_len + margin, "%s",
+			nla_get_string(attrs[WE_A_PATH]));
+#endif
+
+	/*
+	 * Refering a whitelist is expected at this location.
+	 * However, this sample uses not whitelist but blacklist
+	 * because of avoiding a host to become uncontrollable.
+	 * (not_permit_exe is a blacklist containing only one item.)
+	 */
+	if (strcmp(not_permit_exe, path) == 0)
+		*result = -EPERM;
+
+#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+	free(path);
+#endif
+
+	return 0;
+}
diff --git a/samples/whiteegret/checkwl.h b/samples/whiteegret/checkwl.h
new file mode 100644
index 0000000..5888de1
--- /dev/null
+++ b/samples/whiteegret/checkwl.h
@@ -0,0 +1,29 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017 Toshiba Corporation
+ */
+
+#ifndef _CHECKWL_H
+#define _CHECKWL_H
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+#include "we_driver.h"
+#else
+#include <linux/netlink.h>
+#endif
+
+/* byte length of absolute path of file not to permit execution */
+#define NOTPERMITEXENAMELENGTH 1024
+
+extern char not_permit_exe[NOTPERMITEXENAMELENGTH];
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+int check_whitelist(int *result, struct we_req_user *user);
+#else
+int check_whitelist(int *result, struct nlattr *attrs[]);
+#endif
+
+#endif
diff --git a/samples/whiteegret/gennl.c b/samples/whiteegret/gennl.c
new file mode 100644
index 0000000..1b54de7
--- /dev/null
+++ b/samples/whiteegret/gennl.c
@@ -0,0 +1,232 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017 Toshiba Corporation
+ */
+
+#include <errno.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/mngt.h>
+#include <netlink/cache-api.h>
+#include <linux/netlink.h>
+#include <linux/genetlink.h>
+
+#include "we_common.h"
+#include "gennl_common.h"
+#include "gennl_user.h"
+#include "checkwl.h"
+
+uint16_t kerfamilyid;
+
+/* attribute policy */
+static struct nla_policy we_genl_policy[WE_A_MAX + 1] = {
+	[WE_A_UNSPEC]       = { .type = NLA_STRING },
+	[WE_A_AUTHINFO]     = { // .type = NLA_BINARY,  /* only kernel */
+					.maxlen  = AUTHINFOLENGTH },
+	[WE_A_SHORTNAME]    = { .type = NLA_STRING,
+					.maxlen  = SHORTNAMELENGTH },
+	[WE_A_PATH]         = { .type = NLA_STRING },
+	[WE_A_EXECPERMISSION]       = { .type = NLA_FLAG },
+};
+
+/**
+ * seq_num_no_check_callback - Disable checking sequence number.
+ */
+int seq_num_no_check_callback(struct nl_msg *msg, void *arg)
+{
+	return 0;
+}
+
+/**
+ * we_user_execpermission_callback
+ * - Callback function for examination whether the executable input
+ *   to this function is included in whitelist or not.
+ */
+int we_user_execpermission_callback(struct nl_msg *msg, void *arg)
+{
+	struct recv_payload_st *recv_p_st;
+	struct nlmsghdr *hdr;
+	struct genlmsghdr *genhdr;
+	struct nlattr *attrs[WE_A_MAX+1];
+	int checkresult = 0;
+	int rc;
+
+	recv_p_st = (struct recv_payload_st *)arg;
+
+	hdr = nlmsg_hdr(msg);
+	genhdr = (struct genlmsghdr *)nlmsg_data(hdr);
+
+	if (hdr->nlmsg_pid != 0) {
+		rc = -EPERM;
+		return rc;
+	}
+
+	if (hdr->nlmsg_type == recv_p_st->familyid) {
+		if (genhdr->cmd == WE_C_EXECPERMISSION) {
+			rc = nlmsg_validate(hdr, 0, WE_A_MAX,
+					we_genl_policy);
+			if (rc < 0) {
+				nl_perror("nlmsg_validate");
+				return rc;
+			}
+			genlmsg_parse(hdr, 0, attrs, WE_A_MAX,
+					we_genl_policy);
+			rc = check_whitelist(&checkresult, attrs);
+			if (rc < 0) {
+				perror("check_whitelist");
+				return rc;
+			}
+
+			rc = respond_we_user_execpermission(
+					recv_p_st->familyid,
+					recv_p_st->nlhandle, checkresult,
+					hdr->nlmsg_seq,
+					nla_get_string(
+						attrs[WE_A_SHORTNAME])
+					);
+			if (rc < 0) {
+				perror("respond_we_user_execpermission");
+				return rc;
+			}
+		} else {
+			perror("receive msg with unknown command\n");
+		}
+		return NL_OK;
+	}
+
+	perror("receive msg with unknown family\n");
+	return NL_SKIP;
+}
+
+/**
+ * send_we_user_register - Callback function for registration
+ *                             of user's whitelisting application.
+ */
+int send_we_user_register(uint16_t kerfamilyid, struct nl_handle *h,
+		char *authinfo)
+{
+	struct nl_msg *msg;
+	void *hdr;
+
+	msg = nlmsg_alloc();
+	if (msg == NULL) {
+		nl_perror("nlmsg_alloc");
+		return -1;
+	}
+
+	hdr = genlmsg_put(
+			msg, NL_AUTO_PID, NL_AUTO_SEQ, kerfamilyid,
+			0, NLM_F_ECHO, WE_C_USERREGISTER,
+			WE_FAMILY_VERSION
+			);
+	if (hdr == NULL) {
+		nl_perror("genlmsg_put");
+		return -1;
+	}
+
+	if (nla_put(msg, WE_A_AUTHINFO, AUTHINFOLENGTH, authinfo) < 0) {
+		nl_perror("nla_put: authinfo");
+		return -1;
+	}
+
+	if (nl_send_auto_complete(h, msg) < 0) {
+		nl_perror("nl_send_auto_complete");
+		return -1;
+	}
+
+	nlmsg_free(msg);
+
+	return 0;
+}
+
+/**
+ * send_we_user_unregister - Callback function for unregistration
+ *                               of user's whitelisting application.
+ */
+int send_we_user_unregister(uint16_t kerfamilyid, struct nl_handle *h,
+		char *authinfo)
+{
+	struct nl_msg *msg;
+	void *hdr;
+
+	msg = nlmsg_alloc();
+	if (msg == NULL) {
+		nl_perror("nlmsg_alloc");
+		return -1;
+	}
+
+	hdr = genlmsg_put(
+			msg, NL_AUTO_PID, NL_AUTO_SEQ, kerfamilyid,
+			0, NLM_F_ECHO, WE_C_USERUNREGISTER,
+			WE_FAMILY_VERSION
+			);
+	if (hdr == NULL) {
+		nl_perror("genlmsg_put");
+		return -1;
+	}
+
+	if (nla_put(msg, WE_A_AUTHINFO, AUTHINFOLENGTH, authinfo) < 0) {
+		nl_perror("nla_put: authinfo");
+		return -1;
+	}
+
+	if (nl_send_auto_complete(h, msg) < 0) {
+		nl_perror("nl_send_auto_complete");
+		return -1;
+	}
+
+	nlmsg_free(msg);
+
+	return 0;
+}
+
+/**
+ * respond_we_user_execpermission - Send response to kernel space.
+ */
+int respond_we_user_execpermission(uint16_t kerfamilyid,
+		struct nl_handle *h, int checkresult, unsigned int seq,
+		char *shortname)
+{
+	struct nl_msg *msg;
+	void *hdr;
+
+	msg = nlmsg_alloc();
+	if (msg == NULL) {
+		nl_perror("nlmsg_alloc");
+		return -1;
+	}
+
+	hdr = genlmsg_put(
+			msg, NL_AUTO_PID, seq, kerfamilyid,
+			0, NLM_F_ECHO, WE_C_EXECPERMISSION,
+			WE_FAMILY_VERSION
+			);
+	if (hdr == NULL) {
+		nl_perror("genlmsg_put");
+		return -1;
+	}
+
+	if (nla_put_string(msg, WE_A_SHORTNAME, shortname) < 0) {
+		nl_perror("nla_put_string");
+		return -1;
+	}
+
+	if (checkresult != -EPERM) {
+		if (nla_put_flag(msg, WE_A_EXECPERMISSION) < 0) {
+			nl_perror("nla_put_flag: execpermission");
+			return -1;
+		}
+	}
+
+	if (nl_send_auto_complete(h, msg) < 0) {
+		nl_perror("nl_send_auto_complete");
+		return -1;
+	}
+
+	nlmsg_free(msg);
+
+	return 0;
+}
+
diff --git a/samples/whiteegret/gennl_user.h b/samples/whiteegret/gennl_user.h
new file mode 100644
index 0000000..f3dfe77
--- /dev/null
+++ b/samples/whiteegret/gennl_user.h
@@ -0,0 +1,32 @@
+/** @file gennl_user.h
+ * @brief Header file for netlink generic functionalities used in
+ * user's whitelisting application.
+ * Definitions in this file are specific for user's whitelisting
+ * application.
+ */
+
+#ifndef _GENNL_USER_H
+#define _GENNL_USER_H
+
+#include <netlink/genl/genl.h>
+
+/* callback function */
+int seq_num_no_check_callback(struct nl_msg *msg, void *arg);
+int we_user_execpermission_callback(struct nl_msg *msg, void *arg);
+
+/* methods for send a message to kernel space */
+int send_we_user_register(uint16_t kerfamilyid, struct nl_handle *h,
+		char *authinfo);
+int send_we_user_unregister(uint16_t kerfamilyid, struct nl_handle *h,
+		char *authinfo);
+int respond_we_user_execpermission(uint16_t kerfamilyid,
+		struct nl_handle *h, int checkresult, unsigned int seq,
+		char *shortname);
+
+/* datatype for passing to receive callback */
+struct recv_payload_st {
+	uint16_t familyid;
+	struct nl_handle *nlhandle;
+};
+
+#endif  /* _GENNL_USER_H */
diff --git a/samples/whiteegret/main.c b/samples/whiteegret/main.c
new file mode 100644
index 0000000..0034378
--- /dev/null
+++ b/samples/whiteegret/main.c
@@ -0,0 +1,234 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017 Toshiba Corporation
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include "checkwl.h"
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+
+#include <stdlib.h>
+#include "we_driver.h"
+
+#else
+
+#include <netlink/genl/ctrl.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/mngt.h>
+#include <netlink/cache-api.h>
+#include <linux/netlink.h>
+#include <linux/genetlink.h>
+#include "gennl_common.h"
+#include "gennl_user.h"
+
+#endif
+
+#define MAXWAITFROMKER 10
+
+#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+int kerfamilyid = -1;
+int receiving_from_ker = 1;
+#endif
+
+static void sigint_catch(int sig)
+{
+#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
+	receiving_from_ker = 0;
+#endif
+}
+
+static void print_usage(void)
+{
+	fprintf(stderr, "Usage: sample-we-user [file_name]\n");
+	fprintf(stderr, "file_name: absolute path of executable");
+	fprintf(stderr, "not to permit execution.\n");
+}
+
+int main(int argc, char *argv[])
+{
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+	int fd;
+	struct we_req_user *user;
+	struct we_ack ack;
+	char buf[2024];
+#else
+	struct nl_handle *h;
+	int sockfd;
+	struct nl_cb *cb;
+	struct recv_payload_st recvdata;
+	int epfd;
+	struct epoll_event ev, ev_ret[1];
+	int j;
+	int nfds;
+#endif
+	int ret;
+
+	if (argc < 2) {
+		print_usage();
+		return -1;
+	}
+
+	snprintf(not_permit_exe, NOTPERMITEXENAMELENGTH, "%s", argv[1]);
+
+	signal(SIGINT, sigint_catch);
+
+	if (daemon(0, 0) < 0) {
+		perror("daemon");
+		exit(EXIT_FAILURE);
+	}
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
+
+	fd = open(WE_DEV_PATH, O_RDWR, 0);
+	if (fd < 0) {
+		perror(WE_DEV_PATH);
+		exit(EXIT_FAILURE);
+	}
+	user = (struct we_req_user *)((void *)buf);
+
+	while (1) {
+		ret = read(fd, (char *)user, 256);
+		if (ret < 0) {
+			perror("read");
+			continue;
+		}
+
+		ack.ppid = user->ppid;
+		check_whitelist(&ack.permit, user);
+
+		ret = write(fd, (char *)&ack, sizeof(ack));
+	}
+
+	close(fd);
+
+#else  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
+
+	/* initialize and connect for netlink handler */
+	h = nl_handle_alloc();
+	if (!h) {
+		nl_perror("nl_handle_alloc");
+		return -1;
+	}
+
+	if (genl_connect(h) < 0) {
+		nl_perror("genl_connect");
+		nl_close(h);
+		return -1;
+	}
+
+	sockfd = nl_socket_get_fd(h);
+	if (nl_socket_set_nonblocking(h) < 0) {
+		nl_perror("nl_socket_set_nonblocking");
+		nl_close(h);
+		return -1;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (cb == NULL) {
+		nl_perror("nl_cb_alloc");
+		nl_close(h);
+		return -1;
+	}
+
+	/* find the family ID for white list netlink in kernel */
+	for (j = 0; j < MAXWAITFROMKER; j++) {
+		kerfamilyid = genl_ctrl_resolve(h, WE_FAMILY_NAME);
+		if ((kerfamilyid >= 0) || (!receiving_from_ker))
+			break;
+		nl_perror("genl_ctrl_resolve");
+	}
+	if ((j >= MAXWAITFROMKER) || (!receiving_from_ker)) {
+		perror("error in opening kernel netlink.");
+		nl_close(h);
+		exit(EXIT_FAILURE);
+	}
+
+	/* register the user process as the user's whitelist application */
+	if (send_we_user_register(kerfamilyid, h, NULL) < 0) {
+		perror("fatal error at send_we_user_register.");
+		nl_close(h);
+		return -1;
+	}
+
+	/* disable sequence number check */
+	if (nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM,
+				seq_num_no_check_callback, NULL) < 0) {
+		nl_perror("nl_cb_set");
+		goto unregister;
+	}
+
+	/* set callback function for receiving generic netlink message */
+	recvdata.familyid = kerfamilyid;
+	recvdata.nlhandle = h;
+	if (nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM,
+				we_user_execpermission_callback,
+				(void *)&recvdata) < 0) {
+		nl_perror("nl_cb_set");
+		goto unregister;
+	}
+
+	/* preparing polling */
+	epfd = epoll_create(1);
+	if (epfd < 0) {
+		perror("epoll_create");
+		goto unregister;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+	ev.events = EPOLLIN;
+	ev.data.fd = sockfd;
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, sockfd, &ev) != 0) {
+		perror("epoll_ctl");
+		goto unregister;
+	}
+
+	/* polling */
+	while (receiving_from_ker) {
+		nfds = epoll_wait(epfd, ev_ret, 1, -1);
+		if (nfds < 0) {
+			if (errno != EINTR) {
+				perror("epoll_wait");
+				goto unregister;
+			}
+		}
+		for (j = 0; j < nfds; j++) {
+			if (ev_ret[j].data.fd == sockfd) {
+				ret = nl_recvmsgs(h, cb);
+				if (ret < 0) {
+					nl_perror("nl_recvmsgs");
+					goto unregister;
+				}
+			}
+		}
+	}
+
+unregister:
+	/* unregister the user process */
+	ret = send_we_user_unregister(kerfamilyid, h, NULL);
+	if (ret < 0) {
+		perror("fatal error at send_we_user_unregister.");
+		nl_close(h);
+		return -1;
+	}
+
+	nl_close(h);
+
+#endif  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
+
+	return 0;
+}
+
-- 
2.9.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
