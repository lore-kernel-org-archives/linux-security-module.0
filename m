From: jmorris@namei.org (James Morris)
Date: Sat, 5 May 2018 05:51:43 +1000 (AEST)
Subject: [PATCH v2 0/4] Introduce LSM-hook for socketpair(2)
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
Message-ID: <alpine.LRH.2.21.1805050551020.30811@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 4 May 2018, David Herrmann wrote:

> Hi
> 
> This is v2 of the socketpair(2) LSM hook introduction.

Thanks, all applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
