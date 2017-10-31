From: marcelo.leitner@gmail.com (Marcelo Ricardo Leitner)
Date: Tue, 31 Oct 2017 15:16:15 -0200
Subject: [RFC PATCH 5/5] selinux: Add SCTP support
In-Reply-To: <20171017135953.4419-1-richard_c_haines@btinternet.com>
References: <20171017135953.4419-1-richard_c_haines@btinternet.com>
Message-ID: <20171031171614.GE3675@localhost.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 17, 2017 at 02:59:53PM +0100, Richard Haines wrote:
> The SELinux SCTP implementation is explained in:
> Documentation/security/SELinux-sctp.txt
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
...
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 33fd061..c3e9600 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
...
> @@ -4521,7 +4565,14 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  		unsigned short snum;
>  		u32 sid, perm;
>  
> -		if (sk->sk_family == PF_INET) {
> +		/* sctp_connectx(3) calls via
> +		 *selinux_sctp_bind_connect() that validates multiple
> +		 * connect addresses. Because of this need to check
> +		 * address->sa_family as it is possible to have
> +		 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
> +		 */
> +		if (sk->sk_family == PF_INET ||
> +					address->sa_family == AF_INET) {

Not sure which code style applies on this file but the if () above
looks odd. At least, checkpatch.pl complained about it.

  Marcelo
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
