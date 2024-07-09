Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81F7CF18
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564807; cv=none; b=C5UZ9BF5UbWomp/AmHVoAmwEBisoaJyAW3v+G71GtAI7azE97Ahv5/X43hERCJMDkTWxn/GRJpo18H6kD+VwesiREbMndsiNAeKe+1WxMfsZktLwgL7oJdUnM0uiCgiE1R9fBF4j8nQNlo+1tsEllUtt7BPbiDHsPk1DbkV9hAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564807; c=relaxed/simple;
	bh=I3f4DG/oiv9dYnGlhIYJZUcOQw+bp+E1NEWSwbyI0dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkRwSumt56X1eh+rwvRXvx3lnmC+2fOZdU9NwN7pT1eJZx9FZjNTFMLE07jzcY3cuYBhMSdGFWCpcttjtd0ywgAHnTYXZoxCyKVf7ViGeAWXcFdZZGF8gKGZABGq1hFwVGQt9Kk2ANfSoxAGx1R9bHQU7TPi2H/AF8ldCTOn8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Jf0xTW6j; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Jf0xTW6j"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D49F13F20E;
	Tue,  9 Jul 2024 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720564339;
	bh=Z+9Md4tuzerho4RggCPxMGRL1SxSM/0c2EUiVpUmwMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Jf0xTW6jq1r7xFCdUB3uVTh0LNlkBNrtIcmoL9GWlsLpr/Qh5dJimSJr72kJwdmev
	 HapneFDfhv19/jY2fxYC5vcmrn8qyFeC7HkFdd0iaaPajrximMcWz/0DtPQK4eailj
	 G1EEIbj3Y/ih5CHcFtRXOtuUnrf4c4yAaF7WYW7KpV8PTV9OzggB6mGAOgNxt0PALP
	 r1Zcyx/gwsTrcgCLmS3VOEvU9WfoQ4pfob2hsDfIHkwZEhf700w2IYJYMHnrO7faLy
	 UOlHEKPrlBj4HfS7Vl16Wo4xcPduwkevGENGT5mxjPCMtbPl+vdc/FHBSS8ioHEBO5
	 +hN7fakO8F5PA==
Message-ID: <acd63bb6-d870-4660-a4a2-2cc623e05b96@canonical.com>
Date: Tue, 9 Jul 2024 15:32:14 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] LSM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-2-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240708213957.20519-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 14:39, Casey Schaufler wrote:
> Move management of the sock->sk_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h         |  1 +
>   security/apparmor/include/net.h   |  3 +-
>   security/apparmor/lsm.c           | 17 +------
>   security/apparmor/net.c           |  2 +-
>   security/security.c               | 36 +++++++++++++-
>   security/selinux/hooks.c          | 80 ++++++++++++++-----------------
>   security/selinux/include/objsec.h |  5 ++
>   security/selinux/netlabel.c       | 23 ++++-----
>   security/smack/smack.h            |  5 ++
>   security/smack/smack_lsm.c        | 70 +++++++++++++--------------
>   security/smack/smack_netfilter.c  |  4 +-
>   11 files changed, 133 insertions(+), 113 deletions(-)

still looks good

> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a2ade0ffe9e7..efd4a0655159 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -73,6 +73,7 @@ struct lsm_blob_sizes {
>   	int	lbs_cred;
>   	int	lbs_file;
>   	int	lbs_inode;
> +	int	lbs_sock;
>   	int	lbs_superblock;
>   	int	lbs_ipc;
>   	int	lbs_msg_msg;
> diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
> index 67bf888c3bd6..c42ed8a73f1c 100644
> --- a/security/apparmor/include/net.h
> +++ b/security/apparmor/include/net.h
> @@ -51,10 +51,9 @@ struct aa_sk_ctx {
>   	struct aa_label *peer;
>   };
>   
> -#define SK_CTX(X) ((X)->sk_security)
>   static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
>   {
> -	return sk->sk_security;
> +	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
>   }
>   
>   #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 6239777090c4..b3eb0a2f999a 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1057,27 +1057,12 @@ static int apparmor_userns_create(const struct cred *cred)
>   	return error;
>   }
>   
> -static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
> -{
> -	struct aa_sk_ctx *ctx;
> -
> -	ctx = kzalloc(sizeof(*ctx), flags);
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	sk->sk_security = ctx;
> -
> -	return 0;
> -}
> -
>   static void apparmor_sk_free_security(struct sock *sk)
>   {
>   	struct aa_sk_ctx *ctx = aa_sock(sk);
>   
> -	sk->sk_security = NULL;
>   	aa_put_label(ctx->label);
>   	aa_put_label(ctx->peer);
> -	kfree(ctx);
>   }
>   
>   /**
> @@ -1425,6 +1410,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
>   	.lbs_cred = sizeof(struct aa_label *),
>   	.lbs_file = sizeof(struct aa_file_ctx),
>   	.lbs_task = sizeof(struct aa_task_ctx),
> +	.lbs_sock = sizeof(struct aa_sk_ctx),
>   };
>   
>   static const struct lsm_id apparmor_lsmid = {
> @@ -1470,7 +1456,6 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
>   
> -	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
>   	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
>   	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
>   
> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index 87e934b2b548..77413a519117 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -151,7 +151,7 @@ static int aa_label_sk_perm(const struct cred *subj_cred,
>   			    const char *op, u32 request,
>   			    struct sock *sk)
>   {
> -	struct aa_sk_ctx *ctx = SK_CTX(sk);
> +	struct aa_sk_ctx *ctx = aa_sock(sk);
>   	int error = 0;
>   
>   	AA_BUG(!label);
> diff --git a/security/security.c b/security/security.c
> index e5ca08789f74..5e93a72bdca6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -29,6 +29,7 @@
>   #include <linux/msg.h>
>   #include <linux/overflow.h>
>   #include <net/flow.h>
> +#include <net/sock.h>
>   
>   /* How many LSMs were built into the kernel? */
>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -227,6 +228,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>   	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>   	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>   	lsm_set_blob_size(&needed->lbs_xattr_count,
> @@ -401,6 +403,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>   	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>   	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
> @@ -4647,6 +4650,28 @@ int security_socket_getpeersec_dgram(struct socket *sock,
>   }
>   EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>   
> +/**
> + * lsm_sock_alloc - allocate a composite sock blob
> + * @sock: the sock that needs a blob
> + * @priority: allocation mode
> + *
> + * Allocate the sock blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
> +{
> +	if (blob_sizes.lbs_sock == 0) {
> +		sock->sk_security = NULL;
> +		return 0;
> +	}
> +
> +	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
> +	if (sock->sk_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>   /**
>    * security_sk_alloc() - Allocate and initialize a sock's LSM blob
>    * @sk: sock
> @@ -4660,7 +4685,14 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>    */
>   int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
>   {
> -	return call_int_hook(sk_alloc_security, sk, family, priority);
> +	int rc = lsm_sock_alloc(sk, priority);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(sk_alloc_security, sk, family, priority);
> +	if (unlikely(rc))
> +		security_sk_free(sk);
> +	return rc;
>   }
>   
>   /**
> @@ -4672,6 +4704,8 @@ int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
>   void security_sk_free(struct sock *sk)
>   {
>   	call_void_hook(sk_free_security, sk);
> +	kfree(sk->sk_security);
> +	sk->sk_security = NULL;
>   }
>   
>   /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7eed331e90f0..19346e1817ff 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4579,7 +4579,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
>   
>   static int sock_has_perm(struct sock *sk, u32 perms)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net;
>   
> @@ -4647,7 +4647,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>   	isec->initialized = LABEL_INITIALIZED;
>   
>   	if (sock->sk) {
> -		sksec = sock->sk->sk_security;
> +		sksec = selinux_sock(sock->sk);
>   		sksec->sclass = sclass;
>   		sksec->sid = sid;
>   		/* Allows detection of the first association on this socket */
> @@ -4663,8 +4663,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>   static int selinux_socket_socketpair(struct socket *socka,
>   				     struct socket *sockb)
>   {
> -	struct sk_security_struct *sksec_a = socka->sk->sk_security;
> -	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
> +	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
> +	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
>   
>   	sksec_a->peer_sid = sksec_b->sid;
>   	sksec_b->peer_sid = sksec_a->sid;
> @@ -4679,7 +4679,7 @@ static int selinux_socket_socketpair(struct socket *socka,
>   static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
>   {
>   	struct sock *sk = sock->sk;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u16 family;
>   	int err;
>   
> @@ -4819,7 +4819,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
>   					 struct sockaddr *address, int addrlen)
>   {
>   	struct sock *sk = sock->sk;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	int err;
>   
>   	err = sock_has_perm(sk, SOCKET__CONNECT);
> @@ -4997,9 +4997,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
>   					      struct sock *other,
>   					      struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec_sock = sock->sk_security;
> -	struct sk_security_struct *sksec_other = other->sk_security;
> -	struct sk_security_struct *sksec_new = newsk->sk_security;
> +	struct sk_security_struct *sksec_sock = selinux_sock(sock);
> +	struct sk_security_struct *sksec_other = selinux_sock(other);
> +	struct sk_security_struct *sksec_new = selinux_sock(newsk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net;
>   	int err;
> @@ -5028,8 +5028,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
>   static int selinux_socket_unix_may_send(struct socket *sock,
>   					struct socket *other)
>   {
> -	struct sk_security_struct *ssec = sock->sk->sk_security;
> -	struct sk_security_struct *osec = other->sk->sk_security;
> +	struct sk_security_struct *ssec = selinux_sock(sock->sk);
> +	struct sk_security_struct *osec = selinux_sock(other->sk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net;
>   
> @@ -5066,7 +5066,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>   				       u16 family)
>   {
>   	int err = 0;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u32 sk_sid = sksec->sid;
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net;
> @@ -5095,7 +5095,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>   static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   {
>   	int err, peerlbl_active, secmark_active;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u16 family = sk->sk_family;
>   	u32 sk_sid = sksec->sid;
>   	struct common_audit_data ad;
> @@ -5163,7 +5163,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
>   	int err = 0;
>   	char *scontext = NULL;
>   	u32 scontext_len;
> -	struct sk_security_struct *sksec = sock->sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sock->sk);
>   	u32 peer_sid = SECSID_NULL;
>   
>   	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
> @@ -5223,34 +5223,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock,
>   
>   static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
>   {
> -	struct sk_security_struct *sksec;
> -
> -	sksec = kzalloc(sizeof(*sksec), priority);
> -	if (!sksec)
> -		return -ENOMEM;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	sksec->peer_sid = SECINITSID_UNLABELED;
>   	sksec->sid = SECINITSID_UNLABELED;
>   	sksec->sclass = SECCLASS_SOCKET;
>   	selinux_netlbl_sk_security_reset(sksec);
> -	sk->sk_security = sksec;
>   
>   	return 0;
>   }
>   
>   static void selinux_sk_free_security(struct sock *sk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
> -	sk->sk_security = NULL;
>   	selinux_netlbl_sk_security_free(sksec);
> -	kfree(sksec);
>   }
>   
>   static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	newsksec->sid = sksec->sid;
>   	newsksec->peer_sid = sksec->peer_sid;
> @@ -5264,7 +5257,7 @@ static void selinux_sk_getsecid(const struct sock *sk, u32 *secid)
>   	if (!sk)
>   		*secid = SECINITSID_ANY_SOCKET;
>   	else {
> -		const struct sk_security_struct *sksec = sk->sk_security;
> +		const struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   		*secid = sksec->sid;
>   	}
> @@ -5274,7 +5267,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
>   {
>   	struct inode_security_struct *isec =
>   		inode_security_novalidate(SOCK_INODE(parent));
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
>   	    sk->sk_family == PF_UNIX)
> @@ -5291,7 +5284,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
>   {
>   	struct sock *sk = asoc->base.sk;
>   	u16 family = sk->sk_family;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct common_audit_data ad;
>   	struct lsm_network_audit net;
>   	int err;
> @@ -5346,7 +5339,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
>   static int selinux_sctp_assoc_request(struct sctp_association *asoc,
>   				      struct sk_buff *skb)
>   {
> -	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
>   	u32 conn_sid;
>   	int err;
>   
> @@ -5379,7 +5372,7 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
>   static int selinux_sctp_assoc_established(struct sctp_association *asoc,
>   					  struct sk_buff *skb)
>   {
> -	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
>   
>   	if (!selinux_policycap_extsockclass())
>   		return 0;
> @@ -5478,8 +5471,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>   static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
>   				  struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	/* If policy does not support SECCLASS_SCTP_SOCKET then call
>   	 * the non-sctp clone version.
> @@ -5495,8 +5488,8 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
>   
>   static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>   {
> -	struct sk_security_struct *ssksec = ssk->sk_security;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *ssksec = selinux_sock(ssk);
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	ssksec->sclass = sksec->sclass;
>   	ssksec->sid = sksec->sid;
> @@ -5511,7 +5504,7 @@ static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>   static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
>   				     struct request_sock *req)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	int err;
>   	u16 family = req->rsk_ops->family;
>   	u32 connsid;
> @@ -5532,7 +5525,7 @@ static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
>   static void selinux_inet_csk_clone(struct sock *newsk,
>   				   const struct request_sock *req)
>   {
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	newsksec->sid = req->secid;
>   	newsksec->peer_sid = req->peer_secid;
> @@ -5549,7 +5542,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
>   static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
>   {
>   	u16 family = sk->sk_family;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	/* handle mapped IPv4 packets arriving via IPv6 sockets */
>   	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
> @@ -5624,7 +5617,7 @@ static int selinux_tun_dev_attach_queue(void *security)
>   static int selinux_tun_dev_attach(struct sock *sk, void *security)
>   {
>   	struct tun_security_struct *tunsec = security;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	/* we don't currently perform any NetLabel based labeling here and it
>   	 * isn't clear that we would want to do so anyway; while we could apply
> @@ -5747,7 +5740,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
>   			return NF_ACCEPT;
>   
>   		/* standard practice, label using the parent socket */
> -		sksec = sk->sk_security;
> +		sksec = selinux_sock(sk);
>   		sid = sksec->sid;
>   	} else
>   		sid = SECINITSID_KERNEL;
> @@ -5770,7 +5763,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>   	sk = skb_to_full_sk(skb);
>   	if (sk == NULL)
>   		return NF_ACCEPT;
> -	sksec = sk->sk_security;
> +	sksec = selinux_sock(sk);
>   
>   	ad_net_init_from_iif(&ad, &net, state->out->ifindex, state->pf);
>   	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
> @@ -5859,7 +5852,7 @@ static unsigned int selinux_ip_postroute(void *priv,
>   		u32 skb_sid;
>   		struct sk_security_struct *sksec;
>   
> -		sksec = sk->sk_security;
> +		sksec = selinux_sock(sk);
>   		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
>   			return NF_DROP;
>   		/* At this point, if the returned skb peerlbl is SECSID_NULL
> @@ -5888,7 +5881,7 @@ static unsigned int selinux_ip_postroute(void *priv,
>   	} else {
>   		/* Locally generated packet, fetch the security label from the
>   		 * associated socket. */
> -		struct sk_security_struct *sksec = sk->sk_security;
> +		struct sk_security_struct *sksec = selinux_sock(sk);
>   		peer_sid = sksec->sid;
>   		secmark_perm = PACKET__SEND;
>   	}
> @@ -5931,7 +5924,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>   	unsigned int data_len = skb->len;
>   	unsigned char *data = skb->data;
>   	struct nlmsghdr *nlh;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	u16 sclass = sksec->sclass;
>   	u32 perm;
>   
> @@ -6989,6 +6982,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>   	.lbs_inode = sizeof(struct inode_security_struct),
>   	.lbs_ipc = sizeof(struct ipc_security_struct),
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
> +	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
>   };
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index dea1d6f3ed2d..b074099acbaf 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -195,4 +195,9 @@ selinux_superblock(const struct super_block *superblock)
>   	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
>   }
>   
> +static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
> +{
> +	return sock->sk_security + selinux_blob_sizes.lbs_sock;
> +}
> +
>   #endif /* _SELINUX_OBJSEC_H_ */
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 55885634e880..fbe5f8c29f81 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -17,6 +17,7 @@
>   #include <linux/gfp.h>
>   #include <linux/ip.h>
>   #include <linux/ipv6.h>
> +#include <linux/lsm_hooks.h>
>   #include <net/sock.h>
>   #include <net/netlabel.h>
>   #include <net/ip.h>
> @@ -68,7 +69,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
>   static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
>   {
>   	int rc;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr;
>   
>   	if (sksec->nlbl_secattr != NULL)
> @@ -100,7 +101,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
>   							const struct sock *sk,
>   							u32 sid)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
>   
>   	if (secattr == NULL)
> @@ -240,7 +241,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
>   	 * being labeled by it's parent socket, if it is just exit */
>   	sk = skb_to_full_sk(skb);
>   	if (sk != NULL) {
> -		struct sk_security_struct *sksec = sk->sk_security;
> +		struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   		if (sksec->nlbl_state != NLBL_REQSKB)
>   			return 0;
> @@ -277,7 +278,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
>   {
>   	int rc;
>   	struct netlbl_lsm_secattr secattr;
> -	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
>   	struct sockaddr_in addr4;
>   	struct sockaddr_in6 addr6;
>   
> @@ -356,7 +357,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
>    */
>   void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (family == PF_INET)
>   		sksec->nlbl_state = NLBL_LABELED;
> @@ -374,8 +375,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
>    */
>   void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> -	struct sk_security_struct *newsksec = newsk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
> +	struct sk_security_struct *newsksec = selinux_sock(newsk);
>   
>   	newsksec->nlbl_state = sksec->nlbl_state;
>   }
> @@ -393,7 +394,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
>   int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
>   {
>   	int rc;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr;
>   
>   	if (family != PF_INET && family != PF_INET6)
> @@ -510,7 +511,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
>   {
>   	int rc = 0;
>   	struct sock *sk = sock->sk;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr secattr;
>   
>   	if (selinux_netlbl_option(level, optname) &&
> @@ -548,7 +549,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
>   						struct sockaddr *addr)
>   {
>   	int rc;
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   	struct netlbl_lsm_secattr *secattr;
>   
>   	/* connected sockets are allowed to disconnect when the address family
> @@ -587,7 +588,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
>   int selinux_netlbl_socket_connect_locked(struct sock *sk,
>   					 struct sockaddr *addr)
>   {
> -	struct sk_security_struct *sksec = sk->sk_security;
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	if (sksec->nlbl_state != NLBL_REQSKB &&
>   	    sksec->nlbl_state != NLBL_CONNLABELED)
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 041688e5a77a..297f21446f45 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -355,6 +355,11 @@ static inline struct superblock_smack *smack_superblock(
>   	return superblock->s_security + smack_blob_sizes.lbs_superblock;
>   }
>   
> +static inline struct socket_smack *smack_sock(const struct sock *sock)
> +{
> +	return sock->sk_security + smack_blob_sizes.lbs_sock;
> +}
> +
>   /*
>    * Is the directory transmuting?
>    */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f5cbec1e6a92..a931b44bc959 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1581,7 +1581,7 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
>   		if (sock == NULL || sock->sk == NULL)
>   			return -EOPNOTSUPP;
>   
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   
>   		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
>   			isp = ssp->smk_in;
> @@ -1969,7 +1969,7 @@ static int smack_file_receive(struct file *file)
>   
>   	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
>   		sock = SOCKET_I(inode);
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   		tsp = smack_cred(current_cred());
>   		/*
>   		 * If the receiving process can't write to the
> @@ -2384,11 +2384,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
>   static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
>   {
>   	struct smack_known *skp = smk_of_current();
> -	struct socket_smack *ssp;
> -
> -	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
> -	if (ssp == NULL)
> -		return -ENOMEM;
> +	struct socket_smack *ssp = smack_sock(sk);
>   
>   	/*
>   	 * Sockets created by kernel threads receive web label.
> @@ -2402,11 +2398,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
>   	}
>   	ssp->smk_packet = NULL;
>   
> -	sk->sk_security = ssp;
> -
>   	return 0;
>   }
>   
> +#ifdef SMACK_IPV6_PORT_LABELING
>   /**
>    * smack_sk_free_security - Free a socket blob
>    * @sk: the socket
> @@ -2415,7 +2410,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
>    */
>   static void smack_sk_free_security(struct sock *sk)
>   {
> -#ifdef SMACK_IPV6_PORT_LABELING
>   	struct smk_port_label *spp;
>   
>   	if (sk->sk_family == PF_INET6) {
> @@ -2428,9 +2422,8 @@ static void smack_sk_free_security(struct sock *sk)
>   		}
>   		rcu_read_unlock();
>   	}
> -#endif
> -	kfree(sk->sk_security);
>   }
> +#endif
>   
>   /**
>    * smack_sk_clone_security - Copy security context
> @@ -2441,8 +2434,8 @@ static void smack_sk_free_security(struct sock *sk)
>    */
>   static void smack_sk_clone_security(const struct sock *sk, struct sock *newsk)
>   {
> -	struct socket_smack *ssp_old = sk->sk_security;
> -	struct socket_smack *ssp_new = newsk->sk_security;
> +	struct socket_smack *ssp_old = smack_sock(sk);
> +	struct socket_smack *ssp_new = smack_sock(newsk);
>   
>   	*ssp_new = *ssp_old;
>   }
> @@ -2558,7 +2551,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
>    */
>   static int smack_netlbl_add(struct sock *sk)
>   {
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp = ssp->smk_out;
>   	int rc;
>   
> @@ -2591,7 +2584,7 @@ static int smack_netlbl_add(struct sock *sk)
>    */
>   static void smack_netlbl_delete(struct sock *sk)
>   {
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   
>   	/*
>   	 * Take the label off the socket if one is set.
> @@ -2623,7 +2616,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
>   	struct smack_known *skp;
>   	int rc = 0;
>   	struct smack_known *hkp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smk_audit_info ad;
>   
>   	rcu_read_lock();
> @@ -2696,7 +2689,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
>   {
>   	struct sock *sk = sock->sk;
>   	struct sockaddr_in6 *addr6;
> -	struct socket_smack *ssp = sock->sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
>   	struct smk_port_label *spp;
>   	unsigned short port = 0;
>   
> @@ -2784,7 +2777,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
>   				int act)
>   {
>   	struct smk_port_label *spp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp = NULL;
>   	unsigned short port;
>   	struct smack_known *object;
> @@ -2887,7 +2880,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
>   	if (sock == NULL || sock->sk == NULL)
>   		return -EOPNOTSUPP;
>   
> -	ssp = sock->sk->sk_security;
> +	ssp = smack_sock(sock->sk);
>   
>   	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
>   		ssp->smk_in = skp;
> @@ -2935,7 +2928,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
>   	 * Sockets created by kernel threads receive web label.
>   	 */
>   	if (unlikely(current->flags & PF_KTHREAD)) {
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   		ssp->smk_in = &smack_known_web;
>   		ssp->smk_out = &smack_known_web;
>   	}
> @@ -2960,8 +2953,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
>   static int smack_socket_socketpair(struct socket *socka,
>   		                   struct socket *sockb)
>   {
> -	struct socket_smack *asp = socka->sk->sk_security;
> -	struct socket_smack *bsp = sockb->sk->sk_security;
> +	struct socket_smack *asp = smack_sock(socka->sk);
> +	struct socket_smack *bsp = smack_sock(sockb->sk);
>   
>   	asp->smk_packet = bsp->smk_out;
>   	bsp->smk_packet = asp->smk_out;
> @@ -3024,7 +3017,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>   		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
>   			rsp = smack_ipv6host_label(sip);
>   		if (rsp != NULL) {
> -			struct socket_smack *ssp = sock->sk->sk_security;
> +			struct socket_smack *ssp = smack_sock(sock->sk);
>   
>   			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
>   					    SMK_CONNECTING);
> @@ -3819,9 +3812,9 @@ static int smack_unix_stream_connect(struct sock *sock,
>   {
>   	struct smack_known *skp;
>   	struct smack_known *okp;
> -	struct socket_smack *ssp = sock->sk_security;
> -	struct socket_smack *osp = other->sk_security;
> -	struct socket_smack *nsp = newsk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock);
> +	struct socket_smack *osp = smack_sock(other);
> +	struct socket_smack *nsp = smack_sock(newsk);
>   	struct smk_audit_info ad;
>   	int rc = 0;
>   #ifdef CONFIG_AUDIT
> @@ -3867,8 +3860,8 @@ static int smack_unix_stream_connect(struct sock *sock,
>    */
>   static int smack_unix_may_send(struct socket *sock, struct socket *other)
>   {
> -	struct socket_smack *ssp = sock->sk->sk_security;
> -	struct socket_smack *osp = other->sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
> +	struct socket_smack *osp = smack_sock(other->sk);
>   	struct smk_audit_info ad;
>   	int rc;
>   
> @@ -3905,7 +3898,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
>   #endif
>   #ifdef SMACK_IPV6_SECMARK_LABELING
> -	struct socket_smack *ssp = sock->sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
>   	struct smack_known *rsp;
>   #endif
>   	int rc = 0;
> @@ -4117,7 +4110,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
>   	netlbl_secattr_init(&secattr);
>   
>   	if (sk)
> -		ssp = sk->sk_security;
> +		ssp = smack_sock(sk);
>   
>   	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
>   		skp = smack_from_secattr(&secattr, ssp);
> @@ -4139,7 +4132,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
>    */
>   static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   {
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp = NULL;
>   	int rc = 0;
>   	struct smk_audit_info ad;
> @@ -4243,7 +4236,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
>   	u32 slen = 1;
>   	int rc = 0;
>   
> -	ssp = sock->sk->sk_security;
> +	ssp = smack_sock(sock->sk);
>   	if (ssp->smk_packet != NULL) {
>   		rcp = ssp->smk_packet->smk_known;
>   		slen = strlen(rcp) + 1;
> @@ -4293,7 +4286,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
>   
>   	switch (family) {
>   	case PF_UNIX:
> -		ssp = sock->sk->sk_security;
> +		ssp = smack_sock(sock->sk);
>   		s = ssp->smk_out->smk_secid;
>   		break;
>   	case PF_INET:
> @@ -4342,7 +4335,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
>   	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
>   		return;
>   
> -	ssp = sk->sk_security;
> +	ssp = smack_sock(sk);
>   	ssp->smk_in = skp;
>   	ssp->smk_out = skp;
>   	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
> @@ -4362,7 +4355,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
>   {
>   	u16 family = sk->sk_family;
>   	struct smack_known *skp;
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct sockaddr_in addr;
>   	struct iphdr *hdr;
>   	struct smack_known *hskp;
> @@ -4448,7 +4441,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
>   static void smack_inet_csk_clone(struct sock *sk,
>   				 const struct request_sock *req)
>   {
> -	struct socket_smack *ssp = sk->sk_security;
> +	struct socket_smack *ssp = smack_sock(sk);
>   	struct smack_known *skp;
>   
>   	if (req->peer_secid != 0) {
> @@ -5018,6 +5011,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>   	.lbs_inode = sizeof(struct inode_smack),
>   	.lbs_ipc = sizeof(struct smack_known *),
>   	.lbs_msg_msg = sizeof(struct smack_known *),
> +	.lbs_sock = sizeof(struct socket_smack),
>   	.lbs_superblock = sizeof(struct superblock_smack),
>   	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
>   };
> @@ -5141,7 +5135,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
>   	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
>   	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
> +#ifdef SMACK_IPV6_PORT_LABELING
>   	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
> +#endif
>   	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
>   	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
>   	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index b945c1d3a743..bad71b7e648d 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -26,8 +26,8 @@ static unsigned int smack_ip_output(void *priv,
>   	struct socket_smack *ssp;
>   	struct smack_known *skp;
>   
> -	if (sk && sk->sk_security) {
> -		ssp = sk->sk_security;
> +	if (sk) {
> +		ssp = smack_sock(sk);
>   		skp = ssp->smk_out;
>   		skb->secmark = skp->smk_secid;
>   	}

