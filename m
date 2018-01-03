From: geokozey@mailfence.com (Geo Kozey)
Date: Wed, 3 Jan 2018 15:28:49 +0100 (CET)
Subject: [kernel-hardening] [PATCHv4 1/2] capability: introduce sysctl
	for controlled user-ns capability whitelist
In-Reply-To: <20180103072652.161912-1-mahesh@bandewar.net>
References: <20180103072652.161912-1-mahesh@bandewar.net>
Message-ID: <1660505746.8419.1514989729607@ichabod.co-bxl>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> From: Mahesh Bandewar <maheshb@google.com>
> 
> The default value set (for kernel.controlled_userns_caps_whitelist) is
> CAP_FULL_SET indicating that no capability is controlled by default to
> maintain compatibility with the existing behavior of user-ns. Administrator
> will have to modify this sysctl to control any capability as such. e.g. to
> control CAP_NET_RAW the mask need to be changed like -
> 
>   # sysctl -q kernel.controlled_userns_caps_whitelist
>   kernel.controlled_userns_caps_whitelist = 1f,ffffffff
>   # sysctl -w kernel.controlled_userns_caps_whitelist=1f,ffffdfff
>   kernel.controlled_userns_caps_whitelist = 1f,ffffdfff
> 
> For bit-to-mask conversion please check include/uapi/linux/capability.h
> file.

Is it possible to make those sysctl values human readable? That would make
admins life easier.

Yours sincerely

G. K.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
