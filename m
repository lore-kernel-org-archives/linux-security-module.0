From: mjg59@google.com (Matthew Garrett)
Date: Tue, 03 Apr 2018 16:29:48 +0000
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<30459.1522739219@warthog.procyon.org.uk>
	<CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
Message-ID: <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
> Can you explain that much more clearly?  I'm asking why booting via
> UEFI Secure Boot should enable lockdown, and I don't see what this has
> to do with kexec.  And "someone blacklist[ing] your key in the
> bootloader" sounds like a political issue, not a technical issue.

A kernel that allows users arbitrary access to ring 0 is just an
overfeatured bootloader. Why would you want secure boot in that case?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
