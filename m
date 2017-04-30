From: jmorris@namei.org (James Morris)
Date: Mon, 1 May 2017 09:28:52 +1000 (AEST)
Subject: [PATCH v1] LSM: Enable multiple calls to security_add_hooks()
	for the same LSM
In-Reply-To: <20170429190257.27137-1-mic@digikod.net>
References: <20170429190257.27137-1-mic@digikod.net>
Message-ID: <alpine.LRH.2.20.1705010926080.12672@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 29 Apr 2017, Micka?l Sala?n wrote:

> Check if the registering LSM already registered hooks just before. This
> enable to split hook declarations into multiple files without
> registering multiple time the same LSM name, starting from commit
> d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm").

Please include a detailed rationale for these patches.  The above tells us 
very little about why they are needed.



-- 
James Morris
<jmorris@namei.org>
