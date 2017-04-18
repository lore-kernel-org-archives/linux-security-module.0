From: jmorris@namei.org (James Morris)
Date: Wed, 19 Apr 2017 08:32:20 +1000 (AEST)
Subject: [GIT PULL] SELinux patches for 4.12
In-Reply-To: <CAHC9VhSX2R6+eof6JPVyjzCmL0gFMMO=Liw15vVyED502eJ2gQ@mail.gmail.com>
References: <CAHC9VhSX2R6+eof6JPVyjzCmL0gFMMO=Liw15vVyED502eJ2gQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1704190832040.22202@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Apr 2017, Paul Moore wrote:

> Hi James,
> 
> A whopping 31 SELinux patches for v4.12, although 25 of these are the
> small little patches from Markus.  Beyond those 25 patches, the
> remaining six are equally trivial with the only real standout being
> Stephen's patch to reorder the DAC_OVERRIDE and DAC_READ_SEARCH
> checks.  Everything passes selinux-testsuite and merges cleanly with
> the linux-security/next branch; please apply.

Pulled, thanks.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
