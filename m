From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 21 Dec 2017 10:06:35 -0800
Subject: [PATCH] Smack: fix dereferenced before check
In-Reply-To: <1513871872-18759-1-git-send-email-gomonovych@gmail.com>
References: <1513871872-18759-1-git-send-email-gomonovych@gmail.com>
Message-ID: <4da2b0f6-a2d9-ead0-d573-a75bc78938a7@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/21/2017 7:57 AM, Vasyl Gomonovych wrote:
> This patch fixes the warning reported by smatch:
> security/smack/smack_lsm.c:2872 smack_socket_connect() warn:
> variable dereferenced before check 'sock->sk' (see line 2869)
>
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>

I will take this into the Smack tree. Thank you.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/smack/smack_lsm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 14cc7940b36d..30f2c3d1c11c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2866,12 +2866,16 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>  #endif
>  #ifdef SMACK_IPV6_SECMARK_LABELING
>  	struct smack_known *rsp;
> -	struct socket_smack *ssp = sock->sk->sk_security;
> +	struct socket_smack *ssp;
>  #endif
>  
>  	if (sock->sk == NULL)
>  		return 0;
>  
> +#ifdef SMACK_IPV6_SECMARK_LABELING
> +	ssp = sock->sk->sk_security;
> +#endif
> +
>  	switch (sock->sk->sk_family) {
>  	case PF_INET:
>  		if (addrlen < sizeof(struct sockaddr_in))

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
