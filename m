From: james.l.morris@oracle.com (James Morris)
Date: Mon, 11 Dec 2017 09:28:20 +1100 (AEDT)
Subject: [RFC v2 1/3] security: Add safe, dynamic (runtime-loadable) hook
	support
In-Reply-To: <5c089f6eb3bcec36e6021db7dcfcd4409be99111.1512704909.git.sargun@netflix.com>
References: <cover.1512704909.git.sargun@netflix.com>
	<5c089f6eb3bcec36e6021db7dcfcd4409be99111.1512704909.git.sargun@netflix.com>
Message-ID: <alpine.LFD.2.20.1712110923210.19397@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 8 Dec 2017, Sargun Dhillon wrote:

> The primary purpose of this patchset is to facilitate the development of
> out-of-tree minor LSMs.

This is not a valid use-case for the mainline kernel: we don't add 
features for out of tree code.

Please reconsider your rationale :-)


- James
-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
