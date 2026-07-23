Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E73401A13
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843979; cv=none; b=qKyUir/tWJgyco/7S/8FWFhIuf4ognOWZWc8ZxX59IIy6VPCEC47AvM4ikTTJ3/vmNMo/2AhGe82XsKv56toUpg53avN6FS1R4AHHlmg04I4PnvV9w20IkdfdQ4INyAmljd0687iDo90TDGPyfN3g0mhwdPtx/f+hYVYiKYT2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843979; c=relaxed/simple;
	bh=GGXG19D9QF2bR6ErHIN10zpExaaH5BIB04ptF6V8754=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRRTXUmaZ0OUewZSSVU0MDq5cdx4onM5OQOt6l3AmFjsjG8K3GY1uZn18Y0teVeayE5hSEpR+u4nZpfRD9AM2Tgjj1cxCCOkRA/exYAwXdAOVUcGXwNSnzAmwCbwUilzg4/ty6ekkFKnX/GTKOvnnd6WOhE59cLmehVrELTzSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAkLK9Uk; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAkLK9Uk"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ef8255cccso9428387b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843968; x=1785448768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o3oDPcP+InhIXfQ4W1pk+DWhhhPd6pqOphnRvMY6/2k=;
        b=dAkLK9UkmF/pg7SEzCv7NwHnUZq7z+uaQWjsmcRhY7Wd/OSjIpcwNiL094gu+fuTqn
         WsePuzwnYMZbYF3Gvx7qGriR2dcg8eo4hBDD9qFH7xcw957Hgk6M7enUvbXCoGPDKquK
         3E/PnTrnR927frZGRHKqhmFfK9Y9rq9hYGRkS2H9zTGMg6wMExBaLxzt6t4M3MI/chYu
         3BrMMVlwx+Owp2hHO5xUT0L9eUiPxbsTCIvm2jM9UMCr3IiwBy3JCnnQ+X+9Zxh8ruLN
         YF+1sDyQ/isvyhuyYbViGfiSokT4mNeryJ7BkdFhwxOYfJHxODZtaL4H+zNJerBjdAud
         VgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843968; x=1785448768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3oDPcP+InhIXfQ4W1pk+DWhhhPd6pqOphnRvMY6/2k=;
        b=cigAHVecmwk77Tf+iX/jb5ulhZxKfmyWqas2H8n7EszhtTgcL7101yyb+mbVysa7Bb
         Ht06NvTCEITJhhdmKaQNAOZamsnaKGWRQdPqlyc5qUlHswY+a+YNp+3IarWcX/9xTrYe
         0hxITddN+eCV0KlKvqajW1Y+BD91tppUdr8nUXzGCSVTvpO/5549MUd8jaC2eHyDC42m
         fTjdoUXT+GrajXFkLoCVbRQlTX0AzXtDNd90URjnFqqdFmB7lVUOc8QlDcLPGbJbGkc2
         1MF0GQUGRCHE/czXTEbilQtywL8taVQsIwOAutNphYThTCcqto26hcDsg2JdZzmrTyn6
         aRkA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1uPf1BhwZ3KvULteuxo8ZIzOl0knc92YD9E0aryHGe8jDb1wSQh95okQLTb8gyi/yJyMM+Ro7fTWf4Id9p1Dzo+HIIyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDClrWWAzQFIDjDtzrNcPF1yI+WFyT3YFzHcj113I9LgVaSmk3
	zv4939T1MXkIngYy/MAXG7IzhxRuer4O1tVtezUzq5h2Bx5Cv78YaYhW
X-Gm-Gg: AR+sD125h1wEDJK29C3r9R0Wi5It4aLrwtuj134p4stO6tM41knMQtmyOmmib4YVSwl
	qY9XkXy9PzMBhhFHZ0Z9N5JGdG+8BxkKwUdIKL46vXyv8eL2z6GLT6ySPr4OX0WjTUvBYdiNveT
	gp0fXfxTSomt2kCn1ZGkHHTSU3/hnC+oIQVE/FfTDfB7EwcXKPYBYF4DhhWUMwv84kPUGHK0WPZ
	pjOmi6mmsrGagU8UVtxwCV1Biwj/hwdQalAn51+Wxi79VRUuQMIEG+1a8OVWzjxTyMsIWo7tYcS
	19JA9H0VByHnrMNcTh+pwyXe1w1eCnfrZFHNse4A7De1oCjlfYYWHubLgf6nlS0gBuwXTuUWvvE
	b2mhJUZtBBHvY1HK4qhdUZj04HFlYE3nO6RgZ78fd+qyiHcxf/vzGo65ZPPhV4rMeLkk+IsHG2E
	uwAEQCgoAWCaZC99IW3R8sMAClyEvYTI6+gnAnhiwMtHAEq0SdUZT6
X-Received: by 2002:a05:690c:a87:b0:81e:6bd6:39a5 with SMTP id 00721157ae682-81f4c17388bmr15933597b3.1.1784843968453;
        Thu, 23 Jul 2026 14:59:28 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:14cb:1782:889d:964])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c397c9sm34776687b3.14.2026.07.23.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:59:28 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:59:27 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Oxana Kharitonova <oxana@cloudflare.com>
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.or, serge@hallyn.com, wangyan01@kylinos.cn, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, landlock@lists.linux.dev, 
	webprosto@gmail.com
Subject: Re: [PATCH 2/6] landlock: Scope POSIX message queue opens
Message-ID: <amKDYoOSvHMzVbKX@suesslenovo>
References: <20260722122952.42149-1-oxana@cloudflare.com>
 <20260722122952.42149-3-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722122952.42149-3-oxana@cloudflare.com>

On Wed, Jul 22, 2026 at 01:29:38PM +0100, Oxana Kharitonova wrote:
> Add support for enforcing LANDLOCK_SCOPE_POSIX_MSG_QUEUE when opening
> POSIX message queues.
> 
> Tag mqueuefs inodes at instantiation time with the landlock domain of
> the task that created the queue. This domain is stored in the landlock
> inode security blob and kept alive until the inode security blob is
> released.
> 
> On file open, detect mqueuefs regular files and compare the queue
> creator's domain with the opener's scoped domain. Deny the open when
> the opener is restricted by LANDLOCK_SCOPE_POSIX_MSG_QUEUE and the queue
> was created outside of an allowed parent domain.
> 
> This makes POSIX message queues follow the same scoped-domain model as
> the existing landlock IPC restrictions, while keeping the queue creator
> domain tied to the lifetime of the queue inode.
> 
> Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
> ---
>  include/uapi/linux/landlock.h |  1 +
>  security/landlock/audit.c     |  9 ++++++++
>  security/landlock/audit.h     |  1 +
>  security/landlock/fs.c        | 35 ++++++++++++++++++++++++++++
>  security/landlock/fs.h        | 15 ++++++++++++
>  security/landlock/limits.h    |  2 +-
>  security/landlock/ruleset.c   |  1 -
>  security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
>  security/landlock/task.h      |  4 ++++
>  9 files changed, 109 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 272f047df438..96d0c3b423ac 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -491,6 +491,7 @@ struct landlock_net_port_attr {
>  /* clang-format off */
>  #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
>  #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
> +#define LANDLOCK_SCOPE_POSIX_MSG_QUEUE		        (1ULL << 2)
>  /* clang-format on*/
>  
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 50536c568526..895397b5cbca 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -82,6 +82,10 @@ get_blocker(const enum landlock_request_type type,
>  	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
>  		WARN_ON_ONCE(access_bit != -1);
>  		return "scope.signal";
> +
> +	case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
> +		WARN_ON_ONCE(access_bit != -1);
> +		return "scope.posix_msg_queue";
>  	}
>  
>  	WARN_ON_ONCE(1);
> @@ -646,6 +650,11 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  				!!(quiet_mask &
>  				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
>  			break;
> +		case LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE:
> +			quiet_applicable_to_access =
> +				!!(quiet_mask &
> +				   LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
> +			break;
>  		/*
>  		 * Leave LANDLOCK_REQUEST_PTRACE and
>  		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 620f8a24291d..ce85417548fa 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -21,6 +21,7 @@ enum landlock_request_type {
>  	LANDLOCK_REQUEST_NET_ACCESS,
>  	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
>  	LANDLOCK_REQUEST_SCOPE_SIGNAL,
> +	LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
>  };
>  
>  /*
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index f7e5e4ef9eac..c6558b448a06 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -51,6 +51,7 @@
>  #include "object.h"
>  #include "ruleset.h"
>  #include "setup.h"
> +#include "task.h"
>  
>  /* Underlying object management */
>  
> @@ -1268,6 +1269,33 @@ static void hook_inode_free_security_rcu(void *inode_security)
>  	 */
>  	inode_sec = inode_security + landlock_blob_sizes.lbs_inode;
>  	WARN_ON_ONCE(inode_sec->object);
> +
> +	landlock_put_ruleset_deferred(inode_sec->mq_domain);
> +}
> +
> +/*
> + * Tag a newly created POSIX message queue with its creator's domain.
> + *
> + * This is the earliest reachable point with both the creator's context and a
> + * fully initialized inode.
> + */
> +static void hook_d_instantiate(struct dentry *const dentry,
> +			       struct inode *const inode)
> +{
> +	struct landlock_ruleset *dom;
> +
> +	if (!landlock_is_posix_mqueue_inode(inode))
> +		return;
> +
> +	dom = landlock_get_current_domain();
> +	if (!dom)
> +		return;
> +
> +	if (WARN_ON_ONCE(landlock_inode(inode)->mq_domain))
> +		return;
> +
> +	landlock_get_ruleset(dom);
> +	landlock_inode(inode)->mq_domain = dom;
>  }
>  
>  /* Super-block hooks */
> @@ -1756,6 +1784,12 @@ static int hook_file_open(struct file *const file)
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
>  	struct landlock_request request = {};
> +	int err;
> +
> +	/* POSIX message queue scoping is independent of FS access rights. */
> +	err = landlock_check_posix_mqueue_open(file);
> +	if (err)
> +		return err;
>  
>  	if (!subject)
>  		return 0;
> @@ -1979,6 +2013,7 @@ static void hook_file_free_security(struct file *file)
>  
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
> +	LSM_HOOK_INIT(d_instantiate, hook_d_instantiate),
>  
>  	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
>  	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index b4421d9df68f..aefe078845fa 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -14,6 +14,7 @@
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/rcupdate.h>
> +#include <uapi/linux/magic.h>
>  
>  #include "access.h"
>  #include "cred.h"
> @@ -38,6 +39,14 @@ struct landlock_inode_security {
>  	 * performed by get_inode_object().
>  	 */
>  	struct landlock_object __rcu *object;
> +	/**
> +	 * @mq_domain: Domain of the task that created POSIX message queue.
> +	 * Only set for mqueuefs inodes (i.e. s_magic == MQUEUE_MAGIC) at
> +	 * creation time by hook_d_instantiate(), never modified afterwards.
> +	 * Used to check LANDLOCK_SCOPE_POSIX_MSG_QUEUE against the
> +	 * accessing task's domain.
> +	 */
> +	struct landlock_ruleset *mq_domain;

This seems like the right approach for posix mq.

They are NOT like SysV mq, they are opened like files with persistent
handles. This follows the existing approach just like any other file
and doesn't restrict after open.

...

But this doesn't restrict mq_unlink?

Shouldn't it handle that too? (otherwise scoped process could still
unlink an mq created outside it's domain, then recreate one with the
same name and bypass the restriction)

You may need to handle security_inode_unlink for this.

Justin
>  };
>  
>  /**
> @@ -141,6 +150,12 @@ landlock_inode(const struct inode *const inode)
>  	return inode->i_security + landlock_blob_sizes.lbs_inode;
>  }
>  
> +static inline bool
> +landlock_is_posix_mqueue_inode(const struct inode *const inode)
> +{
> +	return S_ISREG(inode->i_mode) && inode->i_sb->s_magic == MQUEUE_MAGIC;
> +}
> +
>  static inline struct landlock_superblock_security *
>  landlock_superblock(const struct super_block *const superblock)
>  {
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 08d5f2f6d321..70a7c5c7af85 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -27,7 +27,7 @@
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> -#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
> +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_POSIX_MSG_QUEUE
>  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
>  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 4dd09ea22c84..aa37d50ead87 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -520,7 +520,6 @@ static void free_ruleset_work(struct work_struct *const work)
>  	free_ruleset(ruleset);
>  }
>  
> -/* Only called by hook_cred_free(). */
>  void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
>  {
>  	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 55522a601367..d65e43550b26 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -453,6 +453,49 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
>  	return -EPERM;
>  }
>  
> +static const struct access_masks posix_mqueue_scope = {
> +	.scope = LANDLOCK_SCOPE_POSIX_MSG_QUEUE,
> +};
> +
> +/**
> + * landlock_check_posix_mqueue_open - Deny opening a POSIX message queue
> + * created by a task from a different (non-ancestor) domain
> + *
> + * @file: The mqueuefs file being opened.
> + *
> + * Return: -EPERM if the open must be denied, 0 otherwise.
> + */
> +int landlock_check_posix_mqueue_open(struct file *const file)
> +{
> +	const struct inode *const inode = file_inode(file);
> +	const struct landlock_cred_security *subject;
> +	size_t handle_layer;
> +
> +	if (!landlock_is_posix_mqueue_inode(inode))
> +		return 0;
> +
> +	subject = landlock_get_applicable_subject(file->f_cred,
> +						  posix_mqueue_scope,
> +						  &handle_layer);
> +	if (!subject)
> +		return 0;
> +
> +	if (!domain_is_scoped(subject->domain,
> +			      landlock_inode(inode)->mq_domain,
> +			      LANDLOCK_SCOPE_POSIX_MSG_QUEUE))
> +		return 0;
> +
> +	landlock_log_denial(subject, &(struct landlock_request) {
> +		.type = LANDLOCK_REQUEST_SCOPE_POSIX_MSG_QUEUE,
> +		.audit = {
> +			.type = LSM_AUDIT_DATA_FILE,
> +			.u.file = file,
> +		},
> +		.layer_plus_one = handle_layer + 1,
> +	});
> +	return -EPERM;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
> diff --git a/security/landlock/task.h b/security/landlock/task.h
> index 7c00360219a2..0b031dc17bbf 100644
> --- a/security/landlock/task.h
> +++ b/security/landlock/task.h
> @@ -9,6 +9,10 @@
>  #ifndef _SECURITY_LANDLOCK_TASK_H
>  #define _SECURITY_LANDLOCK_TASK_H
>  
> +#include <linux/fs.h>
> +
>  __init void landlock_add_task_hooks(void);
>  
> +int landlock_check_posix_mqueue_open(struct file *const file);
> +
>  #endif /* _SECURITY_LANDLOCK_TASK_H */
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
