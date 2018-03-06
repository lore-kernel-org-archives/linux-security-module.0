From: jslaby@suse.cz (Jiri Slaby)
Date: Tue, 6 Mar 2018 15:05:50 +0100
Subject: [PATCH 0/9] KEYS: Blacklisting & UEFI database load
In-Reply-To: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
References: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
Message-ID: <6eabbb43-295e-9ba0-c0d9-120f48aa0e1d@suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/16/2016, 07:10 PM, David Howells wrote:
> Here are two sets of patches.  Firstly, the first three patches provide a
> blacklist, making the following changes:
...
> Secondly, the remaining patches allow the UEFI database to be used to load
> the system keyrings:
...
> Dave Howells (2):
>       efi: Add EFI signature data types
>       efi: Add an EFI signature blob parser
> 
> David Howells (5):
>       KEYS: Add a system blacklist keyring
>       X.509: Allow X.509 certs to be blacklisted
>       PKCS#7: Handle blacklisted certificates
>       KEYS: Allow unrestricted boot-time addition of keys to secondary keyring
>       efi: Add SHIM and image security database GUID definitions
> 
> Josh Boyer (2):
>       MODSIGN: Import certificates from UEFI Secure Boot
>       MODSIGN: Allow the "db" UEFI variable to be suppressed

Hi,

what's the status of this please? Distributors (I checked SUSE, RedHat
and Ubuntu) have to carry these patches and every of them have to
forward-port the patches to new kernels. So are you going to resend the
PR to have this merged?

thanks,
-- 
js
suse labs
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
