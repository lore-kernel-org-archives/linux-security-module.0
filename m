From: jmorris@namei.org (James Morris)
Date: Sat, 31 Mar 2018 11:46:10 +1100 (AEDT)
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <4136.1522452584@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1803311145180.7769@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 31 Mar 2018, David Howells wrote:

> Date: Thu, 26 Oct 2017 17:37:38 +0100
> 
> Hi James,
> 
> Can you pull this patchset into security/next please?  It has been in
> linux-next since the beginning of March.
> 
> It adds kernel lockdown support for EFI secure boot.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git 
next-lockdown and next-testing

Are there any known coverage gaps now?



-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
