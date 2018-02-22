From: jbohac@suse.cz (Jiri Bohac)
Date: Thu, 22 Feb 2018 20:08:14 +0100
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <8846.1519309243@warthog.procyon.org.uk>
References: <151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<8846.1519309243@warthog.procyon.org.uk>
Message-ID: <20180222190814.a5mavnqvii5i6ptf@dwarf.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Feb 22, 2018 at 02:20:43PM +0000, David Howells wrote:
> commit 87a39b258eca2e15884ee90c3fcd5758d6057b17
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Feb 22 13:42:04 2018 +0000
> 
>     kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE
>     
>     This is a preparatory patch for kexec_file_load() lockdown.  A locked down
>     kernel needs to prevent unsigned kernel images to be loaded with

s/to be loaded/from being loaded/
(my own mistake :-))

Otherwise looks good. Thanks for improving my idea.

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
