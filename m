From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 19 Apr 2017 16:16:22 -0700
Subject: [PATCH v3 1/2] modules:capabilities: automatic module loading
	restriction
In-Reply-To: <1492640420-27345-2-git-send-email-tixxdz@gmail.com>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-2-git-send-email-tixxdz@gmail.com>
Message-ID: <CALCETrWzjCWGJ2-ghQBie1AXLgFqGe-B9DALUASm43gDO5RRcw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 19, 2017 at 3:20 PM, Djalal Harouni <tixxdz@gmail.com> wrote:
> Currently, an explicit call to load or unload kernel modules require
> CAP_SYS_MODULE capability. However unprivileged users have always been
> able to load some modules using the implicit auto-load operation. An
> automatic module loading happens when programs request a kernel feature
> from a module that is not loaded. In order to satisfy userspace, the
> kernel then automatically load all these required modules.

I like this feature.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
