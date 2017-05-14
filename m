From: jmorris@namei.org (James Morris)
Date: Mon, 15 May 2017 09:59:07 +1000 (AEST)
Subject: [PATCH v3] LSM: Enable multiple calls to security_add_hooks()
	for the same LSM
In-Reply-To: <20170510204848.1555-1-mic@digikod.net>
References: <20170510204848.1555-1-mic@digikod.net>
Message-ID: <alpine.LRH.2.20.1705150958510.29831@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 10 May 2017, Micka?l Sala?n wrote:

> The commit d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm") extend
> security_add_hooks() with a new parameter to register the LSM name,
> which may be useful to make the list of currently loaded LSM available
> to userspace. However, there is no clean way for an LSM to split its
> hook declarations into multiple files, which may reduce the mess with
> all the included files (needed for LSM hook argument types) and make the
> source code easier to review and maintain.
> 
> This change allows an LSM to register multiple times its hook while
> keeping a consistent list of LSM names as described in
> Documentation/security/LSM.txt . The list reflects the order in which
> checks are made. This patch only check for the last registered LSM. If
> an LSM register multiple times its hooks, interleaved with other LSM
> registrations (which should not happen), its name will still appear in
> the same order that the hooks are called, hence multiple times.
> 
> To sum up, "capability,selinux,foo,foo" will be replaced with
> "capability,selinux,foo", however "capability,foo,selinux,foo" will
> remain as is.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next


-- 
James Morris
<jmorris@namei.org>
