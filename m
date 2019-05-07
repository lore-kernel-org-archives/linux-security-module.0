Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B8C004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D320989
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEGT5P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 15:57:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfEGT5P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 15:57:15 -0400
Received: from static-50-53-34-51.bvtn.or.frontiernet.net ([50.53.34.51] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hO6D5-0008Vu-O6; Tue, 07 May 2019 19:57:08 +0000
Subject: Re: [PATCH v4] apparmor: Use a memory pool instead per-CPU caches
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
References: <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
 <20190430144725.gd6r3aketxuqdyir@linutronix.de>
 <02d7772b-5d06-1c32-b089-454547fbe08b@canonical.com>
 <20190502105158.2hluemukrdz5hbus@linutronix.de>
 <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
 <20190502134730.d3ya46ave6a7bvom@linutronix.de>
 <001f651f-c544-c3fa-c0c2-f2a2b1ed565a@i-love.sakura.ne.jp>
 <20190503114827.yky7r2cjq7zy4dfm@linutronix.de>
 <20190503115145.anv7z4kk7okydthm@linutronix.de>
 <56de7347-b119-155d-675c-23a227ffd516@i-love.sakura.ne.jp>
 <20190503141221.qvqdfbfmmmzc7gfr@linutronix.de>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <b2bb1be2-2130-3d77-2430-1de526accf2a@canonical.com>
Date:   Tue, 7 May 2019 12:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503141221.qvqdfbfmmmzc7gfr@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/3/19 7:12 AM, Sebastian Andrzej Siewior wrote:
> The get_buffers() macro may provide one or two buffers to the caller.
> Those buffers are pre-allocated on init for each CPU. By default it
> allocates
> 	2* 2 * MAX_PATH * POSSIBLE_CPU
> 
> which equals 64KiB on a system with 4 CPUs or 1MiB with 64 CPUs and so
> on.
> 
> Replace the per-CPU buffers with a common memory pool which is shared
> across all CPUs. The pool grows on demand and never shrinks. The pool
> starts with two (UP) or four (SMP) elements. By using this pool it is
> possible to request a buffer and keeping preemption enabled which avoids
> the hack in profile_transition().
> 
> It has been pointed out by Tetsuo Handa that GFP_KERNEL allocations for
> small amount of memory do not fail. In order not to have an endless
> retry, __GFP_RETRY_MAYFAIL is passed (so the memory allocation is not
> repeated until success) and retried once hoping that in the meantime a
> buffer has been returned to the pool. Since now NULL is possible all
> allocation paths check the buffer pointer and return -ENOMEM on failure.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I am going to pull this into my tree and let it sit in linux-next
for a cycle so we can get better testing on this before it is pushed
out


> ---
> v3…v4:
>    - let aa_put_buffer() accept a NULL pointer, noticed by Tetsuo Handa
> 
> v2…v3:
>    - remove an unused flags variable.
> 
> v1…v2:
>    - Use max_t instead min_t for a minimal buffer.
>    - Pre-allocate 2 buffers on UP and 4 buffers on SMP systems.
>    - Use __GFP_RETRY_MAYFAIL | __GFP_NOWARN on memory allocation. The
>      allocation may fail under pressure and we will retry once.
>    - Add an error path to each caller of aa_get_buffer() if the memory
>      allocation fails.
> 
>  security/apparmor/domain.c       |  24 +++----
>  security/apparmor/file.c         |  24 +++++--
>  security/apparmor/include/path.h |  49 +-------------
>  security/apparmor/lsm.c          | 107 +++++++++++++++++++++++--------
>  security/apparmor/mount.c        |  65 +++++++++++++++----
>  5 files changed, 161 insertions(+), 108 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index ca2dccf5b445e..cae0e619ff4fe 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -689,20 +689,9 @@ static struct aa_label *profile_transition(struct aa_profile *profile,
>  	} else if (COMPLAIN_MODE(profile)) {
>  		/* no exec permission - learning mode */
>  		struct aa_profile *new_profile = NULL;
> -		char *n = kstrdup(name, GFP_ATOMIC);
>  
> -		if (n) {
> -			/* name is ptr into buffer */
> -			long pos = name - buffer;
> -			/* break per cpu buffer hold */
> -			put_buffers(buffer);
> -			new_profile = aa_new_null_profile(profile, false, n,
> -							  GFP_KERNEL);
> -			get_buffers(buffer);
> -			name = buffer + pos;
> -			strcpy((char *)name, n);
> -			kfree(n);
> -		}
> +		new_profile = aa_new_null_profile(profile, false, name,
> +						  GFP_KERNEL);
>  		if (!new_profile) {
>  			error = -ENOMEM;
>  			info = "could not create null profile";
> @@ -907,7 +896,12 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  		ctx->nnp = aa_get_label(label);
>  
>  	/* buffer freed below, name is pointer into buffer */
> -	get_buffers(buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer) {
> +		error = -ENOMEM;
> +		goto done;
> +	}
> +
>  	/* Test for onexec first as onexec override other x transitions. */
>  	if (ctx->onexec)
>  		new = handle_onexec(label, ctx->onexec, ctx->token,
> @@ -979,7 +973,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  
>  done:
>  	aa_put_label(label);
> -	put_buffers(buffer);
> +	aa_put_buffer(buffer);
>  
>  	return error;
>  
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index d0afed9ebd0ed..7b424e73a8c74 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -336,12 +336,14 @@ int aa_path_perm(const char *op, struct aa_label *label,
>  
>  	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
>  								0);
> -	get_buffers(buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer)
> +		return -ENOMEM;
>  	error = fn_for_each_confined(label, profile,
>  			profile_path_perm(op, profile, path, buffer, request,
>  					  cond, flags, &perms));
>  
> -	put_buffers(buffer);
> +	aa_put_buffer(buffer);
>  
>  	return error;
>  }
> @@ -479,12 +481,18 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
>  	int error;
>  
>  	/* buffer freed below, lname is pointer in buffer */
> -	get_buffers(buffer, buffer2);
> +	buffer = aa_get_buffer();
> +	buffer2 = aa_get_buffer();
> +	error = -ENOMEM;
> +	if (!buffer || !buffer2)
> +		goto out;
> +
>  	error = fn_for_each_confined(label, profile,
>  			profile_path_link(profile, &link, buffer, &target,
>  					  buffer2, &cond));
> -	put_buffers(buffer, buffer2);
> -
> +out:
> +	aa_put_buffer(buffer);
> +	aa_put_buffer(buffer2);
>  	return error;
>  }
>  
> @@ -528,7 +536,9 @@ static int __file_path_perm(const char *op, struct aa_label *label,
>  		return 0;
>  
>  	flags = PATH_DELEGATE_DELETED | (S_ISDIR(cond.mode) ? PATH_IS_DIR : 0);
> -	get_buffers(buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer)
> +		return -ENOMEM;
>  
>  	/* check every profile in task label not in current cache */
>  	error = fn_for_each_not_in_set(flabel, label, profile,
> @@ -557,7 +567,7 @@ static int __file_path_perm(const char *op, struct aa_label *label,
>  	if (!error)
>  		update_file_ctx(file_ctx(file), label, request);
>  
> -	put_buffers(buffer);
> +	aa_put_buffer(buffer);
>  
>  	return error;
>  }
> diff --git a/security/apparmor/include/path.h b/security/apparmor/include/path.h
> index b6380c5f00972..b0b2ab85e42d8 100644
> --- a/security/apparmor/include/path.h
> +++ b/security/apparmor/include/path.h
> @@ -15,7 +15,6 @@
>  #ifndef __AA_PATH_H
>  #define __AA_PATH_H
>  
> -
>  enum path_flags {
>  	PATH_IS_DIR = 0x1,		/* path is a directory */
>  	PATH_CONNECT_PATH = 0x4,	/* connect disconnected paths to / */
> @@ -30,51 +29,7 @@ int aa_path_name(const struct path *path, int flags, char *buffer,
>  		 const char **name, const char **info,
>  		 const char *disconnected);
>  
> -#define MAX_PATH_BUFFERS 2
> -
> -/* Per cpu buffers used during mediation */
> -/* preallocated buffers to use during path lookups */
> -struct aa_buffers {
> -	char *buf[MAX_PATH_BUFFERS];
> -};
> -
> -#include <linux/percpu.h>
> -#include <linux/preempt.h>
> -
> -DECLARE_PER_CPU(struct aa_buffers, aa_buffers);
> -
> -#define ASSIGN(FN, A, X, N) ((X) = FN(A, N))
> -#define EVAL1(FN, A, X) ASSIGN(FN, A, X, 0) /*X = FN(0)*/
> -#define EVAL2(FN, A, X, Y...)	\
> -	do { ASSIGN(FN, A, X, 1);  EVAL1(FN, A, Y); } while (0)
> -#define EVAL(FN, A, X...) CONCATENATE(EVAL, COUNT_ARGS(X))(FN, A, X)
> -
> -#define for_each_cpu_buffer(I) for ((I) = 0; (I) < MAX_PATH_BUFFERS; (I)++)
> -
> -#ifdef CONFIG_DEBUG_PREEMPT
> -#define AA_BUG_PREEMPT_ENABLED(X) AA_BUG(preempt_count() <= 0, X)
> -#else
> -#define AA_BUG_PREEMPT_ENABLED(X) /* nop */
> -#endif
> -
> -#define __get_buffer(C, N) ({						\
> -	AA_BUG_PREEMPT_ENABLED("__get_buffer without preempt disabled");  \
> -	(C)->buf[(N)]; })
> -
> -#define __get_buffers(C, X...)    EVAL(__get_buffer, C, X)
> -
> -#define __put_buffers(X, Y...) ((void)&(X))
> -
> -#define get_buffers(X...)						\
> -do {									\
> -	struct aa_buffers *__cpu_var = get_cpu_ptr(&aa_buffers);	\
> -	__get_buffers(__cpu_var, X);					\
> -} while (0)
> -
> -#define put_buffers(X, Y...)		\
> -do {					\
> -	__put_buffers(X, Y);		\
> -	put_cpu_ptr(&aa_buffers);	\
> -} while (0)
> +char *aa_get_buffer(void);
> +void aa_put_buffer(char *buf);
>  
>  #endif /* __AA_PATH_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 87500bde5a92d..c5915a6853738 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -47,8 +47,13 @@
>  /* Flag indicating whether initialization completed */
>  int apparmor_initialized;
>  
> -DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
> +union aa_buffer {
> +	struct list_head list;
> +	char buffer[1];
> +};
>  
> +static LIST_HEAD(aa_global_buffers);
> +static DEFINE_SPINLOCK(aa_buffers_lock);
>  
>  /*
>   * LSM hook functions
> @@ -1406,6 +1411,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
>  		return -EPERM;
>  
>  	error = param_set_uint(val, kp);
> +	aa_g_path_max = max_t(uint32_t, aa_g_path_max, sizeof(union aa_buffer));
>  	pr_info("AppArmor: buffer size set to %d bytes\n", aa_g_path_max);
>  
>  	return error;
> @@ -1518,6 +1524,48 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>  	return 0;
>  }
>  
> +char *aa_get_buffer(void)
> +{
> +	union aa_buffer *aa_buf;
> +	bool try_again = true;
> +
> +retry:
> +	spin_lock(&aa_buffers_lock);
> +	if (!list_empty(&aa_global_buffers)) {
> +		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
> +					  list);
> +		list_del(&aa_buf->list);
> +		spin_unlock(&aa_buffers_lock);
> +		return &aa_buf->buffer[0];
> +	}
> +	spin_unlock(&aa_buffers_lock);
> +
> +	aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			 __GFP_NOWARN);
> +	if (!aa_buf) {
> +		if (try_again) {
> +			try_again = false;
> +			goto retry;
> +		}
> +		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
> +		return NULL;
> +	}
> +	return &aa_buf->buffer[0];
> +}
> +
> +void aa_put_buffer(char *buf)
> +{
> +	union aa_buffer *aa_buf;
> +
> +	if (!buf)
> +		return;
> +	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
> +
> +	spin_lock(&aa_buffers_lock);
> +	list_add(&aa_buf->list, &aa_global_buffers);
> +	spin_unlock(&aa_buffers_lock);
> +}
> +
>  /*
>   * AppArmor init functions
>   */
> @@ -1538,38 +1586,48 @@ static int __init set_init_ctx(void)
>  
>  static void destroy_buffers(void)
>  {
> -	u32 i, j;
> +	union aa_buffer *aa_buf;
>  
> -	for_each_possible_cpu(i) {
> -		for_each_cpu_buffer(j) {
> -			kfree(per_cpu(aa_buffers, i).buf[j]);
> -			per_cpu(aa_buffers, i).buf[j] = NULL;
> -		}
> +	spin_lock(&aa_buffers_lock);
> +	while (!list_empty(&aa_global_buffers)) {
> +		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
> +					 list);
> +		list_del(&aa_buf->list);
> +		spin_unlock(&aa_buffers_lock);
> +		kfree(aa_buf);
> +		spin_lock(&aa_buffers_lock);
>  	}
> +	spin_unlock(&aa_buffers_lock);
>  }
>  
>  static int __init alloc_buffers(void)
>  {
> -	u32 i, j;
> +	union aa_buffer *aa_buf;
> +	int i, num;
>  
> -	for_each_possible_cpu(i) {
> -		for_each_cpu_buffer(j) {
> -			char *buffer;
> +	/*
> +	 * A function may require two buffers at once. Usually the buffers are
> +	 * used for a short period of time and are shared. On UP kernel buffers
> +	 * two should be enough, with more CPUs it is possible that more
> +	 * buffers will be used simultaneously. The preallocated pool may grow.
> +	 * This preallocation has also the side-effect that AppArmor will be
> +	 * disabled early at boot if aa_g_path_max is extremly high.
> +	 */
> +	if (num_online_cpus() > 1)
> +		num = 4;
> +	else
> +		num = 2;
>  
> -			if (cpu_to_node(i) > num_online_nodes())
> -				/* fallback to kmalloc for offline nodes */
> -				buffer = kmalloc(aa_g_path_max, GFP_KERNEL);
> -			else
> -				buffer = kmalloc_node(aa_g_path_max, GFP_KERNEL,
> -						      cpu_to_node(i));
> -			if (!buffer) {
> -				destroy_buffers();
> -				return -ENOMEM;
> -			}
> -			per_cpu(aa_buffers, i).buf[j] = buffer;
> +	for (i = 0; i < num; i++) {
> +
> +		aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL |
> +				 __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> +		if (!aa_buf) {
> +			destroy_buffers();
> +			return -ENOMEM;
>  		}
> +		aa_put_buffer(&aa_buf->buffer[0]);
>  	}
> -
>  	return 0;
>  }
>  
> @@ -1734,7 +1792,7 @@ static int __init apparmor_init(void)
>  	error = alloc_buffers();
>  	if (error) {
>  		AA_ERROR("Unable to allocate work buffers\n");
> -		goto buffers_out;
> +		goto alloc_out;
>  	}
>  
>  	error = set_init_ctx();
> @@ -1759,7 +1817,6 @@ static int __init apparmor_init(void)
>  
>  buffers_out:
>  	destroy_buffers();
> -
>  alloc_out:
>  	aa_destroy_aafs();
>  	aa_teardown_dfa_engine();
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index 8c3787399356b..267a26fba14e1 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -412,11 +412,13 @@ int aa_remount(struct aa_label *label, const struct path *path,
>  
>  	binary = path->dentry->d_sb->s_type->fs_flags & FS_BINARY_MOUNTDATA;
>  
> -	get_buffers(buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer)
> +		return -ENOMEM;
>  	error = fn_for_each_confined(label, profile,
>  			match_mnt(profile, path, buffer, NULL, NULL, NULL,
>  				  flags, data, binary));
> -	put_buffers(buffer);
> +	aa_put_buffer(buffer);
>  
>  	return error;
>  }
> @@ -441,11 +443,18 @@ int aa_bind_mount(struct aa_label *label, const struct path *path,
>  	if (error)
>  		return error;
>  
> -	get_buffers(buffer, old_buffer);
> +	buffer = aa_get_buffer();
> +	old_buffer = aa_get_buffer();
> +	error = -ENOMEM;
> +	if (!buffer || old_buffer)
> +		goto out;
> +
>  	error = fn_for_each_confined(label, profile,
>  			match_mnt(profile, path, buffer, &old_path, old_buffer,
>  				  NULL, flags, NULL, false));
> -	put_buffers(buffer, old_buffer);
> +out:
> +	aa_put_buffer(buffer);
> +	aa_put_buffer(old_buffer);
>  	path_put(&old_path);
>  
>  	return error;
> @@ -465,11 +474,13 @@ int aa_mount_change_type(struct aa_label *label, const struct path *path,
>  	flags &= (MS_REC | MS_SILENT | MS_SHARED | MS_PRIVATE | MS_SLAVE |
>  		  MS_UNBINDABLE);
>  
> -	get_buffers(buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer)
> +		return -ENOMEM;
>  	error = fn_for_each_confined(label, profile,
>  			match_mnt(profile, path, buffer, NULL, NULL, NULL,
>  				  flags, NULL, false));
> -	put_buffers(buffer);
> +	aa_put_buffer(buffer);
>  
>  	return error;
>  }
> @@ -492,11 +503,17 @@ int aa_move_mount(struct aa_label *label, const struct path *path,
>  	if (error)
>  		return error;
>  
> -	get_buffers(buffer, old_buffer);
> +	buffer = aa_get_buffer();
> +	old_buffer = aa_get_buffer();
> +	error = -ENOMEM;
> +	if (!buffer || !old_buffer)
> +		goto out;
>  	error = fn_for_each_confined(label, profile,
>  			match_mnt(profile, path, buffer, &old_path, old_buffer,
>  				  NULL, MS_MOVE, NULL, false));
> -	put_buffers(buffer, old_buffer);
> +out:
> +	aa_put_buffer(buffer);
> +	aa_put_buffer(old_buffer);
>  	path_put(&old_path);
>  
>  	return error;
> @@ -537,17 +554,29 @@ int aa_new_mount(struct aa_label *label, const char *dev_name,
>  		}
>  	}
>  
> -	get_buffers(buffer, dev_buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer) {
> +		error = -ENOMEM;
> +		goto out;
> +	}
>  	if (dev_path) {
>  		error = fn_for_each_confined(label, profile,
>  			match_mnt(profile, path, buffer, dev_path, dev_buffer,
>  				  type, flags, data, binary));
>  	} else {
> +		dev_buffer = aa_get_buffer();
> +		if (!dev_buffer) {
> +			error = -ENOMEM;
> +			goto out;
> +		}
>  		error = fn_for_each_confined(label, profile,
>  			match_mnt_path_str(profile, path, buffer, dev_name,
>  					   type, flags, data, binary, NULL));
>  	}
> -	put_buffers(buffer, dev_buffer);
> +
> +out:
> +	aa_put_buffer(buffer);
> +	aa_put_buffer(dev_buffer);
>  	if (dev_path)
>  		path_put(dev_path);
>  
> @@ -595,10 +624,13 @@ int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)
>  	AA_BUG(!label);
>  	AA_BUG(!mnt);
>  
> -	get_buffers(buffer);
> +	buffer = aa_get_buffer();
> +	if (!buffer)
> +		return -ENOMEM;
> +
>  	error = fn_for_each_confined(label, profile,
>  			profile_umount(profile, &path, buffer));
> -	put_buffers(buffer);
> +	aa_put_buffer(buffer);
>  
>  	return error;
>  }
> @@ -671,7 +703,11 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
>  	AA_BUG(!old_path);
>  	AA_BUG(!new_path);
>  
> -	get_buffers(old_buffer, new_buffer);
> +	old_buffer = aa_get_buffer();
> +	new_buffer = aa_get_buffer();
> +	error = -ENOMEM;
> +	if (!old_buffer || !new_buffer)
> +		goto out;
>  	target = fn_label_build(label, profile, GFP_ATOMIC,
>  			build_pivotroot(profile, new_path, new_buffer,
>  					old_path, old_buffer));
> @@ -690,7 +726,8 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
>  		/* already audited error */
>  		error = PTR_ERR(target);
>  out:
> -	put_buffers(old_buffer, new_buffer);
> +	aa_put_buffer(old_buffer);
> +	aa_put_buffer(new_buffer);
>  
>  	return error;
>  
> 

