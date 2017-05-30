From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 30 May 2017 10:28:51 -0700
Subject: [RFC 1/3] WhiteEgret: Add WhiteEgret core functions.
In-Reply-To: <20170530111354.5255-1-masanobu2.koike@toshiba.co.jp>
References: <20170530111354.5255-1-masanobu2.koike@toshiba.co.jp>
Message-ID: <8de78503-c4ec-9b87-cef9-ac6f6c5d8e94@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/30/2017 4:13 AM, Masanobu Koike wrote:
> This RFC provides implementation of WhiteEgret.
>
> Signed-off-by: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
> ---
>  security/Kconfig                   |   7 +-
>  security/Makefile                  |   2 +
>  security/whiteegret/Kconfig        |  21 ++
>  security/whiteegret/Makefile       |   7 +
>  security/whiteegret/auth.c         |  19 ++
>  security/whiteegret/auth.h         |  12 ++
>  security/whiteegret/dd_com.c       |  79 ++++++++
>  security/whiteegret/dd_com.h       |  19 ++
>  security/whiteegret/gennl.c        | 382 +++++++++++++++++++++++++++++++++++++
>  security/whiteegret/gennl.h        |  32 ++++
>  security/whiteegret/gennl_common.h |  43 +++++
>  security/whiteegret/init.c         |  69 +++++++
>  security/whiteegret/main.c         | 340 +++++++++++++++++++++++++++++++++
>  security/whiteegret/print_msg.h    |  19 ++
>  security/whiteegret/request.c      | 248 ++++++++++++++++++++++++
>  security/whiteegret/request.h      |  79 ++++++++
>  security/whiteegret/returntoexec.h |  14 ++
>  security/whiteegret/we.h           |  72 +++++++
>  security/whiteegret/we_common.h    |  19 ++
>  19 files changed, 1482 insertions(+), 1 deletion(-)
>  create mode 100644 security/whiteegret/Kconfig
>  create mode 100644 security/whiteegret/Makefile
>  create mode 100644 security/whiteegret/auth.c
>  create mode 100644 security/whiteegret/auth.h
>  create mode 100644 security/whiteegret/dd_com.c
>  create mode 100644 security/whiteegret/dd_com.h
>  create mode 100644 security/whiteegret/gennl.c
>  create mode 100644 security/whiteegret/gennl.h
>  create mode 100644 security/whiteegret/gennl_common.h
>  create mode 100644 security/whiteegret/init.c
>  create mode 100644 security/whiteegret/main.c
>  create mode 100644 security/whiteegret/print_msg.h
>  create mode 100644 security/whiteegret/request.c
>  create mode 100644 security/whiteegret/request.h
>  create mode 100644 security/whiteegret/returntoexec.h
>  create mode 100644 security/whiteegret/we.h
>  create mode 100644 security/whiteegret/we_common.h
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 93027fd..acfafb0 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -195,6 +195,7 @@ source security/tomoyo/Kconfig
>  source security/apparmor/Kconfig
>  source security/loadpin/Kconfig
>  source security/yama/Kconfig
> +source security/whiteegret/Kconfig
>  
>  source security/integrity/Kconfig
>  
> @@ -204,6 +205,7 @@ choice
>  	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
>  	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
>  	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> +	default DEFAULT_SECURITY_WHITEEGRET if SECURITY_WHITEEGRET
>  	default DEFAULT_SECURITY_DAC
>  
>  	help
> @@ -222,6 +224,9 @@ choice
>  	config DEFAULT_SECURITY_APPARMOR
>  		bool "AppArmor" if SECURITY_APPARMOR=y
>  
> +	config DEFAULT_SECURITY_WHITEEGRET
> +		bool "WhiteEgret" if SECURITY_WHITEEGRET=y
> +
>  	config DEFAULT_SECURITY_DAC
>  		bool "Unix Discretionary Access Controls"
>  
> @@ -233,7 +238,7 @@ config DEFAULT_SECURITY
>  	default "smack" if DEFAULT_SECURITY_SMACK
>  	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
>  	default "apparmor" if DEFAULT_SECURITY_APPARMOR
> +	default "whiteegret" if DEFAULT_SECURITY_WHITEEGRET
>  	default "" if DEFAULT_SECURITY_DAC
>  
>  endmenu
> -
> diff --git a/security/Makefile b/security/Makefile
> index f2d71cd..4fd9ff9 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -9,6 +9,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
>  subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
>  subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
> +subdir-$(CONFIG_SECURITY_WHITEEGRET)	+= whiteegret
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -24,6 +25,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
>  obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
>  obj-$(CONFIG_SECURITY_YAMA)		+= yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
> +obj-$(CONFIG_SECURITY_WHITEEGRET)	+= whiteegret/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
>  
>  # Object integrity file lists
> diff --git a/security/whiteegret/Kconfig b/security/whiteegret/Kconfig
> new file mode 100644
> index 0000000..923316f
> --- /dev/null
> +++ b/security/whiteegret/Kconfig
> @@ -0,0 +1,21 @@
> +config SECURITY_WHITEEGRET
> +        bool "WhiteEgret support"
> +        depends on SECURITY
> +        default n
> +        help
> +	  This enables the WhiteEgret security module.
> +	  WhiteEgret provides a whitelisting execution control capability,
> +	  which helps to stop the execution of unauthorized software
> +	  such as malware.
> +	  You will also need a user application and an execution whitelist.
> +          If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_WHITEEGRET_DRIVER
> +	bool "Use device driver in communication with user space"
> +	depends on SECURITY_WHITEEGRET
> +	default n
> +	help
> +	  This option selects whether you use a device driver
> +	  for communication between kernel space and user space.
> +	  If you do not set this option, netlink is selected for
> +	  communication between two spaces.
> diff --git a/security/whiteegret/Makefile b/security/whiteegret/Makefile
> new file mode 100644
> index 0000000..ed8eb9f
> --- /dev/null
> +++ b/security/whiteegret/Makefile
> @@ -0,0 +1,7 @@
> +obj-$(CONFIG_SECURITY_WHITEEGRET) += whiteegret.o
> +whiteegret-y := init.o main.o request.o
> +ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +whiteegret-y += dd_com.o
> +else
> +whiteegret-y += gennl.o auth.o
> +endif
> diff --git a/security/whiteegret/auth.c b/security/whiteegret/auth.c
> new file mode 100644
> index 0000000..dd2c9eb
> --- /dev/null
> +++ b/security/whiteegret/auth.c
> @@ -0,0 +1,19 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#include "auth.h"
> +
> +/**
> + * userproc_auth - Authenticate user's whitelisting application process.
> + *
> + * @authinfo: authentication credentials
> + *
> + * Returns 1 if authenticated, 0 otherwise.
> + */
> +int userproc_auth(char *authinfo)
> +{
> +	return 1;
> +}
> diff --git a/security/whiteegret/auth.h b/security/whiteegret/auth.h
> new file mode 100644
> index 0000000..ddcd2dd
> --- /dev/null
> +++ b/security/whiteegret/auth.h
> @@ -0,0 +1,12 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _AUTH_H
> +#define _AUTH_H
> +
> +int userproc_auth(char *authinfo);
> +
> +#endif
> diff --git a/security/whiteegret/dd_com.c b/security/whiteegret/dd_com.c
> new file mode 100644
> index 0000000..534c4d5
> --- /dev/null
> +++ b/security/whiteegret/dd_com.c
> @@ -0,0 +1,79 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#include "dd_com.h"
> +#include "request.h"
> +#include "we.h"
> +#include "print_msg.h"
> +
> +struct task_struct *from_task;
> +
> +/**
> + * start_we - Enable WhiteEgret.
> + *
> + * Returns pointer to we_req_q_head.
> + */
> +struct we_req_q_head *start_we(void)
> +{
> +	if (from_task) {
> +		PRINT_WARNING("WhiteEgret has already started.\n");
> +		return NULL;
> +	}
> +
> +	write_lock(&(we_q_head.lock));
> +	from_task = current;
> +	write_unlock(&(we_q_head.lock));
> +
> +	return &we_q_head;
> +}
> +EXPORT_SYMBOL(start_we);
> +
> +/**
> + * stop_we - Disable WhiteEgret.
> + *
> + * Returns -EPERM if the task invoking this function is not valid,
> + * 0 otherwise.
> + */
> +int stop_we(void)
> +{
> +	if (!from_task) {
> +		PRINT_WARNING("WhiteEgret has not started.\n");
> +		return -EPERM;
> +	}
> +	if (from_task != current) {
> +		PRINT_WARNING("This task is not registered to WhiteEgret.\n");
> +		return -EPERM;
> +	}
> +
> +	we_req_q_cleanup();
> +
> +	write_lock(&(we_q_head.lock));
> +	from_task = NULL;
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(stop_we);
> +
> +/**
> + * send_we_obj_info - Wait response from user's whitelisting application.
> + *
> + * @req: Pointer to struct we_req_q.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int send_we_obj_info(struct we_req_q *req)
> +{
> +	/* If there exists queue waiting for this request req done,
> +	 * then wake up it.
> +	 */
> +	if (waitqueue_active(&(we_q_head.waitq)))
> +		wake_up(&(we_q_head.waitq));
> +
> +	return wait_event_interruptible_timeout(req->waitq,
> +			(req->finish_flag == START_EXEC),
> +			WERESULTTIMEOUT);
> +}
> diff --git a/security/whiteegret/dd_com.h b/security/whiteegret/dd_com.h
> new file mode 100644
> index 0000000..9c7c5b8
> --- /dev/null
> +++ b/security/whiteegret/dd_com.h
> @@ -0,0 +1,19 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _DD_COM_H
> +#define _DD_COM_H
> +
> +#include "request.h"
> +
> +extern struct task_struct *from_task;
> +
> +extern struct we_req_q_head *start_we(void);
> +extern int stop_we(void);
> +
> +int send_we_obj_info(struct we_req_q *req);
> +
> +#endif  /* _DD_COM_H */
> diff --git a/security/whiteegret/gennl.c b/security/whiteegret/gennl.c
> new file mode 100644
> index 0000000..10a1113
> --- /dev/null
> +++ b/security/whiteegret/gennl.c
> @@ -0,0 +1,382 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#include <linux/pid.h>
> +#include <linux/cred.h>
> +#include <linux/security.h>
> +#include <net/genetlink.h>
> +
> +#include "auth.h"
> +#include "gennl_common.h"
> +#include "gennl.h"
> +#include "returntoexec.h"
> +#include "we_common.h"
> +#include "we.h"
> +#include "request.h"
> +#include "print_msg.h"
> +
> +/* global variables */
> +int from_pid = -1;      /* pid of user's whitelisting application */
> +struct net *from_net;
> +u32 seq;		/* sequence number */
> +
> +/* attribute policy */
> +static struct nla_policy we_genl_policy[WE_A_MAX + 1] = {
> +	[WE_A_UNSPEC]       = { .type = NLA_STRING },
> +	[WE_A_AUTHINFO]     = { .type = NLA_BINARY,
> +					.len  = AUTHINFOLENGTH },
> +	[WE_A_SHORTNAME]    = { .type = NLA_STRING,
> +					.len  = SHORTNAMELENGTH },
> +	[WE_A_PATH]         = { .type = NLA_STRING },
> +	[WE_A_EXECPERMISSION]       = { .type = NLA_FLAG },
> +};
> +
> +/* operation definition */
> +static struct genl_ops we_gnl_opses[] = {
> +	{
> +		.cmd    = WE_C_UNSPEC,
> +		.flags  = 0,
> +		.policy = we_genl_policy,
> +		.doit   = we_unspec,
> +		.dumpit = NULL,
> +	},
> +	{
> +		.cmd    = WE_C_USERREGISTER,
> +		.flags  = 0,
> +		.policy = we_genl_policy,
> +		.doit   = we_userregister,
> +		.dumpit = NULL,
> +	},
> +	{
> +		.cmd    = WE_C_USERUNREGISTER,
> +		.flags  = 0,
> +		.policy = we_genl_policy,
> +		.doit   = we_userunregister,
> +		.dumpit = NULL,
> +	},
> +	{
> +		.cmd    = WE_C_EXECPERMISSION,
> +		.flags  = 0,
> +		.policy = we_genl_policy,
> +		.doit   = we_execpermission,
> +		.dumpit = NULL,
> +	},
> +};
> +
> +/* family definition */
> +static struct genl_family we_gnl_family = {
> +	.name = WE_FAMILY_NAME,
> +	.version = WE_FAMILY_VERSION,
> +	.maxattr = WE_A_MAX,
> +	.ops = we_gnl_opses,
> +	.n_ops = ARRAY_SIZE(we_gnl_opses),
> +	.module = THIS_MODULE,
> +};
> +
> +/**
> + * we_netlink_register - Initialize netlink.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_netlink_register(void)
> +{
> +	int rc;
> +
> +	PRINT_INFO("%s starts.\n", __func__);
> +
> +	rc = genl_register_family(&we_gnl_family);
> +	if (rc != 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	from_net = kmalloc(sizeof(struct net), GFP_KERNEL);
> +	if (!from_net) {
> +		rc = -ENOMEM;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	PRINT_WARNING("Netlink is registered by WhiteEgret.\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * we_netlink_unregister - Close netlink.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_netlink_unregister(void)
> +{
> +	int rc;
> +
> +	PRINT_INFO("%s starts.\n", __func__);
> +
> +	rc = genl_unregister_family(&we_gnl_family);
> +	if (rc != 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	if (from_net != NULL) {
> +		kfree(from_net);
> +		from_net = NULL;
> +	}
> +
> +	PRINT_WARNING("Netlink is unregistered by WhiteEgret.\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * we_unspec - Receive handler for unspecified.
> + *
> + * @buf: Pointer to struct sk_buff.
> + * @info: Pointer to struct genl_info.
> + *
> + * Returns 0.
> + */
> +int we_unspec(struct sk_buff *buf, struct genl_info *info)
> +{
> +	PRINT_INFO("Some message is handled at %s.\n", __func__);
> +
> +	/* do something if necessary */
> +
> +	return 0;
> +}
> +
> +/**
> + * we_userregister - Register user's whitelisting application.
> + *
> + * @buf: Pointer to struct sk_buff.
> + * @info: Pointer to struct genl_info.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_userregister(struct sk_buff *buf, struct genl_info *info)
> +{
> +	int rc;
> +	struct pid *usrpid;
> +	struct task_struct *usrtask;
> +#ifdef CONFIG_NET_NS
> +	const struct cred *usrcred;
> +#endif
> +
> +	PRINT_INFO("Some message is handled at %s.\n", __func__);
> +
> +	if (from_pid != -1) {
> +		PRINT_WARNING
> +			("The pid %d is already registered to WhiteEgret.\n",
> +				from_pid);
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	usrpid = find_get_pid(info->snd_portid);
> +	if (usrpid == NULL) {
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	usrtask = get_pid_task(usrpid, PIDTYPE_PID);
> +	if (usrtask == NULL) {
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +#ifdef CONFIG_NET_NS
> +	usrcred = get_task_cred(usrtask);
> +	if (usrcred == NULL) {
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	if ((security_capable(usrcred,  genl_info_net(info)->user_ns,

Do not use the LSM interfaces (security_xxx) inside security modules.
In this case you're probably looking for cap_capable() instead.

> +					CAP_NET_ADMIN)) != 0) {
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +#endif
> +
> +	rc = userproc_auth((char *)nla_data(info->attrs[WE_A_AUTHINFO]));
> +	if (rc <= 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	from_pid = info->snd_portid;
> +	memcpy(from_net, genl_info_net(info), sizeof(struct net));
> +
> +	seq = info->snd_seq;
> +
> +	PRINT_WARNING("The pid %d is registered to WhiteEgret.\n", from_pid);
> +
> +	return 0;
> +}
> +
> +/**
> + * we_userunregister - Unregister user's whitelisting application
> + *				invoked by itself.
> + *
> + * @buf: Pointer to struct sk_buff.
> + * @info: Pointer to struct genl_info.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_userunregister(struct sk_buff *buf, struct genl_info *info)
> +{
> +	int rc;
> +
> +	PRINT_INFO("Some message is handled at %s.\n", __func__);
> +
> +	if (from_pid != info->snd_portid) {
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	rc = userproc_auth((char *)nla_data(info->attrs[WE_A_AUTHINFO]));
> +	if (rc <= 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	PRINT_WARNING("The pid %d is unregistered to WhiteEgret.\n", from_pid);
> +
> +	from_pid = -1;
> +
> +	return 0;
> +}
> +
> +/**
> + * we_execpermission - Receive handler for execution permission.
> + *
> + * @buf: Pointer to struct sk_buff.
> + * @info: Pointer to struct genl_info.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_execpermission(struct sk_buff *buf, struct genl_info *info)
> +{
> +	int rc = 0;
> +	struct we_req_data data;
> +
> +	PRINT_INFO("Some message is handled at %s.\n", __func__);
> +
> +	if (from_pid != info->snd_portid) {
> +		rc = -EACCES;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	data.seq = info->snd_seq;
> +	memcpy(&(data.shortname), nla_data(info->attrs[WE_A_SHORTNAME]),
> +			SHORTNAMELENGTH);
> +	if (we_req_q_search(&data) == NULL) {
> +		PRINT_INFO("(%s, %d) is not waiting for execution.\n",
> +				data.shortname, data.seq);
> +		return 0;
> +	}
> +
> +	rc = returntoexec(nla_get_flag(info->attrs[WE_A_EXECPERMISSION]),
> +			&data);
> +	if (rc != 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	we_req_q_specific_pull(&data);
> +
> +	PRINT_INFO("%s done (%s, %d).\n", __func__, data.shortname, data.seq);
> +
> +	return 0;
> +}
> +
> +/**
> + * send_we_obj_info - Send request for matching white list.
> + *
> + * @we_info: Pointer to struct we_obj_info.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int send_we_obj_info(struct we_obj_info *we_info)
> +{
> +	int rc = 0;
> +	void *msg_head;
> +	struct sk_buff *send_skb;
> +
> +	if ((from_pid == -1) || (from_net == NULL)) {
> +		rc = -EINVAL;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	send_skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (send_skb == NULL) {
> +		rc = -ENOMEM;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	msg_head = genlmsg_put(send_skb, 0, seq, &we_gnl_family, 0,
> +			WE_C_EXECPERMISSION);
> +	if (msg_head == NULL) {
> +		rc = -ENOMEM;
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	rc = nla_put_string(send_skb, WE_A_SHORTNAME,
> +			we_info->shortname);
> +	if (rc != 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	rc = nla_put_string(send_skb, WE_A_PATH, we_info->path);
> +	if (rc != 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	genlmsg_end(send_skb, msg_head);
> +
> +	PRINT_INFO("Msg (%s, %s) sent to the pid %d (current process: %d)\n",
> +			we_info->shortname, we_info->path,
> +			from_pid, we_info->pid);
> +
> +	rc = genlmsg_unicast(from_net, send_skb, from_pid);
> +	if (rc != 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * inc_seq - Increment sequence number.
> + */
> +void inc_seq(void)
> +{
> +	seq += 1;
> +}
> +
> +/**
> + * get_seq - Return sequence number.
> + *
> + * Returns sequence number.
> + */
> +int get_seq(void)
> +{
> +	return seq;
> +}
> diff --git a/security/whiteegret/gennl.h b/security/whiteegret/gennl.h
> new file mode 100644
> index 0000000..8b751b2
> --- /dev/null
> +++ b/security/whiteegret/gennl.h
> @@ -0,0 +1,32 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _GENNL_H
> +#define _GENNL_H
> +
> +#include <net/genetlink.h>
> +#include "we.h"
> +
> +extern int from_pid;
> +
> +/* handler */
> +int we_unspec(struct sk_buff *buf, struct genl_info *info);
> +int we_userregister(struct sk_buff *buf, struct genl_info *info);
> +int we_userunregister(struct sk_buff *buf, struct genl_info *info);
> +int we_execpermission(struct sk_buff *buf, struct genl_info *info);
> +
> +/* register/unregister */
> +int we_netlink_register(void);
> +int we_netlink_unregister(void);
> +
> +/* send message to user space */
> +int send_we_obj_info(struct we_obj_info *info);
> +
> +/* manipulate sequence number */
> +void inc_seq(void);
> +int get_seq(void);
> +
> +#endif  /* _GENNL_H */
> diff --git a/security/whiteegret/gennl_common.h b/security/whiteegret/gennl_common.h
> new file mode 100644
> index 0000000..e59615b
> --- /dev/null
> +++ b/security/whiteegret/gennl_common.h
> @@ -0,0 +1,43 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _GENNL_COMMON_H
> +#define _GENNL_COMMON_H
> +
> +/* UWA stands for User's Whitelisting Application */
> +
> +/* Netlink attributes */
> +enum {
> +	WE_A_UNSPEC,    /* unspecified message */
> +	WE_A_AUTHINFO,  /* authentication info for UWA registration */
> +	WE_A_SHORTNAME, /* short name for an object to be examined */
> +	WE_A_PATH,      /* full path for an object to be examined */
> +	WE_A_EXECPERMISSION, /* flag if the object is in the whitelist */
> +	__WE_A_MAX,
> +};
> +
> +/* Number of netlink attributes */
> +#define WE_A_MAX (__WE_A_MAX - 1)
> +
> +/* Name of genl_family */
> +#define WE_FAMILY_NAME "WhiteEgret"
> +
> +/* Version number of genl_family */
> +#define WE_FAMILY_VERSION 1
> +
> +/* Netlink commands */
> +enum {
> +	WE_C_UNSPEC,          /* unspecified message */
> +	WE_C_USERREGISTER,    /* register UWA */
> +	WE_C_USERUNREGISTER,
> +	WE_C_EXECPERMISSION,  /* execution permission */
> +	__WE_C_MAX,
> +};
> +
> +/* Number of netlink commands */
> +#define WE_C_MAX (__WE_C_MAX - 1)
> +
> +#endif  /* _GENNL_COMMON_H */
> diff --git a/security/whiteegret/init.c b/security/whiteegret/init.c
> new file mode 100644
> index 0000000..76254ef
> --- /dev/null
> +++ b/security/whiteegret/init.c
> @@ -0,0 +1,69 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/security.h>
> +#include <linux/fs.h>
> +#include <linux/lsm_hooks.h>
> +#include "we.h"
> +#include "print_msg.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("WhiteEgret Linux Security Module");
> +MODULE_VERSION("1.0.0");
> +
> +static int we_security_bprm_check(struct linux_binprm *bprm)
> +{
> +	if (we_security_bprm_check_main(bprm) == -EPERM)

EPERM means that you tried to do a privileged operation,
but didn't have the required capabilities. This is more like
EACCES, where you are asking to perform a mundane operation
but don't have access to the object.

This applies to most of the cases where you return EPERM.

> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int we_security_mmap_check(struct file *file, unsigned long reqprot,
> +		unsigned long prot, unsigned long flags)
> +{
> +	if (we_security_mmap_check_main(file, reqprot, flags) == -EPERM)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static struct security_hook_list we_hooks[] = {
> +	LSM_HOOK_INIT(bprm_check_security, we_security_bprm_check),
> +	LSM_HOOK_INIT(mmap_file, we_security_mmap_check),
> +};
> +
> +static int __init we_init(void)
> +{
> +	int rc;
> +
> +	if (!security_module_enable("whiteegret"))
> +		return 0;
> +
> +	security_add_hooks(we_hooks, ARRAY_SIZE(we_hooks), "whiteegret");
> +
> +	rc = we_specific_init();
> +	if (rc) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	PRINT_WARNING("WhiteEgret (LSM) initialized.\n");
> +
> +	return 0;
> +}
> +
> +static void __exit we_exit(void)
> +{
> +	we_specific_exit();
> +
> +	PRINT_WARNING("WhiteEgret (LSM) exited.\n");
> +}
> +
> +module_init(we_init);
> +module_exit(we_exit);
> diff --git a/security/whiteegret/main.c b/security/whiteegret/main.c
> new file mode 100644
> index 0000000..8ba97db
> --- /dev/null
> +++ b/security/whiteegret/main.c
> @@ -0,0 +1,340 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#include <linux/semaphore.h>
> +#include <linux/binfmts.h>
> +#include <linux/dcache.h>
> +#include <linux/fs.h>
> +#include <linux/mman.h>
> +#include "we_common.h"
> +#include "we.h"
> +#include "request.h"
> +#include "print_msg.h"
> +
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +
> +#include <linux/sched.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include "dd_com.h"
> +
> +#else
> +
> +#include "gennl.h"
> +#include "returntoexec.h"
> +
> +struct we_req_data reqdata;  /* data of executable */
> +struct semaphore we_result_lock;
> +int result = -1;                 /* result of matching to white list */
> +
> +#endif
> +
> +static int send_receive_we_obj_info(
> +		struct we_obj_info *we_obj_info, int *checkresult);
> +
> +/**
> + * we_specific_init - Initialize netlink and semaphore.
> + *
> + * Returns 0.
> + */
> +int we_specific_init(void)
> +{
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	int rc = 0;
> +
> +	rc = we_netlink_register();
> +	if (rc < 0) {
> +		PRINT_ERROR(rc);
> +		return rc;
> +	}
> +
> +	sema_init(&we_result_lock, 1);
> +#endif
> +	we_req_q_head_init();
> +
> +	return 0;
> +}
> +
> +/**
> + * we_specific_exit - Close netlink.
> + *
> + * Returns 0.
> + */
> +int we_specific_exit(void)
> +{
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	we_netlink_unregister();
> +#endif
> +
> +	return 0;
> +}
> +
> +/**
> + * we_check_main - Common function for security_bprm_check and mmap_file.
> + *
> + * @file: Pointer to struct file.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_check_main(struct file *file)
> +{
> +	struct we_obj_info we_obj_info;
> +	char *pathnamebuf;
> +	char *new_pathnamebuf;
> +	char *pathname;
> +	char *shortnamebuf;
> +	int pathsize;
> +	int rc;
> +	int i;
> +	int checkresult;
> +
> +	if (unlikely(file == NULL))
> +		return 0;
> +
> +	pathsize = EXPECTPATHSIZE;
> +	pathnamebuf = kmalloc(pathsize, GFP_KERNEL);
> +	if (unlikely(!pathnamebuf)) {
> +		rc = -ENOMEM;
> +		PRINT_ERROR(rc);
> +		goto failure;
> +	}
> +	while (pathsize <= MAXPATHSIZE) {
> +		pathname = d_absolute_path(&file->f_path, pathnamebuf,
> +				pathsize-1);
> +		if (!IS_ERR(pathname))
> +			break;
> +
> +		pathsize += ADDEDEXPECTPATHSIZE;
> +		new_pathnamebuf = krealloc(pathnamebuf, pathsize,
> +				GFP_KERNEL);
> +		if (unlikely(!new_pathnamebuf)) {
> +			rc = -ENOMEM;
> +			PRINT_ERROR(rc);
> +			goto failure;
> +		}
> +		pathnamebuf = new_pathnamebuf;
> +	}
> +	if (unlikely(pathsize >= MAXPATHSIZE)) {
> +		rc = -ENOMEM;
> +		PRINT_ERROR(rc);
> +		goto failure;
> +	}
> +
> +	shortnamebuf = pathname;
> +	for (i = 0; i < pathsize; i++) {
> +		if (pathname[i] == '\0')
> +			break;
> +		if (pathname[i] == '/')
> +			shortnamebuf = pathname + (i + 1);
> +	}
> +	strncpy(we_obj_info.shortname, shortnamebuf, SHORTNAMELENGTH);
> +	we_obj_info.path = pathname;
> +	we_obj_info.pid = current->pid;
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	we_obj_info.pathsize = strlen(pathname);
> +	we_obj_info.ppid = current->tgid;
> +#endif
> +
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	rc = down_timeout(&we_result_lock, WERESULTTIMEOUT);
> +	if (rc != 0)
> +		goto failure;
> +	inc_seq();
> +#endif
> +	rc = send_receive_we_obj_info(&we_obj_info, &checkresult);
> +	if (rc < 0)
> +		goto failure;
> +
> +	rc = checkresult;
> +
> +	if (rc == -EPERM)
> +		PRINT_WARNING("block %s.\n", pathname);
> +	else
> +		PRINT_INFO("permit %s.\n", pathname);
> +
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	up(&we_result_lock);
> +#endif
> +
> +failure:
> +	if (pathnamebuf != NULL) {
> +		kfree(pathnamebuf);
> +		pathnamebuf = NULL;
> +	}
> +
> +	if ((rc != 0) && (rc != -EPERM))
> +		PRINT_WARNING("Checking white list does not work.\n");
> +
> +	return rc;
> +}
> +
> +/**
> + * send_receive_we_obj_info - Send message and wait.
> + *
> + * @we_obj_info: Pointer to struct we_obj_info.
> + * @result: Pointer to result of matching to white list.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +static int send_receive_we_obj_info(
> +		struct we_obj_info *we_obj_info, int *checkresult)
> +{
> +	int i;
> +	int rc;
> +	struct we_req_q req;
> +
> +	we_req_q_init(&req, we_obj_info);
> +
> +	if ((we_req_q_search(&(req.data))) == NULL) {
> +		rc = we_req_q_push(&req);
> +		if (rc < 0) {
> +			PRINT_ERROR(rc);
> +			goto failure;
> +		}
> +	}
> +
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +
> +	for (i = 0; i < MAXCOMRETRY; i++) {
> +		rc = send_we_obj_info(&req);
> +
> +		if (likely(req.finish_flag == START_EXEC)) {
> +			break;
> +		} else if (unlikely(rc == -ERESTARTSYS)) {
> +			rc = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	we_req_q_pop(&req);
> +
> +	if (unlikely(i >= MAXCOMRETRY) && req.finish_flag != START_EXEC) {
> +		rc = -EINVAL;
> +		PRINT_ERROR(rc);
> +	}
> +
> +	*checkresult = req.permit;
> +
> +	return rc;
> +
> +#else
> +
> +	for (i = 0; i < MAXCOMRETRY; i++) {
> +		rc = send_we_obj_info(we_obj_info);
> +		if (rc < 0)
> +			continue;
> +
> +		rc = wait_for_completion_interruptible_timeout(&(req.evt),
> +				WEGENNLTIMEOUT);
> +		if (rc <= 0) {
> +			if (unlikely(rc == -ERESTARTSYS)) {
> +				we_req_q_del(&(req.data));
> +				rc = -EINVAL;
> +				PRINT_ERROR(rc);
> +				goto failure;
> +			}
> +			if (rc == 0)
> +				rc = -ETIMEDOUT;
> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	if (unlikely(i >= MAXCOMRETRY)) {
> +		we_req_q_del(&(req.data));
> +		rc = -EINVAL;
> +		PRINT_ERROR(rc);
> +		goto failure;
> +	}
> +
> +	*checkresult = result;
> +
> +	return 0;
> +
> +#endif  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
> +
> +failure:
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	up(&we_result_lock);
> +#endif
> +	return rc;
> +}
> +
> +/**
> + * we_security_bprm_check_main - Target for security_bprm_check.
> + *
> + * @bprm: Pointer to struct linux_binprm.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_security_bprm_check_main(struct linux_binprm *bprm)
> +{
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	if (unlikely(!from_task))
> +#else
> +	if (unlikely(from_pid == -1))
> +#endif
> +		return 0;
> +
> +	return we_check_main(bprm->file);
> +}
> +
> +/**
> + * we_security_mmap_check_main - Target for mmap_file.
> + *
> + * @file: Pointer to struct file to map.
> + * @reqprot: Protection requested by the application.
> + * @flags: Operational flags.
> + *
> + * Returns 0 if succeeded, < 0 otherwise.
> + */
> +int we_security_mmap_check_main(struct file *file,
> +		unsigned long reqprot, unsigned long flags) {
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	if (unlikely(!from_task))
> +#else
> +	if (unlikely(from_pid == -1))
> +#endif
> +		return 0;
> +
> +	if (!(reqprot & PROT_EXEC))
> +		return 0;
> +
> +	if ((flags & MAP_EXECUTABLE))
> +		return 0;
> +
> +	if (!file)
> +		return 0;
> +
> +	if (!file->f_path.dentry)
> +		return 0;
> +
> +	return we_check_main(file);
> +}
> +
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +
> +/**
> + * returntoexec - Record matching data and result.
> + *
> + * @result_: Result whether targeted object is included in the white list.
> + * @reqdata_: Pointer to struct we_req_data.
> + *
> + * Returns 0.
> + */
> +int returntoexec(int result_, struct we_req_data *reqdata_)
> +{
> +	if (!result_)
> +		result = -EPERM;
> +	else
> +		result = 0;
> +	memcpy(&reqdata, reqdata_, sizeof(struct we_req_data));
> +
> +	return 0;
> +}
> +
> +#endif
> diff --git a/security/whiteegret/print_msg.h b/security/whiteegret/print_msg.h
> new file mode 100644
> index 0000000..2d6fe86
> --- /dev/null
> +++ b/security/whiteegret/print_msg.h
> @@ -0,0 +1,19 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _PRINT_MSG_H
> +#define _PRINT_MSG_H
> +
> +#include <linux/kernel.h>
> +
> +#define __STR(x) #x
> +#define __STR2(x) __STR(x)
> +#define ERROR_MSG "error %d at "__STR2(__LINE__)" on " __STR2(__FILE__)"\n"
> +#define PRINT_ERROR(errno) pr_err("WhiteEgret: " ERROR_MSG, errno)
> +#define PRINT_WARNING(fmt, ...) pr_warn("WhiteEgret: " fmt, ##__VA_ARGS__)
> +#define PRINT_INFO(fmt, ...) pr_info("WhiteEgret: " fmt, ##__VA_ARGS__)
> +
> +#endif
> diff --git a/security/whiteegret/request.c b/security/whiteegret/request.c
> new file mode 100644
> index 0000000..fc1da9b
> --- /dev/null
> +++ b/security/whiteegret/request.c
> @@ -0,0 +1,248 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/rwlock_types.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include "we_common.h"
> +#include "request.h"
> +#include "print_msg.h"
> +
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +#include "gennl.h"
> +#endif
> +
> +struct we_req_q_head we_q_head;
> +
> +static int match_we_req_data(struct we_req_data *data1,
> +		struct we_req_data *data2);
> +
> +/**
> + * we_req_q_init - Initialize the global variable we_q_head.
> + *
> + * Returns 0.
> + */
> +int we_req_q_head_init(void)
> +{
> +	rwlock_init(&(we_q_head.lock));
> +	INIT_LIST_HEAD(&(we_q_head.head));
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	init_waitqueue_head(&(we_q_head.waitq));
> +#endif
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_push - Add queue to tail of the list.
> + *
> + * @queue: Pointer to we_req_q to be added to the list.
> + *
> + * Returns 0.
> + */
> +int we_req_q_push(struct we_req_q *queue)
> +{
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	init_completion(&(queue->evt));
> +#endif
> +
> +	write_lock(&(we_q_head.lock));
> +	list_add_tail(&(queue->queue), &we_q_head.head);
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_search - Search data in the list.
> + *
> + * @data: Pointer to we_req_data to be searched in the list.
> + *
> + * Returns pointer to data if data is found in the list,
> + * NULL otherwise.
> + */
> +struct we_req_q *we_req_q_search(struct we_req_data *data)
> +{
> +	struct list_head *p;
> +	struct we_req_q *req;
> +
> +	read_lock(&(we_q_head.lock));
> +
> +	list_for_each(p, &(we_q_head.head)) {
> +		req = list_entry(p, struct we_req_q, queue);
> +
> +		if (match_we_req_data(data, &(req->data))) {
> +			read_unlock(&(we_q_head.lock));
> +			return req;
> +		}
> +	}
> +
> +	read_unlock(&(we_q_head.lock));
> +
> +	return NULL;
> +}
> +
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +
> +/**
> + * we_req_q_init - Initialize queue.
> + *
> + * @req: Pointer to we_req_q to be initialized.
> + * @info: Pointer to we_obj_info.
> + *
> + * Returns 0.
> + */
> +int we_req_q_init(struct we_req_q *req, struct we_obj_info *info)
> +{
> +	req->finish_flag = STOP_EXEC;
> +	req->data.we_obj_info = info;
> +	req->permit = -EPERM;
> +	init_waitqueue_head(&req->waitq);
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_pop - Delete queue in the list.
> + *
> + * Returns 0.
> + */
> +int we_req_q_pop(struct we_req_q *queue)
> +{
> +	write_lock(&(we_q_head.lock));
> +	list_del(&queue->queue);
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> +
> +/**
> + * match_we_req_data - Compare two we_req_data data.
> + *
> + * @data1: Pointer to we_req_data
> + * @data2: Pointer to we_req_data
> + *
> + * Returns 1 if all members of both we_req_data data are equal,
> + * 0 otherwise.
> + */
> +static int match_we_req_data(struct we_req_data *data1,
> +		struct we_req_data *data2)
> +{
> +	if (data1->we_obj_info->ppid == data2->we_obj_info->ppid)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_cleanup - Cleaning up queues.
> + *
> + * Returns 0.
> + */
> +int we_req_q_cleanup(void)
> +{
> +	struct list_head *p;
> +	struct we_req_q *req;
> +
> +	write_lock(&(we_q_head.lock));
> +	list_for_each(p, &we_q_head.head) {
> +		req = list_entry(p, struct we_req_q, queue);
> +		req->finish_flag = START_EXEC;
> +		req->permit = -EINVAL;
> +	}
> +	write_unlock(&(we_q_head.lock));
> +
> +	return 0;
> +}
> +
> +#else  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
> +
> +/**
> + * we_req_q_init - Initialize queue.
> + *
> + * @req: Pointer to we_req_q to be initialized.
> + * @info: Pointer to we_obj_info.
> + *
> + * Returns 0.
> + */
> +int we_req_q_init(struct we_req_q *req, struct we_obj_info *info)
> +{
> +	strncpy(req->data.shortname, info->shortname, SHORTNAMELENGTH);
> +	req->data.seq = get_seq();
> +
> +	return 0;
> +}
> +
> +/**
> + * we_req_q_specific_pull - Wait completion and delete queue in the list.
> + *
> + * @data: Pointer to we_req_data to be deleteed in the list.
> + *
> + * Returns WE_FOUND_REQUEST if data is found in the list,
> + * WE_NOT_FOUND_REQUEST otherwise.
> + */
> +int we_req_q_specific_pull(struct we_req_data *data)
> +{
> +	struct we_req_q *req;
> +
> +	req = we_req_q_search(data);
> +	if (req != NULL) {
> +		write_lock(&(we_q_head.lock));
> +		complete_all(&(req->evt));
> +		list_del(&req->queue);
> +		write_unlock(&(we_q_head.lock));
> +		return WE_FOUND_REQUEST;
> +	}
> +
> +	return WE_NOTFOUND_REQUEST;
> +}
> +
> +/**
> + * we_req_q_del - Delete queue in the list.
> + *
> + * @data: Pointer to we_req_data to be deleteed in the list.
> + *
> + * Returns WE_FOUND_REQUEST if data is found in the list,
> + * WE_NOT_FOUND_REQUEST otherwise.
> + */
> +int we_req_q_del(struct we_req_data *data)
> +{
> +	struct we_req_q *req;
> +
> +	req = we_req_q_search(data);
> +	if (req != NULL) {
> +		write_lock(&(we_q_head.lock));
> +		list_del(&req->queue);
> +		write_unlock(&(we_q_head.lock));
> +		return WE_FOUND_REQUEST;
> +	}
> +
> +	return WE_NOTFOUND_REQUEST;
> +}
> +
> +/**
> + * match_we_req_data - Compare two we_req_data data.
> + *
> + * @data1: Pointer to we_req_data
> + * @data2: Pointer to we_req_data
> + *
> + * Returns 1 if all members of both we_req_data data are equal,
> + * 0 otherwise.
> + */
> +static int match_we_req_data(struct we_req_data *data1,
> +		struct we_req_data *data2)
> +{
> +	if (strncmp(data1->shortname, data2->shortname, SHORTNAMELENGTH) == 0) {
> +		if (data1->seq == data2->seq)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +#endif  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
> diff --git a/security/whiteegret/request.h b/security/whiteegret/request.h
> new file mode 100644
> index 0000000..1ad9439
> --- /dev/null
> +++ b/security/whiteegret/request.h
> @@ -0,0 +1,79 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _REQUEST_H
> +#define _REQUEST_H
> +
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +
> +#include "we.h"
> +
> +struct we_req_q_head {
> +	struct list_head head;
> +	rwlock_t lock;
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	wait_queue_head_t waitq;
> +#endif
> +};
> +
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +
> +#define STOP_EXEC  0
> +#define START_EXEC 1
> +
> +extern struct we_req_q_head we_q_head;
> +
> +/* Structure for information of request from kernel space to user space */
> +struct we_req_data {
> +	struct we_obj_info *we_obj_info;
> +};
> +
> +struct we_req_q {
> +	struct list_head queue;
> +	int finish_flag;
> +	struct we_req_data data;
> +	int permit;
> +	wait_queue_head_t waitq;
> +};
> +
> +int we_req_q_pop(struct we_req_q *queue);
> +int we_req_q_cleanup(void);
> +
> +#else  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
> +
> +#include <linux/completion.h>
> +
> +/* Return values of searching queue of requests */
> +enum {
> +	WE_NOTFOUND_REQUEST,
> +	WE_FOUND_REQUEST
> +};
> +
> +/* Structure for information of request from kernel space to user space */
> +struct we_req_data {
> +	char shortname[SHORTNAMELENGTH];  /* file name */
> +	u32 seq;                          /* sequence number */
> +};
> +
> +/* Structure for queue of requests */
> +struct we_req_q {
> +	struct list_head queue;
> +	struct completion evt;
> +	struct we_req_data data;
> +};
> +
> +int we_req_q_specific_pull(struct we_req_data *data);
> +int we_req_q_del(struct we_req_data *data);
> +
> +#endif  /* CONFIG_SECURITY_WHITEEGRET_DRIVER */
> +
> +int we_req_q_head_init(void);
> +int we_req_q_init(struct we_req_q *req, struct we_obj_info *info);
> +int we_req_q_push(struct we_req_q *queue);
> +struct we_req_q *we_req_q_search(struct we_req_data *data);
> +
> +#endif  /* _REQUEST_H */
> diff --git a/security/whiteegret/returntoexec.h b/security/whiteegret/returntoexec.h
> new file mode 100644
> index 0000000..7fae897
> --- /dev/null
> +++ b/security/whiteegret/returntoexec.h
> @@ -0,0 +1,14 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _RETURNTOEXEC_H
> +#define _RETURNTOEXEC_H
> +
> +#include "request.h"
> +
> +int returntoexec(int result_, struct we_req_data *reqdata_);
> +
> +#endif
> diff --git a/security/whiteegret/we.h b/security/whiteegret/we.h
> new file mode 100644
> index 0000000..4a357e6
> --- /dev/null
> +++ b/security/whiteegret/we.h
> @@ -0,0 +1,72 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _WE_H
> +#define _WE_H
> +
> +#include <linux/binfmts.h>
> +#include <linux/version.h>
> +#include "we_common.h"
> +
> +/*
> + * Initial size in byte of memory allocation to store the path
> + * of an object file
> + */
> +#define EXPECTPATHSIZE 1023
> +
> +/*
> + * Default size in byte to expand block that stores the path
> + * of an object file when the memory block is too small
> + * to store the path
> + */
> +#define ADDEDEXPECTPATHSIZE 1023
> +
> +/* Maximum length in byte of path of object file */
> +#define MAXPATHSIZE 8184
> +
> +/*
> + * Maximum number of retry for sending the same message
> + * to user whitelisting application
> + */
> +#define MAXCOMRETRY 3
> +
> +/* Timeout value in millisecond to aquire the semaphore */
> +#define WERESULTTIMEOUT 1000
> +
> +#ifndef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +
> +/*
> + * Timeout value in jiffies to wait response from
> + * user whitelisting application
> + */
> +#define WEGENNLTIMEOUT 1000
> +
> +#endif
> +
> +/*
> + * Structure for an object to be tested whether it is contained
> + * in the whitelist or not
> + */
> +struct we_obj_info {
> +	char shortname[SHORTNAMELENGTH];  /* short name for the object */
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	int pathsize;
> +#endif
> +	char *path;                       /* full path to the object */
> +	pid_t pid;
> +#ifdef CONFIG_SECURITY_WHITEEGRET_DRIVER
> +	pid_t ppid;
> +#endif
> +};
> +
> +int we_security_bprm_check_main(struct linux_binprm *bprm);
> +int we_security_mmap_check_main(struct file *file,
> +		unsigned long reqprot, unsigned long flags);
> +
> +int we_specific_init(void);
> +int we_specific_exit(void);
> +
> +#endif  /* _WE_H */
> diff --git a/security/whiteegret/we_common.h b/security/whiteegret/we_common.h
> new file mode 100644
> index 0000000..1288562
> --- /dev/null
> +++ b/security/whiteegret/we_common.h
> @@ -0,0 +1,19 @@
> +/*
> + * WhiteEgret Linux Security Module
> + *
> + * Copyright (C) 2017 Toshiba Corporation
> + */
> +
> +#ifndef _WE_COMMON_H
> +#define _WE_COMMON_H
> +
> +/*
> + * Maximum length in byte of authentication credentials
> + * of user's whitelisting application
> + */
> +#define AUTHINFOLENGTH	0
> +
> +/* Maximum length in byte of name of executable file */
> +#define SHORTNAMELENGTH	256
> +
> +#endif  /* _WE_COMMON_H */

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
