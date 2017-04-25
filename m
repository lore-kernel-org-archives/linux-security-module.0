From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 25 Apr 2017 15:55:21 +0100
Subject: [PATCH v4 1/2] tiocsti-restrict : Add owner user namespace to
	tty_struct
In-Reply-To: <20170424051512.20420-2-matt@nmatt.com>
References: <20170424051512.20420-1-matt@nmatt.com>
	<20170424051512.20420-2-matt@nmatt.com>
Message-ID: <20170425155521.03b393de@lxorguk.ukuu.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 24 Apr 2017 01:15:11 -0400
Matt Brown <matt@nmatt.com> wrote:

> This patch adds struct user_namespace *owner_user_ns to the tty_struct.
> Then it is set to current_user_ns() in the alloc_tty_struct function.
> 
> This is done to facilitate capability checks against the original user
> namespace that allocated the tty.
> 
> E.g. ns_capable(tty->owner_user_ns,CAP_SYS_ADMIN)
> 
> This combined with the use of user namespace's will allow hardening
> protections to be built to mitigate container escapes that utilize TTY
> ioctls such as TIOCSTI.

Regardles of the TIOCSTI usefulness this makes complete sense.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
