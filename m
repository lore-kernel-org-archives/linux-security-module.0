From: jmorris@namei.org (James Morris)
Date: Thu, 5 Apr 2018 09:25:19 +1000 (AEST)
Subject: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
	boot)
In-Reply-To: <1119.1522858644@warthog.procyon.org.uk>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
	<1119.1522858644@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1804050918330.21060@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 4 Apr 2018, David Howells wrote:

> > 6. There's a way to *decrease* the lockdown level below the configured
> > value.  (This ability itself may be gated by a config option.)
> > Choices include a UEFI protected variable,
> 
> By turning secure boot off, maybe?

It's surely reasonable to allow an already secure-booted system to be 
debugged without needing to be rebooted.



- James
-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
