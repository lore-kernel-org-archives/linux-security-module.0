From: james.l.morris@oracle.com (James Morris)
Date: Tue, 28 Nov 2017 09:31:18 +1100 (AEDT)
Subject: [PATCH v5 next 0/5] Improve Module autoloading infrastructure
In-Reply-To: <20171128.041426.801732093971324601.davem@davemloft.net>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
	<20171128.041426.801732093971324601.davem@davemloft.net>
Message-ID: <alpine.LFD.2.20.1711280924350.11830@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 28 Nov 2017, David Miller wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Mon, 27 Nov 2017 10:41:30 -0800
> 
> > What are the real life use-cases for normal users having modules
> > auto-load?
> 
> User opens SCTP socket, SCTP protocol module loads.
> 
> People build test cases via namespaces, and in that namespaces normal
> users can setup virtual tunnel devices themselves, and those configure
> operations can bring the tunnel module in.

What about implementing a white list of modules which are able to be 
loaded by unprivileged users?

Then, Linus' solution would look something like:

	va_start(args, fmt);
	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
	va_end(args);

	if (WARN_ON_ONCE(!capable(CAP_SYS_MODULE) ||
                         !capable(CAP_SYS_ADMIN) ||
                         !capable(CAP_NET_ADMIN) ||
                         !unprivileged_autoload(module_name)))
		return -EPERM;



-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
