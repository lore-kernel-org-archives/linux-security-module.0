From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 24 Apr 2017 13:59:48 +0930
Subject: [PATCH v3 2/2] modules:capabilities: add a per-task modules
	autoload restriction
In-Reply-To: <1492640420-27345-3-git-send-email-tixxdz@gmail.com>
References: <1492640420-27345-1-git-send-email-tixxdz@gmail.com>
	<1492640420-27345-3-git-send-email-tixxdz@gmail.com>
Message-ID: <87r30ifmwz.fsf@rustcorp.com.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Djalal Harouni <tixxdz@gmail.com> writes:
> When value is (1), task must have CAP_SYS_MODULE to be able to trigger a
> module auto-load operation, or CAP_NET_ADMIN for modules with a
> 'netdev-%s' alias.

Sorry, the magic 'netdev-' prefix is a crawling horror.  To do this
properly, you need to hand the capability (if any) from the
request_module() call.  Probably by adding a new request_module_cap and
making request_module() call that, then fixing up the callers.

Cheers,
Rusty.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
