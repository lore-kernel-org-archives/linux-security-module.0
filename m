From: solar@openwall.com (Solar Designer)
Date: Mon, 22 May 2017 14:08:48 +0200
Subject: [kernel-hardening] [PATCH v4 next 0/3] modules: automatic module
	loading restrictions
In-Reply-To: <1495454226-10027-1-git-send-email-tixxdz@gmail.com>
References: <1495454226-10027-1-git-send-email-tixxdz@gmail.com>
Message-ID: <20170522120848.GA3003@openwall.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Djalal,

Thank you for your work on this!

On Mon, May 22, 2017 at 01:57:03PM +0200, Djalal Harouni wrote:
> *) When modules_autoload_mode is set to (2), automatic module loading is
> disabled for all. Once set, this value can not be changed.

What purpose does this securelevel-like property ("Once set, this value
can not be changed.") serve here?  I think this mode 2 is needed, but
without this extra property, which is bypassable by e.g. explicitly
loaded kernel modules anyway (and that's OK).

I'm sorry if this has been discussed before.

Alexander
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
