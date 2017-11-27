From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 27 Nov 2017 10:44:21 -0800
Subject: [PATCH v5 next 5/5] net: modules: use request_module_cap() to
	load 'netdev-%s' modules
In-Reply-To: <1511803118-2552-6-git-send-email-tixxdz@gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-6-git-send-email-tixxdz@gmail.com>
Message-ID: <CA+55aFxfO1i1LS9dPTTCf50ovWPXcq6BE9mKiq_FxWSm4iE8Mg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 27, 2017 at 9:18 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
> This uses the new request_module_cap() facility to directly propagate
> CAP_NET_ADMIN capability and the 'netdev' module prefix to the
> capability subsystem as it was suggested.

This is the kind of complexity that I wonder if it's worth it at all.

Nobody sane actually uses those stupid capability bits. Have you ever
actually seen it used in real life?

They were a mistake, and we should never have done them - another case
of security people who think that complexity == security, when in
reality nobody actually wants the complexity or is willing to set it
up and manage it.

                   Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
