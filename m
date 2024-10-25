Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1E166F23;
	Fri, 25 Oct 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869956; cv=none; b=qzbUI0WwbJ3turLVF6Lzl30BvPQnaaCuTacKbhq402hYGo+8xy7sg25w6tXbqdElTIDgBV3i0DaNRGnYBQWbAfkjvLVpmN3zxQYph+4WcA9qLdZK61YGjjGKyPHxk49vlRIM550b7uh/LbeF4RJKl8d22ZAZ0sGE2QK4MiwB9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869956; c=relaxed/simple;
	bh=hbsFD+YaFzPHyt/eMlC7hsrHeIOi0W22CnfP4S4x5aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giHaSqqmDeYvY9GyJoJQViiDK+q0mdcd/9GFvvXdh4BSg0Mijzqj5ehOBMwNA3VHux2c0FSt/VsZK7YVnUmSVARolHK4O3KI0V6T7FNm8OSEnZt4B5lJmheD2BVBpm2XzohJErFaSvhtq8vsO+r1ZDYFc1zigb5cE0hL8UW09WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XoTpv3v3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XoTpv3v3"
Received: from pwmachine.localnet (84-115-216-151.cable.dynamic.surfer.at [84.115.216.151])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1591211A5B7;
	Fri, 25 Oct 2024 08:25:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1591211A5B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729869953;
	bh=ANP6GkLuBGGbk8Pcly384KRE+EVRs/CpCPPDX92ra0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoTpv3v3SQM6EUslxPlPW3Y8UdsJCExgZ3ENt9zw/vUJYqTyblxacqY+ZfoJd5ydK
	 u9uOxO7LWOo8uoFgJVqN/asWTR22pXkIG/xSon8YnjnbvwfCx/OZxunMALjP5kcXJg
	 20LKlshhJLLKk7kktnSDKIYZDcklnZh0BQxmQT38=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 12/14] landlock: Log TCP bind and connect denials
Date: Fri, 25 Oct 2024 17:25:45 +0200
Message-ID: <2345615.iZASKD2KPV@pwmachine>
In-Reply-To: <20241022161009.982584-13-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-13-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le mardi 22 octobre 2024, 18:10:07 CEST Micka=EBl Sala=FCn a =E9crit :
> Add audit support to socket_bind and socket_connect hooks.
>=20
> Audit record sample:
>=20
>   DENY:    domain=3D4533720601 blockers=3Dnet_connect_tcp daddr=3D127.0.0=
=2E1
> dest=3D80 SYSCALL: arch=3Dc000003e syscall=3D42 success=3Dno exit=3D-13 .=
=2E.
>=20
> Cc: G=FCnther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-13-mic@digikod.net
> ---
>  security/landlock/audit.c | 11 +++++++++
>  security/landlock/audit.h |  1 +
>  security/landlock/net.c   | 52 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 60 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 898c95ebe847..c31a4a8719ee 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -41,6 +41,12 @@ static const char *const fs_access_strings[] =3D {
>  };
>  static_assert(ARRAY_SIZE(fs_access_strings) =3D=3D LANDLOCK_NUM_ACCESS_F=
S);
>=20
> +static const char *const net_access_strings[] =3D {
> +	[BIT_INDEX(LANDLOCK_ACCESS_NET_BIND_TCP)] =3D "net_bind_tcp",
> +	[BIT_INDEX(LANDLOCK_ACCESS_NET_CONNECT_TCP)] =3D "net_connect_tcp",
> +};
> +static_assert(ARRAY_SIZE(net_access_strings) =3D=3D LANDLOCK_NUM_ACCESS_=
NET);
> +
>  static __attribute_const__ const char *
>  get_blocker(const enum landlock_request_type type,
>  	    const unsigned long access_bit)
> @@ -58,6 +64,11 @@ get_blocker(const enum landlock_request_type type,
>  		if (WARN_ON_ONCE(access_bit >=3D ARRAY_SIZE(fs_access_strings)))
>  			return "unknown";
>  		return fs_access_strings[access_bit];
> +
> +	case LANDLOCK_REQUEST_NET_ACCESS:
> +		if (WARN_ON_ONCE(access_bit >=3D ARRAY_SIZE(net_access_strings)))
> +			return "unknown";
> +		return net_access_strings[access_bit];
>  	}
>=20
>  	WARN_ON_ONCE(1);
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 320394fd6b84..1075b0c8401f 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -18,6 +18,7 @@ enum landlock_request_type {
>  	LANDLOCK_REQUEST_PTRACE =3D 1,
>  	LANDLOCK_REQUEST_FS_CHANGE_LAYOUT,
>  	LANDLOCK_REQUEST_FS_ACCESS,
> +	LANDLOCK_REQUEST_NET_ACCESS,
>  };
>=20
>  /*
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 27872d0f7e11..c21afd6e0b4d 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -7,10 +7,12 @@
>   */
>=20
>  #include <linux/in.h>
> +#include <linux/lsm_audit.h>
>  #include <linux/net.h>
>  #include <linux/socket.h>
>  #include <net/ipv6.h>
>=20
> +#include "audit.h"
>  #include "common.h"
>  #include "cred.h"
>  #include "limits.h"
> @@ -56,6 +58,10 @@ static int current_check_access_socket(struct socket
> *const sock, };
>  	const struct landlock_ruleset *const dom =3D
>  		landlock_match_ruleset(landlock_get_current_domain(), any_net);
> +	struct lsm_network_audit audit_net =3D {};
> +	struct landlock_request request =3D {
> +		.type =3D LANDLOCK_REQUEST_NET_ACCESS,
> +	};
>=20
>  	if (!dom)
>  		return 0;
> @@ -72,18 +78,49 @@ static int current_check_access_socket(struct socket
> *const sock,
>=20
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
> -	case AF_INET:
> +	case AF_INET: {
> +		const struct sockaddr_in *addr4;
> +
>  		if (addrlen < sizeof(struct sockaddr_in))
>  			return -EINVAL;
> -		port =3D ((struct sockaddr_in *)address)->sin_port;
> +
> +		addr4 =3D (struct sockaddr_in *)address;
> +		port =3D addr4->sin_port;
> +
> +		if (access_request =3D=3D LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +			audit_net.dport =3D port;
> +			audit_net.v4info.daddr =3D addr4->sin_addr.s_addr;
> +		} else if (access_request =3D=3D LANDLOCK_ACCESS_NET_BIND_TCP) {
> +			audit_net.sport =3D port;
> +			audit_net.v4info.saddr =3D addr4->sin_addr.s_addr;
> +		} else {
> +			WARN_ON_ONCE(1);
> +		}
>  		break;
> +	}
>=20
>  #if IS_ENABLED(CONFIG_IPV6)
> -	case AF_INET6:
> +	case AF_INET6: {
> +		const struct sockaddr_in6 *addr6;
> +
>  		if (addrlen < SIN6_LEN_RFC2133)
>  			return -EINVAL;
> -		port =3D ((struct sockaddr_in6 *)address)->sin6_port;
> +
> +		addr6 =3D (struct sockaddr_in6 *)address;
> +		port =3D addr6->sin6_port;
> +		audit_net.v6info.saddr =3D addr6->sin6_addr;

You set this for all access_request, but not for IPv4, is this done on=20
purpose?

> +
> +		if (access_request =3D=3D LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +			audit_net.dport =3D port;
> +			audit_net.v6info.daddr =3D addr6->sin6_addr;
> +		} else if (access_request =3D=3D LANDLOCK_ACCESS_NET_BIND_TCP) {
> +			audit_net.sport =3D port;
> +			audit_net.v6info.saddr =3D addr6->sin6_addr;
> +		} else {
> +			WARN_ON_ONCE(1);
> +		}
>  		break;
> +	}
>  #endif /* IS_ENABLED(CONFIG_IPV6) */
>=20
>  	default:
> @@ -152,6 +189,13 @@ static int current_check_access_socket(struct socket
> *const sock, ARRAY_SIZE(layer_masks)))
>  		return 0;
>=20
> +	audit_net.family =3D address->sa_family;
> +	request.audit.type =3D LSM_AUDIT_DATA_NET;
> +	request.audit.u.net =3D &audit_net;
> +	request.access =3D access_request;
> +	request.layer_masks =3D &layer_masks;
> +	request.layer_masks_size =3D ARRAY_SIZE(layer_masks);
> +	landlock_log_denial(dom, &request);
>  	return -EACCES;
>  }


