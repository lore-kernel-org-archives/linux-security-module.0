From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Mon, 19 Jun 2017 16:10:59 -0400
Subject: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
In-Reply-To: <20170618214532.3031-1-aranea@aixah.de>
References: <20170618214532.3031-1-aranea@aixah.de>
Message-ID: <1497903059.27645.9.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2017-06-18 at 23:45 +0200, Luis Ressel wrote:
> For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
> net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.

No Signed-off-by?

Feel free to add my:
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> ?security/selinux/hooks.c | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 819fd6858b49..1a331fba4a3c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1275,6 +1275,7 @@ static inline u16
> socket_type_to_security_class(int family, int type, int protoc
> ?		case SOCK_SEQPACKET:
> ?			return SECCLASS_UNIX_STREAM_SOCKET;
> ?		case SOCK_DGRAM:
> +		case SOCK_RAW:
> ?			return SECCLASS_UNIX_DGRAM_SOCKET;
> ?		}
> ?		break;
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
