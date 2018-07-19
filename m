From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 19 Jul 2018 15:51:15 -0700
Subject: [PATCH v3 RFC] Smack: Inform peer that IPv6 traffic has been
	blocked
In-Reply-To: <20180719094732eucas1p18ac5bd15693cd06f868238c7a4951aa1~CvBwyJxUf3081230812eucas1p1q@eucas1p1.samsung.com>
References: <CGME20180719094732eucas1p18ac5bd15693cd06f868238c7a4951aa1@eucas1p1.samsung.com>
	<20180719094732eucas1p18ac5bd15693cd06f868238c7a4951aa1~CvBwyJxUf3081230812eucas1p1q@eucas1p1.samsung.com>
Message-ID: <575159b1-b423-cd59-246b-ab4097ce47b8@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 7/19/2018 2:47 AM, Piotr Sawicki wrote:
> In this patch we're sending an ICMPv6 message to a peer to
> immediately inform it that making a connection is not possible.
> In case of TCP connections, without this change, the peer
> will be waiting until a connection timeout is exceeded.
>
> Signed-off-by: Piotr Sawicki <p.sawicki2@partner.samsung.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> Changes in v2:
>  - Add missing Signed-off-by field
> Changes in v3:
>  - Fix formatting issues caused by improper email client configuration
> ---
>  security/smack/smack_lsm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index c2282ac..efa81bc 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -28,6 +28,7 @@
>  #include <linux/tcp.h>
>  #include <linux/udp.h>
>  #include <linux/dccp.h>
> +#include <linux/icmpv6.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/pipe_fs_i.h>
> @@ -4010,6 +4011,9 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  #ifdef SMACK_IPV6_PORT_LABELING
>  		rc = smk_ipv6_port_check(sk, &sadd, SMK_RECEIVING);
>  #endif /* SMACK_IPV6_PORT_LABELING */
> +		if (rc != 0)
> +			icmpv6_send(skb, ICMPV6_DEST_UNREACH,
> +					ICMPV6_ADM_PROHIBITED, 0);
>  		break;
>  #endif /* CONFIG_IPV6 */
>  	}

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
