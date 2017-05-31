From: jmorris@namei.org (James Morris)
Date: Wed, 31 May 2017 12:48:50 +1000 (AEST)
Subject: [kernel-hardening] Re: [PATCH v7 2/2] security: tty: make TIOCSTI
	ioctl require CAP_SYS_ADMIN
In-Reply-To: <CAFUG7CdDd0Yfegb1S6_wNQzje4EuLE0jPdvOE=uSQL152meyjQ@mail.gmail.com>
References: <20170529213800.29438-1-matt@nmatt.com>
	<20170529213800.29438-3-matt@nmatt.com>
	<20170529232640.16211960@alans-desktop>
	<CAFUG7CdDd0Yfegb1S6_wNQzje4EuLE0jPdvOE=uSQL152meyjQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1705311239420.6920@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 29 May 2017, Boris Lukashev wrote:

> With all due respect sir, i believe your review falls short of the
> purpose of this effort - to harden the kernel against flaws in
> userspace.

Which effort?  Kernel self protection is about protecting against flaws in 
the kernel.

See:
https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project

  "This project starts with the premise that kernel bugs have a very long 
   lifetime, and that the kernel must be designed in ways to protect against 
   these flaws."

We need to avoid conflating:

- hardening the kernel against attack; and 
- modifying the kernel to try and harden userspace.

These patches are the latter, and the case for them is not as 
straightforward.


- James
-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
