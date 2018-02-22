From: jbohac@suse.cz (Jiri Bohac)
Date: Thu, 22 Feb 2018 20:14:28 +0100
Subject: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is
	locked down
In-Reply-To: <8887.1519309313@warthog.procyon.org.uk>
References: <8846.1519309243@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<8887.1519309313@warthog.procyon.org.uk>
Message-ID: <20180222191428.mam3w3n3flc63jn2@dwarf.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Feb 22, 2018 at 02:21:53PM +0000, David Howells wrote:
> commit ed0424c531d7dd25adebdec0ee6a78a5784f207a
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Feb 22 14:01:49 2018 +0000
> 
>     kexec_file: Restrict at runtime if the kernel is locked down
>     
>     When KEXEC_VERIFY_SIG is not enabled, kernel should not load images through

s/KEXEC_VERIFY_SIG/KEXEC_SIG/
Again, my mistake :/

Other than that, looks OK. Much cleaner than my version. Thanks!

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
