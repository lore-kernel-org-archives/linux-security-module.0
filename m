From: jmorris@namei.org (James Morris)
Date: Mon, 28 Aug 2017 13:38:26 +1000 (AEST)
Subject: [kernel-hardening] [PATCH net-next v7 00/10] Landlock LSM: Toward
	unprivileged sandboxing
In-Reply-To: <20170821000933.13024-1-mic@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
Message-ID: <alpine.LRH.2.20.1708281335290.8842@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 21 Aug 2017, Micka?l Sala?n wrote:

> ## Why a new LSM? Are SELinux, AppArmor, Smack and Tomoyo not good enough?
> 
> The current access control LSMs are fine for their purpose which is to give the
> *root* the ability to enforce a security policy for the *system*. What is
> missing is a way to enforce a security policy for any application by its
> developer and *unprivileged user* as seccomp can do for raw syscall filtering.
> 

You could mention here that the first case is Mandatory Access Control, 
in general terms.



-- 
James Morris
<jmorris@namei.org>
