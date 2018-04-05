From: mjg59@google.com (Matthew Garrett)
Date: Thu, 05 Apr 2018 00:22:02 +0000
Subject: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
	boot)
In-Reply-To: <alpine.LRH.2.21.1804050918330.21060@namei.org>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
	<1119.1522858644@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1804050918330.21060@namei.org>
Message-ID: <CACdnJusC7pvGhaRZBHAQqxc8MLHBeFUdZAddUO5DG2kFZMktMA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 4, 2018 at 4:25 PM James Morris <jmorris@namei.org> wrote:
> It's surely reasonable to allow an already secure-booted system to be
> debugged without needing to be rebooted.

alt-sysrq-x from a physical console will do that.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
